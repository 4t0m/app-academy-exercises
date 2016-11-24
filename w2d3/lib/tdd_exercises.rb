def my_uniq(array)
  return array if array.empty?
  uniqs = []
  array.each { |el| uniqs << el unless uniqs.include?(el) }

  uniqs
end


class Array

  def two_sum
    return self if self.empty?
    index_pairs = []
    self.each_with_index do |el1,idx1|
      self[(idx1 + 1)..-1].each_with_index do |el2,idx2|
        idx2 += idx1 + 1
        index_pairs << [idx1,idx2] if el1 +  el2 == 0
      end
    end

    index_pairs
  end

end


def my_transpose(array)
  return array if array.length <= 1
  transposed = []
  array.each_with_index do |row, row_index|
    row.each_with_index do |el, col_index|
      row_index == 0 ? transposed << [el] : transposed[col_index] << el
    end
  end

  transposed
end



def stock_picker(arr)
  return nil if arr.size < 2
  biggest_profit = 0
  indices = []
  arr.each_with_index do |price1, index1|
    arr[(index1 + 1)..-1].each_with_index do |price2, index2|
      index2 += index1 + 1
      profit = price2 - price1
      if profit > biggest_profit
        indices = [index1, index2]
        biggest_profit = profit
      end
    end
  end
  biggest_profit.zero? ? nil : indices
end


class TowersOfHanoi
  attr_reader :board

  def initialize
    @board = [[3,2,1], [], []]
  end

  def move_piece(move)
    @board[move.last] << @board[move.first].pop
  end

  def valid_move?(move)
    return false if @board[move.first].empty?
    target_disc = @board[move.first].last
    destination_disc = @board[move.last].last
    return false if destination_disc && target_disc > destination_disc

    true
  end

  def won?
    return true if @board[1..-1].any? { |peg| peg.size == 3 }
    false
  end

end
