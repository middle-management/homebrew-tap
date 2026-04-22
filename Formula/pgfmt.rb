# typed: false
# frozen_string_literal: true

# Installs two binaries from the same release:
#   pgfmt      — the formatter
#   pgfmt-lsp  — Language Server Protocol implementation

class Pgfmt < Formula
  desc "PostgreSQL SQL formatter (with bundled LSP server)"
  homepage "https://github.com/middle-management/pgfmt"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-darwin-arm64"
      sha256 "7a0527a24272cac13d4400d38c966b541efed85073d787fdd787174fa37347f4"

      resource "lsp" do
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-darwin-arm64"
        sha256 "b2fc4bab808fc4388d4cb13040faaec08f4532e3c3e9eab2a250c171a77d7cee"
      end
    end
    on_intel do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-darwin-amd64"
      sha256 "692dd9f9a92fd102a1afdbdd7357277ca7da7456a5cd23e0ea13e06543978e7f"

      resource "lsp" do
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-darwin-amd64"
        sha256 "7962f0be6ff308e31d7af228cabbb64c1d89704aeaf50b86bea2ef4ab4e7397b"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-linux-arm64"
      sha256 "27a81b7552221fc2de15cbfcf4b8203b0b42347f56394d261fe30c46a0713335"

      resource "lsp" do
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-linux-arm64"
        sha256 "527513a6071f14f44773beb0926988994420929e9279ff8f023518caed18c53c"
      end
    end
    on_intel do
      url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-linux-amd64"
      sha256 "95ccc7d6f525b108027350da444c997e341445a0fb79f2b8b4b7d5be68015a32"

      resource "lsp" do
        url "https://github.com/middle-management/pgfmt/releases/download/v#{version}/pgfmt-lsp-linux-amd64"
        sha256 "a7f95503ef4cf18aeaf6fc94a78541aa7c86850b824ad3a7520df41401eba93a"
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
    assert_predicate bin/"pgfmt", :exist?
    assert_predicate bin/"pgfmt-lsp", :exist?
    assert_match "pgfmt", shell_output("#{bin}/pgfmt --help 2>&1", 0..2)
  end
end
