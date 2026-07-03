# typed: false
# frozen_string_literal: true

class Ace < Formula
  desc "Append-only enCrypted Environment variables"
  homepage "https://github.com/middle-management/ace"
  version "0.7.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-darwin-arm64"
      sha256 "0857542fd54838a5fad6b9d8825f4ff3b2e48ba1df786918e477902c9add59aa"
    end
    on_intel do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-darwin-amd64"
      sha256 "49fc75046ad01bb93b56060a5a4583a83264ccc706f33191ae0a6d700177e2ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-linux-arm64"
      sha256 "e7a28de44fe43d788d2564d0ab668973aececfbd72471b71f78fd5e9cec6eda6"
    end
    on_intel do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-linux-amd64"
      sha256 "51d2a92ddc9a34f8d3584253326253cc0bc5dd6e7f5cb92eb6c86298cd332a24"
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
