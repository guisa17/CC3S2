require 'rspec'
require './lib/activerecord_practica.rb'
require 'byebug'

ALL_CUSTOMERS = [nil] + Customer.all.order('id')

def check(actual,expected_ids)
  actual ||= []
  expected = ALL_CUSTOMERS.values_at(*expected_ids)
  missing = expected - actual
  unless missing.empty?
    raise "El resultado deberia haberlos contenido, pero no fue asi:\n" + missing.join("\n")
  end
  extra = actual - expected
  unless extra.empty?
    raise "El resultado NO deberia haberlos contenido, pero si.:\n" + extra.join("\n")
  end
end

describe 'Practica ActiveRecord' do
  around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
  describe 'para encontrar' do
    before(:each) do
      # deshabilita los metodos que no queremos que utilices...
      expect(Customer).not_to receive(:find)
      expect(Customer).not_to receive(:expect)
    end
    describe 'using .where:' do
      # Todos los ejemplos en este bloque de descripcion deben pasarse mediante 
      # una o mas llamadas al comando "where()" de ActiveRecord.
      before(:each) do
        expect(Customer).to receive(:where).at_least(:once).and_call_original
      end
      xspecify 'cualquier persona con el nombre Candice' do
        check Customer.any_candice, [24]
      end
      xspecify 'con un correo electrónico válido (la dirección de correo electrónico contiene "@") (busca el operador SQL LIKE)' do
        check Customer.with_valid_email, [1,2,4,5,7,8,10,11,12,13,14,15,17,18,19,20,23,26,29,30]
      end
      xspecify 'con emails .org' do
        check Customer.with_dot_org_email, [5,7,8,12,23,26,29]
      end
      xspecify 'con correo electronico no valido pero que no este en blanco (no contiene "@")' do
        check Customer.with_invalid_email, [3,6,9,16,22,25,27,28]
      end
      xspecify 'con correo electronico en blanco' do
        check  Customer.with_blank_email, [21,24]
      end
      xspecify 'nacido antes del 1 Enero 1980' do
        check Customer.born_before_1980, [3,8,9,11,15,16,17,19,20,24,25,27]
      end
      xspecify 'con correo electronico valido Y nacidos antes del 1/1/1980' do
        check Customer.with_valid_email_and_born_before_1980, [8,11,15,17,19,20]
      end
      xspecify 'con apellidos que comienzan con "B", ordenados por fecha de nacimiento' do
        expect(Customer.last_names_starting_with_b.map(&:id)).to eq( [25,23,4,28,18,21,29,1] )
      end
    end
    describe 'sin necesidad de .where' do
      xspecify '20 clientes mas jovenes, en cualquier orden (busca ActiveRecord "order" y "limit")' do
        check Customer.twenty_youngest, [7,5,6,30,1,10,29,21,18,13,14,28,26,4,2,22,23,12,11,9]
      end
    end
  end
  describe 'para actualizar' do
    before(:each) do
      expect(Customer).not_to receive(:find)
    end
    xspecify 'la fecha de nacimiento de Gussie Murray hasta el 8 de febrero de 2004 (busca `Time.parse`)'do
      Customer.update_gussie_murray_birthdate
      expect(Customer.find_by(:first => 'Gussie').birthdate.to_date).to eq(Date.new 2004,2,8)
    end
    xspecify 'Todos los correos electronicos no validos deben estar en blanco.' do
      Customer.change_all_invalid_emails_to_blank
      expect(Customer.where("email != '' AND email IS NOT NULL and email NOT LIKE '%@%'").count).to be_zero
    end
    xspecify 'base de datos eliminando al cliente Meggie Herman' do
      Customer.delete_meggie_herman
      expect(Customer.find_by(:first => 'Meggie', :last => 'Herman')).to be_nil
    end
    xspecify 'base de datos eliminando todos los clientes nacidos el 31 de diciembre de 1977' do
      Customer.delete_everyone_born_before_1978
      expect(Customer.where('birthdate < ?', Time.parse("1 January 1978"))).to be_empty
    end
  end
end