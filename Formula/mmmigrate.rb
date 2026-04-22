# typed: false
# frozen_string_literal: true

# Installs three driver-specific binaries side-by-side:
#   mmmigrate-postgres, mmmigrate-mysql, mmmigrate-sqlite
# Invoke the one that matches the database you're migrating.

class Mmmigrate < Formula
  desc "Forward-only SQL migration tool (postgres, mysql, sqlite variants)"
  homepage "https://github.com/middle-management/mmmigrate"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-arm64"
      sha256 "f1c6275505727c3b1fed8a47cc7336ff45a7e16bc5516970d98ab3729ab8adb8"

      resource "mysql" do
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-arm64"
        sha256 "6ecf937be9b2cd6d73f0fe19a75258ab029bd8ff1fb93d2da2fbffdeffb3a1a9"
      end

      resource "sqlite" do
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-arm64"
        sha256 "e371b6803ce032526e771caa9f59ef2144e4bfdd3d1ca8c124b5a7243c348c84"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-darwin-amd64"
      sha256 "62a20c23e0867c925a6c06f2e56e9f0e98d542c18c28c11e4f2ef50c3a958866"

      resource "mysql" do
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-darwin-amd64"
        sha256 "1e5bfa177bf6e469897342eefb16e1fa360154b2d3c36df603507c451fa522f0"
      end

      resource "sqlite" do
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-darwin-amd64"
        sha256 "12d9f7b2f09f1bb9444ffdaf15ee26efff8a2de4ed5b9a7a70d220733db325b8"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-arm64"
      sha256 "20916a9788f84c8477bad758bbec2dbacf516ba7e0c8e68e2d498ff303f8077e"

      resource "mysql" do
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-arm64"
        sha256 "8f94d18f7b3fa75858dcd0a330fb7be71159757c5be3876ae03a7a9862fefd36"
      end

      resource "sqlite" do
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-arm64"
        sha256 "6f3b4fde5011b84276b1396dddd79ca15c56acf01096ecb647e2ad504294a7fe"
      end
    end
    on_intel do
      url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-postgres-linux-amd64"
      sha256 "4150a0af0616cefd7e26861e59b66e9e61ea93345cc6d83d6e8d441376ef5d92"

      resource "mysql" do
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-mysql-linux-amd64"
        sha256 "dbb8962be6b2327342c22da11cbc6835e90764c40d5af8997ddf8b540fb5cf05"
      end

      resource "sqlite" do
        url "https://github.com/middle-management/mmmigrate/releases/download/v#{version}/mmmigrate-sqlite-linux-amd64"
        sha256 "8058111ee4941db1369bcc193f2b33e6e31afb2ae85b9e1c06f2a83b4fb77da8"
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
