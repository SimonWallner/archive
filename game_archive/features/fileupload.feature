Feature:As a contributor,
        in order to show the world how developers look like,
        I want to add an image to a developer.

        Scenario: successfully upload picture
            Given I am on the developers overview page
            When I follow the new developer link
            And I fill in the fields with valid details
            And I choose a valid file and submit it
            Then I should see the picture on the details page of the developer

        Scenario: unsuccessfully upload picture
            Given I am on the developers overview page
            When I follow the new developer link
            And I fill in the fields with valid details
            And I choose a file too big and submit it
            Then I should be notified on that the Image is too big

        Scenario: change profile picture
          Given I have a developer Hans
          When I am on the edit page of the developer
          And I choose a valid file and submit it
          Then I should see the picture on the details page of the given Developer

        Scenario: unsucsessfully upload picture
          Given I have a developer Hans
          When I am on the edit page of the developer
          And I choose a invalid file and submit it
          Then I should be notified on that the Image is too big


