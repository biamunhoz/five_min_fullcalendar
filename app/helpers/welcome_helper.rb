module WelcomeHelper

  #cria uma sessão
  def log_in(loginUsuario)
    session[:login] = loginUsuario
    session[:admingeral] = false

    @user = Usuario.find_by(:loginUsuario => loginUsuario)

    @vinculo = TipoVinculo.where(:usuario_id => @user.id)

    @vinculo.each do |v|
      print v.codigoSetor
      if v.codigoSetor.to_s() == '3610'
        session[:admingeral] = true
      end 
    end
    

  end

  #destroi a sessão criada na def anterior
  def log_out
    session.destroy
    @current_user = nil
  end

  def current_user
    @current_user ||= Usuario.find_by(loginUsuario: session[:login])
  end

  #substituir a ideia de salas de uma agenda com permissao
  def carrega_salas_daagenda(agenda_id)
  end

  def carrega_salas

    @permissao = Permissao.where(usuario_id: current_user.id)

    salaspermitidas = Array.new
    @permissao.each do |p|
      salaspermitidas << p.sala_id
    end

    @salas = Sala.where(" id in (?) ", salaspermitidas)

  end 

  def carrega_agendas

    @salas = carrega_salas

    agendaspermitidas = Array.new

    @salas.each do |a|
      agendaspermitidas << a.agenda_id
    end

    @agendasid = Agenda.where(" tipo = 'Publica' or id in (?)" , agendaspermitidas).select(:id).distinct

    agendasfinal = Array.new
    @agendasid.each do |aid|
      agendasfinal << aid.id
    end

    @agendas = Agenda.where(" id in (?) ", agendasfinal)

  end

end
