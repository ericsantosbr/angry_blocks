require("keys")
testCharacter = require("testCharacter")
cameras = require("camera")

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
end

function love.update(dt)
	world:update(dt)
	if(keys.escape) then e.quit() end
	if(keys.r) then e.quit("restart") end

	if(mainCharacter.body:isTouching(ground.body)) then
		if(keys.up) then worldElements[2]:applyForce(0, -2500) end
		if(keys.left) then worldElements[2]:applyForce(-300, 0) end
		if(keys.right) then worldElements[2]:applyForce(300, 0) end

	else
		if(keys.left) then worldElements[2]:applyForce(-100, 0) end
		if(keys.right) then worldElements[2]:applyForce(100, 0) end
	end

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

end

