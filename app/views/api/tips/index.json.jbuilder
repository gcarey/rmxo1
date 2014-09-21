json.tips  @tips do |tip|
  json.id    tip.id
  json.link  tip.link

  json.user_id tip.user_id ? tip.user_id : nil
end