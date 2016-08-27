class Todo < ActiveRecord::Base
  has_many :things
  # scope :all_with_things, -> () { joins(:things) }, [Thing]
  # scope :completed, -> () { where(completed: true)  }
  # scope :active,    -> () { where(completed: false) }
  # default_scope { where(completed: true) }
end
