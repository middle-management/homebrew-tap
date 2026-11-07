# typed: false
# frozen_string_literal: true

class Kubepose < Formula
  desc "Convert Compose specification files to Kubernetes manifests"
  homepage "https://github.com/middle-management/kubepose"
  version "0.8.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-arm64"
      sha256 "dd8e33c8379b4233cc2797e0702e2ebd2bf6822b25eca1ac9f938f08586a9df3"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-amd64"
      sha256 "72b6beda404af927425d658f6c7caad9d1f4e7217ec893f8be8f2686f17696fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-arm64"
      sha256 "8739187e53a7f0dc48905809b8d80a81760a133b8ed26bb76cb37fd0253acec9"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-amd64"
      sha256 "ac80d4f56cb1d62c84e5b6d079a4a036c27688be105b3ed6b2e5841e41664e33"
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
