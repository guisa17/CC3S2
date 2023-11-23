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
  arr.each_with_index do | element, index |
    complement = n - element
    return true if arr[(index + 1)..].include?(complement)
  end
  false
end


def sum_to_n? arr, n
  # COMPLETA TU CODIGO
end


# Parte 2

def hello(name)
  # COMPLETA TU CODIGO
end

def starts_with_consonant? s
  # COMPLETA TU CODIGO
end

def binary_multiple_of_4? s
  # COMPLETA TU CODIGO
end

# Parte 3

class BookInStock
# COMPLETA TU CODIGO
end


# Parte 2

def hello(name)
  # COMPLETA TU CODIGO
end

def starts_with_consonant? s
  # COMPLETA TU CODIGO
end

def binary_multiple_of_4? s
  # COMPLETA TU CODIGO
end


# Parte 3

class BookInStock
# COMPLETA TU CODIGO
end
