# frozen_string_literal: true

require_relative '../lib/ruby_intro.rb'

describe 'BookInStock' do
  it 'esto deberia ser definido' do
    expect { BookInStock }.not_to raise_error
  end

  describe 'getters y setters' do
    before(:each)  { @book = BookInStock.new('isbn1', 33.8) }
    it 'debe establecer ISBN ' do
      expect(@book.isbn).to eq('isbn1')
    end
    it 'deberia establecer el precio ' do
      expect(@book.price).to eq(33.8)
    end
    it 'deberia cambiar el ISBN' do
      @book.isbn = 'isbn2'
      expect(@book.isbn).to eq('isbn2')
    end
    it 'deberia cambiar el precio' do
      @book.price = 300.0
      expect(@book.price).to eq(300.0)
    end
  end
  describe 'constructor' do
    it 'debe rechazar el numero ISBN no valido' do
      expect { BookInStock.new('', 25.00) }.to raise_error(ArgumentError)
    end
    it 'debe rechazar el precio cero' do
      expect { BookInStock.new('isbn1', 0) }.to raise_error(ArgumentError)
    end
    it 'debe rechazar el precio negativo' do
      expect { BookInStock.new('isbn1', -5.0) }.to raise_error(ArgumentError)
    end
  end
  describe '#price_as_string' do
    it 'esto deberia ser definido' do
      expect(BookInStock.new('isbn1', 10)).to respond_to(:price_as_string)
    end
    it 'debe mostrar 33.95 como "$33.95"' do
      expect(BookInStock.new('isbn11', 33.95).price_as_string).to eq('$33.95')
    end
    it 'debe mostrar  1.1 como $1.10' do
      expect(BookInStock.new('isbn11', 1.1).price_as_string).to eq('$1.10')
    end
    it 'debe mostrar  20 como $20.00 ' do
      expect(BookInStock.new('isbn11', 20).price_as_string).to eq('$20.00')
    end
  end
end