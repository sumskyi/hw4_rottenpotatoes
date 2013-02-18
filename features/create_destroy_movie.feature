Feature: remove and adds movies

  As an avid moviegoer
  So that I can quickly browse movies based on my preferences
  I want to see movies sorted by title or release date

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And I am on the RottenPotatoes home page
  And I check the following ratings: PG, R, G, PG-13, NC-17
  And I press "Refresh"

Scenario: remove movie
  When I am on the details page for "Aladdin"
  And I press "Delete"
  Then I am on the RottenPotatoes home page
  And I should not see "Alien"

Scenario: add movie
  When I follow "Add new movie"
  And I fill in "Title" with "Test Movie"
  And I press "Save Changes"
  Then I am on the RottenPotatoes home page
  And I should see "Test Movie"

