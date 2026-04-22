# typed: false
# frozen_string_literal: true

class Migratex < Formula
  desc "Simple SQLite migration tool"
  homepage "https://github.com/middle-management/migratex"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/migratex/releases/download/v#{version}/migratex-darwin-arm64"
      sha256 "f679ad64782092b2c5ab7b34a89a9a3b6785e04e8f1652c83c711ccbe844eb51"
    end
    on_intel do
      url "https://github.com/middle-management/migratex/releases/download/v#{version}/migratex-darwin-amd64"
      sha256 "4362003bdf4548efe83ddd5d7722a2f8d87aecdd0b7abf76b74741c4d4f05adc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/migratex/releases/download/v#{version}/migratex-linux-arm64"
      sha256 "e33383d81f1116c521f93e9ddfbc1ec0ec7de192b2a008aeadb5cd3312affdce"
    end
    on_intel do
      url "https://github.com/middle-management/migratex/releases/download/v#{version}/migratex-linux-amd64"
      sha256 "a737853ec4dea0f7e6ef8e8c150ad08f543557eec6bf7c6a4aabd2a686d9279a"
    end
  end

  def install
    bin.install Dir["*"].first => "migratex"
  end

  test do
    assert_path_exists bin/"migratex"
    system bin/"migratex", "--help"
  end
end
