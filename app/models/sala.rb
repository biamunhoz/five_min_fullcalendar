class Sala < ApplicationRecord
  belongs_to :agenda
  has_many :events

  has_many :permissaos, :class_name => 'Permissao'
  has_many :perfils, :through => :permissaos

  has_many :permissaos, :class_name => 'Permissao'
  has_many :usuarios, :through => :permissaos

end
