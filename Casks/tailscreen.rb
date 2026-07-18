# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.9.0"
  sha256 "0cf96b1e6c5b49c11a070a0e4352a7dd8d3378f0d27648f06809e9577321b9a8"

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
