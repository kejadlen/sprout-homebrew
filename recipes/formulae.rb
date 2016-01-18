# node['sprout']['homebrew']['formulae'] is an array of casks
# to install (e.g. pstree, htop)
include_recipe 'homebrew'

ENV['HOMEBREW_PREFIX'] = `brew --prefix`.chomp
ENV['HOMEBREW_REPOSITORY'] = ENV['HOMEBREW_PREFIX']
ENV['HOMEBREW_LIBRARY'] = File.join(ENV['HOMEBREW_REPOSITORY'], 'Library')
ENV['HOMEBREW_CELLAR'] = File.join(ENV['HOMEBREW_PREFIX'], 'Cellar')

node['sprout']['homebrew']['formulae'].each do |formula|
  Chef::Log.warn("Doing homebrew formula #{formula}")

  if formula.class == Chef::Node::ImmutableMash
    package formula.fetch(:name) do
      options '--HEAD' if formula.fetch(:head, false)
    end
  else
    package formula
  end
end
