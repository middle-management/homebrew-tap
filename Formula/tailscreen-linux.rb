# typed: false
# frozen_string_literal: true

# The Linux build of Tailscreen, as a formula.
#
# Named `tailscreen-linux` rather than `tailscreen` on purpose: the macOS build
# is the `tailscreen` CASK in this tap, and Homebrew prefers a formula over a
# cask of the same name — so reusing the name would silently change what
# `brew install middle-management/tap/tailscreen` does on a Mac.
class TailscreenLinux < Formula
  desc "Share and view screens peer-to-peer over Tailscale"
  homepage "https://tailscreen.dev"
  version "0.0.0"
  license "MIT"

  # Linux only. On macOS use the cask: `brew install --cask middle-management/tap/tailscreen`.
  depends_on :linux

  on_linux do
    on_intel do
      url "https://github.com/middle-management/tailscreen/releases/download/v#{version}/Tailscreen-#{version}-x86_64.AppImage"
      sha256 "REPLACE_ME_Tailscreen-0.0.0-x86_64.AppImage"
    end
    # No arm64 build yet: the release workflow's AppImage step is x86_64-only
    # (linuxdeploy/appimagetool are pinned to x86_64). Add an `on_arm` block
    # here once an aarch64 artifact ships.
  end

  def install
    # The AppImage arrives under its release filename; keep it out of `bin`
    # (Homebrew would put the versioned name on PATH) and expose a plain
    # `tailscreen` command pointing at it.
    appimage = "Tailscreen-#{version}-x86_64.AppImage"
    libexec.install Dir["*"].first => appimage
    chmod 0755, libexec/appimage
    bin.install_symlink libexec/appimage => "tailscreen"
  end

  def caveats
    <<~EOS
      Tailscreen ships as an AppImage, which needs FUSE to self-mount. If it
      fails with a libfuse error, install your distro's fuse/libfuse2 package or
      run it as:

        APPIMAGE_EXTRACT_AND_RUN=1 tailscreen

      Sharing your screen currently requires X11. Wayland sessions can view but
      not share (that needs the ScreenCast portal backend).

      Homebrew does not register a desktop entry, so Tailscreen will not appear
      in your application launcher. If you want that, use the AppImage directly
      with an integration tool, or the Flatpak once it is published.
    EOS
  end

  test do
    # Needs a display and a tailnet, so there is nothing meaningful to run
    # headlessly — assert the artifact installed and is executable.
    assert_path_exists libexec/"Tailscreen-#{version}-x86_64.AppImage"
    assert_predicate libexec/"Tailscreen-#{version}-x86_64.AppImage", :executable?
  end
end
