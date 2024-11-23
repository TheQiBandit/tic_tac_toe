require 'io/console'

class Board

  attr_accessor :mutable_grid

  def initialize
    @main_array = [
     [1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]
   ]
    @mutable_grid = @main_array.map do |inner_array|
      inner_array.map do |position|
        position = " "
      end
    end
  end

  def display_board
    puts "-------------            Choose a number!"
    puts "| #{mutable_grid[0][0]}  #{mutable_grid[0][1]}  #{mutable_grid[0][2]} |---------------| 1 | 2 | 3 |"
    puts "| #{mutable_grid[1][0]}  #{mutable_grid[1][1]}  #{mutable_grid[1][2]} |---------------| 4 | 5 | 6 |"
    puts "| #{mutable_grid[2][0]}  #{mutable_grid[2][1]}  #{mutable_grid[2][2]} |---------------| 7 | 8 | 9 |"
    puts "-------------"

  end

end


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
      choose_weapon
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


class CLInValidator
  attr_accessor :board, :gamers, :turns
  
  def initialize
    @board = Board.new
    @gamers = Player.new
    @turns = 0
  end

  def empty_position?(position, board)
    board.flatten[position - 1] == " "
  end

  def update_board(position, x_o)

    puts "Player #{x_o}'s turn"
    if empty_position?(position, board.mutable_grid) && position.between?(1, 9)
      @turns += 1
      case position
      when 1..3
        board.mutable_grid[0][position - 1] = x_o
        board.display_board
      when 4..6
        board.mutable_grid[1][position - 4] = x_o
        board.display_board
      when 7..9
        board.mutable_grid[2][position - 7] = x_o 
        board.display_board
      end
    elsif !empty_position?(position, board.mutable_grid) && position.between?(1, 9)
      puts "Please choose an empty position to play!"
    end

  end

  def play_game

    gamers.choose_weapon

    until end_game?(board.mutable_grid)
      if turns.even?
        update_board(gamers.choose_position, gamers.players[0])
      elsif turns.odd?
        update_board(gamers.choose_position, gamers.players[1])
      end
    end
   who_won?(board.mutable_grid)

  end


  def tie?(board)
     
    board.flatten.all? { |position| position == "X" || position == "O"}

  end

  def row_win?(board)
    board.each { |row| return row.first if row.uniq.size == 1 && !row.first.include?(" ") }  
    false
  end

  def col_win?(board)
    row_win?(board.transpose)
  end

  def diagonal_win?(board)
    row_win? ([[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]]])
  end

  def end_game?(board)
    row_win?(board) || col_win?(board) || diagonal_win?(board) || tie?(board)
  end

  def who_won?(board)
    if (row_win?(board) || col_win?(board) || diagonal_win?(board)) == "X"
      puts "Player X wins!"
    elsif (row_win?(board) || col_win?(board) || diagonal_win?(board)) == "O"
      puts "Player O wins!"
    else
      puts "It's a tie!"
    end
  end
end

game1 = CLInValidator.new
game1.play_game