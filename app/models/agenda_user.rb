class AgendaUser < ApplicationRecord
  belongs_to :usuarios
  belongs_to :agendas
end
