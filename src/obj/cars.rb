class CarManager
  def initialize(window, max)
    @window = window
    @arrayOfCars = Array.new()

    num = Random.rand(1..4)

    puts "# of cars: " + num.to_s()

    num.times do
      temp = Car.new(Random.rand(50..450), Random.rand(50..450), GenerateCar())
      @arrayOfCars.push(temp)
    end
  end

  def GetCar(num)
      return @arrayOfCars[num]
  end

  def GetArraySize()
    return @arrayOfCars.size()
  end

  def GenerateCar()
    newNum = Random.rand(55)

    if newNum > 5 && newNum < 10 || newNum > 15 && newNum < 20 || newNum > 25 && newNum < 30 || newNum > 35 && newNum < 40 || newNum > 45 && newNum < 50
      newNum -= 4
    end

    return newNum
  end
end

class Car
  # Car class
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

  def Move()
    # Move car and reset
    @x += @speed

    if @x > 530
      @x = -30
      @y = Random.rand(50..450)
    end
  end
end
