# Game back-end logic

require 'io/console'

class TicLogic
  GRID = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
      
      attr_accessor :mutable_grid

     def initialize
      @mutable_grid = GRID             
     end 

     def player_turn

       puts "Choose a NUMBER to play as X!!"

       get_number = STDIN.noecho { |i| i.gets}.chomp.to_i
       play_turn = GRID.flatten.index(get_number)

       play_turn

     end

     def grid_change(grid_position)

      if mutable_grid.flatten.at(grid_position) == "X" || mutable_grid.flatten.at(grid_position) == "O"
        player_turn

      else

        case grid_position
        when 0..2
          mutable_grid[0][grid_position] = "X"
        when 3..5
          mutable_grid[1][grid_position - 3] = "X"
        when 6..8
          mutable_grid[2][grid_position - 6] = "X"
        else
          puts "Please enter a valid choice!"
        end
        
      end

      display_board(mutable_grid)

     end

     def display_board(mutable_grid = GRID)
       
      grid_string = mutable_grid.map do |array|
        array.map { |elem| elem }.join(" ")
      end
      
      puts grid_string

     end

     def modified_grid
       display_board(mutable_grid)
     end
          
end

first_game = TicLogic.new
first_game.grid_change(first_game.player_turn)
