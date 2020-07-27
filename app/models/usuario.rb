class Usuario < ApplicationRecord
    has_many :tipo_vinculos

    #has_many :agenda_users, :class_name => 'AgendaUser'
    #has_many :agendas, :through => :agenda_users

end
