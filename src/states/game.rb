class Car
  # Car class!
  def initialize(x, y, id)
    @x = x;
    @y = y;
    @id = id;
    @speed = Random.rand(4..8)
  end

  def GetID()
    return @id
  end

  def X()
    return @x
  end

  def Y()
    return @y
  end

  def Move(num)
    @x += num
  end

  def Reset()
    @x = -30
    @y = Random.rand(50..450)
  end

  def GetSpeed()
    return @speed
  end

end

class GameState
  def initialize(window)
    @window = window

    @cars = Gosu::Image.load_tiles("res/cars.png", 24, 16)
    @nano = Gosu::Font.new(@window, "res/NANOTYPE.ttf", 36)

    @playerSpeed = 0

    # Car properties
    @playerCarID = 24
    @playerTopSpeed = 20
    @playerAccRate = 0.5
    @playerDecRate = 1
    @playerTurnSpeed = 0.1

    @playerX = 20
    @playerY = 20

    @playerRot = -67

    @isItKnown = false

    @interstate = Random.rand(1190)

    @arrayOfCars
    @otherCarsSpeed = 5

  end

  def Setup()
    # Generate random cars
    RandomCars()
  end

  def RandomCars()
    @arrayOfCars = Array.new()

    num = Random.rand(1..4)

    puts "# of cars: " + num.to_s()

    num.times do
      temp = Car.new(Random.rand(50..450), Random.rand(50..450), GenerateCar())
      @arrayOfCars.push(temp)
    end
  end

  def GenerateCar()
    newNum = Random.rand(55)

    if newNum > 5 && newNum < 10 || newNum > 15 && newNum < 20 || newNum > 25 && newNum < 30 || newNum > 35 && newNum < 40 || newNum > 45 && newNum < 50
      newNum -= 4
    end

    return newNum
  end

  def MoveCars()

    @arrayOfCars.size.times do |n|
      @arrayOfCars[n].Move(@arrayOfCars[n].GetSpeed())

      if @arrayOfCars[n].X > 530
        @arrayOfCars[n].Reset()
      end
    end

  end

  def Update()

    if @window.button_down?(82) == true && @playerSpeed < @playerTopSpeed
      if @playerSpeed < 0
        @playerSpeed += @playerDecRate
      else
        @playerSpeed += @playerAccRate
      end
    end

    if @window.button_down?(81) == true && @playerSpeed >- @playerTopSpeed
      if @playerSpeed < 0
        @playerSpeed -= @playerDecRate
      else
        @playerSpeed -= @playerAccRate
      end
    end

    if @window.button_down?(81) == false && @window.button_down?(82) == false
      if @playerSpeed - @playerDecRate > 0
        @playerSpeed -= @playerDecRate
      elsif @playerSpeed + @playerDecRate < 0
        @playerSpeed += @playerDecRate
      else
        @playerSpeed = 0
      end
    end

    if @window.button_down?(79) == true && @playerSpeed != 0
      @playerRot += @playerTurnSpeed * @playerSpeed/@playerTopSpeed
    end

    if @window.button_down?(80) == true && @playerSpeed != 0
      @playerRot -= @playerTurnSpeed * @playerSpeed/@playerTopSpeed
    end

    @playerX += Math.sin(@playerRot) * @playerSpeed
    @playerY -= Math.cos(@playerRot) * @playerSpeed

    # Check for collision with each car

    @arrayOfCars.size.times do |n|

      if @window.Touching(@arrayOfCars[n].X+24, @arrayOfCars[n].Y+16, 24, 16, @playerX, @playerY, 24, 16) == true

        puts "Car crash at " + (@playerSpeed*10).to_s() + " KMH"

        @playerX = 20
        @playerY = 20

        @window.SetGameFlags(@playerSpeed, @playerRot, @isItKnown, false, @window.GetGameFlags(4), @window.GetGameFlags(5), @window.GetGameFlags(6))

        # Reset
        @playerRot = -67.5
        @playerSpeed = 0

        @window.GetManager().ChangeState(2)
      end
    end


    if @playerX > 530
      # New page
      RandomCars()

      @playerX = -30
    end

    if @playerX < -30
      # New page
      RandomCars()

      @isItKnown = true
      @playerX = 530
    end


    if @playerY > 530 || @playerY < -30
      puts "Railing crash at " + (@playerSpeed*10).to_s() + " KMH"

      @playerX = 20
      @playerY = 20

      #Speed, rot, you fault, railing, armor level, health, car
      @window.SetGameFlags(@playerSpeed, @playerRot, @isItKnown, true, @window.GetGameFlags(4), @window.GetGameFlags(5), @window.GetGameFlags(6))

      # Reset
      @playerRot = -67.5
      @playerSpeed = 0

      @window.GetManager().ChangeState(2)
    end

    MoveCars()
  end

  def Draw()
    Gosu::draw_quad(0, 0, 0xff_ffffff, 500, 0, 0xff_ffffff, 500, 500, 0xff_ffffff, 0, 500, 0xff_ffffff, 0)

    # Draw each car
    @arrayOfCars.size.times do |n|
      @cars[@arrayOfCars[n].GetID()].draw(@arrayOfCars[n].X, @arrayOfCars[n].Y, 0, 2, 2)
    end

    #Draw player
    @cars[@playerCarID].draw_rot(@playerX, @playerY, 0, @playerRot*180/3.141593-90, 0.5, 0.5, 2, 2)

    @nano.draw("Speed: " + (@playerSpeed*10).to_s() + " KMH", 10, 0, 0, 1, 1, 0xff_000000)
    @nano.draw("Interstate " + @interstate.to_s(), 10, 500-43, 0, 1, 1, 0xff_000000)

  end

  def ButtonDown(id)
    # Escape key
    if id == 41
      @window.GetManager().ChangeState(1)
    end

    if id == 21
      @playerX = 20
      @playerY = 20
    end
  end
end
