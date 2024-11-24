# Class for displaying a 3x3 grid of empty spaces.
class Board
  attr_accessor :mutable_grid

  def initialize
    @main_array = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
    @mutable_grid = @main_array.map do |inner_array|
      inner_array.map do |_position|
        " "
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

  def help_display
    help_arr = @main_array.map { |a| a.map { |i| i.to_s.rjust(3) }.join }
    puts help_arr
  end
  
end
