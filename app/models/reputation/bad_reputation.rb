class Reputation::BadReputation < Reputation
  after_create { |reputation| reputation.tweet.update(bad_count: Reputation::BadReputation.where(tweet_id: reputation.tweet_id).count) }
  after_destroy { |reputation| reputation.tweet.update(bad_count: Reputation::BadReputation.where(tweet_id: reputation.tweet_id).count) }
end
