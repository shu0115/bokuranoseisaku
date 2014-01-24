class TopController < ApplicationController
  skip_before_filter :authenticate

  # トップ
  def index(page)
    # if current_user.present?
      # client = Twitter::REST::Client.new do |config|
      #   config.consumer_key        = Settings.twitter_key
      #   config.consumer_secret     = Settings.twitter_secret
      #   config.access_token        = current_user.authentications.first.token
      #   config.access_token_secret = current_user.authentications.first.secret
      # end

      # # 最新10件取得
      # results = client.search("#ぼくらの政策 OR #僕らの政策 -rt", since_id: 0, lang: "ja", result_type: "recent").first(10)
      # # result = client.search("#ぼくらの政策 -rt", since_id: 0, max_id: (426600690710884352 - 1), lang: "ja", result_type: "recent").first

      # results.each do |result|
      #   # ツイート保存
      #   Tweet.where(tweet_id: result.id).first_or_create(
      #     tweet_id:       result.id,
      #     twitter_uid:    result.user.id,
      #     screen_name:    result.user.screen_name,
      #     content:        result.text,
      #     tweet_at:       result.created_at,
      #     retweet_count:  result.retweet_count,
      #     favorite_count: result.favorite_count,
      #   )
      # end
    # end

    @tweets = Tweet.order(tweet_at: :desc).page(page).per(50)
  end
end
