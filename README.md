# Dynamic ListBox
Dynamic ListBox for LÖVE - Free 2D Game Engine 0.10+ https://love2d.org/ 

# Demo:
```lua
function love.load()

font = love.graphics.newFont(15)

list = require "listbox"

local tlist={
x=200, y=100,
font=font,ismouse=true,
rounded=true,
w=200,h=300,showindex=true}

list:newprop(tlist)

list:additem("MySite","www.MySite.com")
list:additem("MyNumber",123456)
end

function love.keypressed(key)
list:key(key,true)
end

function love.wheelmoved(x,y)
list:mousew(x,y)
end

function love.update(dt)
list:update(dt)
end

function love.draw()
list:draw()
end
```
# DEFAULT VALUUES (tlist)
```lua
listbox={

x=100,y=100, -- listbox position x,y (number)

w=200,h=400, -- listbox size Width x Height (number)

hor=true,ver=true, -- Show scroller Horizontal and Vertical (boolean)

sort=false, -- sort mode: string "asc" or "desc" or boolean true(asc) or false(disabled)

enabled=true, -- enable or disable the listbox, it remains visible, but does not interact (boolean)

visible=true, -- visible or invisible, the listbox may interact invisibly if it is not disabled

adjust=true, -- adjuste (boolean)

rounded=false, -- rounded rectangle (boolean)

expand=false, -- expand the listbox (boolean)

expandmode="size", -- expand mode: size true (boolean|string) or position "pos" (string)

expx=12, -- expand pixels (number)

radius=15, -- scroll ball size/radius (number)

sep=";;", -- separator that limits where the text ends and the data starts in the index (string)

ismouse=true, -- if you will use mouse (boolean)

istouch=false, -- if you will use touches (boolean)

gw = love.graphics.getWidth(), -- first Width captured to resize, do not works if you confugured(conf.lua) in fullscreen (or set gw)

gh = love.graphics.getHeight(), -- first Height captured to resize, do not works if you confugured(conf.lua) in fullscreen (or set gh)

incenter=false, -- in center of screen (boolean)

asize=false, -- auto size the listbox (boolean)

font = love.graphics.newFont(12), -- listbox font (object)

fcolor={0,190,0}, -- font color RGB (table)

bordercolor={50,50,50}, -- border color RGB (table)

selectedcolor={50,50,50}, -- selected color RGB (table)

fselectedcolor={200,200,200}, -- font selected color RGB (table)

selectedtip="fill", -- selected mode "fill" or "line" (string)

bgcolor={20,20,20}, -- background selected color RGB (table)

showindex=false, -- show index (boolean)

indexzeros=1, -- index left zeros (number)

selected=false, -- first index selected (number) or (false) none

gpadding=5 -- global padding (number) }
```
# FUNCTIONS
```lua
NOTE: all default values and functions are in lowercase

text = string or number
data = string or number
str = string or number
index = integer (number)
item = index (text and data)
tlist = table
mode = boolean or string
update = boolean (uplist)
font = object
[] = optional

listbox:additem(text,[data],[update]) or listbox:insert(text,[data],[update]) -- add new item, return true if successfully
ex: list:additem("MySite","www,mysite.com",true)
ex: list:insert("MySite","www,mysite.com",false)

listbox:delitem(index) or listbox:remove(index) -- delete a specific item, return true if successfully
ex: list:delitem(16)

listbox:delall() or listbox:empty() -- remove all itens, no returns

listbox:getcount() or listbox:maxn() -- return max itens (number) if successfully or false (boolean)

listbox:getselected() -- return selected index (number) if successfully or false (boolean)

listbox:getdata(index) -- return item data (string) if successfully or "" (empty string)

listbox:gettext(index) -- return item text (string) if successfully or "" (empty string)

listbox:getfusion(index) or listbox:concat(index) -- return item concatenated text..data (string) if successfully or (false)

listbox:getsize() -- two returns dimension Width Height of the listbox (number)

listbox:getpos() -- two returns position X Y of the listbox (number)

listbox:uplist() -- update/atualize the listbox, no returns

listbox:unselect() or listbox:deselect() -- deselect the listbox, no returns

listbox:setexpand(mode) -- set expand mode true enables or "size" and enables or "pos" and enables or false disable, no returns
ex: list:setexpand("size")
ex: list:setexpand("pos")
ex: list:setexpand(true)
ex: list:setexpand(false)

listbox:settext(index,text) -- replaces item text, return true if successfully
ex = list:settext(2,"Second")

listbox:setdata(index,data) -- replaces item data, return true if successfully

listbox:setitem(index,text,[data]) -- replaces item text and data, return true if successfully
ex = list:setitem(2,"Second","SecondData")

listbox:setfont(font) -- set the listbox font, return true if successfully

listbox:setselected(index) -- selects a item in the listbox, return true if successfully

listbox:newprop(tlist) -- creates a new property for the listbox 

listbox:setrounded(boolean) -- listbox is rounded or rectangle

listbox:findlist(str,[mode],[sensible]) or listbox:search(str,[mode],[sensible]) -- return (table) index of all found str if successfully, or false (boolean)
ex: result = list:findlist("love","text",true)
if result then print(result[1]) end

ex: result = list:search("love","textdata",false)
if result then list:setselected(table.maxn(result)) end

ex: result = list:findlist("love","data",false)
if result then list:setdata(result[1],"Love2D") end

listbox:resort(mode,update) -- sort the listbox in asceding or descending, no returns
ex: list:resort("asc",true)
ex: list:resort(true,true) -- ascending 
ex: list:resort("desc",true)
ex: list:resort(false) -- disables, but not defaults sorted itens

listbox:setsize(Width,Height) -- set dimension (number)

listbox:setpos(X,Y) -- set position (number)

listbox:setindex(boolean) -- show or hide index numbers counted, no returns

listbox:setvisible(boolean) -- visible or invisible, the listbox may interact invisibly if it is not disabled

listbox:setenabled(boolean) -- enable or disable the listbox, it remains visible, but does not interact (boolean)

listbox:isvisible() -- get if is visible, return boolean

listbox:isenabled() -- get if is enabled, return boolean

listbox:isover() -- get if is pointed(over) in the listbox, return boolean

listbox:isselectchange() -- get if item selected is changed, return boolean

listbox:isdoublec() -- get if is double click in the selected item, return boolean

listbox:autosize(boolean) -- auto size the listbox, no returns

listbox:center(boolean) -- auto center in the screen, no returns

listbox:export(file,[mode1],[mode2]) or listbox:save(file,[mode1],[mode2]) -- save all itens in a file to save directory or on the side
ex: list:export("list.txt",true,"text") -- ("text" or true) exports only itens texts in save directory (and index if enabled)
ex: list:export("list.txt",false,false) -- exports all itens text..separator..data on the side (and index if enabled)
ex: list:export("list.txt") -- exports all itens text..separator..data on the side (and index if enabled)
NOTE: on the side (mode1-false) not works in android or ios, automatically exports in your save directory (mode1-true)

listbox:import(file) or listbox:open(file) -- load all lines in the listbox, if have separator will add as data, return true if successfully
ex: list:import("newlist.list") 
```
# EXTRA TOOLS
```lua
listbox:getfileext(filepath) -- return file extension

listbox:getfilename(filepath) -- return file name

listbox:getdirname(path) -- return directory name

listbox:onlynumbers(str) -- return only numbers of a given string

listbox:onlyletters(str) -- return only letters of a given string

listbox:insensible(string) -- return string insensible "aA"=="aa"

listbox:enudir(path,[extensions]) -- return (table) of all files enumerated with a specific extension (or no), or false
ex: result = list:enudir("music/rock",".wav .mp3 .ogg")
ex: result = list:enudir("images",".png .jpeg .bmp")
ex: result = list:enudir("contents")

listbox:sectotime(seconds,[milliseconds]) -- return a time of a given number, or "00:00:00"
ex: result = list:sectotime(1000) -- return 00:16:40
ex: result = list:sectotime(1e3,true) -- return 00:16:40.0

listbox:rgbtohex(tcolor) -- return hexadecimal (string) of a given RGB color (table)
ex: tcolor = {100,200,255}
result = list:rgbtohex(tcolor) -- return 64C8FF

ex: print("#"..list:rgbtohex({100,200,255})) -- print #64C8FF

listbox:mount(path) -- mounts a directory outside of its executable
```
# MAIN FUNCTIONS
```lua
listbox:key(key,shortcut) -- required if you want to interacts the listbox using keyboards, returns key pressed

ex: function love.keypressed(key)
list:key(key,true) -- if shortcut is enabled, select the first item character found while pressed a key 
end

listbox:mousew(x,y) -- required if you want to interacts the listbox using mouse wheel

ex: function love.wheelmoved(x,y)
list:mousew(x,y)
end

listbox:update(dt) -- required if you want to interacts the listbox...

ex: function love.update(dt)
list:update(dt)
end

listbox:press(x,y) or list.ispress=true -- optional for mouses, required for touches

ex: function love.touchpressed(id, x, y, dx, dy, pressure)
list:press(x,y)
end

ex: function love.touchpressed(id, x, y, dx, dy, pressure)
list.ispress=true
end

listbox:moved(x,y) or list.ispress=true -- optional for mouses, required for touches

listbox:released(x,y) or list.ispress=false -- optional for mouses, required for touches

listbox:resize() -- required if you want to autosize the listbox on resize

ex: function love.resize(w,h)
list:resize()
end

listbox:draw() -- required if you want to use the listbox

ex: function love.draw()
list:draw()
end
```
