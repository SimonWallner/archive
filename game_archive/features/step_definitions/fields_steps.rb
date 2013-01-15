#  Scenario: add game field data with valid data
When /^I enter valid game data$/ do
  @game_title = "Game1"
  @game = Game.find_by_title @game_title
  fill_in "game_title", :with => @game_title
  sleep(1)
end
 
When /^I enter field with "(.*?)"$/ do |fill|
    @day = "21"
    @month = "3"
    @year = "2012"
    @additionalDate = "@additionalDate"
    @allDateText=@day +"." +@month+"." + @year
    if fill == "Release Dates"
      within(".release_dates_div") do
        select(@day, :from => 'day_release_date1')
        select(@month, :from => 'month_release_date1')
        fill_in "year_release_date1", :with => @year
        fill_in "text_release_date1", :with => " - "+@additionalDate
      end
    end
    if fill == "Developer"
      @textDeveloper = "new developer"
      fill_in "developer_link", :with => @textDeveloper
    end
    if fill == "Publisher"
      @textPublisher = "new publisher"
      fill_in "publisher_link", :with => @textPublisher
    end
    if fill == "Distributor"
      @textDistributor = "new distributor"
      fill_in "distributor_link", :with => @textDistributor
    end
    if fill == "Credits"
      @textCredits = "new credits"
      fill_in "credits_link", :with => @textCredits
    end
    if fill == "Series"
      @textSeries = "new series"
      fill_in "series_link", :with => @textSeries
    end
    if fill == "Userdefined"
      @nameUserdefined = "new name Userdefined"
      @contentUserdefined = "new contentUserdefined"
      click_link_or_button "Add Field"
      select(fill, :from => 'newFieldId')
      fill_in "name_userdefined1", :with => @nameUserdefined
      fill_in "content_userdefined1", :with => @contentUserdefined
    end
    if fill == "External Links"
      @externalLinks= "new external links"
      fill_in "new_external_links", :with => @externalLinks
    end
    if fill == "Aggregate Scores"
      @aggregate_scores= "new a scores"
      click_link_or_button "Add Field"
      select(fill, :from => 'newFieldId')
      fill_in "new_aggregate_scores", :with => @aggregate_scores
    end
    if fill == "Review Scores"
      click_link_or_button "Add Field"
      @review_scores= "new r scores"
      select(fill, :from => 'newFieldId')
      fill_in "new_review_scores", :with => @review_scores
    end
end

And /^I create the game$/ do
  click_link_or_button "Create Game" 
end

Then /^I should see the saved (.*?) fields$/ do |pname|
  within(".fact-box") do
    if pname == "Game"
      page.should have_content(@contentUserdefined)
      page.should have_content(@allDateText)
      page.should have_content(@additionalDate)
      page.should have_content(@externalLinks)
      page.should have_content(@aggregate_scores)
      page.should have_content(@review_scores)
      page.should have_content(@textDeveloper)
      page.should have_content(@textPublisher)
      page.should have_content(@textSeries)
      page.should have_content(@textDistributor)
      page.should have_content(@textCredits)
    end
    if pname == "Developer"
      page.should have_content(@contentUserdefined)
      page.should have_content(@externalLinks)
    end
    if pname == "Company"
      page.should have_content(@contentUserdefined)
      page.should have_content("Founded")
      page.should have_content(@additionalDefunct)
      page.should have_content(@textLocation)
      page.should have_content(@textOfficialName)
      page.should have_content(@externalLinks)
    end
  end
end

#  Scenario: add Release Dates without day
Then /^I enter field of Release Dates without day$/ do  
  within(".newFieldsDiv") do
    sleep(1)
    @day = "nil"
    @month = "3"
    @year = "2012"
    @additionalDate = "@additionalDate"
    @allDateText=@day +"." +@month+"." + @year
      within(".release_dates_div") do              
        select(@month, :from => 'month_release_date1')
        fill_in "year_release_date1", :with => @year
        fill_in "text_release_date1", :with => @additionalDate
    end  
  end    
    #page.should have_css('div.error_explanation')      
    #page.should have_content("Release dates day must be between 1 and 30")       
end

#    Scenario: add Release Dates without month
And /^I enter field of Release Dates without month$/ do 
  within(".newFieldsDiv") do
    sleep(1)
    @day = "12"
    @month = "nil"
    @year = "2012"
    @additionalDate = "@additionalDate"
    @allDateText=@day +"." +@month+"." + @year
      within(".release_dates_div") do              
        select(@day, :from => 'day_release_date1')
        fill_in "year_release_date1", :with => @year
        fill_in "text_release_date1", :with => @additionalDate
    end  
  end    
end

Then /^I should see error for month$/ do
  within("#error_explanation") do
    page.should have_content("Release dates month must be between 1 and")
  end
end

Then /^I should see error for day$/ do
  within("#error_explanation") do
    page.should have_content("Release dates day must be between 1 and")
  end
end

#   Scenario: add game field with token list 
 When /^I enter field with token list "(.*?)"$/ do |fill|
     sleep(1)
     if fill == "Platform"
      @textPlatforms = "new plattforms"
      fill_in "new_platforms_input", :with => @textPlatforms
    end    
        if fill == "Genres" 
      @textGenres = "new genres"
      fill_in "new_genres_input", :with => @textGenres
    end
        if fill == "Tags"
      @textTags = "new tags"
      fill_in "new_tags_input", :with => @textTags
    end    
        if fill == "Mode"
      @textModes = "new modes"
      fill_in "new_modes_input", :with => @textModes
    end
    if fill == "Media"
      @textMedias = "new medias"
      fill_in "new_medias_input", :with => @textMedias
    end
end

Then /^I should see the saved token list data$/ do

  #mysterious bug prohobiting this test from running through


   #wait for page to fully load/fix for selenium bug
   #wait_until { page.evaluate_script('$.active') == 0 }

   page.should have_content(@textGenres)
   page.should have_content(@textPlatforms)
   page.should have_content(@textMedias)
   page.should have_content(@textModes)
   page.should have_content(@textTags)
end


 