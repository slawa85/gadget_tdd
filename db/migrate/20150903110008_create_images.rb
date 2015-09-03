class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :gadget, index:true
      t.attachment :image
      t.timestamps null: false
    end
  end
end
