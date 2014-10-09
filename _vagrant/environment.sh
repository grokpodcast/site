#!/bin/sh
 
# Setup basic environment
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git-core vim software-properties-common curl whois

echo "**** Install postmodern's ruby-install"
wget -O /tmp/ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
cd /tmp
tar -xzvf ruby-install-0.4.3.tar.gz
cd ruby-install-0.4.3/
sudo make install
 
echo "**** Install postmodern's chruby"
wget -O /tmp/chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
cd /tmp
tar -xzvf chruby-0.3.8.tar.gz
cd chruby-0.3.8/
sudo make install
echo "\n#setup chruby\nsource /usr/local/share/chruby/chruby.sh\n" >> ~/.bashrc
 
echo "**** Install and configure ruby"
echo "set grub-pc/install_devices /dev/sda" | debconf-communicate
cd ~
ruby-install ruby 2.1
echo "\n#change to Ruby 2.1 by default\nchruby 2.1\n" >>  ~/.bashrc
