class Sticker < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'

  mount_uploader :photo, PictureUploader
end
