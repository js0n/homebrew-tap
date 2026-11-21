class Mcps < Formula
  include Language::Python::Shebang

  desc "List Claude Code and Codex MCP servers by scope, across all projects"
  homepage "https://github.com/js0n/mcps"
  url "https://github.com/js0n/mcps/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "0322074f59e0347747cf6eaba2c433355469419d60bf68293729dd80e1df57e5"
  license "MIT"

  depends_on "python@3.14"

  def install
    rewrite_shebang detected_python_shebang, "mcps"
    bin.install "mcps"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mcps --version")
    (testpath/".claude.json").write <<~JSON
      {"mcpServers": {"demo": {"command": "demo-mcp"}}}
    JSON
    with_env(HOME: testpath.to_s) do
      assert_match "demo-mcp", shell_output(bin/"mcps")
    end
  end
end
