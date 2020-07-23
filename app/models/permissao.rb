class Permissao < ApplicationRecord
  belongs_to :usuarios
  belongs_to :salas
  belongs_to :perfils
end
