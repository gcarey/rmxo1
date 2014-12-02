json.tips  @shares do |share|
  json.id       share.tip.id
  json.shareId  share.id
  json.sender   User.where(id: share.tip.user_id).last.full_name
end