class AgentsSessionTracker < Formula
  desc "Raycast-style tracker for Claude Code / Codex sessions (menubar + CLI)"
  homepage "https://github.com/cms5380/agents-session-tracker"
  url "https://github.com/cms5380/agents-session-tracker/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d3e4f177466fdaee4777fa3e95654fa6f7e3944c03895fdf224648feeded1cf9"
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
