# typed: false
# frozen_string_literal: true

class Kubepose < Formula
  desc "Convert Compose specification files to Kubernetes manifests"
  homepage "https://github.com/middle-management/kubepose"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-arm64"
      sha256 "2df8b111268b2ea03b0c9ac233bd17cd6b9f902f70bca09c58ca01347511696b"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-amd64"
      sha256 "91f54f1365ae35081f6b2fdb83b834e609f080189af4038b5561bb8d8febcc54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-arm64"
      sha256 "1f4c3d5e306cbad27aef3abc77d5a0ffab3f5743e3e7199b9e0f167dcb0dc5ed"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-amd64"
      sha256 "8b88d8e4bf211e570612c49d7d922c7ba2e76c08c4da970189222f28a41bbaee"
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
