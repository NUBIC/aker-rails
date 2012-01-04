Given /^no one is logged in$/ do
  get '/logout'
end

Given /^I am logged in as (\w+)$/ do |username|
  password =
    case username
    when 'mr296'; 'br0wn';
    when 'zaw102'; 'saw';
    else pending "No credentials known for #{username.inspect}";
    end

  get '/login'
  Then 'I am on the login page'

  login_form = page.form_with(:action => '/login')
  login_form.field_with(:name => 'username').value = username
  login_form.field_with(:name => 'password').value = password
  submit(login_form)
  page.code.should == '200'
end

Then /^I am on the login page/ do
  page.uri.path.should == '/login'
  page.code.should == '200'
end

When /^I access (?:an?|the) (\S+) page$/ do |page_name|
  url =
    case page_name
    when 'public'
      '/'
    when 'protected'
      '/protected'
    when 'owners-only'
      '/owners'
    when 'portal'
      '/portal'
    when 'logout'
      '/logout'
    else
      pending "No URL defined for a #{page_name} page"
    end

  get url
end

When /^I access a protected page without a CSRF token$/ do
  post '/protected'
end

When /^I access a protected page with a correct CSRF token$/ do
  get '/protected'

  page.body =~ /CSRF (\S+)/
  header 'X-CSRF-Token', $1

  post '/protected'
end

Then /^I can access that (\S+) page$/ do |page_name|
  page.code.should == '200'

  pattern =
    case page_name
    when 'public'
      /^Anyone can see this./
    when 'protected'
      /^I'm protected/
    when 'owners-only'
      /^This page is only visible to owners.$/
    else
      pending "No pattern defined for the content of a #{page_name} page"
    end

  page.body.should =~ pattern
end

Then /^the page contains "([^\"]+)"$/ do |expected_content|
  page.body.should include(expected_content)
end

Then /^I( do not)? see the owner\'s content$/ do |neg|
  page.code.should == '200'

  should = neg.nil? ? :should : :should_not

  page.body.send(should, include("Isn't it great to own things?"))
end

Then /^I am forbidden from accessing that page$/ do
  page.code.should == '403'
end
