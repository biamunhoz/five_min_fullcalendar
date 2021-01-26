module SalasHelper

    def tempermissaosuperadmin(sala_id)

        @valor = Sala.joins(:permissaos).where(id: sala_id).where(" permissaos.perfil_id = 2 and permissaos.usuario_id = ? ", current_user.id)

        return @valor.exists?

    end

end
