class Array

  def my_each(&prc)
    index = 0
    while index < self.size
      prc.call(self[index])
      index += 1
    end
  end

  def my_select(&prc)
    new_array = []
    self.my_each do | el |
      new_array << el if prc.call(el)
    end

    new_array
  end

  def my_reject(&prc)
    new_array = []
    self.my_each do | el |
      new_array << el unless prc.call(el)
    end

    new_array
  end

  def my_any?(&prc)
    self.my_each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |el|
      return false unless prc.call(el)
    end
    true
  end

  def my_flatten
    new_arr = []
    return self unless self.my_any? { |el| el.is_a? Array }
    self.my_each do |el|
      if !(el.is_a? Array)
        new_arr.push(el)
      else
        new_arr.concat(el)
      end
    end
    new_arr.my_flatten
  end

  def my_zip(*arrays)
    all_arrays = [self]
    arrays.each do | array |
      all_arrays << array
    end

    new_arr = []
    (0...self.size).each do | index |
      inner_arr = []

      all_arrays.my_each do | array |
        inner_arr << array[index]
      end
      new_arr << inner_arr
    end

    new_arr
  end

  def my_rotate(rotate_size = 1)
    if rotate_size > 0
      rotate_size.times do
        self << self.shift
      end
    else
      rotate_size.abs.times do
        self.unshift(self.pop)
      end
    end
    self
  end

  def my_join(sep = "")
    new_str = ""
    self.my_each do |el|
      new_str << "#{el}#{sep}"
    end
    sep == "" ? new_str : new_str[0...-1]
  end

  def my_reverse
    arr = []
    self.size.times do
      arr << self.pop
    end
    arr
  end
end

# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

def factors(num)
  all_factors = []
  1.upto(num) do | test_factor |
    all_factors << test_factor if num % test_factor == 0
  end

  all_factors
end

p factors(12)

# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator

class Array
  def bubble_sort!(&prc)
    prc ||= proc { |el1, el2| el1 > el2}
    (0...self.size).each do | first_index |
      (first_index+1...self.size).each do | second_index |
        if prc.call(self[first_index], self[second_index])
          self[first_index], self[second_index] = self[second_index], self[first_index]
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    new_array = self.dup
    new_array.bubble_sort!(&prc)
  end
end

p [0,1,3,2].bubble_sort

# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).

def substrings(string)
  all_substrings = []
  chars = string.chars
  (1..chars.size).each do | index |
    chars.each_cons(index) { |letters| all_substrings << letters.join }
  end

  all_substrings.uniq
end

p substrings("cat")

def subwords(word, dictionary)
  substrings = substrings(word)
  all_words = []

  substrings.my_select { |sub_str| dictionary.include?(sub_str)}
end

p subwords("cat", ["at"])
