class Tweet < ActiveRecord::Base
  has_many :tags, through: :taggings
  has_many :taggings

  def good?(user)
    Reputation::GoodReputation.where(tweet_id: self.id, user_id: user.id).exists?
  end

  def bad?(user)
    Reputation::BadReputation.where(tweet_id: self.id, user_id: user.id).exists?
  end

  private

  class << self
    ## ツイート取得
    # ruby bin/rails runner "Tweet.fetch_tweets"
    def fetch_tweets
      begin
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = Settings.twitter_key
          config.consumer_secret     = Settings.twitter_secret
        end

        results = client.search("#ぼくらの政策 OR #僕らの政策 -rt", lang: "ja", result_type: "recent").to_a

        Tweet.create_tweets(results)
      rescue => e
        puts "[ ---------- e ---------- ]" ; e.tapp ;
      end
    end

    ## 過去ツイート取得
    # ruby bin/rails runner "Tweet.fetch_past_tweets"
    def fetch_past_tweets
      begin
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = Settings.twitter_key
          config.consumer_secret     = Settings.twitter_secret
        end

        results = client.search("#ぼくらの政策 OR #僕らの政策 -rt", since_id: 0, max_id: (Tweet.order(tweet_at: :asc).first.tweet_id - 1), lang: "ja", result_type: "recent").to_a

        Tweet.create_tweets(results)
        puts "[ ---------- results.length ---------- ]" ; results.length.tapp ;
      rescue => e
        puts "[ ---------- e ---------- ]" ; e.tapp ;
      end
    end

    ## ツイートを保存
    def create_tweets(results)
      results.each.with_index(1) do |result, index|
        # ツイート保存
        Tweet.where(tweet_id: result.id).first_or_create(
          tweet_id:       result.id,
          twitter_uid:    result.user.id,
          screen_name:    result.user.screen_name,
          content:        result.text,
          tweet_at:       result.created_at,
          retweet_count:  result.retweet_count,
          favorite_count: result.favorite_count,
        )
      end
    end
  end
end
