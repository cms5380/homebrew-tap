class AgentsSessionTracker < Formula
  desc "Raycast-style tracker for Claude Code / Codex sessions (menubar + CLI)"
  homepage "https://github.com/cms5380/agents-session-tracker"
  url "https://github.com/cms5380/agents-session-tracker/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "d61d624b48a5df4148f6a2164fc99e9798e6b1b2c602ebd82feb49f5f5dc0071"
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
