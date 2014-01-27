class ReputationsController < ApplicationController
  def good(tweet_id)
    reputation = Reputation::GoodReputation.where(tweet_id: tweet_id, user_id: current_user.id).first_or_create
    render partial: '/top/reputation', locals: { tweet: reputation.tweet }
  end

  def cancel_good(tweet_id)
    reputation = Reputation::GoodReputation.where(tweet_id: tweet_id, user_id: current_user.id).first
    reputation.destroy if reputation.present?
    render partial: '/top/reputation', locals: { tweet: reputation.tweet }
  end

  def bad(tweet_id)
    reputation = Reputation::BadReputation.where(tweet_id: tweet_id, user_id: current_user.id).first_or_create
    render partial: '/top/reputation', locals: { tweet: reputation.tweet }
  end

  def cancel_bad(tweet_id)
    reputation = Reputation::BadReputation.where(tweet_id: tweet_id, user_id: current_user.id).first
    reputation.destroy if reputation.present?
    render partial: '/top/reputation', locals: { tweet: reputation.tweet }
  end
end
