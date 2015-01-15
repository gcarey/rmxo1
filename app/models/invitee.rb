class Invitee < ActiveRecord::Base
	has_many :invites
  has_many :users, :through => :invites

	has_many :outgoing_shares
	has_many :tips, :through => :outgoing_shares
end