name 'monitors_cpu_latency'
description 'Nodes with this role will automatically have their CPU Latency monitored and forwarded to Graphite.'

run_list("recipe[cpu_latency_forwarder]")

# Attributes of the CPU Latencey Forwarder can be modified as follows.
# default_atributes('cpu_latency_forwarder' => {
#   'hostname' => 'localhost',
#   'port' => 2003,
#   'sampling_script_path' => '/root/cpu_latency.bt',
#   'flush_interval' => 15
# }

