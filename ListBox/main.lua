require "tools"
local iscolored=nil
local isdemo=nil
lo= cal isverdana=nil
sizew=1
sizeh=1
function love.load()

font = love.graphics.newFont(15)
fverdana = love.graphics.newFont("font/verdana.ttf",16)

list = require "listbox"

local tlist={
x=200, y=100,
font=font,ismouse=true,
rounded=true,
w=200,h=300,showindex=true}

list:newprop(tlist)

for i=1,100 do
list:additem(randomname(),(list:getcount() and list:getcount()+1 or 1))
end

list:center(true)
list:setexpand(true)

--result = list:findlist("love","text",false) --listbox:findlist(string,mode(text|textdata|data),sensible)
--if result then list:setselected(result[1]) end --return (table or nil) of all index results founded
list:setselected(1)
love.graphics.setFont(font)
end

function love.keypressed(key)
	local selected = list:getselected()
   if key == "escape" then
      love.event.quit()
    elseif key == "1" or key == "kp1" then
    if list.expand then list:setexpand(false) else list:setexpand(true) end
    elseif key == "0" or key == "kp0" or key == "h" then
    	if isdemo==true then isdemo=false else isdemo=true end
    elseif key == "2" or key == "kp2" then
    list.expmode = (list.expmode and list.expmode=="pos") and "size" or "pos"
    elseif key == "3" or key == "kp3" then
    if list.incenter then list.incenter=false list:center(false) else list.expand=false list.incenter=true list:center(true) end
    elseif key == "4" or key == "kp4" then
    if list.asize then list.asize =false else list.expand=false list.asize=true end
   elseif key == "5" or key == "kp5" then
    if list.rounded then list:setrounded(false) else list:setrounded(true) end
    elseif key == "6" or key == "kp6" then
    if list.showindex then list:setindex(false) else list:setindex(true) end
    elseif (key == "a" or key == "insert") then
    list:insert("MyAdd "..(list:getcount() and list:getcount()+1 or 1),"MyAdded data "..(list:getcount() and list:getcount()+1 or 1),true)
    list:setselected(list:getcount())
    elseif key == "return" or key == "kpenter" then
    	love.window.showMessageBox("DataIs",list:getdata(selected))
    elseif (key == "d" or key == "delete") then
    	--list:delitem(selected) or
    	list:remove(selected)
    elseif key == "r" then
    	--list:delall() or
    	list:empty()
    elseif key == "left" then
    	list:resort("asc",true)
    elseif key == "right" then
    	list:resort("desc",true)
	elseif key == "7" or key == "kp7" then
		list:setitem(2,"Second","Second Data")
	elseif key == "f" then
		result = list:findlist("love","text",false)
		if result then
			list:setselected(result[1])
			love.window.showMessageBox("Find love","Found "..table.maxn(result).." love in the list")
		else
			love.window.showMessageBox("Find love","no results")
		end
	elseif key == "8" or key == "kp8" then
		list:setselected(list:maxn())
	elseif key == "9" or key == "kp9" then
		if list.ver then
			list.ver=false
			list.hor=false
		else
			list.ver=true
			list.hor=true
		end
	elseif key == "e" then
		result=list:export("list.txt",false,false)
	elseif key == "i" then
		list.indexzeros=3
		result=list:import("pokemons.txt")
		if result then list:delitem(1) love.window.showMessageBox("ListBox","pokemons.txt Imported Successfully") end
	elseif key == "c" then
		if not iscolored then
			list.fcolor={50,50,50}
			list.bgcolor={240,240,240}
			list.bordercolor={50,50,50}
			love.graphics.setBackgroundColor(255,255,255)
			iscolored=true
		else
			list.fcolor={0,190,0}
			list.bgcolor={20,20,20}
			list.bordercolor={50,50,50}
			love.graphics.setBackgroundColor(0,0,0)
			iscolored=nil
		end
	elseif key == "v" then
		if not isverdana then
		list:setfont(fverdana)
		isverdana=true
		else
		list:setfont(font)
		isverdana=nil
		end
	elseif key == "m" then
		list:delall()
		list.indexzeros=4
		for i=1,5e3 do
		list:additem(randomname(),(list:getcount() and list:getcount()+1 or 1))
		end
		list:uplist()
		list:setselected(1)
   end
   list:key(key,false)
end

function love.resize(w,h)
sizew=w/800
sizeh=h/600
list:resize()
end

function love.wheelmoved(x,y)
list:mousew(x,y)
end

function love.update(dt)
list:update(dt)
end

function love.draw()
	list:draw()
	local selected = list:getselected()

	love.graphics.setColor(list.fcolor)
	if list:isover() then
	love.graphics.print("FOCUS",love.graphics.getWidth()-70,love.graphics.getHeight()-30)
	end
	if not isdemo then
	love.graphics.print("PRESS KEY 0 (ZERO) OR KEY H - SHOW/HIDE",10,40*sizeh,0,1.2*sizew,1.2*sizeh)
	else
	love.graphics.print("Mouse = "..(list.ismouse and "true" or "false").."      Touch = "..(list.istouch and "true" or "false"),10,40*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("1 - SetExpand "..(list.expand and "ON" or "OFF").."       2 - Expand Mode: "..list.expmode,10,70*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("3 - Centered "..(list.incenter and "ON" or "OFF"),10,100*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("4 - AutoSize",10,130*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("5 - Rounded "..(list.rounded and "ON" or "OFF"),10,160*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("6 - Show/Hide Index",10,190*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("D or Delete - Delete Selected",10,220*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("A or Insert - AddItem: \"MyAdd\"",10,250*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("R - Remove All",10,280*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("LEFT - Sort Ascending Order",10,310*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("RIGHT - Sort Descending Order",10,340*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("7 - SetItem(2) to \"Second\"",10,370*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("F - FindList for \"love\"",10,400*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("8 - SetSelected max index",10,430*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("ENTER - MSG Get data ftom Selected",10,460*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("9 - Show/Hide Scrollbars",10,490*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("E - EXPORT the list (on the side)  I - IMPORT Pokemons list",10,520*sizeh,0,1.2*sizew,1.2*sizeh)
	love.graphics.print("C - Change Colors   V - SetFont "..(isverdana and "Verdana size 16" or "Default").."   M - Add 5.000 itens",10,550*sizeh,0,1.2*sizew,1.2*sizeh)
	end
	if selected then
	love.graphics.print("Index:"..selected.."  ItemText: "..list:gettext(selected).."  ItemData: "..list:getdata(selected).."  FPS: "..love.timer.getFPS(),10*sizew,10,0,1.2*sizew,1.2*sizeh)
	end
end