#Feature file is given a global tag so the whole suite can be run with this tag
@test_problem_one

  #Each specific scenario is given a tag so that they may be run separately if needed
  @test_problem_one_001
  #Scenario is the title text that will be outputted for each test to improve tester and client readability
  Scenario: Values page loads the correct amount of elements
    #Given sets the beginning state of the test, in this case loading onto the website
    Given I am on the values page
    #In cases where the something needs to be changed from the starting Given condition a When condition will be added to
    #get the page to a state where what needs to be tested can be tested. The Then statement then performs the necessary check
    Then I verify the page layout is correct

  @test_problem_one_002
  #In cases where tests go down similar testing paths, it is better to use a Scenario Outline to condense the feature file
  #And prevent creating superfluous functions. In this case I am combining the test to make sure values are above zero and
  #Correctly formatted as currencies. In a real testing environment I would do this all in the same test but in this case
  #I am splitting it up to show the Scenario Outline
  Scenario Outline: Values are presented in the correct format
    #To provide better clarity in a scenario outline, I'm adding an additional Given state to output a line of
    #text for whoever views the test. The "<variable_name>" reads inputs below and sends it as a value to the function
    #In the step definition file.
    Given I output "<title>"
      And I am on the values page
    Then I verify the values are "<state>"
    #The Examples line feeds in the information for the "<>" in the outline. The first line is to signify which value applies to which
    Examples:
    | title                             | state      |
    | Values are Greater than Zero      | above_zero |
    | Values are displayed as currency  | currency   |

  #The third and fifth bullet points on the Objectives list are basically saying the same thing in different ways so I'm treating them as the same

  @test_problem_one_003
  Scenario: Values correctly add up to the total balance
  Given I am the values page
  Then I verify values add up to the total balance
