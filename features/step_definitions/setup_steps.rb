Given /I am using the user interface/ do
  browser.webclient.addRequestHeader("Accept", "text/html")
end

Given /I am using the API/ do
  browser.webclient.addRequestHeader("Accept", "application/json")
end
