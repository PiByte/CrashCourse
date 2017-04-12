class Player
  def initialize(window, id, topSpeed, acc, dec, turn)

    @window = window

    @playerSpeed = 0

    # Car properties
    @playerCarID = id
    @playerTopSpeed = topSpeed
    @playerAccRate = acc
    @playerDecRate = dec
    @playerTurnSpeed = turn

    @playerX = 20
    @playerY = 20

    @playerRot = -67

    @yourFault = 0

  end

  def Update()
    # Updating car

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

  end

  def GetID()
    return @playerCarID
  end

  def X()
    return @playerX
  end

  def Y()
    return @playerY
  end

  def GetSpeed()
    return @playerSpeed
  end

  def GetRot()
    return @playerRot
  end

  def Reset(x, y, rot, speed)
    @playerX = x
    @playerY = y
    @playerRot = rot
    @playerSpeed = speed
  end

  def YourFault()
    return @yourFault
  end

  def SetYourFault(value)
    @yourFault = value
  end

end
