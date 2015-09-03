class Gadget < ActiveRecord::Base
  validates :name, presence: true,  length: { minimum: 3 }

  def self.get_by(owner_id)
    owner_id.nil? ? all : where("user_id = #{owner_id}")
  end
end
