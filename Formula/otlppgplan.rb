# typed: false
# frozen_string_literal: true

# NOTE: release v0.0.1 currently has no prebuilt assets uploaded.
# This formula assumes the standard asset naming used across the other
# middle-management Go tools (otlppgplan-<os>-<arch>). Once the binaries
# are published at that path, run ./update-shas.sh to fill in the sha256s.

class Otlppgplan < Formula
  desc "OTLP PostgreSQL query plan exporter"
  homepage "https://github.com/middle-management/otlppgplan"
  version "0.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/otlppgplan/releases/download/v#{version}/otlppgplan-darwin-arm64"
      sha256 "REPLACE_ME_otlppgplan-darwin-arm64"
    end
    on_intel do
      url "https://github.com/middle-management/otlppgplan/releases/download/v#{version}/otlppgplan-darwin-amd64"
      sha256 "REPLACE_ME_otlppgplan-darwin-amd64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/otlppgplan/releases/download/v#{version}/otlppgplan-linux-arm64"
      sha256 "REPLACE_ME_otlppgplan-linux-arm64"
    end
    on_intel do
      url "https://github.com/middle-management/otlppgplan/releases/download/v#{version}/otlppgplan-linux-amd64"
      sha256 "REPLACE_ME_otlppgplan-linux-amd64"
    end
  end

  def install
    bin.install Dir["*"].first => "otlppgplan"
  end

  test do
    assert_predicate bin/"otlppgplan", :exist?
    system bin/"otlppgplan", "--help"
  end
end
