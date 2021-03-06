include_recipe "apt"
include_recipe "build-essential"
include_recipe "mokhan-myface::user"
include_recipe "mokhan-myface::aws"
include_recipe "mokhan-myface::monit"

packages = [
  "curl",
  "libcurl3", "libcurl3-gnutls", "libcurl4-openssl-dev",
  "git-core",
  "python-software-properties",
  "build-essential",
  "tklib",
  "zlib1g-dev",
  "libssl-dev",
  "libreadline-gplv2-dev",
  "libxml2",
  "libxml2-dev",
  "libxslt1-dev",
  "gawk",
  "libreadline6-dev",
  "libyaml-dev",
  "libsqlite3-dev",
  "autoconf",
  "libgdbm-dev",
  "libncurses5-dev",
  "automake",
  "libtool",
  "bison",
  "pkg-config",
  "libffi-dev",
  "vim",
  "unzip",
]

packages.each do |item|
  package item do
    action :upgrade
  end
end
