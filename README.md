# CPU Latency Forwarder

Forwards CPU latency samples taken from a eBPF script, to a graphite instance.


## Install

TODO


## Usage

```
Usage: ./bin/run
    -h HOSTNAME  Specify the Graphite hostname. Default is 'localhost'.
    -p PORT      Specify the Graphite port. Default is '2003'.
    -c PATH      Specify the path of the CPU sampling script. Default is '/root/cpu_latency.bt'.
    -i SECONDS   Specify the period used to flush samples to Graphite. Default is '15'.
```

Any log messages are printed to STDOUT.


## Testing

Makes use of Mocha, which is available as a gem.

```
bundle install
rake
```
