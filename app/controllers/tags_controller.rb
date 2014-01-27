class TagsController < ApplicationController
  def create(tweet_id, tag_name)
    tweet = Tweet.find_by(id: tweet_id)
    tag   = Tag.where(Tag.arel_table[:name].matches("#{tag_name}")).first
    tag   = Tag.create(name: tag_name, user_id: current_user.id) if tag.blank?
    Tagging.where(tweet_id: tweet_id, tag_id: tag.id).first_or_create(user_id: current_user.id)

    render partial: '/top/tags', locals: { tweet: tweet }
  end

  def destroy(id, tweet_id)
    tagging = Tagging.where(tag_id: id, tweet_id: tweet_id, user_id: current_user.id).first
    tagging.destroy if tagging.present?

    render partial: '/top/tags', locals: { tweet: tagging.tweet }
  end
end
