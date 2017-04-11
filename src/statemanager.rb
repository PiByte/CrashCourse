# Statemanager
class Statemanager

  def initialize()
    @states = Array.new()
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
    cycles.times do
      temp = @states.last()
      @states.pop()
      @states.unshift(temp)
    end
  end
end
