require_relative 'board'
require_relative 'players'
require_relative 'win_tie'
# Command line interface class for
class CLI
  include WinTie
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

game1 = CLI.new
game1.play_game
