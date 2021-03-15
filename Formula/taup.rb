# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Taup < Formula
  desc ""
  homepage ""
  url "https://www.seis.sc.edu/downloads/TauP/prerelease/TauP-2.5.0-SNAPSHOT.tgz"
  sha256 "402bd4780b8cc940ded684d706324908696de007b671f2f3bd70f4c3e15c554e"
  license "LGPL-3.0-or-later"

    bottle :unneeded

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
