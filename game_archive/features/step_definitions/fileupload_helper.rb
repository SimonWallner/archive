def get_path_and_tag_to_type(type)
  if type == "developer"

    filename = "loudspeaker.png"
    tag = 'developer_image'

  elsif type == "game"

    filename = "field.jpg"
    tag = 'game_image'

  elsif type == "company"

    filename = "parliament.jpg"
    tag = 'company_image'
  else
    filename = ""
    tag = nil

  end

  path = "#{Rails.root}/features/testpics/#{filename}"

  return tag,path
end