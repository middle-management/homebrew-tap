# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.3.0"
  sha256 "7335e14b0150cb2e40322181c8861033f7a7f7759677659e0db05398c1fb1be5"

  url "https://github.com/middle-management/tailscreen/releases/download/v#{version}/Tailscreen-v#{version}-macOS.zip"
  name "Tailscreen"
  desc "Screen sharing over Tailscale"
  homepage "https://github.com/middle-management/tailscreen"

  depends_on macos: ">= :sequoia"

  app "Tailscreen.app"

  zap trash: [
    "~/Library/Preferences/se.middlemanagement.tailscreen.plist",
    "~/Library/Saved Application State/se.middlemanagement.tailscreen.savedState",
  ]
end
