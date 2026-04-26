# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.1.0"
  sha256 "0d04d93c3c0f85f773edcf69d78d60b3b01f824163ffe721263d51c94b81520c"

  url "https://github.com/middle-management/tailscreen/releases/download/v#{version}/Tailscreen-v#{version}-macOS.zip"
  name "Tailscreen"
  desc "Stream a Mac's display to another Mac over Tailscale"
  homepage "https://github.com/middle-management/tailscreen"

  depends_on macos: ">= :sequoia"

  app "Tailscreen.app"

  zap trash: [
    "~/Library/Preferences/se.middlemanagement.tailscreen.plist",
    "~/Library/Saved Application State/se.middlemanagement.tailscreen.savedState",
  ]
end
