class AgentsSessionTracker < Formula
  desc "Raycast-style tracker for Claude Code / Codex sessions (menubar + CLI)"
  homepage "https://github.com/cms5380/agents-session-tracker"
  url "https://github.com/cms5380/agents-session-tracker/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "6a8e302c3c0a678d230c789bf28568bf21b34d6051d1468bde064d8c3fec762c"
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
