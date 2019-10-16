class Seabolt < Formula
  desc "Neo4j Bolt Connector for C"
  homepage "https://github.com/neo4j-drivers/seabolt"
  url "https://github.com/neo4j-drivers/seabolt/archive/v1.7.4.tar.gz"
  sha256 "f51c02dfef862d97963a7b67b670750730fcdd7b56a11ce87c8c1d01826397ee"

  depends_on "cmake" => :build
  depends_on "openssl"

  def install
    system "mkdir", "build"
    Dir.chdir('build')
    system "cmake", "..", *std_cmake_args
    system "cmake", "--build", ".", "--target", "install"
    
    bin.install "bin/seabolt-cli"
  end

  test do
    require "open3"
    Open3.popen3("BOLT_USER= #{bin}/seabolt-cli run \"UNWIND range(1, 3) AS n RETURN n\"") do |_, _, stderr|
      assert_equal "FATAL: Failed to connect", stderr.read.strip
    end
  end
end
