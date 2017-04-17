## Assignment 3

Create a puppet module that installs  SSH and changes the default port.

Create a puppet module that installs apache2 and changes the default page.

Templates and the ready modules are found in the on GIT in h3.

### Environment
**Oracle Virtualbox instance:** Xubuntu 16.04 | 1GB RAM | 8GB  HDD

**Host:** Windows 10 x64 | 6GB RAM | i5345 CPU @3.10GHz

### Prep:
    $sudo apt-get update
    $sudo apt-get upgrade

### Create SSH puppet module

Created a template in the SSH module template directory.

Module needs to install SHH package, make sure its running and change the config file to specify the wanted port in addition to restarting the service.

```

class ssh{	
	package{"ssh":
		ensure => "installed",
	}
	
	service{"sshd":
		ensure => "running",
		enable => "true",
		require => Package["ssh"],
	}
	
	file{"/etc/ssh/sshd_config":
		content => template('ssh/sshd_config.erb'),
		require => Package["ssh"],
		notify => Service["sshd"],
	}
}
```

Applied module with command:
      
    sudo puppet apply -e 'class '{'ssh':}'
    
### Create Apache2 puppet module

Created a template in the Apache2 module template directory.

Module needs to install apache2, create a public_html directory for the user, create a index.html file to that directory and use the available template to replace the existing default page.

```
class apache {
	package{'apache2':
		ensure => 'installed',
	}

	service{'apache2':
		ensure => 'running',
		enable => 'true',
		require => Package['apache2'],
	}
	
	file{'/home/joonas/public_html':
		ensure => 'directory',
		owner => 'joonas',
		group => 'joonas',
	}
	
	file{'/home/joonas/public_html/index.html':
		ensure => 'file',
		content => "Hello World",
		owner => 'joonas',
		group => 'joonas',
	}

	file{'/etc/apache2/sites-available/joonas.conf':
		content => template('apacheconf/joonas.conf.erb'),
		require => Package['apache2'],
		owner => 'root',
		group => 'root',
	}
	
	file{'/etc/apache2/sites-enabled/joonas.conf':
		ensure => 'link',
		target => '/etc/apache2/sites-available/joonas.conf',
		notify => Service['apache2'],
		require => Package['apache2'],
	}
	
	file{'/etc/apache2/sites-enabled/000-default.conf':
		ensure => 'absent',
		notify => Service['apache2'],
		require => Package['apache2'],
	}
}
```
