# typed: false
# frozen_string_literal: true

class Ace < Formula
  desc "Append-only enCrypted Environment variables"
  homepage "https://github.com/middle-management/ace"
  version "0.7.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-darwin-arm64"
      sha256 "1064b24f15157eb2cf32f22d8025ba2890a8cdc37173c5674f912fcf6f152213"
    end
    on_intel do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-darwin-amd64"
      sha256 "667f745265270abb2c847fa6743e2b028445436d2307bdc019a2b5e09bb3b63f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-linux-arm64"
      sha256 "fec67f61da22a08843c06873bca724a9f3946e57cef7665aa8b5786472822d25"
    end
    on_intel do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-linux-amd64"
      sha256 "4a4b15266ad3893213174e944750cff3ea091e06cd9d5729977a7fe8aea948c8"
    end
  end

  def install
    bin.install Dir["*"].first => "ace"
  end

  test do
    assert_path_exists bin/"ace"
    system bin/"ace", "--help"
  end
end
