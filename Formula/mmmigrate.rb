# typed: false
# frozen_string_literal: true

# Installs three driver-specific binaries side-by-side:
#   mmmigrate-postgres, mmmigrate-mysql, mmmigrate-sqlite
# Invoke the one that matches the database you're migrating.

class Mmmigrate < Formula
  desc "Forward-only SQL migration tool (postgres, mysql, sqlite variants)"
  homepage "https://github.com/middle-management/mmmigrate"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-arm64"
      sha256 "0fc0fde3c840f9d5f1d221d7160065d6e8ec48a6298ce3e56f3fe235e27d80a5"

      resource "mysql" do
        version "0.5.1"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-arm64"
        sha256 "6c536f534f134a13f3a57ea0bd014995d40d97b02c0ddf645e57c36c2c5cfd3e"
      end

      resource "sqlite" do
        version "0.5.1"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-arm64"
        sha256 "d374287269a8ed31d36d5fdf9563c6e73e49c147269d44b16510fec351796d23"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-amd64"
      sha256 "7cf69f1f43edae730f1f3ff085775a50c4ae3f75e4e2aab9cfe88a48d647cc5f"

      resource "mysql" do
        version "0.5.1"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-amd64"
        sha256 "06c1ed4012676dd1553f47fc19187215f8a2262e239a42ef25c6d1c996cccf66"
      end

      resource "sqlite" do
        version "0.5.1"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-amd64"
        sha256 "eaf476d40149eb5e6efa84d88fb736cbddb57e9d72f8dc7d0dbc5ca134b20e67"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-arm64"
      sha256 "87ccf08e1786bae138d7938d2dbc55e4d08a36a1eb25719851dfff78f4e571e3"

      resource "mysql" do
        version "0.5.1"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-arm64"
        sha256 "6bf2d552d94b00df4d8cba2ee2ec5281e57536f8f6c1832d65cef12f85623f5b"
      end

      resource "sqlite" do
        version "0.5.1"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-arm64"
        sha256 "9b6b5346543d03aea7b5396826bb94aac2b9f37626d3061512d90049f23ec81b"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-amd64"
      sha256 "117958bd90b7f1a55b095af38ed73e8ced7da2a66c7f4e91c309406ca388b61c"

      resource "mysql" do
        version "0.5.1"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-amd64"
        sha256 "79e8ab74f8f6e8a1d601808211dc90730a5e2ec8e298767fdb97abc676631a8f"
      end

      resource "sqlite" do
        version "0.5.1"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-amd64"
        sha256 "fef95ed8bd1810e684c8e58347923493456523c8e6ff2d3f84b546e126686091"
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
