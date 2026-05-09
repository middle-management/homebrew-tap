# typed: false
# frozen_string_literal: true

# Installs two binaries from the same release:
#   pgfmt      — the formatter
#   pgfmt-lsp  — Language Server Protocol implementation

class Pgfmt < Formula
  desc "PostgreSQL SQL formatter (with bundled LSP server)"
  homepage "https://github.com/middle-management/pgfmt"
  version "0.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-darwin-arm64"
      sha256 "92993d7c08118ec9b2d8c3b22b358f0870b694ce20fb0fc6307f1270ac2322b7"

      resource "lsp" do
        version "0.3.3"
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-darwin-arm64"
        sha256 "762b17fc7eb92e68fc91e98c99249828d0078720e3552a2f4bb44ad2d19cd209"
      end
    end
    on_intel do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-darwin-amd64"
      sha256 "b96e7b79a44ba76c8e2117fa6b7ce219302c051fe5ea94f48b42a4931b8b66f7"

      resource "lsp" do
        version "0.3.3"
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-darwin-amd64"
        sha256 "0fabe17667631fd0767010e13ab27d232adf3ffd73f5b3f5e92536f0c24ccd84"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-linux-arm64"
      sha256 "483286d7a0e0403299794ca07f36eb49167f250f32d7a8e43f7ccc5b85ceb099"

      resource "lsp" do
        version "0.3.3"
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-linux-arm64"
        sha256 "a71e20c21f3e43723ef11b53add0066f365cbbe516fb979e42758e7876b1ee26"
      end
    end
    on_intel do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-linux-amd64"
      sha256 "a649696431b0f892be4aba373d8365aea8ecb3897896df7cc6978eaafbec1fd5"

      resource "lsp" do
        version "0.3.3"
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-linux-amd64"
        sha256 "7f194b772cee6f6342856838676ddac1ea06bc1e50c8e7e16feaffa1029db8bc"
      end
    end
  end

  def install
    # Top-level download is pgfmt-<os>-<arch>; LSP comes from the resource.
    bin.install Dir["pgfmt-*"].first => "pgfmt"
    resource("lsp").stage do
      bin.install Dir["pgfmt-lsp-*"].first => "pgfmt-lsp"
    end
  end

  test do
    assert_path_exists bin/"pgfmt"
    assert_path_exists bin/"pgfmt-lsp"
    assert_match "pgfmt", shell_output("#{bin}/pgfmt --help 2>&1", 0..2)
  end
end
