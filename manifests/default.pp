exec { "apt-get update":
  path => "/usr/bin",
}
package { "openjdk-7-jdk":
  ensure  => present,
  require => Exec["apt-get update"],
}
package { "zsh":
  ensure  => present,
  require => Exec["apt-get update"],
}
package { "apache2":
  ensure  => present,
  require => Exec["apt-get update"],
}
package { "tomcat7":
  ensure  => present,
  require => Exec["apt-get update"],
}
service { "apache2":
  ensure  => "running",
  require => Package["apache2"],
}
file { "/var/www/sample-webapp":
  ensure  => "link",
  target  => "/vagrant/sample-webapp",
  require => Package["apache2"],
  notify  => Service["apache2"],
}

include postgresql::server
postgresql::db { 'testdb':
  user     => 'test',
  password => 'test'
}

file {'testfile':
      path    => '/tmp/testfile',
      ensure  => present,
      mode    => 0640,
      content => "I'm a test file.",
}
    
user { 'dave':
      ensure     => present,
      uid        => '507',
      gid        => 'admin',
      shell      => '/bin/zsh',
      home       => '/home/dave',
      password   => sha1("1234"),
      managehome => true
}

user { 'mona':
      ensure     => present,
      uid        => '508',
      gid        => 'admin',
      shell      => '/bin/zsh',
      home       => '/home/mona',
      password   => '$1$sB3SBkM.$mvmnJU3VrsR5e9hiPuaF1.',
      managehome => true
}