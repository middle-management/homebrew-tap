# typed: false
# frozen_string_literal: true

# upstream: middle-management/tailscreen
#
# One cask, both platforms. macOS gets the notarized .app from the release zip;
# Linux gets the AppImage via the `appimage` stanza, which links it into
# Homebrew's AppImage directory.
#
# The version is shared deliberately: both artifacts are built from the same
# release tag, and update-shas.sh reads the FIRST `version` line in the file and
# interpolates it into every URL — so a per-OS version would silently compute
# the wrong URL for one platform.
cask "tailscreen" do
  version "0.9.1"

  name "Tailscreen"
  desc "Screen sharing over Tailscale"
  homepage "https://tailscreen.dev/"

  on_macos do
    sha256 "7badffe81a9f5ff0c2397b738bce84f2a42ea7bcf2b98228dad3396deafbb5a9"
    url "https://github.com/middle-management/tailscreen/releases/download/v#{version}/Tailscreen-v#{version}-macOS.zip"

    depends_on macos: :sequoia

    app "Tailscreen.app"

    zap trash: [
      "~/Library/Preferences/se.middlemanagement.tailscreen.plist",
      "~/Library/Saved Application State/se.middlemanagement.tailscreen.savedState",
    ]
  end

  on_linux do
    # x86_64 only: the AppImage build is pinned to that arch (linuxdeploy and
    # appimagetool are x86_64 binaries). Add an arch conditional here once an
    # aarch64 artifact ships.
    sha256 "REPLACE_ME_Tailscreen-0.9.1-x86_64.AppImage"
    url "https://github.com/middle-management/tailscreen/releases/download/v#{version}/Tailscreen-#{version}-x86_64.AppImage"

    appimage "Tailscreen-#{version}-x86_64.AppImage"
  end

  caveats do
    <<~EOS
      On Linux, Tailscreen ships as an AppImage, which needs FUSE to self-mount.
      If it fails with a libfuse error, install your distro's fuse/libfuse2
      package or run it with APPIMAGE_EXTRACT_AND_RUN=1.

      Sharing your screen on Linux currently requires X11. Wayland sessions can
      view but not share (that needs the ScreenCast portal backend).
    EOS
  end
end
