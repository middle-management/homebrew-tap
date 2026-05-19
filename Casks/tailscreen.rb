# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.7.0"
  sha256 "03ad7dd974e0d2885a7a1f7e281b1e9fa1d5ae346124d22ddb7a93aef71d5002"

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
