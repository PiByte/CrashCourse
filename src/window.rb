$Version = 0.01
$WindowHeight = 500
$WindowWidth = 500
$WindowTitle = "Crash Course"

puts "Crash Course - Version " + $Version.to_s()

class Window < Gosu::Window
  def initialize()
    # Window
    super $WindowWidth, $WindowHeight
    self.caption = $WindowTitle

    # Enable retrofication
    Gosu::enable_undocumented_retrofication()

    @manager = Statemanager.new()

    @menu = MenuState.new(self)
    @game = GameState.new(self)
    @hospital = HospitalState.new(self)
    @shop = ShopState.new(self)
    @gameover = GameoverState.new(self)
    @dialog = DialogState.new(self)

    @manager.AddState(@gameover)
    @manager.AddState(@shop)
    @manager.AddState(@hospital)
    @manager.AddState(@game)
    @manager.AddState(@dialog)
    @manager.AddState(@menu)

    # Byt ut den här så att man kan byta språk via settingsfilen (och lägg till en settings state)
  #  @dialog = 0

  #  f = File.open("./res/lang/EN", "r")
  #  @dialog = f.read().split("*")
  #  f.close()

  end

  def update()
    if @manager.FirstFrame(0)
      puts "Running Setup"
      @manager.GetState().Setup()
      @manager.FirstFrame(1)
    end

    @manager.GetState().Update()
  end

  def draw()
    @manager.GetState().Draw()
  end

  def button_down(id)
    @manager.GetState().ButtonDown(id)
  end

  def GetManager()
    return @manager
  end

  #def GetDialog(num)
  #  puts @dialog
  #  return @dialog
  #end

  def Touching(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2+w2 &&
           x2 < x1+w1 &&
           y1 < y2+h2 &&
           y2 < y1+h1
  end
end
