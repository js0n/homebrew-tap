class Mcps < Formula
  include Language::Python::Shebang

  desc "List Claude Code and Codex MCP servers by scope, across all projects"
  homepage "https://github.com/js0n/mcps"
  url "https://github.com/js0n/mcps/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c023aec64da7314c240161e7a27b7febf71156156edece0a33c6ed8679a0bd26"
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
      assert_match "demo-mcp", shell_output("#{bin}/mcps")
    end
  end
end
