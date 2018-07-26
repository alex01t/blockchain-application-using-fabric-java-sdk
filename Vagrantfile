# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # https://docs.vagrantup.com.

  config.hostmanager.enabled = true

  config.vm.define "orderer" do |b|
    b.vm.box = "bento/ubuntu-18.04"
    b.vm.hostname = "orderer"
    b.vm.network "private_network", ip: "192.168.33.10"
    b.hostmanager.aliases = %w(orderer.example.com)
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
      cd /org/network && chmod +x teardown.sh && ./teardown.sh
      cd /org/network && chmod +x build.sh && ./build.sh orderer
    SHELL
  end
  config.vm.define "org2" do |org|
    org.vm.box = "bento/ubuntu-18.04"
    org.vm.hostname = "org2"
    org.vm.network "private_network", ip: "192.168.33.12"
    org.hostmanager.aliases = %w(ca.org2.example.com peer0.org2.example.com peer1.org2.example.com)
    org.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 2
    end

    org.vm.provision "docker" do |d|
      # just install please
    end
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker-compose && apt-get install -y openjdk-8-jdk && apt-get install -y maven
      apt-get install -y gradle
      rm -rf /org && cp -a /vagrant /org && echo OK..
      cd /org/network && chmod +x teardown.sh && ./teardown.sh
      cd /org/network && chmod +x build.sh && ./build.sh org2
      # cd /org && sudo -u vagrant make client
      cd /org && sudo -u vagrant make gui
    SHELL
  end
  config.vm.define "org1" do |org|
    org.vm.box = "bento/ubuntu-18.04"
    org.vm.hostname = "org1"
    org.vm.network "private_network", ip: "192.168.33.11"
    org.hostmanager.aliases = %w(ca.org1.example.com peer0.org1.example.com peer1.org1.example.com)
    org.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 2
    end

    org.vm.provision "docker" do |d|
      # just install please
    end
    org.vm.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker-compose && apt-get install -y openjdk-8-jdk && apt-get install -y mavena
      apt-get install -y gradle
      rm -rf /org && cp -a /vagrant /org && echo OK..
      cd /org/network && chmod +x teardown.sh && ./teardown.sh
      cd /org/network && chmod +x build.sh && ./build.sh org1
      
      cd /org && sudo -u vagrant make all
      cd /org && sudo -u vagrant make gui
    SHELL
  end
  #config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"
end
