function randomname()
local tb,x={}

x=love.math.random(4)
if x==1 then
tb[1]="Love 2D"
elseif x==2 then
tb[1]="Lua"
elseif x==3 then
tb[1]="Blue sky"
elseif x==4 then
tb[1]="Coffee is cool"
end

x=love.math.random(4)
if x==1 then
tb[2]="it"
elseif x==2 then
tb[2]="are"
elseif x==3 then
tb[2]="the best"
elseif x==4 then
tb[2]="what is it"
end

x=love.math.random(4)
if x==1 then
tb[3]="for You"
elseif x==2 then
tb[3]="for Me"
elseif x==3 then
tb[3]="in my Life"
elseif x==4 then
tb[3]="in your home"
end
return table.concat(tb," ")
end