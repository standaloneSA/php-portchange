Vagrant.configure("2") do |config|
  config.vm.box = 'dummy'
  config.vm.box_url = './dummy.box'

  config.vm.provider :vsphere do |vsphere|
    # The host we're going to connect to
    vsphere.host = 'myvsphere'

   # The host for the new VM
    vsphere.compute_resource_name = 'myvmhost'

    # The resource pool for the new VM
    vsphere.resource_pool_name = 'Vagrant'

	 vsphere.clone_from_vm = true
    vsphere.template_name = 'Systems Dev/Vagrant/Vagrant-CentOS7-Template'

    # The name of the new machine
    vsphere.name = 'myvmname'

    # vSphere login
    vsphere.user = 'myusername'

    # vSphere password
    vsphere.password = 'mypassword'

    # If you don't have SSL configured correctly, set this to 'true'
    vsphere.insecure = true                                    

	 vsphere.data_store_name = 'mydatastore'

	 vsphere.linked_clone = true
  end

# config.vm.network 'private_network', ip: '192.168.50.4'
config.vm.provision :shell, :path => "bootstrap.sh"

config.vm.provision :puppet do |puppet|
	puppet.manifests_path = "puppet/manifests" 
	puppet.module_path = "puppet/modules" 
	puppet.manifest_file = "init.pp" 
   puppet.working_directory = "/tmp/vagrant-puppet"
end 

end

