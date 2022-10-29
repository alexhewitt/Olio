# frozen_string_literal: true

class Reaction < ApplicationRecord
  has_one :article
end
