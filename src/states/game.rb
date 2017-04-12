class GameState
  def initialize(window)
    @window = window

    @cars = Gosu::Image.load_tiles("res/cars.png", 24, 16)
    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)

    @interstate = Random.rand(1190)

  end

  def Setup()

    # Creates player
    @player = Player.new(@window, 40, 8, 0.05, 0.1, 0.1)

    # Generate random cars
    @carManager = CarManager.new(@window, 4)
  end


  def Update()
    # Check for collision with each car

    #Update player
    @player.Update()

    @carManager.GetArraySize.times do |n|

      if @window.Touching(@carManager.GetCar(n).X()+24, @carManager.GetCar(n).Y()+16, 24, 16, @player.X(), @player.Y(), 24, 16) == true
        puts "Car crash at " + (@player.GetSpeed*10).round().to_s() + " KMH"

        @window.SetGameFlag(8, (@player.GetSpeed*10).round())
        
        Crash()
      end

    end



    if @player.X > 530
      # New page
      @carManager = CarManager.new(@window, 4)

      @player.Reset(-30, @player.Y, @player.GetRot, @player.GetSpeed)
    end

    if @player.X < -30
      # New page
      @carManager = CarManager.new(@window, 4)

      @player.SetYourFault(1)
      @player.Reset(530, @player.Y, @player.GetRot, @player.GetSpeed)
    end


    if @player.Y > 530 || @player.Y < -30
      puts "Railing crash at " + (@player.GetSpeed*10).round().to_s() + " KMH"


      @window.SetGameFlag(8, (@player.GetSpeed*10).round())

      @window.SetGameFlag(3, 1)

      Crash()

    end

    # Move cars
    @carManager.GetArraySize.times do |n|
      @carManager.GetCar(n).Move()
    end

  end

  def Draw()
    # Plain background
    Gosu::draw_quad(0, 0, 0xff_ffffff, 500, 0, 0xff_ffffff, 500, 500, 0xff_ffffff, 0, 500, 0xff_ffffff, 0)

    # Draw each car
    @carManager.GetArraySize.times do |n|
      @cars[@carManager.GetCar(n).GetID()].draw(@carManager.GetCar(n).X, @carManager.GetCar(n).Y, 0, 2, 2)
    end

    #Draw player
    @cars[@player.GetID()].draw_rot(@player.X, @player.Y, 0, @player.GetRot*180/3.141593-90, 0.5, 0.5, 2, 2)

    @nano.draw("Speed: " + (@player.GetSpeed*10).round().to_s() + " KMH", 10, 0, 0, 1, 1, 0xff_000000)
    @nano.draw("Interstate " + @interstate.to_s(), 10, 500-43, 0, 1, 1, 0xff_000000)

  end

  def Crash()
    
    # Change gameflags
    @window.SetGameFlag(0, @player.GetSpeed)
    @window.SetGameFlag(1, @player.GetRot)
    @window.SetGameFlag(2, @player.YourFault())

    # Reset
    @player.Reset(20, 20, -67.5, 0)

    # Change state
    @window.GetManager().ChangeState(2)
  end

  def ButtonDown(id)
    # Escape key
    if id == 41
      @window.GetManager().ChangeState(1)
    end

    # Reset car
    if id == 21
      @player.Reset(20, 20, -67.5, 0)
    end
  end
end
