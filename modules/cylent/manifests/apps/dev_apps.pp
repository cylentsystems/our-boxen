class cylent::apps::default_apps {
  notify { 'class cylent::apps::default_apps declared': }

  include macvim
  include vmware_fusion
  include cmake
  include iterm2::dev
  include github_for_mac
  include java6 #needed for intellij
  include maven
  include virtualbox

  file {'node.zsh':
    path => "${cylent_env}/zsh/node.zsh",
    ensure => file,
    require => [Repository[$cylent_dotfiles],File[$cylent_env]],
    content => template("cylent/node_env.erb")
  }

  class {'intellij':
    edition => 'ultimate',
    version => '14.0.2'
  }

  class {'vagrant':
    version => '1.7.2'
  }

  class {'docker':
    version => '1.6.2'
  }

  # Homebrew Packages
  package {
    [
      'findutils',
      'gnu-tar',
      'ack',
      'tree',
      'watch',
      'git-crypt',
      'go',
    ]:
  }
  ->
  file {'/bin/git-crypt':
    ensure => link,
    target => "/opt/boxen/homebrew/bin/git-crypt"
  }
}