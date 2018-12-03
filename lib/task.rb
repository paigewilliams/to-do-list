class Task
  attr_reader(:description, :list_id, :due_date, :id, :completed)

  def initialize(attributes)
    @description = attributes.fetch("description")
    @due_date = attributes.fetch("due_date")
    @id = attributes.fetch("id").to_i
    @list_id = attributes.fetch("list_id").to_i
    @completed = convert_completed(attributes.fetch("completed"))
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
    result = DB.exec("INSERT INTO tasks (description, due_date, list_id, completed) VALUES ('#{@description}', '#{@due_date}', #{@list_id}, '#{convert_completed(@completed)}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def set_completed(param)
    update = DB.exec("UPDATE tasks SET completed = #{param} WHERE ID = #{@id} RETURNING completed;")
    @completed = update.first().fetch('completed')
    @completed = convert_completed(@completed)
  end

  def convert_completed(param)
    if param.class == String
      if param == 't'
        return true
      elsif param == 'f'
        return false
      end
    else
      if param == true
        return 't'
      elsif param == false
        return 'f'
      end
    end

  end

  def ==(another_task)
  self.description().==(another_task.description()).&(self.due_date().==(another_task.due_date())).&(self.list_id().==(another_task.list_id())).&(self.id().==(another_task.id()))
  end
end
