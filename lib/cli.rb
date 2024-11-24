require_relative "board"
require_relative "players"
require_relative "win_tie"

# Command line interface class
class CLI
  include WinTie
  attr_accessor :board, :gamers, :turns

  # Initialize new board, new players, and set turns to 0.
  def initialize
    @board = Board.new
    @gamers = Player.new
    @turns = 0
  end

  # Checking if position is empty when chosen.
  def empty_position?(position, board)
    board.flatten[position - 1] == " "
  end

  # Updates the board with the chosen position and respective icon.
  def update_board(position, x_o)
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

  # Main loop to play the game and keep it going depending by incrementing the turns.
  def play_game
    gamers.choose_weapon
    board.help_display

    until end_game?(board.mutable_grid)
      if turns.even?
        puts "Player #{gamers.players[0]}'s turn now"
        update_board(gamers.choose_position, gamers.players[0])
      elsif turns.odd?
        puts "Player #{gamers.players[1]}'s turn now"
        update_board(gamers.choose_position, gamers.players[1])
      end
    end
    who_won?(board.mutable_grid)
  end

  # Mainly a check to terminate the game if a result is reached.
  def end_game?(board)
    row_win?(board) || col_win?(board) || diagonal_win?(board) || tie?(board)
  end

  # Declare the result of the game.
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