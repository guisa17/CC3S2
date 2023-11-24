require 'sqlite3'
require 'active_record'
require 'byebug'


ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'customers.sqlite3')
# Mostrar consultas en la consola.
# Comenta esta linea para desactivar la visualización de consultas SQL sin formato.
ActiveRecord::Base.logger = Logger.new(STDOUT)

class Customer < ActiveRecord::Base
  def to_s
    "  [#{id}] #{first} #{last}, <#{email}>, #{birthdate.strftime('%Y-%m-%d')}"
  end

  # NOTA: Cada uno de estos se puede resolver por completo mediante llamadas de ActiveRecord.
  # No deberías necesitar llamar a las funciones de  Ruby para ordenar, filtrar, etc.
  def self.any_candice
    # Tu codigo aqui para devolver todos los clientes cuyo nombre sea Candice
    # probablemente algo asi:  Customer.where(....)
    Customer.where(first: 'Candice')
  end

  def self.with_valid_email
    # Tu codigo aqui para devolver solo clientes con direcciones de correo electronico validas (que contengan '@')
    Customer.where("email LIKE '%@%'") 
  end
  
  def self.with_dot_org_email
    Customer.where("email LIKE '%.org%'")
  end

  def self.with_invalid_email
    Customer.where("email NOT LIKE '%@%' AND email != '' AND email IS NOT NULL")
  end

  def self.with_blank_email
    Customer.where(email: ['', nil])
  end

  def self.born_before_1980
    Customer.where("birthdate < '1980-01-01'")
  end

  def self.with_valid_email_and_born_before_1980
    Customer.with_valid_email.born_before_1980
  end

  def self.last_names_starting_with_b
    Customer.where("last LIKE 'B%'").order(:birthdate)
  end

  def self.twenty_youngest
    Customer.order('birthdate DESC').limit(20)
  end

  def self.update_gussie_murray_birthdate
    gussie = Customer.find_by(first: 'Gussie', last: 'Murray')
    gussie.update(birthdate: '2004-02-08')
  end

  def self.change_all_invalid_emails_to_blank
    Customer.where("email NOT LIKE '%@%' AND email != '' AND email IS NOT NULL").update_all(email: '')
  end

  def self.delete_meggie_herman
    meggie = Customer.find_by(first: 'Meggie', last: 'Herman')
    meggie&.destroy
  end

  def self.delete_everyone_born_before_1978
    Customer.where("birthdate < '1978-01-01'").destroy_all
  end
end
