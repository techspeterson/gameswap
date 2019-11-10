class Purchase < ApplicationRecord
  # model relations
  belongs_to :user
  belongs_to :listing
end
