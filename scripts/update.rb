#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

# Updates the Formula and Cask from the latest enbu GitHub release.
module UpdateEnbu
  REPOSITORY = "enbu-net/enbu"
  ROOT = File.expand_path("..", __dir__).freeze
  VERSION_PATTERN = /\A\d+\.\d+\.\d+\z/

  module_function

  def download(url, redirects = 5)
    abort "too many redirects while downloading #{url}" if redirects.negative?

    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/vnd.github+json"
    request["User-Agent"] = "enbu-homebrew-tap-updater"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    case response
    when Net::HTTPSuccess
      response.body
    when Net::HTTPRedirection
      download(URI.join(url, response.fetch("location")).to_s, redirects - 1)
    else
      response.value
    end
  end

  def replace_package?(path, version, assets, checksums)
    original = File.read(path)
    pending_asset = nil

    updated = original.lines.map do |line|
      next "#{line[/\A\s*/]}version \"#{version}\"\n" if line.strip.start_with?('version "')

      if line.strip.start_with?('url "')
        pending_asset = assets.find { |marker, _asset| line.include?(marker) }&.last
        next line
      end

      if pending_asset && line.strip.start_with?('sha256 "')
        line = "#{line[/\A\s*/]}sha256 \"#{checksums.fetch(pending_asset)}\"\n"
        pending_asset = nil
      end

      line
    end.join

    return false if updated == original

    File.write(path, updated)
    true
  end

  def run
    release = JSON.parse(download("https://api.github.com/repos/#{REPOSITORY}/releases/latest"))
    tag = release.fetch("tag_name")
    version = tag.delete_prefix("v")
    abort "unsupported release tag: #{tag}" unless VERSION_PATTERN.match?(version)

    checksum_asset = release.fetch("assets").find { |asset| asset.fetch("name") == "checksums.txt" }
    abort "checksums.txt is missing from release #{tag}" unless checksum_asset

    checksums = download(checksum_asset.fetch("browser_download_url")).lines.to_h do |line|
      checksum, filename = line.split
      [filename, checksum]
    end

    formula_assets = {
      "darwin_arm64.tar.gz" => "enbu_v#{version}_darwin_arm64.tar.gz",
      "linux_arm64.tar.gz"  => "enbu_v#{version}_linux_arm64.tar.gz",
      "linux_amd64.tar.gz"  => "enbu_v#{version}_linux_amd64.tar.gz",
    }
    cask_assets = {
      "darwin_arm64.dmg" => "enbu-desktop_v#{version}_darwin_arm64.dmg",
    }
    required_assets = formula_assets.values | cask_assets.values
    missing_assets = required_assets - checksums.keys
    abort "checksums are missing for: #{missing_assets.sort.join(", ")}" unless missing_assets.empty?

    changed = replace_package?(File.join(ROOT, "Formula/enbu.rb"), version, formula_assets, checksums)
    changed |= replace_package?(File.join(ROOT, "Casks/enbu-desktop.rb"), version, cask_assets, checksums)

    if (output_path = ENV.fetch("GITHUB_OUTPUT", nil))
      File.open(output_path, "a") do |output|
        output.puts "version=#{version}"
        output.puts "changed=#{changed}"
      end
    end

    puts "enbu #{version}: #{changed ? "updated" : "already current"}"
  end
end

UpdateEnbu.run
