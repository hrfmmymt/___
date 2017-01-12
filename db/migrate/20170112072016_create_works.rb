class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.text :left_breast
      t.text :right_breast
      t.timestamps
    end
  end
end
