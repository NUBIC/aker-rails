Given /^no one is logged in$/ do
  visit '/logout'
end

Given /^I am logged in as mr296$/ do
  visit '/login'
  browser.url.should =~ %r{/login}
  browser.status_code.should == 200
  browser.text_field(:id, 'username').value = 'mr296'
  browser.text_field(:id, 'password').value = 'br0wn'
  browser.button(:value, "Log in").click
  browser.status_code.should == 200
end

Then /^I am on the login page/ do
  browser.url.should =~ %r{/login}
end

When /^I access a (\S+) page$/ do |page_name|
  url =
    case page_name
    when 'public'
      '/'
    when 'protected'
      '/protected'
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
    else
      pending "No pattern defined for the content of a #{page_name} page"
    end
  browser.text.should =~ pattern
end

Then /^the page contains "([^\"]+)"$/ do |expected_content|
  browser.text.should include(expected_content)
end
