require 'io/console'

class Board
  GRID = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
  ]
      
  attr_accessor :mutable_grid

  def initialize
    @mutable_grid = GRID.map do |inner_array|
            inner_array.map do |position|
              position = " "
            end
    end             
  end 

  def help_board
    display_options = GRID.map do |arr|
      arr.map { |element| element }.join(" ")
    end

    puts "Choose any empty spot/number to play your turn at."
    puts "-----"
    puts display_options
    puts "-----"

  end

  def display_board
    puts "-------------"
    puts "| #{mutable_grid[0][0]} : #{mutable_grid[0][1]} : #{mutable_grid[0][2]} |"
    puts "............."
    puts "| #{mutable_grid[1][0]} : #{mutable_grid[1][1]} : #{mutable_grid[1][2]} |"
    puts "............."
    puts "| #{mutable_grid[2][0]} : #{mutable_grid[2][1]} : #{mutable_grid[2][2]} |"
    puts "-------------"

  end

  def update_board
    
  end

end

# first_game = Board.new
# first_game.display_board


class Player
  attr_accessor :players, :turns_played
  attr_reader :board
  
  def initialize
    @players = []
    @turns_played = 0
  end

  def choose_weapon
    puts "Choose X or O!!"

    choice = STDIN.noecho { |i| i.gets }.chomp.upcase

    if choice != "X" && choice != "O"
      puts "Unacceptable, only X's or O's please!"
    else
      players.push(choice)
    end

  end

  def distribute_players
     
    if players[0] == "X"
      players.push("O")
    else
      players.push("X") unless players[0] == nil
    end
    
    players
  end

  def choose_position
    
    @board.help_board
    chosen_position = STDIN.noecho { |i| i.gets }.chomp.to_i

    if chosen_position.between?(1, 9)
      chosen_position
    else
      puts "Please only choose a number from 1 - 9!"
      choose_position
    end

  end

end

test_play = Player.new
test_play.choose_weapon
test_play.distribute_players
puts test_play.choose_position
