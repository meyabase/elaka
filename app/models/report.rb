class Report < ApplicationRecord
  paginates_per 10
  has_paper_trail

  belongs_to :entry
  belongs_to :user, counter_cache: true
end
