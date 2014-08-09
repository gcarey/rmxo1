class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validation
  validates :first_name, presence: true
  validates :last_name, presence: true


  # Profile Photos
  has_attached_file :avatar, :styles => { :medium => "190x190#", :thumb => "45x45#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  # Friendships
  has_many :friendships
  has_many :passive_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  has_many :active_friends, -> { where(friendships: { approved: true}) }, :through => :friendships, :source => :friend
  has_many :passive_friends, -> { where(friendships: { approved: true}) }, :through => :passive_friendships, :source => :user
  has_many :pending_friends, -> { where(friendships: { approved: false}) }, :through => :friendships, :source => :friend
  has_many :requested_friendships, -> { where(friendships: { approved: false}) }, :through => :passive_friendships, :source => :user

	def friends
    active_friends | passive_friends
  end


  # Tips
  has_many :tips
  has_many :received_tips, :class_name => "Tip", :foreign_key => "recipient_id"


  # Display
  def full_name
    [first_name, last_name[0.1]].join(" ")+"."
  end
end
