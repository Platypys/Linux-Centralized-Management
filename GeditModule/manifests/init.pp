class gedit {
	package { 'gedit':
		ensure => 'installed',
	}

	package { 'gedit-plugins':
		ensure => 'installed',
	}

	file { '/etc/gnome/defaults.list':
		ensure => file,
		content => template('gedit/defaults.list'),
	}
}
