Given /I am using the user interface/ do
  header "Accept", "text/html"
end

Given /I am using the API/ do
  agent.user_agent_alias = 'Mechanize'

  header "Accept", "application/json"
end
