# typed: false
# frozen_string_literal: true

# Installs three driver-specific binaries side-by-side:
#   mmmigrate-postgres, mmmigrate-mysql, mmmigrate-sqlite
# Invoke the one that matches the database you're migrating.

class Mmmigrate < Formula
  desc "Forward-only SQL migration tool (postgres, mysql, sqlite variants)"
  homepage "https://github.com/middle-management/mmmigrate"
  version "0.5.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-arm64"
      sha256 "1619d748d99d88aefc52ddcca1bf779e99821ac9d093cec2a58637d4f23ac1dd"

      resource "mysql" do
        version "0.5.2"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-arm64"
        sha256 "f05dc46015f0d7eb3d8bc5685827db9beb736682d469dd18e978b3bbcd4b87be"
      end

      resource "sqlite" do
        version "0.5.2"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-arm64"
        sha256 "40c7aa9335d58674e8403ed76429485ed8b3d948bc42749aac4a08b0a040b362"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-amd64"
      sha256 "eb4420cf4c54657df870b1ab6ff1a675d1e4e348c287442e50cec9e63aaa0f1c"

      resource "mysql" do
        version "0.5.2"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-amd64"
        sha256 "cdccd26474a5c2bdbaa4d1462968d880d1b6e930477a2de7d695759054e0717d"
      end

      resource "sqlite" do
        version "0.5.2"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-amd64"
        sha256 "d1217f2eeda88cd51900f6e85e8a2348bd4252b2189ce51d0d7ee4f42c898237"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-arm64"
      sha256 "96fda6e202c37c9175cb5942ecf91e698b936c800c7038f2fbb46b8dd8fdec20"

      resource "mysql" do
        version "0.5.2"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-arm64"
        sha256 "fb8032c900965697b9f6e338e1b1eb855966cd6248b5589a30a979b9186a39e4"
      end

      resource "sqlite" do
        version "0.5.2"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-arm64"
        sha256 "b4e21ff7207a491b41db57038b133b948dfd19cbeffb7058f60de3284b44e31e"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-amd64"
      sha256 "de41960b2c81b77f1f4bd54048a3ef47c7b0944c81e84f7a3a70ad4a2b84f57b"

      resource "mysql" do
        version "0.5.2"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-amd64"
        sha256 "2d6facb15cdff630451cd9316ec560d45e8e963e3ac1def333ea7d3b17788e8e"
      end

      resource "sqlite" do
        version "0.5.2"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-amd64"
        sha256 "17389720bd63bf2a2ee7e284bb219993bb98a302364abf0b7941c5e108a20144"
      end
    end
  end

  def install
    # Top-level download is the postgres variant; its filename contains the os/arch suffix.
    bin.install Dir["mmmigrate-postgres-*"].first => "mmmigrate-postgres"
    resource("mysql").stage do
      bin.install Dir["mmmigrate-mysql-*"].first => "mmmigrate-mysql"
    end
    resource("sqlite").stage do
      bin.install Dir["mmmigrate-sqlite-*"].first => "mmmigrate-sqlite"
    end
  end

  test do
    assert_path_exists bin/"mmmigrate-postgres"
    assert_path_exists bin/"mmmigrate-mysql"
    assert_path_exists bin/"mmmigrate-sqlite"
    system bin/"mmmigrate-postgres", "--help"
    system bin/"mmmigrate-mysql", "--help"
    system bin/"mmmigrate-sqlite", "--help"
  end
end
