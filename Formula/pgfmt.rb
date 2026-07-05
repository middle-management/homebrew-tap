# typed: false
# frozen_string_literal: true

# Installs two binaries from the same release:
#   pgfmt      — the formatter
#   pgfmt-lsp  — Language Server Protocol implementation

class Pgfmt < Formula
  desc "PostgreSQL SQL formatter (with bundled LSP server)"
  homepage "https://github.com/middle-management/pgfmt"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-darwin-arm64"
      sha256 "5cc5ad6049a820d5760266b932dcc21cf89adb0d115a93dde3451f47a31ce55d"

      resource "lsp" do
        version "0.4.0"
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-darwin-arm64"
        sha256 "10a50cbd605927bdbd6a4d755812bc3968158335c4d6f11f005c6c16dc58e702"
      end
    end
    on_intel do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-darwin-amd64"
      sha256 "ff8e9190070024f124eb79ce921d3a8677852d0ae7ddb4962339bbdda3c9bb72"

      resource "lsp" do
        version "0.4.0"
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-darwin-amd64"
        sha256 "bcbdd3be994477eb7df73775bbc85eb8f12eb85b78531c0937960e4f797613dd"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-linux-arm64"
      sha256 "a41715200370fe94e93a2442a4433005a6485aa73b7297ed86d0acf3a08e6c49"

      resource "lsp" do
        version "0.4.0"
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-linux-arm64"
        sha256 "981e52877f4830f889ae7759ae41b31b00057e2e505f40ef04bf28ff4cc2266a"
      end
    end
    on_intel do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-linux-amd64"
      sha256 "3ac7bfba3890d9a4bf22187b349775798f8ddba4dc10d27720483cff06bfca04"

      resource "lsp" do
        version "0.4.0"
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-linux-amd64"
        sha256 "cbcaf73d40ab981f586f089de479f7756ac1140ec6cbb3e5e1104104130e7352"
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
