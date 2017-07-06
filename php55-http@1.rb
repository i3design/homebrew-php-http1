require File.expand_path("/usr/local/Homebrew/Library/Taps/homebrew/homebrew-php/Abstract/abstract-php-extension", __FILE__)

class Php55HttpAT1 < AbstractPhp55Extension
  init
  desc "This HTTP extension aims to provide a convenient and powerful set of functionality for one of PHPs major applications."
  homepage "https://pecl.php.net/package/pecl_http"
  url "https://github.com/m6w6/ext-http/archive/RELEASE_1_7_6.tar.gz"
  sha256 "b0012dda19eee9c5af0280d30fbbb7bd9e38cb29225766764689830d90109283"
  revision 1

  head "https://github.com/m6w6/ext-http.git"

  depends_on "curl"
  depends_on "libevent"

  def config_filename
    "ext-http@1.ini"
  end

  def extension
    "http"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent-dir=#{Formula["libevent"].opt_prefix}",
                          "--with-curl-dir=#{Formula["curl"].opt_prefix}"
    system "make"
    prefix.install "modules/http.so"
    write_config_file if build.with? "config-file"
  end
end
