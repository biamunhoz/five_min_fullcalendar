class NotificaMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifica_mailer.confirmacao.subject
  #
  def confirmacao
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifica_mailer.permissaosala.subject
  #
  def permissaosala
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def inscricaoagenda(idinscr, status)
    
    @status = status
    @insc = Inscricao.where(id: idinscr)

    @insc.each do |i|
      @user = Usuario.find_by(id: i.usuario_id)
      @agenda = Agenda.find_by(id: i.agenda_id)  

      mail to: @user.emailPrincipalUsuario, subject: "Permissao de usuario - Agenda"
    end

  end


  def permissaoagenda(agenda, user)

    @user = Usuario.find_by(id: user)

    @agenda = Agenda.find_by(id: agenda)

    @salasx = Sala.where(agenda_id: agenda)

    @salasx.each do |s| 

      @super = Permissao.where(perfil_id: 2, sala_id: s.id)

      @super.each do |su|

        @usersuper = Usuario.find_by(id: su.usuario_id)

        mail to: @usersuper.emailPrincipalUsuario, cc: @user.emailPrincipalUsuario, subject: "Permissao de usuario - Agenda"
      end
    end
    
  end

end
