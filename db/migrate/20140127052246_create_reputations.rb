class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.string :type
      t.references :user, index: true
      t.references :tweet, index: true

      t.timestamps
    end

    add_column :tweets, :good_count, :integer, default: 0
    add_column :tweets, :bad_count, :integer, default: 0
  end
end
