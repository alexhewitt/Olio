# frozen_string_literal: true

# Article record. Returns article record and required associations
class Article < ApplicationRecord
  has_one :user
  has_one :address, as: :locatable
  has_one :reaction
  has_one :value

  # Returns the author of the article. Assumes there is one.
  def user
    User.find(user_id)
  end

  # Returns the reaction of the article. Assumes there is one.
  def reaction
    Reaction.find_by(article_id: id)
  end
end
