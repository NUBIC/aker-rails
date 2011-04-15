Given /I am using the user interface/ do
  header "Accept", "text/html"
end

Given /I am using the API/ do
  header "Accept", "application/json"
end
