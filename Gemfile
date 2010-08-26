source :rubygems

# This is deliberately open -- I expect that this rails plugin will
# change much less frequently than the library.
gem 'bcsec', '>= 2.0.0.rc', :git => 'git+ssh://code.bioinformatics.northwestern.edu/git/bcsec.git'

gem 'rails', '~> 2.3.5' # for now; 2.1 will support Rails 3

group :development do
  gem 'rake', '~> 0.8'

  # Cucumber requires this.
  gem 'bundler', '0.9.26'

  gem 'rspec', '~> 1.3'

  gem 'cucumber', '~> 0.8.0'
  gem 'culerity', '~> 0.2'
  # celerity is used by culerity under jruby.  When running with bundle exec,
  # the jruby invocation uses the gems defined here, so it needs to be here.
  gem 'celerity', :require => nil

  gem 'net-ssh'
  gem 'net-scp'

  gem 'yard', '~> 0.5'
  gem 'rdiscount'
  gem 'fssm'

  gem 'rcov'
  gem 'ci_reporter', '~> 1.6'
end
