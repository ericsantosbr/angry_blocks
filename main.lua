require("keys")
testCharacter = require("testCharacter")
cameras = require("camera")
menus = require("menu")

p = love.physics
g = love.graphics
e = love.event
w = love.window

world = p.newWorld(0, 9.8 * 64, true)

-- camera = cameras.newCamera(g.getWidth() / 2, g.getHeight() / 2)
camera = cameras.newCamera(0, 0)

worldElements = {}
drawableObjects = {}
mainCharacter = nil

stats = ""

status = "running"
sinceLastChange = 1

menu = nil

function love.load(args)
	-- Windows configurations
	w.setMode(1000, 600, {borderless = true})

	p.setMeter(64)

	-- Test object configurations
	ground = {}
	ground.body = p.newBody(world, g.getWidth() / 2, g.getHeight() - 50)
	ground.shape = p.newRectangleShape(g.getWidth(), 100)
	ground.fixture = p.newFixture(ground.body, ground.shape)
	ground.color = {0.4, 0.86, 0.2, 1}
	ground.draw = function(self)
		g.setColor(self.color)
		g.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	end

	table.insert(worldElements, ground)
	table.insert(drawableObjects, ground)

	local block1 = testCharacter.newCharacter()
	table.insert(worldElements, block1)
	table.insert(drawableObjects, block1)

	mainCharacter = block1

	menu = menus.newMenu(20, 20, 300, 400, keys, status)
end

function love.update(dt)
	stats = ""

	if(status == "running" and sinceLastChange > 0.25) then

		world:update(dt)
		-- if(keys.escape) then e.quit() end
		if(keys.escape and sinceLastChange > 0.25) then
			status = "debug"
			sinceLastChange = 0
		end

		if(mainCharacter.body:isTouching(ground.body) and mainCharacter.body:getY() < ground.body:getY()) then
			if(keys.up) then worldElements[2]:applyForce(0, -2250) end
			if(keys.left) then worldElements[2]:applyForce(-300, 0) end
			if(keys.right) then worldElements[2]:applyForce(300, 0) end

		else
			if(keys.left) then worldElements[2]:applyForce(-100, 0) end
			if(keys.right) then worldElements[2]:applyForce(100, 0) end
		end
	end

	if (status == "debug" and sinceLastChange > 0.25) then
		status = menu:update(dt, keys)

		if (status == "running") then
			sinceLastChange = 0
		end

	end
	
	sinceLastChange = sinceLastChange + dt

	if(keys.r) then e.quit("restart") end

	stats = stats .. "\ncharacter body x: " .. mainCharacter.body:getY() .. "\n" .. "ground body x: " .. ground.body:getY()
	stats = stats .. "\n" .. status
end


function love.draw()
	g.setBackgroundColor(0.5, 0.7, 0.67)
	camera:set()
	for k, v in pairs(drawableObjects) do
		v:draw()
	end

	x, y = mainCharacter.body:getWorldCenter()
	camera:setPosition(x - (g.getWidth() / 2), y - (g.getHeight() / 2))

	camera:unset()

	if(status == "debug") then menu:draw() end

	g.setColor({1, 0, 0, 1})
	g.print(stats, 20, 20)

end

