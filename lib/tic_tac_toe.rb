require 'io/console'

class Board

  attr_accessor :mutable_grid, :main_array

  def initialize
    @main_array = [
     [1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]
   ]
    @mutable_grid = main_array.map do |inner_array|
      inner_array.map do |position|
        position = " "
      end
    end
  end

  def display_board
    puts "-------------              Choose a number!"
    puts "| #{mutable_grid[0][0]}  #{mutable_grid[0][1]}  #{mutable_grid[0][2]} |---------------| 1 | 2 | 3 |"
    puts "| #{mutable_grid[1][0]}  #{mutable_grid[1][1]}  #{mutable_grid[1][2]} |---------------| 4 | 5 | 6 |"
    puts "| #{mutable_grid[2][0]}  #{mutable_grid[2][1]}  #{mutable_grid[2][2]} |---------------| 7 | 8 | 9 |"
    puts "-------------"

  end

  def update_board(position, x_o)
        
    case position
      when 1..3
        mutable_grid[0][position - 1] = x_o unless mutable_grid[0][position - 1] != " "
        display_board
      when 4..6
        mutable_grid[1][position - 4] = x_o unless mutable_grid[1][position - 4] != " "
        display_board
      when 7..9
        mutable_grid[2][position - 7] = x_o unless mutable_grid[2][position - 7] != " "
        display_board
      else
        puts "Please enter a valid choice!"
    end

  end

end

# first_game = Board.new
# first_game.display_board
# first_game.update_board(1, "X")



class Player
  attr_accessor :players
  
  def initialize
    @players = []
  end

  def choose_weapon
    puts "First player, please choose X or O!!"

    choice = STDIN.noecho { |i| i.gets }.chomp.upcase

    if choice != "X" && choice != "O"
      puts "Unacceptable, only X's or O's please!"
    elsif choice == "X"
      players.push("X", "O")
    else
      players.push("O", "X")
    end

    puts "Player 1 is #{players[0]} & player 2 is #{players[1]}"

  end

  def choose_position

    chosen_position = STDIN.noecho { |i| i.gets }.chomp.to_i

    if chosen_position.between?(1, 9)
      chosen_position
    else
      puts "Please only choose a number from 1 - 9!"
      choose_position
    end

  end

end

# test_play = Player.new
# test_play.choose_weapon
# test_play.distribute_players
# puts test_play.choose_position

class CLInValidator
  attr_accessor :board, :gamers
  
  def initialize
    @board = Board.new
    @gamers = Player.new
  end

  def play_game

    gamers.choose_weapon
    i = 1

    while !end_game?(board.mutable_grid)
      if i.odd?
        i += 1
        board.update_board(gamers.choose_position, gamers.players[0])
        puts "Player's #{gamers.players[1]}'s turn now"
      elsif i.even?
        i += 1
        board.update_board(gamers.choose_position, gamers.players[1])
        puts "Player's #{gamers.players[0]}'s turn now"
      end
    end
   puts end_game?(board.mutable_grid)

  end


  def game_tie?(board)
     
    board.flatten.all? { |position| position == "X" || position == "O"}

  end

  def row_win?(board)
    board.each do |row|
      return row.first if row.include?(" ") == false && row.uniq.size == 1
    end
    false
  end

  def col_win?(board)
    row_win?(board.transpose)
  end

  def diagonal_win?(board)
    row_win? ([[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]]])
  end

  def end_game?(board)
    if row_win?(board) || col_win?(board) || diagonal_win?(board) || game_tie?(board)
    else
      false
    end
  end
end

game1 = CLInValidator.new
game1.play_game