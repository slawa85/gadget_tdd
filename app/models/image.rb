class Image < ActiveRecord::Base
  belongs_to :gadget

  has_attached_file :image,
    styles: { large: '600x600>', medium: '300x300>', thumb: '100x100>' },
    url: '/assets/images/:id/:style/:basename.:extension',
    path: ':rails_root/public/assets/images/:id/:style/:basename.:extension'

  validates_attachment_content_type :image,
    content_type: /\Aimage\/.*\Z/

  validates_attachment_size :image, in: 0..1.megabyte
end
