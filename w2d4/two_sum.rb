require 'set'

def brute_two_sum?(arr, target)
  arr.each do |el1|
    arr.each do |el2|
      next if el1 == el2
      return true if el1 + el2 == target
    end
  end
  false
end

def sort_two_sum?(arr, target)
  sorted = arr.sort
  sorted.each do |el|
    return true if sorted.bsearch { |el2| el != el2 && el + el2 == target}
  end
  false
end

def set_two_sum?(arr, target)
  values = Set.new(arr)
  arr.any? do |el|
    required_value = target - el
    next if required_value == el
    values.include?(required_value)
  end
end
