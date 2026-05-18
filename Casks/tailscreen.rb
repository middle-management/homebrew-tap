# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.6.2"
  sha256 "130290dff9f14a77ad9fcb4d12f1caf3411c414df35ec5eb423c190a5ed3ed92"

  url "https://github.com/middle-management/tailscreen/releases/download/v#{version}/Tailscreen-v#{version}-macOS.zip"
  name "Tailscreen"
  desc "Screen sharing over Tailscale"
  homepage "https://github.com/middle-management/tailscreen"

  depends_on macos: :sequoia

  app "Tailscreen.app"

  zap trash: [
    "~/Library/Preferences/se.middlemanagement.tailscreen.plist",
    "~/Library/Saved Application State/se.middlemanagement.tailscreen.savedState",
  ]
end
