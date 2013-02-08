def submit_any_button

  begin
    if find_button("Update Developer")
      click_button "Update Developer"
    end
  rescue Capybara::ElementNotFound
    #puts "Update Developer not found"
  end

  begin
    if find_button("Create Developer")
      click_button "Create Developer"
    end
  rescue Capybara::ElementNotFound
    #puts "Create Developer not found"
  end

  begin
    if find_button("Create Game")
      click_button "Create Game"
    end
  rescue Capybara::ElementNotFound
    #puts "Create Game not found"
  end
  begin
    if find_button("Update Game")
      click_button "Update Game"
    end
  rescue Capybara::ElementNotFound
    #puts "Update Game not found"
  end
  begin
    if find_button("Update Company")
      click_button "Update Company"
    end
  rescue Capybara::ElementNotFound
    #puts "Update Company not found"
  end
  begin
    if find_button("Create Company")
      click_button "Create Company"
    end
  rescue Capybara::ElementNotFound
    #puts "Create Company not found"
  end

end

def  fill_in_name(type)

  if type == "developer"
    @new_name ="Hans"
    fill_in("developer_name", :with => @new_name)
  elsif type == "game"
    @new_game = "newgame"
    fill_in("game_title", :with => @new_game)
  elsif type == "company"
    @new_company = "BowseruCo"
    fill_in("company_name", :with => @new_company)
  end
end