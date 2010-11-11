source :rubygems
source "http://download.bioinformatics.northwestern.edu/gems/"

gemspec

group :development do
  gem 'rake', '~> 0.8'

  # Cucumber requires this.
#  gem 'bundler', '0.9.26'

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
