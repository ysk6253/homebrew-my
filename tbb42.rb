require "formula"

class Tccbb42 < Formula
    homepage "http://www.threadingbuildingblocks.org/"
    url "https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb43_20140724oss_src.tgz"
    sha1 "4cb73cd0ac61b790318358ae4782f80255715278"
    version "4.3-20140724"
    
    bottle do
end

option :cxx11

def install
    # Intel sets varying O levels on each compile command.
    ENV.no_optimization
    
    args = %W[tbb_build_prefix=BUILDPREFIX]
    
    case ENV.compiler
        when :clang
        args << "compiler=clang"
        else
        args << "compiler=gcc"
    end
    
    if MacOS.prefer_64_bit?
        args << "arch=intel64"
        else
        args << "arch=ia32"
    end
    
    if build.cxx11?
        ENV.cxx11
        args << "cpp0x=1" << "stdlib=libc++"
    end
    
    system "make", *args
    lib.install Dir["build/BUILDPREFIX_release/*.dylib"]
    include.install "include/tbb"
end
end
