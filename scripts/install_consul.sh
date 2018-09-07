#!/usr/bin/env bash

IP=127.0.0.1

if [ -d /vagrant ]; then
  mkdir -p /vagrant/logs
  LOG="/vagrant/logs/consul_${HOSTNAME}.log"
else
  LOG="consul.log"
fi

PKG="wget unzip"
which ${PKG} &>/dev/null || {
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y ${PKG}
}

# check consul binary
which consul || {
  pushd /usr/local/bin
  [ -f consul_1.2.2_linux_amd64.zip ] || {
    sudo wget https://releases.hashicorp.com/consul/1.2.2/consul_1.2.2_linux_amd64.zip
  }
  sudo unzip consul_1.2.2_linux_amd64.zip
  sudo chmod +x consul
  popd
}

# check consul-template binary
which consul-template || {
  pushd /usr/local/bin
  [ -f consul-template_0.19.5_linux_amd64.zip ] || {
    sudo wget https://releases.hashicorp.com/consul-template/0.19.5/consul-template_0.19.5_linux_amd64.zip
  }
  sudo unzip consul-template_0.19.5_linux_amd64.zip
  sudo chmod +x consul-template
  popd
}

# check envconsul binary
which envconsul || {
  pushd /usr/local/bin
  [ -f envconsul_0.7.3_linux_amd64.zip ] || {
    sudo wget https://releases.hashicorp.com/envconsul/0.7.3/envconsul_0.7.3_linux_amd64.zip
  }
  sudo unzip envconsul_0.7.3_linux_amd64.zip
  sudo chmod +x envconsul
  popd
}

AGENT_CONFIG="-config-dir=/etc/consul.d -enable-script-checks=true"
sudo mkdir -p /etc/consul.d

# start consul
/usr/local/bin/consul members 2>/dev/null || {
  sudo /usr/local/bin/consul agent -server -ui -client=0.0.0.0 -bind=${IP} ${AGENT_CONFIG} -data-dir=/usr/local/consul -bootstrap-expect=1 >${LOG} &
  sleep 5
}

echo consul started
