# Ubuntu with Docker

This project sets up an Ubuntu 15.04 VM with Docker installed.

# Usage

This project requires that [Vagrant](https://www.vagrantup.com/downloads.html), [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and the [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf) plugin be installed.

1. Clone this repository
2. From a command line, call: `vagrant up`

The VM has an IP address of 192.168.50.10 and runs the Sinatra server inside a container that exposes port 80. So, after calling `vagrant up`, you can browse to 192.168.50.10 to see it working.
