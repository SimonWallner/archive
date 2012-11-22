
When /^I fill in the fields with valid details$/ do
  @new_name ="Hans"
  fill_in("developer_name", :with => @new_name)

end

When /^I choose a valid file and submit it$/ do

  path = "#{Rails.root}/features/testpics/Luigi.png"
  attach_file('developer_image',path)

  click_button "Create Developer"
end

Then /^I should see the picture on the details page of the developer$/ do

  upload_to_path = "uploads/developer/image/" + Developer.find_by_name(@new_name).id.to_s + "/tiled_4x_Luigi.png"
  puts upload_to_path

  if page.respond_to? :should
    page.should have_selector("img[src$='#{upload_to_path}']")
  else
    assert page.has_selector?("img[src$='#{upload_to_path}']")
  end



end

When /^I choose a file too big and submit it$/ do
  path = "#{Rails.root}/features/testpics/barley_too_big.jpg"
  attach_file('developer_image',path)

  click_button "Create Developer"
end

Then /^I should be notified on that the Image is too big$/ do
  page.should have_content("Image is too big")
end