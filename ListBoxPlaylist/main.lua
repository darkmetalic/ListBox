mpos,mduration=0,0
mselected=nil
random=false
time=0
count=1

function love.load()

font = love.graphics.newFont("font/verdana.ttf",20)

list = require "listbox"

local tlist={
bgcolor={10,10,10,200},
font=font, showindex=true,ismouse=true,istouch=false,expand=true,expmode="pos",
rounded=true,incenter=true,selected=1,sort="desc",indexzeros=2, hor=false,
w=300,h=300}

list:newprop(tlist)

dir="music"
img="img"
files = list:enudir(dir,".mp3 .wav .ogg")

if files then
for i, mus in ipairs(files) do
mus=dir.."/"..mus
list:additem(list:getfilename(mus),list:getfileext(mus))
end
end

quad = love.graphics.newQuad(0,0,list.gw,list.gh,list.gw,list.gh)

timg={}
files = list:enudir(img,".jpg .png .bmp .jpeg")
if files then
for i, image in ipairs(files) do
image=img.."/"..image
table.insert(timg,love.graphics.newImage(image))
end
end

if list:maxn() and list:maxn()>=4 then
list:autosize(true)
end

if list:maxn() then
mselected=1
source = love.audio.newSource(dir.."/"..list:getfusion(mselected))
source:play()
mduration=source:getDuration(unit)
end

love.graphics.setFont(font)
end

play_x=0
function nowp(str)
local width = font:getWidth(str)*4
local height = font:getHeight(str)*4
if (play_x+width)>20 then
  play_x=play_x-3
else
  play_x=list.gw-20
end
love.graphics.print(str, play_x, 20,0,4,4)
end

function love.keypressed(key)
	local selected = list:getselected()
   if key == "escape" then
      love.event.quit()
    elseif key == "return" or key == "kpenter" then
    	source = love.audio.newSource(dir.."/"..list:getfusion(selected))
    	love.audio.stop()
    	source:play()
    	mduration=source:getDuration(unit)
    	mselected=selected
   end
   list:key(key)
end

function love.wheelmoved(x, y)
	list:mousew(x,y)
end

function love.update(dt)

	time=time+dt

	if source and source:isPlaying() then
		mpos=source:tell(unit)
	elseif source and not source:isPlaying() then
		local count = list:getcount()
		if random then
		mselected=(math.random(count))
		list:setselected(mselected)
		source = love.audio.newSource(dir.."/"..list:getfusion(mselected))
    	source:play()
		else
		if mselected+1<=count then
		mselected=mselected+1
		list:setselected(mselected)
		source = love.audio.newSource(dir.."/"..list:getfusion(mselected))
    	source:play()
    	else
    	mselected=1
    	list:setselected(mselected)
		source = love.audio.newSource(dir.."/"..list:getfusion(mselected))
    	source:play()
    	end
    	end
    	mduration=source:getDuration(unit)
	end

	list:update(dt)

	if list:isdoublec() then
		mselected=list:getselected()
		source = love.audio.newSource(dir.."/"..list:getfusion(mselected))
    	love.audio.stop()
    	source:play()
    	mduration=source:getDuration(unit)
    	mpos=source:tell(unit)
	end
end

function love.touchpressed( id, x, y, dx, dy, pressure )
list:press()
end

function love.touchmoved( id, x, y, dx, dy, pressure )
list:move()
end

function love.touchreleased( id, x, y, dx, dy, pressure )
list:released()
end

function love.draw()
	if timg[count] then
		if math.floor(time)>=10 and timg[count+1] then
		count=count+1
		time=0
		elseif math.floor(time)>=10 and not timg[count+1] then
		count=1
		time=0
		end
		love.graphics.setColor(200,200,200)
		love.graphics.draw(timg[count], quad)
	end
	
	if source and source:isPlaying() then
	love.graphics.setColor(list.fcolor)
	nowp("Now Playing "..list:concat(mselected))
	end
	love.graphics.setColor(list.fcolor)
	love.graphics.print(list:sectotime(mpos),10,list.gh-list.fh*3,0,3)
	love.graphics.print(list:sectotime(mduration),list.gw-(font:getWidth("00:00:00")*3+list.fw),list.gh-list.fh*3,0,3)

	list:draw()
end