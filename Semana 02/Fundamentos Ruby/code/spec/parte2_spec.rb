# frozen_string_literal: true

require_relative '../lib/ruby_intro.rb'

describe '#hello' do
  it 'deberia ser definido' do
    expect { hello('Testing') }.not_to raise_error#::NoMethodError)
  end

  it 'El metodo hello retorna la cadena correcta' do
    expect(hello('Checha').class).to eq(String)
    expect(hello('Checha')).to eq('Hello, Checha'), 'Resultado incorrecto para la entrada: "Checha"'
    expect(hello('CESARIO')).to eq('Hello, CESARIO'), 'Resultado incorrecto para la entrada: "CESARIO"'
    expect(hello('Mr. Zarin')).to eq('Hello, Mr. Zarin'), 'Resultado incorrecto para la entrada: "Mr. Zarin"'
  end
end

describe '#starts_with_consonant?' do
  it 'deberia ser definido' do
    expect { starts_with_consonant?('d') }.not_to raise_error#::NoMethodError)
  end
  it 'clasifica casos verdaderos' do
    expect(starts_with_consonant?('v')).to be_truthy, "'v' es una consonante"
    %w[v vest Veeee crypt].each do |string|
      expect(starts_with_consonant?(string)).to be_truthy, "Resultado incorrecto para la entrada: \"#{string}\""
    end
  end
  it 'clasifica casos falsos' do
    expect(starts_with_consonant?('a')).to be_falsy, "'a' no es una consonante"
    %w[asdfgh Unix].each do |string|
      expect(starts_with_consonant?(string)).to be_falsy, "Resultado incorrecto para la entrada: \"#{string}\""
    end
  end
  it 'funciona en la cadena vacia'  do
    expect(starts_with_consonant?('')).to be_falsy
  end
  it 'funciona con elementos que no son letras' do
    expect(starts_with_consonant?('#foo')).to be_falsy
  end
end

describe '#binary_multiple_of_4?' do
  it 'deberia ser definido' do
    expect { binary_multiple_of_4?('yes') }.not_to raise_error#::NoMethodError)
  end
  it 'clasifica numeros binarios validos' do
    %w[1010101010100 0101010101010100 100 0].each do |string|
      expect(binary_multiple_of_4?(string)).to be_truthy,  "Resultado incorrecto para la entrada: \"#{string}\""
    end
    %w[101 1000000000001].each do |string|
      expect(binary_multiple_of_4?(string)).not_to be_truthy,  "Resultado incorrecto para la entrada: \"#{string}\""
    end
  end
  it 'rechaza numeros binarios no validos' do
    expect(binary_multiple_of_4?('a100')).to be_falsy, "'a100' no es un numero binario valido!"
    expect(binary_multiple_of_4?('')).to be_falsy, 'La cadena vacia no es un numero binario valido.!'
  end
end