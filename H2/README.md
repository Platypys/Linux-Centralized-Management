## Assignment 2:
Install and configure a service using Puppet Package-File-Service

### Environment
Oracle Virtualbox instance: Xubuntu 16.04 | 1GB RAM | 8GB  HDD
Host: Windows 10 x64 | 6GB RAM | i5345 CPU @3.10GHz

### Prep:
    $sudo apt-get update
    $sudo apt-get upgrade

Puppet is installed

### Create module
We are going to create a puppet module that installs Apache2 to the system and configures a index page.

The current system already has Apahce2 installed, so we need to get rid of that istallation first:
    
    $sudo apt-get purge apache2

Next we need to make the necessary directories for our module:
    
    $sudo mkdir -p /etc/puppet/modules/apachecreate/manifests
Moving to that directory path and creating our init.pp file

    $sudo nano init.pp

Our init.pp is going to look like this:
    
    class apachecreate {
	    package {'apache2':
		    ensure => 'installed',
	    }
	    file {'/var/www/html/index.html':
		    content => "If I were to give you my sword, what would you do with it?",
            notify => Service['apache2'],
	    }
	    service {'apache2':
		    ensure => 'running',
		    require => [
			    Package['apache2'],
			    File['/var/www/html/index.html'],
		    ]
	    }
    }

#### Hypothesis
We might need to run the puppet couple times for it to work correctly, because it needs to install at the same time as it runs. This might be fixed with some modifications to the init.pp that I have yet to discover.

    $sudo puppet apply -e 'class {"apachecreate":}'

#### Result
I ran the command three times, but it seems that it made changes only on the first try. Note the line "ensure changed 'purged' to 'present'. Maybe there were traces of my previous apache installation left? Should have made sure it was completely gone...

### Sources
Package delete http://askubuntu.com/questions/1143/how-can-i-uninstall-software
Restarting using puppet https://www.puppetcookbook.com/posts/restart-a-service-when-a-file-changes.html
