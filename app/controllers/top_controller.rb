class TopController < ApplicationController
  skip_before_filter :authenticate

  # トップ
  def index(page, q)
    @search = Tweet.order(tweet_at: :desc).page(page).per(50).search(q)
    @tweets = @search.result
  end
end
