#!/bin/bash -xe

# Need Ruby headers etc. Install sister package to `ruby2.5` package already installed.
# Also need library for libyajl2 Gem, a dependency of chef.
apt install -y libgmp-dev ruby2.5-dev

# Get and install chef.
# NOTE: Chef fixed to version pre-licencing change.
gem install chef -v '13.6.0'

# Install bundler, matching version used to Bundle application.
gem install bundler -v '2.0.1'

# Trust any host as github.
# NOTE: Will re-add hosts if re-run.
echo -e "|1|Qexp97voug20AhQ+UL6ag3jfUVE=|nqzbfK/ktiMkYDXSsFb5H743QA8= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==\n|1|QRaGpSmor3IZr/mBUQJbl0BAhJ4=|GvF3dpCS203PVoxyqVqe+qhZyJA= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> /root/.ssh/known_hosts

# Get the repo.
if [ ! -d /opt/cpu_latency_forwarder ]
then
  git clone git@github.com:dougal/cpu_latency_forwarder.git /opt/cpu_latency_forwarder
else
  cd /opt/cpu_latency_forwarder
  git pull
fi

# Run chef
chef-solo -c /opt/cpu_latency_forwarder/chef/solo.rb -j /opt/cpu_latency_forwarder/chef/bootstrap.json

