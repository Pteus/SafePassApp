class Entry < ApplicationRecord
  belongs_to :user

  validates :name, :username, :password, presence: true
  validate :url_must_be_valid

  encrypts :password
  encrypts :username, deterministic: true

  private

  def url_must_be_valid
    unless url.include?("http")
      errors.add(:url, "must be valid")
    end
  end

end
