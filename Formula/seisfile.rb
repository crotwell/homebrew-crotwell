class Seisfile < Formula
  desc "Library for reading and writing seismic file formats in java"
  homepage "https://www.seis.sc.edu/seisFile.html"
  url "https://github.com/crotwell/seisFile/releases/download/v2.3.4/seisFile-2.3.4.zip"
  sha256 "72a4c092c1ef962556559fefceb2e1c0fd710e4296b4e9c544f82c87cc2ceac0"
  license "LGPL-3.0-or-later"
  depends_on "openjdk"

  def install
    rm Dir["bin/*.bat"]
    man1.install "docs/manpage/seisfile.1"
    # etc.install "docs/bash_completion.d"
    libexec.install %w[bin lib]
    env = Language::Java.overridable_java_home_env
    (bin/"seisfile").write_env_script libexec/"bin/seisfile", env
  end

  test do
    # assert_match version.to_s, shell_output("#{bin}/seisfile --version")
    help_output = shell_output("#{bin}/seisfile help")
    assert_includes help_output, "Usage: seisfile [COMMAND]"
  end
end
