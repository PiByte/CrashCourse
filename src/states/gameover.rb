class GameoverState
  def initialize(window)
    @window = window

    @vcr = Gosu::Font.new(@window, "res/vcr.ttf", 48)
    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)

    @message = ""
  end

  def Setup()

    if @window.GetGameFlag(0) > 10
      @message = "You died!"
    elsif @window.GetGameFlag(7) < 0
      @message = "You're in debt!"
    else
      @message = "Game Over!"
    end

  end

  def Update()

  end

  def Draw()
    Gosu::draw_quad(0, 0, 0xff_000000, 500, 0, 0xff_000000, 500, 500, 0xff_000000, 0, 500, 0xff_000000, 0)

    @vcr.draw("You died!", 10, 10, 0, 1, 1, 0xff_ffffff)
    @nano.draw("(enter)", 10, 36*2, 0, 1, 1, 0xff_ffffff)
  end

  def ButtonDown(id)
    if id == 40
      @window.GetManager().ChangeState(1)
    end
  end
end
