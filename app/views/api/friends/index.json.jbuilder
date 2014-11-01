json.friends  @friends do |friend|
  json.id    friend.id
  json.fullName  friend.full_name
  json.email   friend.email
  json.avatar  friend.avatar_file_name
end

json.uID  current_user.id
json.uName  current_user.full_name
json.uAvatar  current_user.avatar_file_name