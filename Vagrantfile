Vagrant.configure("2")  do |config|
  #config.vm.box = "precise32"
  #config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  #config.vm.box = "precise64_vmware_fusion"
  #config.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"

  config.vm.network :private_network, ip: "192.168.3.14"
  config.vm.synced_folder ".", "/vagrant", :nfs => true

  config.vm.provider :vmware_fusion do |v|
    v.vmx["memsize"] = "1024"
    v.vmx["numvcpus"] = 2
  end

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 1024, "--cpus", 2]
  end

  if RUBY_PLATFORM =~ /linux|darwin/i
    host_user_id = Process.euid
    host_group_id = Process.egid
  else
    host_user_id = 1000
    host_group_id = 1000
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ['cookbooks', 'site-cookbooks']

    chef.add_recipe('rvm::vagrant')
    chef.add_recipe('rvm::user')

    chef.add_recipe('mysql::server')
    chef.add_recipe('mysql::ruby')

    chef.add_recipe('postgresql::server')
    chef.add_recipe('postgresql::ruby')

    chef.add_recipe('database::mysql')

    chef.add_recipe('phantomjs')

    # This is where all the magic happens.
    # see site-cookbooks/gitlab/
    chef.add_recipe('gitlab::vagrant')

    chef.json = {
      :rvm => {
        :user_installs => [
          { :user         => 'vagrant',
            :default_ruby => '1.9.3'
          }
        ],
        :vagrant => {
          :system_chef_solo => '/opt/vagrant_ruby/bin/chef-solo'
        },
        :global_gems => [{ :name => 'bundler'}],
        :branch => 'none',
        :version => '1.17.10'
      },
      :phantomjs => {
        :version => '1.8.1'
      },
      :mysql => {
        :server_root_password => "nonrandompasswordsaregreattoo",
        :server_repl_password => "nonrandompasswordsaregreattoo",
        :server_debian_password => "nonrandompasswordsaregreattoo"
      },
      :postgresql => {
        :password => { :postgres => "598fedc3550ad4ecad4ec14aa7992e82"},
        :run_list => ["recipe[postgresql::server"]
      },
      :gitlab => {
        :host_user_id => host_user_id,
        :host_group_id => host_group_id
      }
    }
  end
end
