def fill_in_all_for_game (type)

  if type == "old"

    @old_name="Mario"
    @old_description = "great game"
    @old_filename = "painting.jpg"
    @old_embedcode = "http://youtu.be/YlUKcNNmywk"
    @old_screenshot = "painting.jpg"
    @old_external_link_name =  "WikipediaExternalLink"
    @old_external_link= "[#{@old_external_link_name}](http://wikipedia.org)"
    @old_day = "1"
    @old_month = "3"
    @old_year = "2012"
    @old_developer = "Hugo"
    @old_publisher = "EA"
    @old_distributor = "EA"
    @old_credits = "credits_old"
    @old_series = "Mario Series"
    @old_genres = "jumpandrun"
    @old_platform = "nes"
    @old_media = "nescartridge"
    @old_mode = "single"
    @old_tags = "tag_old"

    fill_in("game_title", :with => @old_name)
    fill_in("game_description", :with => @old_description)

    path = "#{Rails.root}/features/testpics/#{@old_filename}"
    tag = 'game_image'
    attach_file(tag,path)

    add_embedcode(@old_embedcode)

    attach_screenshot(@old_screenshot)

    fill_in "new_external_links", :with => @old_external_link

    select(@old_day, :from => 'day_release_date1')
    select(@old_month, :from => 'month_release_date1')
    fill_in "year_release_date1", :with => @old_year

    fill_in "developer_link", :with => @old_developer
    fill_in "publisher_link", :with => @old_publisher
    fill_in "distributor_link", :with => @old_distributor
    fill_in "credits_link", :with => @old_credits
    fill_in "series_link", :with => @old_series

    fill_in "new_platforms_input", :with => @old_platform
    fill_in "new_genres_input", :with => @old_genres
    fill_in "new_tags_input", :with => @old_tags
    fill_in "new_modes_input", :with => @old_mode
    fill_in "new_medias_input", :with => @old_media


  elsif type == "new"

    @new_name="Mario"
    @new_description = "great game_new"
    @new_filename = "field.jpg"
    @new_embedcode = "http://www.youtube.com/watch?v=i_6wZ_3uJr8"
    @new_screenshot = "field.jpg"
    @new_external_link_name =  "GoogleExternalLink"
    @new_external_link= "[#{@old_external_link_name}](http://google.com)"
    @new_day = "2"
    @new_month = "4"
    @new_year = "2011"
    @new_developer = "Peter"
    @new_publisher = "ubisoft"
    @new_distributor = "ubisoft"
    @new_credits = "credits_new"
    @new_series = "Luigi Series"
    @new_genres = "shooter"
    @new_platform = "snes"
    @new_media = "snescartridge"
    @new_mode = "multi"
    @new_tags = "tag_new"

    fill_in("game_title", :with => @new_name)
    fill_in("game_description", :with => @new_description)

    path = "#{Rails.root}/features/testpics/#{@new_filename}"
    tag = 'game_image'
    attach_file(tag,path)

    add_embedcode(@new_embedcode)

    remove_screenshot
    attach_screenshot(@new_screenshot)

    fill_in "new_external_links", :with => @new_external_link

    select(@new_day, :from => 'day_release_date1')
    select(@new_month, :from => 'month_release_date1')
    fill_in "year_release_date1", :with => @new_year

    fill_in "developer_link", :with => @new_developer
    fill_in "publisher_link", :with => @new_publisher
    fill_in "distributor_link", :with => @new_distributor
    fill_in "credits_link", :with => @new_credits
    fill_in "series_link", :with => @new_series


    fill_in "new_platforms_input", :with => @new_platform
    fill_in "new_genres_input", :with => @new_genres
    fill_in "new_tags_input", :with => @new_tags
    fill_in "new_modes_input", :with => @new_mode
    fill_in "new_medias_input", :with => @new_media
  end

end

def fill_in_all_for_developer(type)
  if type == "old"

    @old_name="Hans"
    @old_description = "great programmer"
    @old_filename = "loudspeaker.png"
    @old_external_link_name =  "WikipediaExternalLink"
    @old_external_link= "[#{@old_external_link_name}](http://wikipedia.org)"

    #fill in all the fields
    fill_in("developer_name", :with => @old_name)
    fill_in("developer_description", :with => @old_description)

    path = "#{Rails.root}/features/testpics/#{@old_filename}"
    tag = 'developer_image'
    attach_file(tag,path)


    fill_in "new_external_links", :with => @old_external_link

  elsif type == "new"

    @new_name = "Hans"
    @new_description = "great programmer_new"
    @new_filename = "field.jpg"
    @new_external_link_name= "GoogleExternalLink"
    @new_external_link= "[#{@new_external_link_name}](http://google.com)"

    #change the fields
    fill_in("developer_name", :with => @new_name)
    fill_in("developer_description", :with => @new_description)

    path = "#{Rails.root}/features/testpics/#{@new_filename}"
    tag = 'developer_image'
    attach_file(tag,path)


    fill_in "new_external_links", :with => @new_external_link

    end

end


def fill_in_all_for_company(type)

  if type == "old"

    @old_name="Peterson"
    @old_description = "great company"
    @old_filename = "loudspeaker.png"
    @old_external_link_name =  "WikipediaExternalLink"
    @old_external_link= "[#{@old_external_link_name}](http://wikipedia.org)"
    @old_official_name = "Peterson Co"
    @old_locations = "California"

    @old_day = "1"
    @old_month = "3"
    @old_year = "2012"


    fill_in("company_name", :with => @old_name)
    fill_in("company_description", :with => @old_description)

    path = "#{Rails.root}/features/testpics/#{@old_filename}"
    tag = 'company_image'
    attach_file(tag,path)

    fill_in "new_external_links", :with => @old_external_link

    select(@old_day, :from => 'day_founded')
    select(@old_month, :from => 'month_founded')
    fill_in "year_founded", :with => @old_year

    fill_in "official_name", :with => @old_official_name
    fill_in "new_locations", :with => @old_locations

  elsif type == "new"

    @new_name = "Peterson"
    @new_description = "great company_new"
    @new_filename = "field.jpg"
    @new_external_link_name= "GoogleExternalLink"
    @new_external_link= "[#{@new_external_link_name}](http://google.com)"
    @new_official_name = "Peterson Co_new"
    @new_locations = "Florida"
    @new_day = "2"
    @new_month = "4"
    @new_year = "2011"


    fill_in("company_name", :with => @new_name)
    fill_in("company_description", :with => @new_description)

    path = "#{Rails.root}/features/testpics/#{@new_filename}"
    tag = 'company_image'
    attach_file(tag,path)

    fill_in "new_external_links", :with => @new_external_link

    select(@new_day, :from => 'day_founded')
    select(@new_month, :from => 'month_founded')
    fill_in "year_founded", :with => @new_year

    fill_in "official_name", :with => @new_official_name
    fill_in "new_locations", :with => @new_locations


  end

end