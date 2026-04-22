# typed: false
# frozen_string_literal: true

class Httproxy < Formula
  desc "Simple path-based HTTP reverse proxy"
  homepage "https://github.com/middle-management/httproxy"
  version "0.5.0"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/httproxy/releases/download/#{version}/httproxy-darwin-arm64"
      sha256 "5a5cfdf6b62260121afe2e83d5f053faefc27d7197550519c13dcf5c8d8d4d6b"
    end
    on_intel do
      url "https://github.com/middle-management/httproxy/releases/download/#{version}/httproxy-darwin-amd64"
      sha256 "2076272616c0e6d296c32d1672413691a4c03c0e914e76b36aaa308c123ce7de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/httproxy/releases/download/#{version}/httproxy-linux-arm64"
      sha256 "55681916d246a26a0d56447d2a56ca4b83abe3a442595dfb15dee79814c88223"
    end
    on_intel do
      url "https://github.com/middle-management/httproxy/releases/download/#{version}/httproxy-linux-amd64"
      sha256 "a108a88550d23ac92dff2cbe9d6c37741e9ebe9788bba71238f46e1ede422249"
    end
  end

  def install
    bin.install Dir["*"].first => "httproxy"
  end

  test do
    assert_path_exists bin/"httproxy"
    system bin/"httproxy", "--help"
  end
end
