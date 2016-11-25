def my_min_1(arr)
  arr.each do |el1|
    return el1 if arr.all? {|el2| el1 <= el2}
  end
end

def my_min_2(arr)
  min = arr.first
  arr.each do |el|
    min = el if el < min
  end
  min
end

def lcs_1(arr)
  all_subs = []
  arr.each_index do |i|
    (i+1...arr.length).each do |j|
      all_subs << arr[i..j]
    end
  end
  all_subs.map{|subarray| subarray.inject(:+)}.max
end

def lcs_2(arr)
  largest_sum = arr.first
  current_sum = arr.first
  arr[1..-1].each do |el|
    if current_sum + el >= 0
      current_sum += el
      largest_sum = current_sum if current_sum > largest_sum
    else
      current_sum = 0
    end
  end
  largest_sum
  
end
