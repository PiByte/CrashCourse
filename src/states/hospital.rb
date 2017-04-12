class HospitalState
  def initialize(window)
    @window = window

    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)
    @mouse = Gosu::Image.new("res/mouse.png")

    @crash = Gosu::Song.new("res/crash.wav")

    @message = ""
    @message2 = ""
    @message3 = ""

    @bill
    @insurance

    @message4 = ""


  end

  def Setup()
    # Load flags from @window
    @crash.play(false)

    # Parsing data from crash
    # speed, rot, fault, railing, armor, health, car, money, How Close to death
    
    if @window.GetGameCell(0) > 10
      @window.GetManager().ChangeState(2)
    end

    if @window.GetGameCell(3) == 1
      @message = "Railing crash at " + (@window.GetGameCell(0)*10).round().to_s() + " KMH, huh?"
    else
      @message = "Car crash at " + (@window.GetGameCell(0)*10).round().to_s() + " KMH, huh?"
    end

    if @window.GetGameCell(2) == 1
                  #----------------------------------------
      @message2 = "Your fault too? That'll result in a fine"
    else
      @message2 = "Atleast it wasn't your fault"
    end
    
    # 75> 50> 25> 0>

    if @window.GetGameCell(8) > 75
                  #----------------------------------------
      @message3 = "By the way, how are you still alive?"

    elsif @window.GetGameCell(8) > 50
                  #----------------------------------------
      @message3 = "You might have a couple broken bones"

    elsif @window.GetGameCell(8) > 25
                  #----------------------------------------
      @message3 = "You'll have a few marks, nothing special"

    elsif @window.GetGameCell(8) > 0

      @message3 = "You should be completely fine"
    end

    @bill = 0
    @insurance = 0

    GetBill()
    GetMoney()

    if @insurance == 0
      @message4 = "You don't have any insurance"
    else
      @message4 = "The insurance company paid you " + GetMoney().to_s() + " USD"
    end

  end

  def Update()

  end

  def Draw()


    Gosu::draw_quad(0, 0, 0xff_ffffff, 500, 0, 0xff_ffffff, 500, 500, 0xff_ffffff, 0, 500, 0xff_ffffff, 0)

    @nano.draw(@message, 10, 0, 0, 1, 1, 0xff_000000)
    @nano.draw(@message2, 10, 36, 0, 1, 1, 0xff_000000)

    @nano.draw(@message3, 10, 36*3, 0, 1, 1, 0xff_000000)

    @nano.draw("Your final bill totals " + @bill.to_s() + " USD", 10, 36*5, 0, 1, 1, 0xff_000000)
    @nano.draw(@message4, 10, 36*6, 0, 1, 1, 0xff_000000)

  end

  def ButtonDown(id)

    if id == 40
      @window.ResetGameFlags()

      @window.GetManager().ChangeState(5)
    end

  end

  def GetBill()
    @bill = @window.GetGameCell(8) * 100 + Random.rand(500..1000)

    if @window.GetGameCell(2) == 1
      @bill += 500
    end
  end

  def GetMoney()

    if @window.GetGameCell(5) == 0 && @window.GetGameCell(6) == 0
      @insurance = 0
    end

    if @window.GetGameCell(5) == 1 && @window.GetGameCell(6) == 1
      @insurance = @window.GetGameCell(8) * 100 + 1000 * 1.12
    else
      @insurance = ((@window.GetGameCell(8) * 100 + 1000 * 1.12)/2).round()
    end

  end
end
