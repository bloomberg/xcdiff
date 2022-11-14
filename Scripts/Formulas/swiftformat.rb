class Swiftformat < Formula
  desc "Formatting tool for reformatting Swift code"
  homepage "https://github.com/nicklockwood/SwiftFormat"
  url "https://github.com/nicklockwood/SwiftFormat/archive/0.50.3.tar.gz"
  sha256 "ec7dd4f0ac892f99e174ea952a5395b2649c337670f7dac0a5b871fd741073c1"
  license "MIT"
  head "https://github.com/nicklockwood/SwiftFormat.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fca75bfe7fda2151c2972e7e9262e9ca6ce2f50e3fc562e0688dd817550813c2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f03398746b42c97a4057eb74c740a842b96b7fbb49b003057daf114d72db74b4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ff1b0f20ebaaa03a580817e8f4c670e54227c86c3c53d813899c276d03415461"
    sha256 cellar: :any_skip_relocation, monterey:       "5dddca5459af2ad28f1a9ef1e664da40ed664ae907c0351dc92b3cd0af52c29e"
    sha256 cellar: :any_skip_relocation, big_sur:        "7427e072a246141371df90135c5cea00c832bf2c511b62ef1cf49c1148b5bf23"
    sha256 cellar: :any_skip_relocation, catalina:       "a3de195f76316795eb6a56e240265a8fd41c042c7d515ae1df254aa3f577b540"
    sha256                               x86_64_linux:   "8557726207a8ce0871b950bf44ae9f2b8e95973ba026a77cf728d31cefc3ac00"
  end

  depends_on xcode: ["10.1", :build]

  uses_from_macos "swift"

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release"
    bin.install ".build/release/swiftformat"
  end

  test do
    (testpath/"potato.swift").write <<~EOS
      struct Potato {
        let baked: Bool
      }
    EOS
    system "#{bin}/swiftformat", "#{testpath}/potato.swift"
  end
end