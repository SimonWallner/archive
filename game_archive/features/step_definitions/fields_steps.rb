#  Scenario: add game field data with valid data
When /^I enter valid game data$/ do
  @game_title = "Game1"
  @game = Game.find_by_title @game_title
  fill_in "game_title", :with => @game_title
  click_link_or_button "Add Field"
end
 
When /^I enter field with "(.*?)"$/ do |fill|
    @day = "21"
    @month = "3"
    @year = "2012"
    @additionalDate = "@additionalDate"
    @allDateText=@day +":" +@month+":" + @year+":" + @additionalDate
    @count=0
  within(".newFieldsDiv .addedField") do

    if fill == "Release Dates"
      select(fill, :from => 'newFieldId')
      within(".release_dates_div") do
        select(@day, :from => 'day_release_date1')
        select(@month, :from => 'month_release_date1')
        fill_in "year_release_date1", :with => @year
        fill_in "text_release_date1", :with => " - "+@additionalDate
        sleep(1)
      end
    end
    if fill == "Developer"
      @textDeveloper = "new developer"
      select(fill, :from => 'newFieldId')
      fill_in "new_developers", :with => @textDeveloper
      @count++
      sleep(1) end
    if fill == "Publisher"
      @textPublisher = "new publisher"
      select(fill, :from => 'newFieldId')
      fill_in "new_publishers", :with => @textPublisher
       @count++
      sleep(1) end
    if fill == "Distributor"
      @textDistributor = "new distributor"
      select(fill, :from => 'newFieldId')
      fill_in "new_distributors", :with => @textDistributor
       @count++
      sleep(1) end
    if fill == "Credits"
      @textCredits = "new credits"
      select(fill, :from => 'newFieldId')
      fill_in "new_credits", :with => @textCredits
      @count++
      sleep(1) end

    if fill == "Series"
      @textSeries = "new series"
      select(fill, :from => 'newFieldId')
      fill_in "new_series", :with => @textSeries
       @count++
      sleep(1) end
    if fill == "Userdefined"
      @nameUserdefined = "new name Userdefined"
      @contentUserdefined = "new contentUserdefined"
      select(fill, :from => 'newFieldId')
      fill_in "name_userdefined1", :with => @nameUserdefined
      fill_in "content_userdefined1", :with => @contentUserdefined
      sleep(1)
    end

    if fill == "External Links"
      @externalLinks= "new external links"
      select(fill, :from => 'newFieldId')
      fill_in "new_external_links", :with => @externalLinks
      sleep(1)
    end
    if fill == "Aggregate Scores"
      @aggregate_scores= "new a scores"
      select(fill, :from => 'newFieldId')
      fill_in "new_aggregate_scores", :with => @aggregate_scores
      sleep(1)
    end
    if fill == "Review Scores"
      @review_scores= "new r scores"
      select(fill, :from => 'newFieldId')
      fill_in "new_review_scores", :with => @review_scores
      sleep(1)
    end
  end
end

And /^should create game$/ do
  click_link_or_button "Create Game" 
end
When /^The data be saved$/ do
  Game.count.should eq 1
  MixedField.count.should eq @count  
end 
Then /^I should see the saved field$/ do
#page.should have_content(@textDeveloper)
end



#   Scenario: add Release Dates without day
Then /^I enter field of Release Dates without day$/ do  
  within(".newFieldsDiv .addedField") do    
    @day = "nil"
    @month = "3"
    @year = "2012"
    @additionalDate = "@additionalDate"
    @allDateText=@day +":" +@month+":" + @year+":" + @additionalDate 
    select("Release Dates", :from => 'newFieldId')    
      within(".release_dates_div") do              
        select(@month, :from => 'month_release_date1')
        fill_in "year_release_date1", :with => @year
        fill_in "text_release_date1", :with => @additionalDate
        sleep(1) 
    end  
  end    
    #page.should have_css('div.error_explanation')      
    #page.should have_content("Release dates day must be between 1 and 30")       
end 
 Then /^I should see error for day$/ do 
    ReleaseDate.check_from_string(@allDateText).should== nil 
    #page.should have_content("Release dates day must be between 1 and 30") 
    click_link_or_button "Back"
 end
 
 
 
#    Scenario: add Release Dates without month
And /^I enter field of Release Dates without month$/ do 
  within(".newFieldsDiv .addedField") do    
    @day = "12"
    @month = "nil"
    @year = "2012"
    @additionalDate = "@additionalDate"
    @allDateText=@day +":" +@month+":" + @year+":" + @additionalDate 
    select("Release Dates", :from => 'newFieldId')    
      within(".release_dates_div") do              
        select(@day, :from => 'day_release_date1')
        fill_in "year_release_date1", :with => @year
        fill_in "text_release_date1", :with => @additionalDate
        sleep(1) 
    end  
  end    
end 
 Then /^I should see error for month$/ do 
   #page.should have_content("Release dates day must be between 1 and 30")
  ReleaseDate.check_from_string(@allDateText).should== nil  
   click_link_or_button "Back"
 end
 
 
 
 
#   Scenario: add game field with token list 
 When /^I enter field with token list "(.*?)"$/ do |fill|
   within(".newFieldsDiv .addedField") do
         if fill == "Platform"
      @textPlatforms = "new plattforms"
      select(fill, :from => 'newFieldId')
      fill_in "new_platforms_input", :with => @textPlatforms 
      sleep(1)
    end    
        if fill == "Genres" 
      @textGenres = "new genres"
      select(fill, :from => 'newFieldId')
      fill_in "new_genres_input", :with => @textGenres
      sleep(1)
    end
        if fill == "Tags"
      @textTags = "new tags"
      select(fill, :from => 'newFieldId')
      fill_in "new_tags_input", :with => @textTags
      sleep(1)
    end    
        if fill == "Mode"
      @textModes = "new modes"
      select(fill, :from => 'newFieldId')
      fill_in "new_modes_input", :with => @textModes
      sleep(1)
    end
    if fill == "Media"
      @textMedias = "new medias"
      select(fill, :from => 'newFieldId')
      fill_in "new_medias_input", :with => @textMedias
      sleep(1)
    end
   end      
end
 
 When /^should create game with token list$/ do
  click_link_or_button "Create Game" 
end 

 When /^The token list data be saved$/ do  
      Game.count.should eq 1
      #Genre.count.should eq 1
      #Mode.count.should eq 1
      #Platform.count.should eq 1
      #Tag.count.should eq 1
      #Medium.count.should eq 1
end 

Then /^I should see the saved token list data$/ do
   #page.should have_content(@textPlatforms)  
   #page.should have_content(@textMedias)  
   #page.should have_content(@textModes)
   #page.should have_content(@textTags) 
end


 