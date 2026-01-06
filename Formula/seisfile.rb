class Seisfile < Formula
  desc "Library for reading and writing seismic file formats in java"
  homepage "https://www.seis.sc.edu/seisFile.html"
  url "https://github.com/crotwell/seisFile/releases/download/v2.3.2/seisFile-2.3.2.zip"
  sha256 "4091c8d9723fe0a6d709f682d6f726058645b387563368204a5a9fc4d1fde1fa"
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
