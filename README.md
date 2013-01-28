# puppet-cassandra

This class manages cassandra via Puppet.  It is Ubuntu specific.

## Sample Usage

```
class { "cassandra":
  clustername => "cluster1",
  listen => "0.0.0.0",
}
```

## Parameters:

 * $listen: ip address to bind to
 * $package: The DataStax package to use
 * $clustername: The name of the cluster
 * $initialtoken: Initial token to use
 * $partitioner: The partitioner type
   http://www.datastax.com/docs/1.0/cluster_architecture/partitioning
 * $repository: The DataStax repository to use
 * $vardir: Base directory where cassandra data is stored
