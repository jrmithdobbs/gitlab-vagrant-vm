# Set attributes for the git user
default['gitlab']['user'] = "vagrant"
default['gitlab']['group'] = "git"
default['gitlab']['home'] = "/home/vagrant"
default['gitlab']['app_home'] = "/vagrant/gitlabhq"
default['gitlab']['real_repos_path'] = "/vagrant/repositories"
default['gitlab']['real_repos_satellites_path'] = "/vagrant/gitlab-satellites"
default['gitlab']['real_keys_path'] = "/vagrant/repositories/.ssh/authorized_keys"
default['gitlab']['real_app_shell_home'] = "/vagrant/gitlab-shell"
default['gitlab']['real_app_shell_hooks_path'] = "/vagrant/gitlab-shell/hooks"
default['gitlab']['real_app_shell_log_file'] = "/vagrant/gitlabhq/log/gitlab-shell_error.log"

default['gitlab']['repos_path'] = "/home/git/repositories"
default['gitlab']['repos_satellites_path'] = "/home/git/gitlab-satellites"
default['gitlab']['keys_path'] = "/home/git/.ssh/authorized_keys"
default['gitlab']['app_shell_home'] = "/home/git/gitlab-shell"
default['gitlab']['app_shell_hooks_path'] = "/home/git/gitlab-shell/hooks"
default['gitlab']['app_shell_log_file'] = "/home/git/gitlabhq/log/gitlab-shell_error.log"

# Set github URL for gitlab
default['gitlab']['gitlab_url'] = "git://github.com/gitlabhq/gitlabhq.git"
default['gitlab']['gitlab_branch'] = "master"

default['gitlab']['packages'] = %w{
  vim curl wget checkinstall libxslt-dev
  libcurl4-openssl-dev libssl-dev libmysql++-dev
  libicu-dev libc6-dev libyaml-dev python python-dev libqt4-dev libqtwebkit-dev
  xvfb xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic bash-completion
}

# GitLab Shell
default['gitlab']['gitlab_shell_url'] = "git://github.com/gitlabhq/gitlab-shell.git"
default['gitlab']['gitlab_shell_branch'] = "master"
default['gitlab']['trust_local_sshkeys'] = "yes"
default['gitlab']['https'] = false
