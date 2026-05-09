# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.5.0"
  sha256 "f996874e1fa858bcb046bbe8aed3ee3e97f5a6dd13689db9c43082a671db1d94"

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
