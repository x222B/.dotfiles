local gears            = require("gears")
local theme = { }
local string = string
theme.name = "gruvgruv"
--theme.dir = string.format("%s/.config/awesome/themes/%s", os.getenv("HOME"), theme.name)
theme.dir = string.format("/home/dino/.config/awesome/themes/gruvgruv")

theme.wallpaper                                 = "/home/dino/.config/awesome/themes/gruvgruv/wallpapers/randall-mackey-mural2.jpg"
gears.wallpaper.tiled(theme.wallpaper,s)

return theme
