class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_attached_file :avatar, :styles => { :medium => "190x190#", :thumb => "45x45#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  has_many :direct_friends, -> { where(friendships: { approved: true}) }, :through => :friendships, :source => :friend
  has_many :inverse_friends, -> { where(friendships: { approved: true}) }, :through => :inverse_friendships, :source => :user
  has_many :pending_friends, -> { where(friendships: { approved: false}) }, :through => :friendships, :source => :friend
  has_many :requested_friendships, -> { where(friendships: { approved: false}) }, :through => :inverse_friendships, :source => :user


	def friends
    direct_friends | inverse_friends
  end
end
