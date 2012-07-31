class package_base
{
  group {
    "puppet": ensure => "present";
  }

  file 
  {
    'apt.config':
      path    => '/etc/apt/apt.conf.d/99aptcache',
      ensure  => present,
      source  => '/vagrant/vagrant/resources/apt-config'
  }

  file 
  {
    'karmic.sources':
      path    => '/etc/apt/sources.list.d/karmic.list',
      ensure  => present,
      source  => '/vagrant/vagrant/resources/karmic-sources',
      require => File['apt.config']
  }

  file 
  {
    'php.preferences':
      path    => '/etc/apt/preferences.d/php',
      ensure  => present,
      source  => '/vagrant/vagrant/resources/karmic-preferences',
      require => File['karmic.sources']
  }

  exec
  {
    'init':
      command => 'apt-get update',
      path    => '/usr/bin/',
      require => File['karmic.sources']
  }

  package
  {
    'htop':
      ensure  => present,
      require => Exec['init']
  }

}
