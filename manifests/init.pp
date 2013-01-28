# Class: cassandra
#
# This class installs Cassandra
#
# Notes:
#  This class is Ubuntu specific.
#
# Actions:
#  - Install DataStax Community distribution of Cassandra
#  - Manage the Cassandra service
#
# Sample Usage:
#  class { cassandra:
#    clustername => "cluster1"
#  }
#
class cassandra(
  $package = $cassandra::params::package,
  $clustername = $cassandra::params::clustername,
  $listen = $cassandra::params::listen,
  $initialtoken = $cassandra::params::initialtoken,
  $partitioner = $cassandra::params::partitioner,
  $repository = $cassandra::params::repository,
  $vardir = $cassandra::params::vardir
) inherits cassandra::params {

  include curl

  exec { "datastax-cassandra-apt-key":
    path => "/bin:/usr/bin",
    command => "curl -L http://debian.datastax.com/debian/repo_key | apt-key add -",
    unless => "apt-key list | grep B999A372",
    require => Package["curl"],
  }

  exec { "datastax-cassandra-apt-repo":
    path => "/bin:/usr/bin",
    command => "echo '${repository}' >> /etc/apt/sources.list",
    unless => "grep datastax /etc/apt/sources.list",
    require => Exec["datastax-cassandra-apt-key"],
  }

  exec { "datastax-cassandra-apt-update":
    path => "/bin:/usr/bin",
    command => "apt-get update",
    unless => "/usr/bin/test -e /etc/cassandra",
    require => Exec["datastax-cassandra-apt-repo"],
  }

  package { $package:
    ensure => installed,
    require => Exec["datastax-cassandra-apt-update"],
  }

  service { "cassandra":
    enable => true,
    ensure => running,
    require => Package[$package],
  }

  file { "/etc/cassandra/cassandra.yaml":
    content => template("cassandra/cassandra.yaml_${package}.erb"),
    mode => "0644",
    notify => Service["cassandra"],
    require => Package[$package],
  }

}
