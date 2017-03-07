require "sqlite3"
require "tools"

DB = sqlite3.open("ListBoxSQL/mydatabase.db");

function love.load()

font = love.graphics.newFont(20)

list = require "listbox"

local tlist={
x=200, y=100,
fcolor={50,50,50},
bgcolor={190,190,190},
bordercolor={50,50,50},
font=font, showindex=true,expand=true,expmode="pos",incenter=true,
w=200,h=300}

list:newprop(tlist)

if DB then
local ADD,SELECT
ADD = "DROP TABLE IF EXISTS test;"..
"CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT(20), number INT(10));"..
"INSERT INTO test(name,number) VALUES('Luiz Renato',123456);"..
"INSERT INTO test(name,number) VALUES('Richter Belmont',6542);"..
"INSERT INTO test(name,number) VALUES('Alucard Dracula',666);"..
"INSERT INTO test(name,number) VALUES('Stephen Hawking',999);"..
"INSERT INTO test(name,number) VALUES('Charles Darwin',10);"..
"INSERT INTO test(name,number) VALUES('Carl Sagan',688487);";
DB:execute(ADD);

SELECT = "SELECT id,name FROM test WHERE name IS NOT NULL and name!=''"

for table in DB:nrows(SELECT) do
	list:additem(table.name,table.id)
end

DB:close();
end

local result = list:search("dracula","text") 
if result then list:setselected(result[1]) end

love.graphics.setFont(font)
love.graphics.setBackgroundColor(200,200,200)
end

function reload()
list:empty()
local update = true
DB = sqlite3.open("ListBoxSQL/mydatabase.db");
SELECT = "SELECT name,id FROM test WHERE name IS NOT NULL and name!=''"
for table in DB:nrows(SELECT) do
	list:additem(table.name,table.id,update)
end
DB:close();
end

function delete(id)
DB = sqlite3.open("ListBoxSQL/mydatabase.db");
local DELETE = string.format("DELETE FROM test WHERE id==%i;",id)
DB:execute(DELETE);
DB:close();
end

function insert(name)
DB = sqlite3.open("ListBoxSQL/mydatabase.db");
local INS = string.format("INSERT INTO test(name) VALUES('%s');",name)
DB:execute(INS);
DB:close();
end

function love.keypressed(key)
	local selected = list:getselected()
   if key == "escape" then
      love.event.quit()
    elseif selected and (key == "d" or key == "delete") then
    delete(list:getdata(selected))
    reload()
    if list:maxn() and selected>1 then list:setselected(selected-1) end
    if list:maxn() and selected==1 then list:setselected(1) end
    elseif (key == "a" or key == "insert") then
    insert(randomname())
    reload()
    list:setselected(list:maxn())
    elseif (key == "u") then
    	list:unselect()
   end
   list:key(key,false)
end

function love.wheelmoved(x, y)
	list:mousew(x,y)
end

function love.update(dt)
list:update(dt)
end

function love.draw()
	x, y = love.mouse.getPosition()
	list:draw(x,y,istouch)


	love.graphics.setColor(list.fcolor)
	love.graphics.print("D or Delete - to delete selected database id",10,10,0,1.2)
	love.graphics.print("A or Insert - to add new random name in database",10,40,0,1.2)
	love.graphics.print("U - to unselect item",10,70,0,1.2)
end