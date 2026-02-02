class Seisfile < Formula
  desc "Library for reading and writing seismic file formats in java"
  homepage "https://www.seis.sc.edu/seisFile.html"
  url "https://github.com/crotwell/seisFile/releases/download/v2.3.3/seisFile-2.3.3.zip"
  sha256 "252b5c98a96c7ac19de2ce2811881c83f57ff1a641fba4bfc7797a52590ac65b"
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
