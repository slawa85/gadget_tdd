class Gadget < ActiveRecord::Base
  validates :name, presence: true,  length: { minimum: 3 }

  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: Proc.new { |a| a['image'].nil? }

  default_scope { includes(:images) }

  def self.get_by(owner_id)
    owner_id.nil? ? all : where("user_id = #{owner_id}")
  end
end
