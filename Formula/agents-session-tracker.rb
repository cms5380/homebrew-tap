class AgentsSessionTracker < Formula
  desc "Raycast-style tracker for Claude Code / Codex sessions (menubar + CLI)"
  homepage "https://github.com/cms5380/agents-session-tracker"
  url "https://github.com/cms5380/agents-session-tracker/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "ddd586a6ddfbb34705e5254b64f0d49bf301313d4778f1a7b0a2349b11d8cdf3"
  license "MIT"

  depends_on "jq"
  depends_on :macos

  def install
    libexec.install Dir["*"]
    (bin/"agents-session-tracker-setup").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/install.sh" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Finish setup (registers Claude hooks, builds the menubar app,
      enables login autostart):

        agents-session-tracker-setup            # add --codex for Codex too

      Requires the Xcode Command Line Tools (xcode-select --install)
      for the one-time app build.
    EOS
  end

  test do
    assert_predicate libexec/"bin/ast", :exist?
  end
end
