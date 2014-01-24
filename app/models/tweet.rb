class Tweet < ActiveRecord::Base

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

        # 最新10件取得
        results = client.search("#ぼくらの政策 OR #僕らの政策 -rt", lang: "ja", result_type: "recent").to_a

        Tweet.create_tweets(results)
      rescue => e
        puts "[ ---------- e ---------- ]" ; e.tapp ;
      end
    end

    # ツイートを保存
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
