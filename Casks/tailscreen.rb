# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.6.0"
  sha256 "13e06aba143681dca406b933d020db63b225a4a634bdb616c61f593c10f1b70f"

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
