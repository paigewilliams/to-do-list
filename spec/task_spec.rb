require("rspec")
require("pg")
require("task")

DB = PG.connect ({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.EXEC("DELETE FROM tasks *;")
  end
end

describe (Task) do
  describe("#save")do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL"})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end
end
