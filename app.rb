require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/Task")
require("./lib/List")
require("pg")
require 'pry'

DB = PG.connect({:dbname => "to_do"})

get('/')do
  DB.exec("DELETE FROM lists *;")
  DB.exec("DELETE FROM tasks *;")
  @lists = List.all
  erb(:task)
end

get('/list')do
  @lists = List.all
  @tasks = Task.all
  erb(:task)
end


post('/list')do
  new_list = List.new(params)
  new_list.save
  @lists = List.all
  @tasks = Task.all
  erb(:task)
end

post('/list/:list_id') do
  new_task = Task.new(params)
  new_task.save
  @lists = List.all
  @tasks = Task.all

  erb(:task)
end

get('/complete/:task_id') do
  found_task = Task.find(params["task_id"])
  new_task = Task.new(found_task)
  binding.pry
  new_task.set_completed(true)
  @lists = List.all
  @tasks = Task.all
  erb(:task)
end
