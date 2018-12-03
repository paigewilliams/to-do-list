require('spec_helper')
require('pry')

describe(Task)do
  describe('.all')do
    it('is empty at first')do
      expect(Task.all()).to(eq([]))
    end
  end

  describe('#save')do
    it('adds a task to the array of saved tasks') do
      test_task = Task.new({'description' => 'learn SQL', 'list_id' => 1, 'due_date' => '1999-01-08 04:05:06', 'id' => nil})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe('#description') do
    it('lets you read the description out')do
      test_task = Task.new({'description' => 'learn SQL', 'list_id' => 1, 'due_date' => '1999-01-08 04:05:06', 'id' => nil})
      expect(test_task.description()).to(eq('learn SQL'))
    end
  end

  describe('#list_id') do
    it('lets you read the list ID out') do
      test_task = Task.new({'description' => 'learn SQL', 'list_id' => 1, 'due_date' => '1999-01-08 04:05:06', 'id' => nil})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe('#==') do
    it('is the same task if it has the same description') do
      task1 = Task.new({'description' => 'learn SQL', 'list_id' => 1, 'due_date' => '1999-01-08 04:05:06', 'id' => nil})
      task2 = Task.new({'description' => 'learn SQL', 'list_id' => 1, 'due_date' => '1999-01-08 04:05:06', 'id' => nil})
      expect(task1).to(eq(task2))
    end
  end

  describe('.all') do
    it('tests the sorting functionality of progsql') do
      task1 = Task.new({'description' => 'learn SQL', 'list_id' => 1, 'due_date' => '1999-01-09 04:05:06', 'id' => nil})
      task1.save
      task2 = Task.new({'description' => 'learn SQL', 'list_id' => 1, 'due_date' => '1999-01-08 04:05:06', 'id' => nil})
      task2.save
      task3 = Task.new({'description' => 'learn SQL', 'list_id' => 1, 'due_date' => '1999-01-10 04:05:06', 'id' => nil})
      task3.save
      expect(Task.all).to(eq([task2, task1, task3]))
    end
  end

end
