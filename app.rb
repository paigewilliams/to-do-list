require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/Task")
require("./lib/List")
require("pg")

DB = PG.connect({:dbname => "to_do"})

get('/')do
  @lists = List.all
  erb(:task)
end

post('/list')do
  @lists = List.all
  erb(:task)
end

post('/list/:id') do
  @lists = List.all
  @tasks = Tasks.all
  erb(:task)
end
