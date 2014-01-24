class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :tweet_id, limit: 8
      t.string :twitter_uid
      t.string :screen_name
      t.text :content
      t.timestamp :tweet_at
      t.integer :retweet_count
      t.integer :favorite_count

      t.timestamps
    end
  end
end
