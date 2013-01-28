# Class: cassandra::params
#
# This class manages Cassandra parameters
#
# Parameters:
# - The DataStax package to use
# - The name of the cluster
# - Network interface to listen on
# - Initial token to use
# - The partitioner type
#   http://www.datastax.com/docs/1.0/cluster_architecture/partitioning
# - The DataStax repository to use
# - Base directory where cassandra data is stored
#
# Sample Usage:
#  include cassandra::params
#
class cassandra::params {
  $package = "dsc12"
  $clustername = "Test Cluster"
  $listen = "localhost"
  $initialtoken = ""
  $partitioner = "Murmur3Partitioner"
  $repository = "deb http://debian.datastax.com/community stable main"
  $vardir = "/var/lib/cassandra"
}
