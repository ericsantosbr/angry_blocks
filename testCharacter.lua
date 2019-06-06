testCharacter = {}

testCharacter.newCharacter = function()
	local newCharacter = {}

	newCharacter.body = p.newBody(world, g.getWidth() / 2, g.getHeight() / 2, "dynamic")
	newCharacter.shape = p.newRectangleShape(20, 20)
	newCharacter.fixture = p.newFixture(newCharacter.body, newCharacter.shape)
	newCharacter.color = {1, 0, 0, 1}
	newCharacter.draw = function(self)
		g.setColor(self.color)
		g.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	end
	newCharacter.body:setFixedRotation(true)

	newCharacter.body:setLinearDamping(2)

	newCharacter.applyForce = function(self, dx, dy) 
		self.body:applyForce(dx, dy)
	end


	return newCharacter
end


return testCharacter