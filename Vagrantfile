Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "otus-linux-pro-vm6"
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    v.check_guest_additions = false
    v.name = "rpm-repo"
  end
  config.vm.provision "shell", path: "script.sh"
end
