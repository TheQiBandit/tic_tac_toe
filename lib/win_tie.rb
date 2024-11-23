# Check win/loss/tie conditions.
module WinTie
  
  # Checks if board is full i.e a tie.
  def tie?(board)
    board.flatten.all? { |position| %w[X O].include?(position) }
  end
  # Checks for horizontal win.
  def row_win?(board)
    board.each { |row| return row.first if row.uniq.size == 1 && !row.first.include?(" ") }
    false
  end

  #Checks for vertical win.
  def col_win?(board)
    row_win?(board.transpose)
  end
  
  # Checks for diagonal wins.
  def diagonal_win?(board)
    row_win?([[board[0][0], board[1][1], board[2][2]], [board[0][2], board[1][1], board[2][0]]])
  end

end