# typed: false
# frozen_string_literal: true

# Installs three driver-specific binaries side-by-side:
#   mmmigrate-postgres, mmmigrate-mysql, mmmigrate-sqlite
# Invoke the one that matches the database you're migrating.

class Mmmigrate < Formula
  desc "Forward-only SQL migration tool (postgres, mysql, sqlite variants)"
  homepage "https://github.com/middle-management/mmmigrate"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-arm64"
      sha256 "9939c6e1da4ceb463e019d5881405888ddf4fb52831ba33a157d055d2f28923d"

      resource "mysql" do
        version "0.8.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-arm64"
        sha256 "d3b60d424f363e6f40cc48d703b4526bbc0f8314b15e9c54386c29c11b385947"
      end

      resource "sqlite" do
        version "0.8.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-arm64"
        sha256 "8212fcee4b6bdffb341a2b33d7e4b1b44b7c5c83174e26c23b46462ac337925c"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-amd64"
      sha256 "e31d8f2962a414d834a1c5d83699eef5bac7250ce2d0ff45e1920860de42f21c"

      resource "mysql" do
        version "0.8.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-amd64"
        sha256 "c743984822ddab67848982e38d637c42e2f516357836e43311cbea23df126fcf"
      end

      resource "sqlite" do
        version "0.8.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-amd64"
        sha256 "6de3b6b096fc9f1649380b6e700894e3f9d061eda3a6d734ce41dffa1b844092"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-arm64"
      sha256 "e1356c130aef57622c2ccc100f705ec36767bae8b36d8cf2b25606cc87453a23"

      resource "mysql" do
        version "0.8.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-arm64"
        sha256 "48d95b144d1f29d987dbc87977249493b3a8c6c0d25ad310037a577af98a65e9"
      end

      resource "sqlite" do
        version "0.8.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-arm64"
        sha256 "6d3c5750c65f9bb837f82f8a1e7bd9e42e8d777553f5cb6e695b509ef757a586"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-amd64"
      sha256 "5e4da65b598a4907bc382e0ae4a86a57d19a199b0b3d808e233d39e3900dfae5"

      resource "mysql" do
        version "0.8.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-amd64"
        sha256 "7ef7f6711b804896450754fde8c7cb2b22107fb942abd997d1de85302a00af04"
      end

      resource "sqlite" do
        version "0.8.0"
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-amd64"
        sha256 "b3c8d213b2a37eb5339c316afa07354e114edaa63c703d4d46b6f55bd5fc7987"
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
