class Task
  attr_reader(:description, :list_id, :due_date)

  def initialize(attributes)
    @description = attributes.fetch("description")
    @due_date = attributes.fetch("due_date")
    @list_id = attributes.fetch("id").to_i
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks")
    tasks = []
    returned_tasks.each() do |task_i|
      tasks.push(Task.new(task_i))
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (id, description, due_date) VALUES (#{@list_id}, '#{@description}', '#{@due_date}');")
  end

  def ==(another_task)
  self.description().==(another_task.description()).&(self.due_date().==(another_task.due_date())).&(self.list_id().==(another_task.list_id()))
  end
end
