class Thing < ActiveRecord::Base
  belongs_to :todo
  scope :for_todo, -> (todo_id) { where(todo_id: todo_id)  }
  # scope :for_todo, (lambda do |todo_id|
  #       where(id: todo_id)
  # end)
  def special_name
    puts "running on the client"
    "I am the special name"
  end
end
