class AddCryptidRefToEncounters < ActiveRecord::Migration
  def change
    add_reference :encounters, :cryptid, index: true, foreign_key: true
  end
end
