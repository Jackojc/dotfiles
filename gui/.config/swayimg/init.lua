# try to replicate nsxiv bindings

swayimg.viewer.set_window_background(0xff0e0f1a)
swayimg.viewer.mark_color = 0xffe69f00

swayimg.gallery.window_color = 0xff0e0f1a
swayimg.gallery.unselected_color = 0xff0e0f1a
swayimg.gallery.selected_color = 0xff292a34
swayimg.gallery.border_color = 0xff56b4e9
swayimg.gallery.mark_color = 0xffe69f00

local viewer = swayimg.viewer
local gallery = swayimg.gallery

for _, mode in ipairs({ viewer, gallery }) do
	mode.on_key("m", function() mode.mark_image() end)
	mode.on_key("q", function() swayimg.exit() end)
end

gallery.on_key("h", function() gallery.select("left") end)
gallery.on_key("j", function() gallery.select("down") end)
gallery.on_key("k", function() gallery.select("up") end)
gallery.on_key("l", function() gallery.select("right") end)

gallery.on_key("g", function() gallery.select("first") end)
gallery.on_key("Shift+g", function() gallery.select("last") end)

viewer.on_key("g", function() viewer.open("first") end)
viewer.on_key("Shift+g", function() viewer.open("last") end)

viewer.on_key("n", function() viewer.open("next") end)
viewer.on_key("space", function() viewer.open("next") end)

viewer.on_key("p", function() viewer.open("prev") end)
viewer.on_key("backspace", function() viewer.open("prev") end)

viewer.on_key("Shift+less", function() viewer.rotate(270) end)
viewer.on_key("Shift+greater", function() viewer.rotate(90) end)
viewer.on_key("Shift+question", function() viewer.rotate(180) end)
viewer.on_key("Shift+bar", function() viewer.flip_horizontal() end)
viewer.on_key("Shift+underscore", function() viewer.flip_vertical() end)

viewer.on_key("Shift+plus", function() viewer.scale = viewer.scale + viewer.scale / 10 end)
viewer.on_key("equal", function() viewer.set_fix_scale("real") end)
viewer.on_key("w", function() viewer.set_fix_scale("optimal") end)
viewer.on_key("Shift+w", function() viewer.set_fix_scale("fit") end)
viewer.on_key("Shift+f", function() viewer.set_fix_scale("fill") end)
viewer.on_key("e", function() viewer.set_fix_scale("width") end)
viewer.on_key("Shift+e", function() viewer.set_fix_scale("height") end)
