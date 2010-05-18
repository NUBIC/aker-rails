Given /^no one is logged in$/ do
  visit '/logout'
end

Given /^I am logged in as (\w+)$/ do |username|
  password =
    case username
    when 'mr296'; 'br0wn';
    when 'zaw102'; 'saw';
    else pending "No credentials known for #{username.inspect}";
    end
  visit '/login'
  browser.url.should =~ %r{/login}
  browser.status_code.should == 200
  browser.text_field(:id, 'username').value = username
  browser.text_field(:id, 'password').value = password
  browser.button(:value, "Log in").click
  browser.status_code.should == 200
end

Then /^I am on the login page/ do
  browser.url.should =~ %r{/login}
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
    else
      pending "No URL defined for a #{page_name} page"
    end
  visit url
end

Then /^I can access that (\S+) page$/ do |page_name|
  browser.status_code.should == 200
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
  browser.text.should =~ pattern
end

Then /^the page contains "([^\"]+)"$/ do |expected_content|
  browser.text.should include(expected_content)
end

Then /^I( do not)? see the owner\'s content$/ do |neg|
  browser.status_code.should == 200
  should = neg.nil? ? :should : :should_not
  browser.text.send(should, include("Isn't it great to own things?"))
end

Then /^I am forbidden from accessing that page$/ do
  browser.status_code.should == 403
end
