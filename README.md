# What does it do?

This vagrant configuration sets up a basic LAMP environment suited for Symfony 2 development:

* Based on Ubuntu Lucid
* Apache 2.2
* PHP 5.3 with intl and readline, xdebug, sqlite extensions
* phpMyAdmin
* MySQL Server 5.1
* Git and SVN clients

# Prerequisites

## Install Vagrant

Obviously, you need [Vagrant](http://www.vagrantup.com/), which in turn requires Ruby and VirtualBox. Vagrant runs on Linux, OS X, and Windows, although some special configuration applies to Windows (see below).

## Download and install a base image

    $ vagrant box add base http://files.vagrantup.com/lucid32.box

This example uses the default Ubuntu image from the Vagrant project, although you can use other Ubuntu boxes if you like. If you do not name the box "base", you will later on need to adapt the Vagrantfile in the project root directory.

## Setup a working directory and start your new environment

    $ git clone git://github.com/erivello/sf2-vagrant.git mydir/vagrant
    $ cd mydir
    $ cd vagrant
    $ vagrant up

## Vagrant up fails

Run this in your command line:

    $ VBoxManage list vms | grep cat .vagrant | cut -d\" -f 6 | cut -d\" -f2

this returns a string (like sf2-vagrant_1343247736) to be used in the next command line:

    $ VBoxManage guestcontrol sf2-vagrant_1343247736 exec "/usr/bin/sudo" --username vagrant --password vagrant --verbose dhclient

Depending on the versions of the box and your VirtualBox installation, you might see a notice that the guest additions of the box do not match the version of VirtualBox you are using. If you encounter any problems, you might want to install up to date guest additions on your box once running and [repackage it for use with Vagrant](http://vagrantup.com/docs/getting-started/packaging.html).

If you prefer a clean URL, you might want to map `33.33.33.100` to a local domain of your choice in your hosts file. This is entirely optional.

## Use it

### Webserver

Vagrant will create one additional directory:

`mydir/vagrant/log/apache2` for Apache logs.

Drop your Symfony 2 app into the `mydir/project` directory. Apache will use `mydir/project/web` as the web root.

The app is now accessible from your host system at [http://33.33.33.100](http://33.33.33.100).

### MySQL

The setup will configure MySQL with a user/password of root/root. PhpMyAdmin is at [http://33.33.33.100/phpmyadmin](http://33.33.33.100/phpmyadmin).

### SSH and the Symfony console

Connect to your virtual machine:

    $ vagrant ssh

Change to your project directory and launch the Symfony shell:

    vagrant@vagrantup:~$ cd /project
    vagrant@vagrantup:~$ ./app/console -s

## Notes

Vagrant will run on Windows without problems, although this is not tested with this specific configuration. As Windows does not offer NFS, you will however need to comment out the corresponding line in `mydir/vagrant/Vagrantfile`.

If you want to use multiple instances of this virtual machine at the same time on a single host, you will need to edit the IP set in `mydir/vagrant/Vagrantfile` to avoid conflicts.



