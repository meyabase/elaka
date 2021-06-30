class Report < ApplicationRecord
  paginates_per 15
  has_paper_trail

  belongs_to :entry, counter_cache: true
  belongs_to :user
end
