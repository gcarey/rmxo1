class Invite < ActiveRecord::Base
	belongs_to :user
	belongs_to :invitee
end