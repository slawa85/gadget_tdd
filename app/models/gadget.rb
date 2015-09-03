class Gadget < ActiveRecord::Base
  validates :name, presence: true,  length: { minimum: 3 }

  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: Proc.new { |a| a['image'].nil? }

  default_scope { includes(:images) }

  def self.get_by(owner_id)
    owner_id.nil? ? all : where("user_id = #{owner_id}")
  end

  def self.search(search, user_id)
    if search
      search_condition = "%#{search}%"
      where('(name LIKE ? OR description LIKE ?) AND (user_id=?)', search_condition, search_condition, user_id)
    else
      where('user_id=?', user_id)
    end
  end
end
