class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]

  # Validation
  validates :first_name, presence: true, length: { maximum: 14 }
  validates :last_name, presence: true, length: { maximum: 28 }

  # Welcome Email
  after_create :send_welcome_email

  # Profile Photos
  has_attached_file :avatar, :styles => { :medium => "190x190#", :small => "85x85#", :thumb => "45x45#" }, :default_url => "paperclip-defaults/:style/missing.png"

  validates_attachment  :avatar,
                        :content_type => { :content_type => /\Aimage\/.*\Z/ },
                        :size => { :less_than => 10.megabyte }

  # Settings
  has_settings do |s|
    s.key :email, :defaults => { :tip => true, :friend => true, :news => true }
  end

  # Friendships
  has_many :friendships
  has_many :passive_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  has_many :active_friends, -> { where(friendships: {approved: true}) }, :through => :friendships, :source => :friend
  has_many :passive_friends, -> { where(friendships: {approved: true}) }, :through => :passive_friendships, :source => :user
  has_many :pending_friends, -> { where(friendships: {approved: nil}) }, :through => :friendships, :source => :friend
  
  has_many :requested_friendships, -> { where(friendships: {approved: nil}) }, :through => :passive_friendships, :source => :user

	def friends
    active_friends | passive_friends
  end

  # Tips
  has_many :tips, dependent: :destroy
  has_many :shares
  has_many :received_tips, :through => :shares, :source => :tip
  has_many :originated_tips, :class_name => "Tip", :foreign_key => "originator_id"

  # Invites
  has_many :invites
  has_many :invitees, :through => :invites
  after_create :tally_invites

  # Display
  def full_name
    [first_name, last_name[0.1]].join(" ")+"."
  end


  # Google+ with OmniAuth
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).last

    unless user
      user = User.create(
        first_name: data["first_name"],
        last_name: data["last_name"],
        email: data["email"],
        password: Devise.friendly_token[0,20],
        avatar: data["image"],
        provider: "google"
        )
    end
    user
  end


  private
    def send_welcome_email
      Notifications.welcome(self).deliver
    end

    def tally_invites
      if Invitee.where(email: self.email).last
        invitee = Invitee.where(email: self.email).last
        self.update(invitations: invitee.invites.count)
      end
    end
end
