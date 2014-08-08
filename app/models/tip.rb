class Tip < ActiveRecord::Base
	belongs_to :user
	belongs_to :recipient, :class_name => "User"

  validates :link, presence: true, :format => URI::regexp(%w(http https))
  before_save :scrape_with_grabbit
	serialize :images   # Store images array as YAML in the database  

  has_attached_file :image, :styles => { :full => "225x225#"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


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
      # Only runs if images were returned by Grabbit 
      unless data.images.nil?
        $offset = 0
        # Runs until an image is saved
        while self.image_file_name == nil
          # Checks and conditionally sets file with offset of 0, 1, 2, etc.
          geometry = Paperclip::Geometry.from_file(data.images.drop($offset).first)
          if geometry.width.to_i >= 225 && geometry.height.to_i >= 225
            self.image = URI.parse(data.images.drop($offset).first)
          end
          $offset +=1
          # If no more images to check, just use first
          if data.images.drop($offset).first == nil
            self.image = URI.parse(data.images.first)
            break
          end
        end 
      end
    end
  end
end
