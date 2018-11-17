Feature: User can manually add movie

Scenario: Add a movie
	Given I am on the RottenPotatoes home page
	When I follow "Add new movie"
	Then I should be on the Create New Movie page
	When I fill in "Title" with "Men in Black"
	And I select "PG-13" from "Rating"
	And I press "Save Changes"
	Then I should be on the RottenPotatoes home page
	And I should see "Men in Black"


Scenario: Add director info to an existing movie
	Given the following movies exist:
	| title                   | rating | release_date |
	| Aladdin                 | G      | 25-Nov-1992  |
	And I am on the editing page of the movie 'Aladdin'
	When I fill in "Director" with "Director X"
	And I press "Update Movie Info"
	Then I should be on the page of the movie 'Aladdin'
	And I should see "Director X"
