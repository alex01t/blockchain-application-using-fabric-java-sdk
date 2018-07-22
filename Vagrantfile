# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.define "orderer" do |b|
    b.vm.box = "bento/ubuntu-18.04"
    b.vm.hostname = "orderer"
    b.vm.network "private_network", ip: "192.168.33.10"
    b.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 2
    end

    b.vm.provision "docker" do |d|
      # just install please
    end
    b.vm.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker-compose 
      rm -rf /org && cp -a /vagrant /org && echo OK..
      cd /org/network && chmod +x build.sh && ./build.sh orderer
    SHELL
  end
  config.vm.define "org1" do |org|
    org.vm.box = "bento/ubuntu-18.04"
    org.vm.hostname = "org1"
    org.vm.network "private_network", ip: "192.168.33.11"
    org.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 2
    end

    org.vm.provision "docker" do |d|
      # just install please
    end
    org.vm.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker-compose && apt-get install -y openjdk-8-jdk && apt-get install -y maven
      rm -rf /org && cp -a /vagrant /org && echo OK..
      chmod +x /org/build_client.sh && sudo -u vagrant /org/build_client.sh
      cd /org/network && chmod +x build.sh && ./build.sh org1
    SHELL
  end
  config.vm.define "org2" do |org|
    org.vm.box = "bento/ubuntu-18.04"
    org.vm.hostname = "org2"
    org.vm.network "private_network", ip: "192.168.33.12"
    org.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 2
    end

    org.vm.provision "docker" do |d|
      # just install please
    end
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker-compose && apt-get install -y openjdk-8-jdk && apt-get install -y maven
      rm -rf /org && cp -a /vagrant /org && echo OK..
      chmod +x /org/build_client.sh && sudo -u vagrant /org/build_client.sh
      cd /org/network && chmod +x build.sh && ./build.sh org2
    SHELL
  end

  #config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  # config.vm.synced_folder "../data", "/vagrant_data"

end
