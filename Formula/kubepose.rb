# typed: false
# frozen_string_literal: true

class Kubepose < Formula
  desc "Convert Compose specification files to Kubernetes manifests"
  homepage "https://github.com/middle-management/kubepose"
  version "0.8.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-arm64"
      sha256 "a290bf3b1249e953a3e3fec75b25ecce06073db213e58a1c495500e958d776e2"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-amd64"
      sha256 "74c9c4c04d7641c28985f25aab3df0de58a5a3b4507750f937d6fdbb3f5b24e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-arm64"
      sha256 "6e0c9cb93bb46a4590218746aa6cd92d0514394d3a5f742d40145a4e94a040e9"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-amd64"
      sha256 "3956a5af15e86ab4c9f3739d304ead479fc35450fa197601a6000a7bdd028cd9"
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
