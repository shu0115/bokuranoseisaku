class TopController < ApplicationController
  skip_before_filter :authenticate

  # トップ
  def index(page, q: {})
    @tweets = Tweet.order(tweet_at: :desc).page(page).per(50)
    @tweets = @tweets.search(content_cont_all: q[:content_cont].to_s.split(/ |　/))
    @tweets = @tweets.result

    # 検索条件保持
    @search = Tweet.search(q)
  end
end
