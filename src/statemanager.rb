# Statemanager
class Statemanager

  def initialize()
    @states = Array.new()
    @firstFrame = true
  end
  # Adds state to end of array
  def AddState(state)
    @states.push(state)
  end
  # Returns last state
  def GetState()
    return @states.last()
  end
  # Change state
  def ChangeState(cycles)
    puts "Changing state (" + cycles.to_s() + " cycles)"
    @firstFrame = true
    cycles.times do
      temp = @states.last()
      @states.pop()
      @states.unshift(temp)
    end
  end
  def FirstFrame(option)
    if option == 1
       @firstFrame = false
    else
      return @firstFrame
    end
  end
end
