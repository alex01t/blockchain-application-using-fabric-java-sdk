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
  config.vm.define "org1" do |org|
    org.vm.box = "bento/ubuntu-18.04"
    org.vm.hostname = "org1"
    org.vm.network "private_network", ip: "192.168.33.11"

    org.vm.provision "docker" do |d|
      # just install please
    end
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y openjdk-8-jdk
      apt-get install -y maven docker-compose

      rm -rf /org && cp -a /vagrant /org && echo OK..

      cd /org/network && chmod +x build.sh && ./build.sh && echo OK..

      cd /org/java && mvn install && cd target && cp blockchain-java-sdk-0.0.1-SNAPSHOT-jar-with-dependencies.jar blockchain-client.jar
      cp /org/java/target/blockchain-client.jar /org/network_resources && echo OK..

      cd /org/network_resources && java -cp blockchain-client.jar org.app.network.CreateChannel
      cd /org/network_resources && java -cp blockchain-client.jar org.app.network.DeployInstantiateChaincode
      cd /org/network_resources && java -cp blockchain-client.jar org.app.user.RegisterEnrollUser
      cd /org/network_resources && java -cp blockchain-client.jar org.app.chaincode.invocation.InvokeChaincode
      cd /org/network_resources && java -cp blockchain-client.jar org.app.chaincode.invocation.QueryChaincode

    SHELL
  end
#  config.vm.define "org2" do |org|
#    org.vm.box = "bento/ubuntu-18.04"
#    org.vm.hostname = "org2"
#    org.vm.network "private_network", ip: "192.168.33.12"
#
#    org.vm.provision "docker" do |d|
#    end
#  end

  #config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  # config.vm.synced_folder "../data", "/vagrant_data"

end
