Then /^the request is deemed interactive$/ do
  get '/'

  Then %Q{the page contains "This request is interactive"}
end

Then /^the request is deemed non\-interactive$/ do
  get '/'

  Then %Q{the page contains "This request is non-interactive"}
end
