#The Feature file calls upon functions in the Step Definitions which then call functions in the Page Object Page

  browser = Watir::Browser.new:chrome
  #This is pretty old school but I just wrote a simple test for the practice problem
  #Let me know if you want me to do this with Browserstack or any other App Integration

  #
  Given /I am on the values page$/ do
    browser.goto("https://www.exercise1.com/values")
    #I would put an await but the layout check is basically an await
  end

  Given /I output "([^"]*)"$/ do |title|
    puts "#{title}"
  end

  Then /I verify the page layout is correct$/ do
    expect(verify_layout).to be true
  end

  Then /I verify the values are "([^"]*)"$/ do |state|
    expect(verify_values(state)).to be true
  end

  Then /I verify values add up to the total balance$/ do
    expect(verify_balance).to be true
  end
