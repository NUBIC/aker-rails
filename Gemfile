source :rubygems
source "http://download.bioinformatics.northwestern.edu/gems/"

gemspec

gem 'bcsec', :git => 'git+ssh://code.bioinformatics.northwestern.edu/git/bcsec.git'

# avoids long bundle resolution times brought on by actionpack requiring rack
# ~> 1.1.0, and dependencies evaluated before actionpack (bcaudit, warden)
# that specify looser constraints (~> 1.1 and >= 1.0.0, respectively)
gem 'rack', '~> 1.1.0'

group :development do
  gem 'rake', '~> 0.8'

  gem 'rspec', '~> 1.3'

  gem 'cucumber', '~> 0.9.0'
  gem 'mechanize'

  gem 'net-ssh'
  gem 'net-scp'

  gem 'yard', '~> 0.5'
  gem 'rdiscount'
  gem 'fssm'

  gem 'rcov'
  gem 'ci_reporter', '~> 1.6'
end
