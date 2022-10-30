# frozen_string_literal: true

class Article < ApplicationRecord
  has_one :user
  has_one :address, as: :locatable
  has_one :reaction
  has_one :value

  def user
    User.find(user_id)
  end

  def reaction
    Reaction.find_by(article_id: id)
  end
end
