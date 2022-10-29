# frozen_string_literal: true

class Article < ApplicationRecord
  has_one :user
  has_one :address, as: :locatable
end
