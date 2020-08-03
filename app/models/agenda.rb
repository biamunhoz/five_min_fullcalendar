class Agenda < ApplicationRecord

    #has_many :agenda_users, :class_name => 'AgendaUser'
    #has_many :usuarios, :through => :agenda_users
    has_many :salas
end
