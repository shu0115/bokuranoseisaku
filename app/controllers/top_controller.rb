class TopController < ApplicationController
  skip_before_filter :authenticate

  # トップ
  def index(page, q: {}, sort: 'new', tag_id: nil)
    @tweets = Tweet.order(bad_count: :asc).page(page).per(Settings.per_page)
    @tweets = sort == 'popular' ? @tweets.order(good_count: :desc) : @tweets.order(tweet_at: :desc)
    @tweets = @tweets.where(id: Tagging.where(tag_id: tag_id).pluck(:tweet_id)) if tag_id.present?
    @tweets = @tweets.search(content_cont_all: q[:content_cont].to_s.split(/ |　/))
    @tweets = @tweets.result

    # 検索条件保持
    @search = Tweet.search(q)
    @tag    = Tag.find_by(id: tag_id)

    # タグ一覧
    @tags = Tag.order(name: :asc).includes(:taggings).where.not(taggings: { id: nil })
  end
end
