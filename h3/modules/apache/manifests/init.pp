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
