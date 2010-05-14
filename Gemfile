source :rubygems

# This is deliberately open -- I expect that this rails plugin will
# change much less frequently than the library.
gem 'bcsec', '>= 2.0.0.pre', :git => 'git+ssh://code.bioinformatics.northwestern.edu/git/bcsec.git'

gem 'rails', '~> 2.3.5' # for now; 2.1 will support Rails 3

group :development do
  gem 'rake', '~> 0.8'

  gem 'rspec', '~> 1.3'
  gem 'cucumber', '~> 0.7.0'
  gem 'culerity', '~> 0.2'
  # celerity is used by culerity under jruby.  When running with bundle exec,
  # the jruby invocation uses the gems defined here, so it needs to be here.
  gem 'celerity', :require => nil

  gem 'yard', '~> 0.5'
  gem 'ci_reporter', '~> 1.6'
end
