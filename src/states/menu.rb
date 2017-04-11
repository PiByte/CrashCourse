class MenuState
  def initialize(window)
    @window = window

    @vcr = Gosu::Font.new(@window, "res/vcr.ttf", 48)
    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)

    @mouse = Gosu::Image.new("res/mouse.png")
    @car = Gosu::Image.load_tiles("res/cars.png", 24, 16)

    @music = Gosu::Song.new("res/The Endless.wav")

    @carPos = 0
    @toolTip = true

    @carID = 0

  #  @titleStr = @window.GetDialog(0)
  #  @startStr = @window.GetDialog(1)
  #  @exitStr = @window.GetDialog(2)

  end

  def Setup()
    @music.play(true)
  end

  def Update()
    # LOL, nuttin' here!
  end

  def Draw()

    # Draws white background using quad! (Hrmpf)
    Gosu::draw_quad(0, 0, 0xffffffff, 500, 0, 0xffffffff, 500, 500, 0xffffffff, 0, 500, 0xffffffff, 0)

    # Draws menu
    @vcr.draw("Crash Course", 10, 10, 0, 1, 1, 0xff_000000)
    @nano.draw("Start Game", 60, 100, 0, 1, 1, 0xff_000000)
    @nano.draw("qUiT", 60, 150, 0, 1, 1, 0xff_000000) # LOL, the Nanotype font doens't support lowercase characters, so I can type whatever I want!
    @nano.draw("Copyright (c) Jacob Johansson 2017", 90, 500-36, 0, 1, 1, 0xff_000000)

    # Tooltip
    if @toolTip == true
      @nano.draw("(Arrow keys)", 10, 200, 0, 1, 1, 0xff_000000)
    end

    # Render car
    @car[@carID].draw(5, 105 + (50 * @carPos), 0, 2, 2)

    # Render cursor
    #@mouse.draw(@window.mouse_x, @window.mouse_y, 0, 2, 2)

  end

  def ButtonDown(id)

    # Moves car
    if id == 81 && @carPos == 0
      @carPos = 1
      GenerateCar()
    elsif id == 82 && @carPos == 1
      @carPos = 0
      GenerateCar()
    end
    if id == 82 or id == 81
      @toolTip = false
    end
    if id == 40
      if @carPos == 0
        @window.GetManager().ChangeState(2) # Bytar till spel istället för dialogen, ÄNDRA!
      elsif @carPos == 1
        @window.close! # Exiting game!
      end
    end
  end

  def ButtonUp(id)

  end

  def GenerateCar()
    newNum = Random.rand(55)

    if newNum > 5 && newNum < 10 || newNum > 15 && newNum < 20 || newNum > 25 && newNum < 30 || newNum > 35 && newNum < 40 || newNum > 45 && newNum < 50
      newNum -= 4
    end

    @carID = newNum
  end
end
