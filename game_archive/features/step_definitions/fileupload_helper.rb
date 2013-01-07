def get_path_and_tag_to_type(type)
  if type == "developer"

    filename = "Luigi.png"
    tag = 'developer_image'

  elsif type == "game"

    filename = "diablo3.jpeg"
    tag = 'game_image'

  elsif type == "company"

    filename = "bowser.jpg"
    tag = 'company_image'
  else
    filename = ""
    tag = nil

  end

  path = "#{Rails.root}/features/testpics/#{filename}"

  return tag,path
end