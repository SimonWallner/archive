Given /^I have a game$/ do
  @game_title = "mario"
  @gameField=FactoryGirl.create :game  
end

When /^I follow the Add Field button$/ do
  visit new_game_path
     fill_in "game_title", :with => @game_title
  click_link_or_button "Add Field"
  sleep(1)
end

Then /^I enter game field with "(.*?)"$/ do |fill|

  within(".newFieldsDiv .addedField") do
    @day = "21"
    @month = "3"
    @year = "2012"
    if fill == "Release Dates"

      select(fill, :from => 'newFieldId')
      within(".release_dates_div") do
        select(@day, :from => 'day_release_date1')
        select(@month, :from => 'month_release_date1')
        fill_in "year_release_date1", :with => @year
        sleep(1)
      end

    end

    if fill == "Developer"
      @text = "new developer"
      select(fill, :from => 'newFieldId')
      fill_in "new_developers", :with => @text
      sleep(1) end
    if fill == "Publisher"
      @text = "new publisher"
      select(fill, :from => 'newFieldId')
      fill_in "new_publishers", :with => @text
      sleep(1) end
    if fill == "Distributor"
      @text = "new distributor"
      select(fill, :from => 'newFieldId')
      fill_in "new_distributors", :with => @text
      sleep(1) end
    if fill == "Credits"
      @text = "new credits"
      select(fill, :from => 'newFieldId')
      fill_in "new_credits", :with => @text
      sleep(1) end
    if fill == "Series"
      @text = "new series"
      select(fill, :from => 'newFieldId')
      fill_in "new_series", :with => @text
      sleep(1) end
    if fill == "Genres"
      @text = "new genres"
      select(fill, :from => 'newFieldId')
      fill_in "new_genres_input", :with => @text
      sleep(1)
    end
    
 
  end


end


  
  
  Then /^The data should be saved$/ do
   
  g = Game.find_by_title @game_title
  
  g.should_not == nil
   
  g.mixed_fields.should_not == nil
  
  g.mixed_fields.size.should == 1
  
end


Then /^I should see the mixed field type added$/ do
   #page.should have_content(@day + "." + @month + "." +@year)
    page.should have_content(@game_title)
end
  
 

