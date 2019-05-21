camera = {}

g = love.graphics

camera.newCamera = function(x, y, sx, sy, r)
	newCamera = {}
	newCamera.x = x or g.getWidth() / 2
	newCamera.y = y or g.getHeight() / 2
	newCamera.scaleX = sx or 1
	newCamera.scaleY = sy or 1
	newCamera.angle = r or 0

	newCamera.set = function(self)
		g.push()
		g.rotate(self.angle)
		g.translate(-self.x, -self.y)
		g.scale(self.scaleX, self.scaleY)
	end

	newCamera.unset = function(self)
		g.pop()
	end

	newCamera.move = function(self, dx, dy)
		self.x = self.x + dx
		self.y = self.y + dy
	end

	newCamera.setPosition = function(self, x, y)
		self.x = x or self.x
		self.y = y or self.y
	end

	newCamera.rotate = function(self, r)
		self.angle = self.angle + r
	end

	newCamera.scale = function(self, sx, sy)
		self.scaleX = self.scaleX * sx
		self.scaleY = self.scaleY * sy
	end

	newCamera.setScale = function(self, sx, sy)
		self.scaleX = sx or self.scaleX
		self.scaleY = sy or self.scaleY
	end


	return newCamera

end



return camera