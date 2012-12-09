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
      sleep(1) end
    if fill == "Publisher"
      @textPublisher = "new publisher"
      select(fill, :from => 'newFieldId')
      fill_in "new_publishers", :with => @textPublisher
      sleep(1) end
    if fill == "Distributor"
      @textDistributor = "new distributor"
      select(fill, :from => 'newFieldId')
      fill_in "new_distributors", :with => @textDistributor
      sleep(1) end
    if fill == "Credits"
      @textCredits = "new credits"
      select(fill, :from => 'newFieldId')
      fill_in "new_credits", :with => @textCredits
      sleep(1) end

    if fill == "Series"
      @textSeries = "new series"
      select(fill, :from => 'newFieldId')
      fill_in "new_series", :with => @textSeries
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
#page.should have_content(@allDateText)
end

 
 
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
  
    click_link_or_button "Create Game"
    #page.should have_css('div.error_explanation')
   # @game.create_add_new_release_dates(@allDateText).should_not == nil
   #  ReleaseDate.check_from_string(@allDateText).should_not == nil
    #page.should have_content("Release dates day must be between 1 and 30")       
end

And /^I enter field of Release Dates without month$/ do
 
  within(".newFieldsDiv .addedField") do    
    @day = "12"
    @month = "nil"
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
  
    click_link_or_button "Create Game"
    #page.should have_css('div.error_explanation') 
   #  ReleaseDate.check_from_string(@allDateText).should_not == nil
    #page.should have_content("Release dates day must be between 1 and 30") 

end

 
 
 When /^I enter field with token list "(.*?)"$/ do |fill|
   within(".newFieldsDiv .addedField") do
         if fill == "Platform"
      @textPlatforms = "new plattforms"
      select(fill, :from => 'newFieldId')
      fill_in "new_platforms_input", :with => @textPlatforms 
      sleep(1)
    end
    
        if fill == "Genres"
      sleep(1)
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


     
 
 When /^The token list data be saved$/ do 
  # @game.create_add_new_token(@textGenres, @textPlatforms, @textMedias, @textModes, @textTags).should_not==nil  
      click_link_or_button "Create Game"
    Game.count.should eq 1
    Genre.should be_true  
  
end

Then /^I should see the saved token list data$/ do
   #page.should have_content(@textPlatforms)  
   #page.should have_content(@textMedias)  
   #page.should have_content(@textModes)
   #page.should have_content(@textTags) 
end


 