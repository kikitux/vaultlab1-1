Vagrant.configure("2") do |config|
  config.vm.box = "alvaro/xenial64"
  config.vm.provision :shell, :path => "scripts/install_consul.sh", run: "always"
  config.vm.provision :shell, :path => "scripts/install_vault.sh", run: "always"
  config.vm.provision :shell, :inline => "cd /vagrant ; ./app.sh", run: "always"

  config.vm.define "leader01" do |l1|
      l1.vm.hostname = "leader01"
      l1.vm.network "private_network", ip: "192.168.2.10"
      l1.vm.network "forwarded_port", guest: 8500, host: 1234
      l1.vm.network "forwarded_port", guest: 8200, host: 1235
  end

end
