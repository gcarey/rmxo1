class Tip < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :recipients, :class_name => "User"
  belongs_to :originator, :class_name => "User"

  validates :link, presence: true, :format => URI::regexp(%w(http https))
  before_save :scrape_with_grabbit
	serialize :images   # Store images array as YAML in the database  

  has_attached_file :image, :styles => { :full => "130x130#"}, :default_url => "paperclip-defaults/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  private

  # Scrape images, title, description
  def scrape_with_grabbit
    ### I highly recommend passing the following call off to a Resque worker, or Delayed Job queue.
    ### The reason is that Grabbit will attempt to access the remote URL. If there is a network problem,
    ### or the remote URL is unavailable, the following line could hang up your Rails process.

    data = Grabbit.url(link)

    if data
      self.title = data.title
      self.description = data.description
      unless data.images.nil?
        $offset = 0
        # Run until an image is saved
        while self.image_file_name == nil
          # Attempt to extract file dimensions
          begin
            geometry = Paperclip::Geometry.from_file(data.images.drop($offset).first)
          rescue
            false
          else
            # Set file as image if dimensions meet reqs
            if geometry.width.to_i >= 130 && geometry.height.to_i >= 130
              self.image = URI.parse(data.images.drop($offset).first)
            end
          end
          # Move on to next image
          $offset +=1
          # If no more images to check, stop checking
          if data.images.drop($offset).first == nil
            ## And use first image
            #self.image = URI.parse(data.images.first)
            break
          end
        end 
      end
    end
  end
end
