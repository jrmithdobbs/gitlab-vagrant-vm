# Clone Gitlab Shell repo from github
git node['gitlab']['real_app_shell_home'] do
  repository node['gitlab']['gitlab_shell_url']
  reference node['gitlab']['gitlab_shell_branch']
  action :checkout
  user 'root'
end

# Render gitlab shell config file
template "#{node['gitlab']['real_app_shell_home']}/config.yml" do
  source "gitlab_shell.yml.erb"
  user node['gitlab']['host_user_id']
  group node['gitlab']['host_group_id']
  variables({
    :repo_path => node['gitlab']['repos_path'],
    :keys_path => node['gitlab']['keys_path'],
    :shell_log_file => node['gitlab']['app_shell_log_file'],
    
  })
  mode 0644
end

# Create /vagrant/repositories directory.
directory node['gitlab']['real_repos_path'] do
  user node['gitlab']['host_user_id']
  group node['gitlab']['host_group_id']
  mode "0755"
  action :create
end
 
# Mount /vagrant/repositories directory.
mount node['gitlab']['real_repos_path'] do
  device "#{node['gitlab']['app_home']}/tmp/repositories"
  fstype "nfs"
  options ["rw", "rbind"]
  action [:mount]
  not_if "mountpoint #{node['gitlab']['repos_path']}"
end

# Create /home/vagrant/repositories directory.
directory "#{node['gitlab']['home']}/repositories" do
  user node['gitlab']['host_user_id']
  group node['gitlab']['host_group_id']
  mode "0755"
  action :create
end

# Mount /home/vagrant/repositories directory.
mount "#{node['gitlab']['home']}/repositories" do
  device "#{node['gitlab']['app_home']}/tmp/repositories"
  fstype "nfs"
  options ["rw", "rbind"]
  action [:mount]
  not_if "mountpoint #{node['gitlab']['home']}/repositories"
end
 
# Create /home/vagrant/gitlabhq directory.
directory "#{node['gitlab']['home']}/gitlabhq" do
  user node['gitlab']['host_user_id']
  group node['gitlab']['host_group_id']
  mode "2755"
  action :create
end

# Mount /home/vagrant/gitlabhq directory.
mount "#{node['gitlab']['home']}/gitlabhq" do
  device node['gitlab']['app_home']
  fstype "nfs"
  options ["rw", "rbind"]
  action [:mount]
  not_if "mountpoint #{node['gitlab']['home']}/gitlabhq"
end

# Create /home/vagrant/gitlab-shell directory.
directory "#{node['gitlab']['home']}/gitlab-shell" do
  user node['gitlab']['host_user_id']
  group node['gitlab']['host_group_id']
  mode "0755"
  action :create
end

# Mount /home/vagrant/gitlab-shell directory.
mount "#{node['gitlab']['home']}/gitlab-shell" do
  device node['gitlab']['real_app_shell_home']
  fstype "nfs"
  options ["rw", "rbind"]
  action [:mount]
  not_if "mountpoint #{node['gitlab']['home']}/gitlab-shell"
end
 
# Create /vagrant/gitlab-satellites directory.
directory node['gitlab']['real_repos_satellites_path'] do
  user node['gitlab']['host_user_id']
  group node['gitlab']['host_group_id']
  mode "0755"
  action :create
end

# Create /home/vagrant/gitlab-satellites directory.
directory "#{node['gitlab']['home']}/gitlab-satellites" do
  user node['gitlab']['host_user_id']
  group node['gitlab']['host_group_id']
  mode "0755"
  action :create
end

# Mount /home/vagrant/gitlab-satellites directory.
mount "#{node['gitlab']['home']}/gitlab-satellites" do
  device node['gitlab']['real_repos_satellites_path']
  fstype "nfs"
  options ["rw", "rbind"]
  action [:mount]
  not_if "mountpoint #{node['gitlab']['home']}/gitlab-satellites"
end
 
# Create /home/git
directory "/home/git" do
  user node['gitlab']['host_user_id']
  group node['gitlab']['host_group_id']
  mode "0755"
  action :create
end

# Mount /home/git directory.
mount "/home/git" do
  device node['gitlab']['home']
  fstype "nfs"
  options ["rw", "rbind"]
  action [:mount]
  not_if "mountpoint /home/git"
end
 
# GitLab Shell application install script
execute "gitlab-shell install" do
  command "su -l -c 'cd #{node['gitlab']['real_app_shell_home']} && bundle install && ./bin/install' vagrant"
  cwd node['gitlab']['real_app_shell_home']
  user 'root'
end

