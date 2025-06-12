class Seisfile < Formula
  desc "Library for reading and writing seismic file formats in java"
  homepage "https://www.seis.sc.edu/seisFile.html"
  url "https://github.com/crotwell/seisFile/releases/download/v2.3.0/seisFile-2.3.0.tar"
  sha256 "64eb776679a18e186135d6f35e9efd86e538ae5a0300a3bb30224a862d9067ea"
  license "LGPL-3.0-or-later"
  revision 2
  depends_on "openjdk"

  def install
    rm Dir["bin/*.bat"]
    man1.install "docs/manpage/seisfile.1"
    # etc.install "docs/bash_completion.d"
    libexec.install %w[bin lib]
    (bin/"seisfile").write_env_script libexec/"bin/seisfile", env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/seisfile --version")
    help_output = shell_output("#{bin}/seisfile help")
    assert_includes help_output, "Usage: seisfile [COMMAND]"
  end
end
