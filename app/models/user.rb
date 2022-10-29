# frozen_string_literal: true

class User < ApplicationRecord
  has_many :articles
  has_one :address, as: :locatable
end
