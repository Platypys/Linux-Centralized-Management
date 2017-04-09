class apachecreate {
	package {'apache2':
		ensure => 'installed',
	}

	file {'/var/www/html/index.html':
		content => "If I were to give you my sword, what would you do with it?",
		notify => Service[apache2],
	}
 
	service {'apache2':
		ensure => 'running',
		require => [
			Package['apache2'],
			File['/var/www/html/index.html'],
		]
	}
}
