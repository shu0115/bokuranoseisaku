class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :tweet_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
