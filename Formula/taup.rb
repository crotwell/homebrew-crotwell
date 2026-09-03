class Taup < Formula
  desc "Flexible Seismic Travel-Time and Raypath Utilities"
  homepage "https://www.seis.sc.edu/TauP/"
  url "https://zenodo.org/records/22287948/files/TauP-3.2.1.zip"
  sha256 "57a25c1420fdaeff9685e42b0fce4d70cc5656bcc6437fe4c06a1c2cbe81d295"
  license "LGPL-3.0-or-later"
  depends_on "openjdk"

  def install
    rm Dir["bin/*.bat"]
    libexec.install %w[bin docs lib src]
    env = Language::Java.overridable_java_home_env
    (bin/"taup").write_env_script libexec/"bin/taup", env
    cp "./taup_completion", "./taup_completion.bash"
    bash_completion.install "./taup_completion.bash"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/taup --version")
    taup_output = shell_output("#{bin}/taup help")
    assert_includes taup_output, "Usage: taup"
  end
end
