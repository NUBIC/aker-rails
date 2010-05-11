Given /^no one is logged in$/ do
  # visit '/logout'
end

When /^I access a public page$/ do
  visit '/public'
end

Then /^I can access that public page$/ do
  page.source.should =~ /Anyone can see this./
end
