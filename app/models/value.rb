# frozen_string_literal: true

# Value record. Returns article values record. Turned out to be redundant for this application.
class Value < ApplicationRecord
  # belongs to an article to indicate price, currency and payment type.
  belongs_to :article
end
