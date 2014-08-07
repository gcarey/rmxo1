class Tip < ActiveRecord::Base
	belongs_to :user
	belongs_to :recipient, :class_name => "User"

	serialize :images   # Store images array as YAML in the database  

  validates :link, presence: true, :format => URI::regexp(%w(http https))

  has_attached_file :image, :styles => { :full => "225x225#"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  before_save :scrape_with_grabbit


  private

  # Scrape images, title, description
  def scrape_with_grabbit
    # I highly recommend passing the following call off to a Resque worker, or Delayed Job queue.
    # The reason is that Grabbit will attempt to access the remote URL. If there is a network problem,
    # or the remote URL is unavailable, the following line could hang up your Rails process.

    data = Grabbit.url(link)

    if data
      self.title = data.title
      self.description = data.description
      self.images = data.images
      self.image = URI.parse(data.images.first)
    end
  end
end
