class Seisfile < Formula
  desc "Library for reading and writing seismic file formats in java"
  homepage "https://www.seis.sc.edu/seisFile.html"
  url "https://github.com/crotwell/seisFile/releases/download/v2.0.3/seisFile-2.0.3.tgz"
  sha256 "43d2229adeb157a809a394fc3dc14f14c953c8ce48d245d46f8f9cafa1b0e1f2"
  license "LGPL-3.0-or-later"

  def install
    rm_f Dir["bin/*.bat"]
    man1.install "docs/manpage/seisfile.1"
    etc.install "docs/bash_completion.d"
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
