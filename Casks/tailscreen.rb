# typed: false
# frozen_string_literal: true

cask "tailscreen" do
  version "0.3.1"
  sha256 "567c882d142674a1a54b5a4615cc1852ea2e4da6113622d093ed0036038ed400"

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
