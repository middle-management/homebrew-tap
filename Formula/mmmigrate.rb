# typed: false
# frozen_string_literal: true

# Installs three driver-specific binaries side-by-side:
#   mmmigrate-postgres, mmmigrate-mysql, mmmigrate-sqlite
# Invoke the one that matches the database you're migrating.

class Mmmigrate < Formula
  desc "Forward-only SQL migration tool (postgres, mysql, sqlite variants)"
  homepage "https://github.com/middle-management/mmmigrate"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-arm64"
      sha256 "abbc7ffc8b6e7248a7df3b129361bf8665340b94c33e985d6fb2ffad16b06f5c"

      resource "mysql" do
        version "0.7.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-arm64"
        sha256 "c83e705dcb42ecb51c8f8c327db63717b60d700342f0c3e5b26918a35087d8fc"
      end

      resource "sqlite" do
        version "0.7.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-arm64"
        sha256 "06f9f796f1910c7085fa46cbdf7ccb2aab45e026f1be1d674f4848d5f8f78d74"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-amd64"
      sha256 "743bb46e87c56ab58b5f28ffb48bc232f1653431f1f7455c1bf16369592f0815"

      resource "mysql" do
        version "0.7.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-amd64"
        sha256 "28ca794e1c0272bd2b584f767063e0816f1317b1e476f51c325f4ff60a9dfb23"
      end

      resource "sqlite" do
        version "0.7.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-amd64"
        sha256 "c2dd0bc264f7f59116f26755346d9c25418ecc6d3be25aca154ac42bf54c8948"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-arm64"
      sha256 "4b8f3951b388430f7179297b14b83ad4e9408f6fbfaa736615ecd872ee7c9cad"

      resource "mysql" do
        version "0.7.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-arm64"
        sha256 "6288577c25947b4016c736ba52b559ee22ef4b1746db2bab02e5d18bc37652d3"
      end

      resource "sqlite" do
        version "0.7.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-arm64"
        sha256 "deebdb6444a8d78043f53ffa338b2df286b96f6d782e0e4a314ba4d128c492d2"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-amd64"
      sha256 "345a981503267c4c40d76e86774f7c4437f70c3f221b748f33f8e511ec5abe04"

      resource "mysql" do
        version "0.7.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-amd64"
        sha256 "fff3b3d68fd23539a7b54841a1331ed02483838478a8267a824d6e7f50ef2ad4"
      end

      resource "sqlite" do
        version "0.7.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-amd64"
        sha256 "0da3f99b97041b6405a75beb144746ecbb18d966670ab53640b9a65e689402c3"
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
