class DialogState
  def initialize(window)
    @window = window
  end

  def Setup()

  end

  def Update()
    # Load data
  end

  def Draw()
    Gosu::draw_quad(0, 0, 0xff_000000, 500, 0, 0xff_ffffff, 500, 500, 0xff_ffffff, 0, 500, 0xff_ffffff, 0)
  end

  def ButtonDown(id)

  end
end
