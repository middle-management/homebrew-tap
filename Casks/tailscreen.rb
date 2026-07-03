# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.8.0"
  sha256 "547a8f8c33f4513cde71851a51a40d8039eb546d455649c3fc6b48ac0d25a60a"

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
