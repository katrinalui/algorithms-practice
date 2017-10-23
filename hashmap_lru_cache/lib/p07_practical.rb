require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  letter_count = HashMap.new

  string.each_char do |char|
    if letter_count.include?(char)
      letter_count.delete(char)
    else
      letter_count.set(char, 1)
    end
  end

  letter_count.count <= 1
end
