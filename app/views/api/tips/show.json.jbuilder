json.tip do
  json.id    @tip.id
  json.title @tip.title

  json.user_id tip.user_id ? tip.user_id : nil
end