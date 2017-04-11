class HospitalState
  def initialize(window)
    @window = window

    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)
    @mouse = Gosu::Image.new("res/mouse.png")

    @crash = Gosu::Song.new("res/crash.wav")

  end

  def Setup()
    # Load flags from @window

    puts @window.GetGameFlags(0)
    @crash.play(false)
  end

  def Update()

  end

  def Draw()
    Gosu::draw_quad(0, 0, 0xff_ffffff, 500, 0, 0xff_ffffff, 500, 500, 0xff_ffffff, 0, 500, 0xff_ffffff, 0)

    @nano.draw("You just crashed at 200 KMH!", 10, 0, 0, 1, 1, 0xff_000000)
    @nano.draw("Did you honestly expect to survive that?", 10, 36, 0, 1, 1, 0xff_000000)
    @nano.draw("(ENTER)", 10, 36*3, 0, 1, 1, 0xff_000000)
  end

  def ButtonDown(id)
    if id == 40
      @window.GetManager().ChangeState(2)
    end
  end
end
