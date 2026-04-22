# typed: false
# frozen_string_literal: true

class Kubepose < Formula
  desc "Convert Compose specification files to Kubernetes manifests"
  homepage "https://github.com/middle-management/kubepose"
  version "0.5.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-arm64"
      sha256 "036069cf59af15b2bb66628c463fe9c8f917c7b5594ed862ca4c989f8399235b"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-darwin-amd64"
      sha256 "b91a04a9d2dc56d4638dae8fd65e1691ea547410ad4a1c25a3a4805de3ccf441"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-arm64"
      sha256 "8e44a2a000ff0117614ad869c5871d1809ad66cce8fb07330c148c9ca6a8066c"
    end
    on_intel do
      url "https://github.com/middle-management/kubepose/releases/download/v#{version}/kubepose-linux-amd64"
      sha256 "6e29fe14197a5233e2b09c126a38037709f1bb5740cf26df35cff4210108d359"
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
