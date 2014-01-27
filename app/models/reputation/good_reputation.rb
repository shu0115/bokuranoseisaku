class Reputation::GoodReputation < Reputation
  after_create { |reputation| reputation.tweet.update(good_count: Reputation::GoodReputation.where(tweet_id: reputation.tweet_id).count) }
  after_destroy { |reputation| reputation.tweet.update(good_count: Reputation::GoodReputation.where(tweet_id: reputation.tweet_id).count) }
end
