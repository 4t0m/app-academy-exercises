def first_anagram?(source_str, target_str)
  all_anagrams = source_str.chars.permutation.map(&:join)
  all_anagrams.include?(target_str)
end

def second_anagram?(source_str, target_str)
  characters = source_str.chars + target_str.chars
  characters.reject! { |char| source_str.include?(char) && target_str.include?(char) }
  characters.empty?
end

def third_anagram?(source_str, target_str)
  source_str.chars.sort == target_str.chars.sort
end

def fourth_anagram?(source_str, target_str)
  source_hash, target_hash = Hash.new(0), Hash.new(0)
  source_str.each_char { |char| source_hash[char] += 1 }
  target_str.each_char { |char| target_hash[char] += 1 }
  source_hash == target_hash
end


def bonus_anagram?(source_str, target_str)
  source_hash = Hash.new(0)
  source_str.each_char { |char| source_hash[char] += 1 }
  target_str.each_char { |char| source_hash[char] -= 1 }
  source_hash.all? { |_k, value| value == 0 }
end
