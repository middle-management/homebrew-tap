# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.9.1"
  sha256 "7badffe81a9f5ff0c2397b738bce84f2a42ea7bcf2b98228dad3396deafbb5a9"

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
