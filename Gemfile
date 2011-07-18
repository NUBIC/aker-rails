source :rubygems
source "http://download.bioinformatics.northwestern.edu/gems/"

gemspec

gem 'aker', :git => 'git://github.com/NUBIC/aker.git'

# avoids long bundle resolution times brought on by actionpack requiring rack
# ~> 1.1.0, and dependencies evaluated before actionpack (bcaudit, warden)
# that specify looser constraints (~> 1.1 and >= 1.0.0, respectively)
gem 'rack', '~> 1.1.0'

group :development do
  gem 'rake', '~> 0.9'

  gem 'rspec', '~> 1.3'

  gem 'cucumber', '~> 0.10.0'
  gem 'mechanize'

  gem 'net-ssh'
  gem 'net-scp'

  gem 'yard', '~> 0.5'
  gem 'rdiscount'
  gem 'fssm'

  gem 'rcov'
  gem 'ci_reporter', '~> 1.6'
end
