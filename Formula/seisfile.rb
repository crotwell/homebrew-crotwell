class Seisfile < Formula
  desc "library for reading and writing seismic file formats in java"
  homepage "https://www.seis.sc.edu/seisFile.html"
  url "https://www.seis.sc.edu/downloads/seisFile/seisFile-2.0.2.tgz"
  sha256 "03709a0eee72ff8a5c94f73d6f854efebb79c3fc5571df30280c830c120e6ae3"
  license "LGPL-3.0-or-later"

  def install
    rm_f Dir["bin/*.bat"]
    man1.install "docs/manpage/seisfile.1"
    etc.install Dir["docs/bash_completion.d"]
    libexec.install %w[bin lib]
    env = if Hardware::CPU.arm?
      Language::Java.overridable_java_home_env("11")
    else
      Language::Java.overridable_java_home_env
    end
    (bin/"seisfile").write_env_script libexec/"bin/seisfile", env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/seisfile --version")
    help_output = shell_output("#{bin}/seisfile help")
    assert_includes help_output, "Usage: seisfile [COMMAND]"
  end
end
