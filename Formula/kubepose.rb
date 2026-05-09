# typed: false
# frozen_string_literal: true

class Kubepose < Formula
  desc "Convert Compose specification files to Kubernetes manifests"
  homepage "https://github.com/middle-management/kubepose"
  version "0.6.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-arm64"
      sha256 "0fb24e80ad6d07f94f49b96c6df8b9f0270aee942a905cc0c336fa9cb12bb0e6"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-amd64"
      sha256 "d7305c8f5dd1f928520ae7b7e6a80710cf38b796a272cf29ee5e16d1d1b7cafc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-arm64"
      sha256 "d416bf557968e0162436be1f12bc822f66b75ef350d935d047ab419e56cf29fa"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-amd64"
      sha256 "940e7af5730e7fc67971b25b276c138e98d25ddaa83c1a2a1d7cb6bc100817e2"
    end
  end

  def install
    bin.install Dir["*"].first => "kubepose"
  end

  test do
    assert_path_exists bin/"kubepose"
    system bin/"kubepose", "--help"
  end
end
