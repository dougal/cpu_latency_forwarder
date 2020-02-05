git "/opt/cpu_latency_forwarder/" do
  repository "git@github.com:dougal/cpu_latency_forwarder.git"
  reference "master"
  action :sync
  notifies :restart, "service[cpu_latency_forwarder]"
end

template "/etc/systemd/system/cpu_latency_forwarder.service" do
  source 'service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

service "cpu_latency_forwarder" do
  provider Chef::Provider::Service::Systemd
  action [:enable, :start]
end

