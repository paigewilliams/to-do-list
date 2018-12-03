class Task
  attr_reader(:description, :list_id, :due_date, :id)

  def initialize(attributes)
    @description = attributes.fetch("description")
    @due_date = attributes.fetch("due_date")
    @id = attributes.fetch("id").to_i
    @list_id = attributes.fetch("list_id").to_i
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks ORDER BY list_id DESC, due_date")
    tasks = []
    returned_tasks.each() do |task|
      tasks.push(Task.new(task))
    end
    tasks
  end

  def save
    result = DB.exec("INSERT INTO tasks (description, due_date, list_id) VALUES ('#{@description}', '#{@due_date}', #{@list_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_task)
  self.description().==(another_task.description()).&(self.due_date().==(another_task.due_date())).&(self.list_id().==(another_task.list_id())).&(self.id().==(another_task.id()))
  end
end
