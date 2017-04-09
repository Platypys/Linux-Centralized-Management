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

	$joonas@Miku:/etc/puppet/modules/apachecreate/manifests$ sudo puppet apply -e 'class {"apachecreate":}'
	[sudo] password for joonas: 
	Notice: Compiled catalog for miku.elisa-laajakaista.fi in environment production in 0.74 seconds
	Notice: /Stage[main]/Apachecreate/Package[apache2]/ensure: ensure changed 'purged' to 'present'
	Notice: /Stage[main]/Apachecreate/File[/var/www/html/index.html]/content: content changed '{md5}9ad421244b28db9cb4a6857edd297ef5' to '{md5}8f37b383ee80e28ec5abd439b117fab3'
	Notice: /Stage[main]/Apachecreate/Service[apache2]: Triggered 'refresh' from 1 events
	Notice: Finished catalog run in 19.03 seconds
	$joonas@Miku:/etc/puppet/modules/apachecreate/manifests$ sudo puppet apply -e 'class {"apachecreate":}'
	Notice: Compiled catalog for miku.elisa-laajakaista.fi in environment production in 0.79 seconds
	Notice: Finished catalog run in 0.06 seconds
	$joonas@Miku:/etc/puppet/modules/apachecreate/manifests$ sudo puppet apply -e 'class {"apachecreate":}'
	Notice: Compiled catalog for miku.elisa-laajakaista.fi in environment production in 0.44 seconds
	Notice: Finished catalog run in 0.08 seconds


I ran the command three times, but it seems that it made changes only on the first try. **Note** the line "ensure changed 'purged' to 'present'. Maybe there were traces of my previous apache installation left? Should have made sure it was completely gone...

### Sources
Package delete http://askubuntu.com/questions/1143/how-can-i-uninstall-software

Restarting using puppet https://www.puppetcookbook.com/posts/restart-a-service-when-a-file-changes.html

Puppet language https://docs.puppet.com/puppet/latest/lang_relationships.html#packagefileservice

Course site http://terokarvinen.com/2017/aikataulu-%E2%80%93-linuxin-keskitetty-hallinta-%E2%80%93-ict4tn011-11-%E2%80%93-loppukevat-2017-p2

My Blog https://joonaslappalainen.wordpress.com/
