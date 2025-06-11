# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  vm_definitions = {
    "artefatos" => "192.168.1.100",
    "dados" => "192.168.1.101",
    "k8s-tools-controlplane" => "192.168.1.102",
    "k8s-tools-worker1" => "192.168.1.103",
    "k8s-desenv-controlplane" => "192.168.1.104",
    "k8s-desenv-worker1" => "192.168.1.105",
    "k8s-desenv-worker2" => "192.168.1.106"
  }

  vm_definitions.each do |vm_name, vm_ip|
    config.vm.define vm_name do |node|
      node.vm.box = "generic/ubuntu2204"
      node.vm.hostname = vm_name
      node.vm.network "private_network", ip: vm_ip

      node.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "2"
      end

      node.vm.provision "shell", inline: <<-SHELL
        echo "Provisioning #{vm_name}..."
        sudo apt-get update -qq > /dev/null
        echo "Installing Python3 and pip..."
        sudo apt-get install -y python3 python3-pip > /dev/null
        echo "Installing Docker and Docker Compose..."
        sudo apt-get install -y docker.io docker-compose > /dev/null
        echo "Adding vagrant user to docker group..."
        sudo usermod -aG docker vagrant
        echo "Install any other common dependencies here if needed"
        # For RKE, nodes need Docker installed.
        # Ensure passwordless sudo for vagrant user if needed for some ansible tasks,
        # though ansible_become should handle it.
        # Vagrant default insecure key is used.
        # The existing 'hosts' file refers to custom key paths like '/home/pgmadmin/.ssh/pgm_artefatos'.
        # The '.vagrant/keys_cp.sh' script is intended to copy keys from a Windows host
        # to the './.vagrant' directory and rename them.
        # Users will need to run keys_cp.sh (or a similar mechanism) after 'vagrant up'
        # and ensure the keys are placed where the Ansible 'hosts' file expects them
        # (e.g., in /home/pgmadmin/.ssh/ or update hosts file to point to ./.vagrant/pgm_xxx keys).
        echo "Python3 and Docker installed for #{vm_name}."
      SHELL
    end
  end

  # Optional: Configure Ansible provisioner to use the existing hosts file
  # This would run Ansible from the Vagrant host after VMs are up.
  # However, the request is to prepare VMs so Ansible can be run *against* them
  # from an external Ansible control node that uses the `hosts` file.
  # config.vm.provision "ansible" do |ansible|
  #   ansible.inventory_path = "hosts"
  #   ansible.playbook = "play_all.yml"
  #   # Ensure ansible.cfg is set up if needed, or specify private_key paths here if not using ssh-agent
  # end
end
