# Gosu!
require "gosu"

# This is where the endless list of other files are located
require_relative "src/window.rb"
require "./src/statemanager.rb"

# States
require "./src/states/menu.rb"
require "./src/states/game.rb"
require "./src/states/hospital.rb"
require "./src/states/shop.rb"
require "./src/states/gameover.rb"
require "./src/states/dialog.rb"
require "./src/states/pause.rb"
require "./src/states/settings.rb"

# Other
require "./src/obj/cars.rb"
require "./src/obj/player.rb"

# Starts game
Window.new.show()
