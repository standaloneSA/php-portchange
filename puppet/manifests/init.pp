node default { 


	class { 'mysql::server':
		root_password				=> 'ChangeMe',
		remove_default_accounts	=> 'true',
	}


	mysql::db { 'portchange':
		user			=> 'portchange', 
		password		=> 'Changeme', 
		host			=> 'localhost',
		grant			=> [ 'ALL' ], 
	}

	include network

	service { 'NetworkManager':
		ensure	=> stopped,
	}


	file { '/etc/sysconfig/network-scripts/ifcfg-eno16780032':
		ensure	=> present, 
		mode		=> '0644',
		source	=> '/tmp/ifcfg-eno16780032',
		notify	=> Service['network'],
		require	=> File['/etc/sysconfig/network-scripts/ifcfg-br0'],
	}

	file { '/etc/sysconfig/network-scripts/ifcfg-veth0':
		ensure	=> present, 
		mode		=> '0644',
		source	=> '/tmp/ifcfg-veth0',
		require	=> File['/etc/sysconfig/network-scripts/ifcfg-br0'],
		notify	=> Service['network'],
	}

	file { '/etc/sysconfig/network-scripts/ifcfg-veth1':
		ensure	=> present, 
		mode		=> '0644',
		source	=> '/tmp/ifcfg-veth1',
		require	=> File['/etc/sysconfig/network-scripts/ifcfg-br0'],
		notify	=> Service['network'],
	}

	file { '/etc/sysconfig/network-scripts/ifcfg-br0':
		ensure	=> present, 
		mode		=> '0644',
		source	=> '/tmp/ifcfg-br0',
		notify	=> Service['network'],
	}

	class { 'apache': } 

   service { 'firewalld':
		ensure	=> stopped,
	}

	service { 'network':
		ensure	=> running, 
	} -> 

	apache::vhost { 'portchange.ccs.neu.edu':
		port		=>	'8080',
		docroot	=> '/var/www/portchange',
		ip			=> "$::fact::ipaddress_veth0",
	}

	package { 'telnet':
		ensure	=> installed,
	}

	file { '/etc/sysconfig/network':
		ensure	=> present,
		content	=> "GATEWAY=10.254.0.1",
	}

	


	

	
	
		
	
	
} 
