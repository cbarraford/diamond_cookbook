[![Build
Status](https://travis-ci.org/CBarraford/diamond_cookbook.svg?branch=master)](https://travis-ci.org/CBarraford/diamond_cookbook)

About
=====

Diamond is a python daemon that collects system metrics and publishes them to Graphite. It is
capable of collecting cpu, memory, network, i/o, load and disk metrics.  Additionally,
it features an API for implementing custom collectors for gathering metrics from almost any source.

The documentation can be found on our [wiki](https://github.com/python-diamond/Diamond/wiki). For your
convenience the wiki is setup as a submodule of this checkout. You can get it via running

    git submodule init
    git submodule update

Definitions
===========
This cookbook has a definition to make it easy to create collector configs. By default, the definition enables the
collector. You can supply it with addition parameters. Below is the simplest example.

```
    collector_config "CPUCollector"
```

This simple example just enables the collector and it inhereits the default configuration for this collector as defined
by the collector.

You can override these default settings by passing additional parameters. Below is an example of this.

```
    collector_config "DiskSpaceCollector" do
      filesystems      'ext2,ext3,xfs'
      exclude_filters  "'^/export/home'"
    end
```

This example is enabling the DiskSpaceCollector while passing addition settings to specify which filesystems to mine data
and to exclude certain directories (regex). Read the documentation/collector source code for information on what parameters
each collector has.
It is recommended that instead of passing values directly, inherit them from the node (as show belown).

```
    collector_config "DiskSpaceCollector" do
      filesystems      node[:diamond][:collectors][:DiskSpaceCollector][:filesystems]
      exclude_filters  node[:diamond][:collectors][:DiskSpaceCollector][:exclude_filters]
    end
```

When you are collecting data via snmp, you need to specify that in the definition (as shown below)
```
      collector_config "SNMPInterfaceCollector" do
        path      node[:diamond][:collectors][:SNMPInterfaceCollector][:path]
        snmp      true
        interval  node[:diamond][:collectors][:SNMPInterfaceCollector][:interval]
        time__out node[:diamond][:collectors][:SNMPInterfaceCollector][:timeout]
        retries   node[:diamond][:collectors][:SNMPInterfaceCollector][:retries]
        port      node[:diamond][:collectors][:SNMPInterfaceCollector][:port]
        community node[:diamond][:collectors][:SNMPInterfaceCollector][:community]
        devices   node[:diamond][:collectors][:SNMPInterfaceCollector][:devices]
      end
```

Whats with the double underscore ('__')?
if a double underscore exists in the attribute name, it will be automatically removed when written to the collector config file.
This is due to limitations within ruby code. Sometimes a attibute name may be a reserved ruby word (ie timeout), in which
case, you can't use that key to specify an attribute for the collector. The use of double underscores ('__') is a work around for that.
(so 'timeout' is called as 'time__out' in the cookbook, but writes 'timeout' to the config file.

USAGE
=====
It is recommended that you create a recipe per collector, and add that recipe to the related role.
When passing sensitive data to a diamond collector config (ie a username, password, etc), use data bags
to encrypt the values.

CI
=====
Using [travis-ci](https://travis-ci.org/CBarraford/diamond_cookbook) for
testing changes.

Publishing to [Chef Supermarket](https://supermarket.getchef.com/)
=====

To update the cookbook on the supermarket use
[stove](https://supermarket.chef.io/tools/stove)

**Example**
```bash
stove login --username cbarraford --key ~/.chef/cbarraford.pem
stove
```
