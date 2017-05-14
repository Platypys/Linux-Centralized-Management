## My Own Puppet Module
Install Gedit and plugins. Change it to default for HTML.

### Purpose
My Puppet module installs Gedit and the readily available plugins for Gedit. It changes the default application for HTML-files to Gedit and removes mousepad text editor.

The module is developed and tested on a Virtual Xubuntu Machine.

### Environment
**Oracle Virtualbox instance:** Xubuntu 16.04 | 1GB RAM | 8GB  HDD

**Host:** Windows 10 x64 | 6GB RAM | i5345 CPU @3.10GHz

### Prep:
    $sudo apt-get update
    $sudo apt-get upgrade

### Reasons and what it does
As a baseline, Gedit is much more versatile than the default Xubuntu text editor Mousepad. I want an environment for HTML developement using Gedit. Some configuration is required to change the default text editor. The defaults.list file needs to be modified so it sets the application used for opening HTML files from Firefox to Gedit. Mousepad needs to be removed so Xubuntu actually uses gedit by default.

### Experimenting
I installed gedit and all it's available plugins using `sudo apt-get install gedit gedit-plugins`. After finishing the install, I started figuring out how to change the default programs. First I checked the current default programs used for `.txt` files and `.html` files. `.txt` files are open with Mousepad and .html files with Firefox. I manually went to */usr/share/applications/defaults.list* and modified the file so `.html` files are opened in Gedit. Interestingly plain text files are set to open in Gedit, yet they actually open in Mousepad, now the same happens with HTML files. So I need to get rid of Mousepad in order for Gedit to be the default. This was done with `sudo apt-get remove mousepad`. Now both plain text files and HTML files open in Gedit.

Now to do the same with Puppet!

### Writing the Puppet Module

#### Manifest
This is my process for creating the manifest init.pp for my Gedit puppet module step by step. It is located in */etc/puppet/modules/gedit/manifests*.

##### Package install
First I wrote the package installation part of the module to install gedit and gedit-plugins:
        
    class gedit {
	package { 'gedit':
		ensure => 'installed',
	}

	package { 'gedit-plugins':
		ensure => 'installed',
	}

It worked just fine, note that gedit and its plugins have been installed on this machine so it doesnt actually install them, but verifies that they are installed). Here are the results:

![alt-text](https://github.com/Platypys/Linux-Centralized-Management/blob/master/Own%20Puppet%20Module/img/package.PNG "Packages")
##### File
Then on to the file part, I need to change the contents of the defaults.list file at `text/html=`. Normally it is `text/html=firefox.desktop` and I need it to be `text/html=gedit.desktop`. I will be using a template to do that. Here is the File part of the manifest:

    file { '/etc/gnome/defaults.list':
		ensure => file,
		content => template('gedit/defaults.list'),
	}

#### Package remove
Last part is to remove mouspad text editor. Here is the removal part of the manifest:
        
        
        
### Sources
http://installion.co.uk/ubuntu/precise/universe/m/mousepad/uninstall/index.html
https://askubuntu.com/questions/13447/how-do-i-change-the-default-text-editor
https://www.puppetcookbook.com/posts/remove-package.html
