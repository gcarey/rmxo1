class OutgoingShare < ActiveRecord::Base
	belongs_to :invitee
	belongs_to :tip
end