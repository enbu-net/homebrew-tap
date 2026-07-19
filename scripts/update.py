#!/usr/bin/env python3

import json
import os
import re
import urllib.request
from pathlib import Path


REPOSITORY = "enbu-net/enbu"
ROOT = Path(__file__).resolve().parent.parent
VERSION_PATTERN = re.compile(r"[0-9]+\.[0-9]+\.[0-9]+")


def download(url: str) -> bytes:
    request = urllib.request.Request(
        url,
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "enbu-homebrew-tap-updater",
        },
    )
    with urllib.request.urlopen(request) as response:
        return response.read()


def replace_package(path: Path, version: str, assets: dict[str, str]) -> bool:
    original = path.read_text()
    lines = original.splitlines(keepends=True)
    pending_asset = None

    for index, line in enumerate(lines):
        if line.strip().startswith('version "'):
            indent = line[: len(line) - len(line.lstrip())]
            lines[index] = f'{indent}version "{version}"\n'
            continue

        if line.strip().startswith('url "'):
            pending_asset = next(
                (asset for marker, asset in assets.items() if marker in line),
                None,
            )
            continue

        if pending_asset and line.strip().startswith('sha256 "'):
            indent = line[: len(line) - len(line.lstrip())]
            lines[index] = f'{indent}sha256 "{checksums[pending_asset]}"\n'
            pending_asset = None

    updated = "".join(lines)
    if updated == original:
        return False

    path.write_text(updated)
    return True


release = json.loads(
    download(f"https://api.github.com/repos/{REPOSITORY}/releases/latest")
)
tag = release["tag_name"]
version = tag.removeprefix("v")
if not VERSION_PATTERN.fullmatch(version):
    raise SystemExit(f"unsupported release tag: {tag}")

checksum_asset = next(
    (asset for asset in release["assets"] if asset["name"] == "checksums.txt"),
    None,
)
if checksum_asset is None:
    raise SystemExit(f"checksums.txt is missing from release {tag}")

checksums = {}
for line in download(checksum_asset["browser_download_url"]).decode().splitlines():
    checksum, filename = line.split(maxsplit=1)
    checksums[filename] = checksum

formula_assets = {
    "darwin_arm64.tar.gz": f"enbu_{version}_darwin_arm64.tar.gz",
    "linux_arm64.tar.gz": f"enbu_{version}_linux_arm64.tar.gz",
    "linux_amd64.tar.gz": f"enbu_{version}_linux_amd64.tar.gz",
}
cask_assets = {
    "darwin_arm64.dmg": f"enbu-desktop_v{version}_darwin_arm64.dmg",
}
required_assets = set(formula_assets.values()) | set(cask_assets.values())
missing_assets = required_assets - checksums.keys()
if missing_assets:
    raise SystemExit(f"checksums are missing for: {', '.join(sorted(missing_assets))}")

changed = replace_package(ROOT / "Formula/enbu.rb", version, formula_assets)
changed |= replace_package(ROOT / "Casks/enbu-desktop.rb", version, cask_assets)

if output_path := os.environ.get("GITHUB_OUTPUT"):
    with open(output_path, "a") as output:
        output.write(f"version={version}\n")
        output.write(f"changed={'true' if changed else 'false'}\n")

print(f"enbu {version}: {'updated' if changed else 'already current'}")
