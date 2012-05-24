class Ticket < ActiveRecord::Base
  belongs_to :components
  belongs_to :priorities
  belongs_to :staffs
  belongs_to :statuses
  belongs_to :clients
  belongs_to :types
  has_many   :notes
  validates_presence_of :summary
end
