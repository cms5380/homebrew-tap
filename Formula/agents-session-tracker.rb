class AgentsSessionTracker < Formula
  desc "Raycast-style tracker for Claude Code / Codex sessions (menubar + CLI)"
  homepage "https://github.com/cms5380/agents-session-tracker"
  url "https://github.com/cms5380/agents-session-tracker/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "1a3a58edb4b5630c8353ae17a8f8ac96cbe6e643c6a96ee5714415280ad11057"
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
    assert_predicate libexec/"bin/cst", :exist?
  end
end
