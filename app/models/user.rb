class User < ActiveRecord::Base
  has_many :links, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :uuid,  uniqueness: true

  before_create :generate_uuid
  before_create :generate_token

  private

  def generate_uuid
    return if uuid.present?

    begin
      self.uuid = SecureRandom.hex
    end while self.class.exists?(uuid: uuid)
  end

  def generate_token
    self.token = SecureRandom.hex if token.blank?
  end
end
