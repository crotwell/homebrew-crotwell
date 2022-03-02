class Taup < Formula
  desc "Flexible Seismic Travel-Time and Raypath Utilities"
  homepage "https://www.seis.sc.edu/TauP/"
  url "https://github.com/crotwell/TauP/releases/download/v2.6.0/TauP-2.6.0.tgz"
  sha256 "1ce62415b4c4acaeb3f5f2421e5f84260e6e502fd33eabccc58b5ed713c417c9"
  license "LGPL-3.0-or-later"

  def install
    rm_f Dir["bin/*.bat"]
    rm_f Dir["bin/taup_*"]
    libexec.install %w[bin docs lib src]
    env = if Hardware::CPU.arm?
      Language::Java.overridable_java_home_env("11")
    else
      Language::Java.overridable_java_home_env
    end
    (bin/"taup").write_env_script libexec/"bin/taup", env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/taup --version")
    taup_output = shell_output("#{bin}/taup help")
    assert_includes taup_output, "Usage: taup"
  end
end
