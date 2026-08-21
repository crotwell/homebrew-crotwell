class Seisfile < Formula
  desc "Library for reading and writing seismic file formats in java"
  homepage "https://www.seis.sc.edu/seisFile.html"
  url "https://github.com/crotwell/seisFile/releases/download/v2.4.0/seisFile-2.4.0.zip"
  sha256 "2a59a3f46fd286ce5e04ea9c2f00ad33046df3eb6751ddcf7c53d4361b2edd9c"
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
