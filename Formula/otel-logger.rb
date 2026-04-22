# typed: false
# frozen_string_literal: true

class OtelLogger < Formula
  desc "OpenTelemetry log forwarder"
  homepage "https://github.com/middle-management/otel-logger"
  version "0.2.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/otel-logger/releases/download/v#{version}/otel-logger-darwin-arm64"
      sha256 "b63cf2a8018e90c182d31a82340aae1535d478d8eb700d1fe2dd7e7c0b5c5fc0"
    end
    on_intel do
      url "https://github.com/middle-management/otel-logger/releases/download/v#{version}/otel-logger-darwin-amd64"
      sha256 "5bf44ed92048d298c97aa60efc59c29ef56c58d22f88d422b61dc1801bf5c748"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/otel-logger/releases/download/v#{version}/otel-logger-linux-arm64"
      sha256 "87a7b3633fea71d20ca61c8f5f9ba32dcbbe8b33ef844bdda4223b4f53adedac"
    end
    on_intel do
      url "https://github.com/middle-management/otel-logger/releases/download/v#{version}/otel-logger-linux-amd64"
      sha256 "96fedb65febcc88492176f42b7ad67d4740c76c3c45099e98ea99e856d0ab7e1"
    end
  end

  def install
    bin.install Dir["*"].first => "otel-logger"
  end

  test do
    assert_predicate bin/"otel-logger", :exist?
    system bin/"otel-logger", "--help"
  end
end
