require "io/console"

# Player class which allows you to choose which player is first and,
# allows to choose your icon, and to choose a position to play.
class Player
  attr_accessor :players

  # initialize any empty array to push your choices into and icons respectively.
  def initialize
    @players = []
  end

  # Method to choose the icon (x or o).
  def choose_weapon
    puts "First player, please choose X or O!!"

    choice = $stdin.noecho(&:gets).chomp.upcase

    if choice != "X" && choice != "O"
      puts "Unacceptable, only X's or O's please!"
      choose_weapon
    elsif choice == "X"
      players.push("X", "O")
    else
      players.push("O", "X")
    end

    puts "Player 1 is #{players[0]} & player 2 is #{players[1]}"
    puts "Please choose a number to play!"
    
  end

  # method to choose a position between 1-9.
  def choose_position
    chosen_position = $stdin.noecho(&:gets).chomp.to_i

    if chosen_position.between?(1, 9)
      chosen_position
    else
      puts "Please only choose a number from 1 - 9!"
      choose_position
    end
  end
end
