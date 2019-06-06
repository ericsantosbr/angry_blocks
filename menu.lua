g = love.graphics
e = love.event

local menu = {}

menu.newMenu = function(x, y, width, height, keys, status)
	local newMenu = {}
	newMenu.x = x
	newMenu.y = y
	newMenu.width = width
	newMenu.height = height
	newMenu.keys = keys
	newMenu.sinceLastChange = 0
	-- newMenu.status = status

	newMenu.draw = function(self)
		g.setColor({0, 0, 0, .5})
		g.rectangle("fill", self.x, self.y, self.width, self.height)

	end

	newMenu.update = function(self, dt, keys)
		status = "debug"

		if keys.escape then
			status = "running"

			return status
		end

		if keys.q then e.quit() end

		return status
	end

	return newMenu
end



return menu