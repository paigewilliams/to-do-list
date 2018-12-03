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

post('/list')do
  new_list = List.new(params)
  new_list.save
  @lists = List.all
  binding.pry
  erb(:task)
end

post('/list/:id') do
  @lists = List.all
  @tasks = Tasks.all
  erb(:task)
end
