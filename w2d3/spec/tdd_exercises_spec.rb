require "tdd_exercises"

describe "#my_uniq" do

  it "returns an empty array when array is empty" do
    expect(my_uniq([])).to eq([])
  end

  it "returns the array when there are no duplicates" do
    expect(my_uniq([1, 2, 3])).to eq([1, 2, 3])
  end

  it "removes duplicates" do
    expect(my_uniq([1, 1, 2])).to eq([1, 2])
  end
end

describe Array do
  describe "#two_sum" do

    it "returns an empty array when called on an empty array" do
      expect([].two_sum).to eq([])
    end

    it "returns an empty array when there are no matching elements" do
      expect([1, 1].two_sum).to eq([])
    end

    it "returns the pair when there exist two matching elements" do
      expect([1,-1].two_sum).to eq([[0,1]])
    end

    it "returns the array sorted dictionary-wise" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end

    it "doesn't match an element with itself" do
      expect([0].two_sum).to eq([])
    end

  end
end

describe "#my_transpose" do
  it "returns an empty array when passed an empty array" do
    expect(my_transpose([])).to eq([])
  end

  it "transposes 3x3 matrix" do
    arr = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
    ]

    transposed_arr = [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
    ]
    expect(my_transpose(arr)).to eq(transposed_arr)
  end
end

describe "#stock_picker" do
  it "returns nil if array length < 2" do
    expect(stock_picker([1])).to eq(nil)
  end

  it "returns nil if no profitable trade exists" do
    expect(stock_picker([500000,0])).to eq(nil)
  end

  it "returns the most profitable trade" do
    expect(stock_picker([0,1,-3,6])).to eq([2,3])
  end
end

describe TowersOfHanoi do

  subject { TowersOfHanoi.new }

  describe "#initialize" do
    it "creates a board with three discs on the first peg" do
      expect(subject.board).to eq([[3,2,1], [], []])
    end
  end

  describe "#move_piece" do
    it "moves a piece to a new location when the move is valid" do
      subject.move_piece([0, 1])
      expect(subject.board).to eq([[3,2], [1], []])
    end
  end

  describe "#valid_move?" do
    it "returns false if starting peg is empty" do
      expect(subject.valid_move?([1,2])).to be false
    end

    it "return false if moved disc is larger than the smallest on the new peg" do
      subject.move_piece([0, 1])
      expect(subject.valid_move?([0,1])).to be false
    end

    it "returns false if one of the 'pegs' is out of bounds" do
      expect(subject.valid_move?([-1,1])).to be false
    end

    it "returns true for legit moves" do
      expect(subject.valid_move?([0,1])).to be true
    end
  end

  describe "#won?" do
    it "returns true if second peg is full" do
      3.times { subject.move_piece([0,1]) }
      expect(subject.won?).to be true
    end

    it "returns true if third peg is full" do
      3.times { subject.move_piece([0,2]) }
      expect(subject.won?).to be true
    end

    it "returns false if first peg is full" do
      expect(subject.won?).to be false
    end

    it "returns false if no pegs are full" do
      subject.move_piece([0,1])
      expect(subject.won?).to be false
    end
  end
end
