class TopController < ApplicationController
  skip_before_filter :authenticate

  # トップ
  def index(page, q: {}, sort: 'new')
    @tweets = Tweet.order(bad_count: :asc).page(page).per(50)
    @tweets = sort == 'popular' ? @tweets.order(good_count: :desc) : @tweets.order(tweet_at: :desc)
    @tweets = @tweets.search(content_cont_all: q[:content_cont].to_s.split(/ |　/))
    @tweets = @tweets.result

    # 検索条件保持
    @search = Tweet.search(q)
  end
end
