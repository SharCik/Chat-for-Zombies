

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lastseenable

         has_many :conversations, :foreign_key => :sender_id
         has_one :profile
         has_many :favorites, class_name:  "favorites",
                                  foreign_key: "second_id",
                                  dependent:   :destroy


    mount_uploader :picture, PictureUploader

  def self.online_now
    where("last_seen > ?", 5.minutes.ago)
  end

  validates_presence_of   :picture
  validates_integrity_of  :picture
  validates_processing_of :picture
end
