# Parte 1

def sum arr
  suma = 0
  arr.each{ |x| suma += x }
  suma
end
  
def max_2_sum arr
  return 0 if arr.empty?
  return arr[0] if arr.length == 1
  
  sorted_arr = arr.sort.reverse
  sorted_arr[0] + sorted_arr[1]
end

def sum_to_n? arr, n
  return false if arr.empty?

  arr.combination(2).any? { |a, b| a + b == n }
end


# Parte 2

def hello(name)
  "Hello, #{name}"
end

def starts_with_consonant? s
  return false if s.empty? || !s[0].match?(/[a-zA-Z]/)
  !s[0].match?(/[aeiouAEIOU]/)
end

def binary_multiple_of_4? s
  return false unless /^[01]+$/.match(s)
  s =~ /00$/ || s == '0'
end


# Parte 3

class BookInStock
  attr_accessor :isbn, :price

  def initialize(isbn, price)
    return raise ArgumentError if isbn.empty? || price <= 0
    @isbn = isbn
    @price = price
  end

  def price_as_string
    format("$%.2f", @price)
  end
end
