# typed: false
# frozen_string_literal: true

class Ace < Formula
  desc "Append-only enCrypted Environment variables"
  homepage "https://github.com/middle-management/ace"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-darwin-arm64"
      sha256 "4bb35dfb6e9cabc7ab89affdf4ad5a762591ddeb5b03238ecc352511a41e94e0"
    end
    on_intel do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-darwin-amd64"
      sha256 "30dd53dcf7309aa9197068fd4711044c5f20ef653b178b2ac21071783134653c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-linux-arm64"
      sha256 "0518af86173c797c8856d2bfd922dc7fc0402c1b106dfee2571473b2b43e97a0"
    end
    on_intel do
      url "https://github.com/middle-management/ace/releases/download/v#{version}/ace-linux-amd64"
      sha256 "4677714699cb523c5a357a7ac6cfa428eebd12e24e9a5da3470da37a7e212d30"
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
