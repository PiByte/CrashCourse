
class GameState
  def initialize(window)
    @window = window

    @cars = Gosu::Image.load_tiles("res/cars.png", 24, 16)
    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)

    @playerSpeed = 0

    @playerTopSpeed = 15

    @playerX = 50
    @playerY = 50

    @playerSlowingDown = false

  end

  def Setup()

  end

  def Update()

    if @window.button_down?(82) == true
      @playerX += @playerSpeed

      if (@playerSpeed < @playerTopSpeed)
        @playerSpeed += 0.5
      end

    end

    if @window.button_down?(81) == true
      @playerX -= @playerSpeed

      if (@playerSpeed < @playerTopSpeed)
        @playerSpeed += 0.5
      end

    end


    if @playerSlowingDown == true
      @playerX += @playerSpeed

      if (@playerSpeed > 0)
        @playerSpeed -= 0.5
      else
        @playerSlowingDown = false
      end

    end

    if @playerX > 525
      @playerX = -25
    end


  end

  def Draw()
    Gosu::draw_quad(0, 0, 0xff_ffffff, 500, 0, 0xff_ffffff, 500, 500, 0xff_ffffff, 0, 500, 0xff_ffffff, 0)

    @nano.draw("Speed: " + @playerSpeed.to_s(), 10, 5, 0, 1, 1, 0xff_000000)

    @cars[1].draw(@playerX, @playerY, 0, 2, 2)


  end

  def ButtonDown(id)



    # Escape key
    if id == 41
      @window.GetManager().ChangeState(4) # Byt om du måste!
    end
  end

  def ButtonUp(id)
    if id == 82
      @playerSlowingDown = true
    end
  end
end
