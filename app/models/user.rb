class User < ActiveRecord::Base
  acts_as_tagger
  has_many :authentications

  def admin?
    self.authentications.first.try(:uid) == '14369656'
  end

  private

  # ユーザ作成
  def self.create_with_auth(authentication)
    # ユーザ作成
    user = User.new
    user.name                = (authentication.nickname.presence || authentication.name)
    user.image               = authentication.image    if authentication.image.present?
    user.email               = authentication.email    if authentication.email.present?
    user.last_login_provider = authentication.provider if authentication.provider.present?
    user.last_login_at       = Time.now

    # データ保存
    user.save!

    # auth紐付け
    authentication.user_id = user.id
    authentication.save!

    return user
  end
end
