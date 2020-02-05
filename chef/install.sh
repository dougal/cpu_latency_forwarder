#!/bin/bash -xe

# Get and install chef.
# NOTE: Chef fixed to version pre-licencing change.
wget "https://packages.chef.io/files/stable/chef/13.6.0/ubuntu/18.04/chef_13.6.0-1_amd64.deb"
dpkg -i chef_13.6.0-1_amd64.deb

# Trust any host as github.
# NOTE: Will re-add hosts if re-run.
echo -e "|1|Qexp97voug20AhQ+UL6ag3jfUVE=|nqzbfK/ktiMkYDXSsFb5H743QA8= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==\n|1|QRaGpSmor3IZr/mBUQJbl0BAhJ4=|GvF3dpCS203PVoxyqVqe+qhZyJA= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> .ssh/known_hosts

# Get the repo.
git clone git@github.com:dougal/cpu_latency_forwarder.git /opt/cpu_latency_forwarder

# Run chef
cd /opt/cpu_latency_forwarder/chef
chef-solo -c solo.rb -j bootstrap.json

