class GameoverState
  def initialize(window)
    @window = window

    @vcr = Gosu::Font.new(@window, "res/vcr.ttf", 48)
    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)
  end

  def Setup()

  end

  def Update()

  end

  def Draw()
    Gosu::draw_quad(0, 0, 0xff_000000, 500, 0, 0xff_000000, 500, 500, 0xff_000000, 0, 500, 0xff_000000, 0)

    @vcr.draw("Game Over!", 10, 10, 0, 1, 1, 0xff_ffffff)
    @nano.draw("(enter)", 10, 36*2, 0, 1, 1, 0xff_ffffff)
  end

  def ButtonDown(id)
    if id == 40
      @window.GetManager().ChangeState(1)
    end
  end
end
