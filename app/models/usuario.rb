class Usuario < ApplicationRecord
    has_many :tipo_vinculos
    
    has_many :inscricaos, :class_name => 'Inscricao'
    has_many :agendas, :through => :inscricaos

    has_many :permissaos, :class_name => 'Permissao'
    has_many :perfils, :through => :permissaos

    has_many :permissaos, :class_name => 'Permissao'
    has_many :salas, :through => :permissaos

end
