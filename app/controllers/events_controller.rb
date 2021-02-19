class EventsController < ApplicationController
  include ApplicationHelper

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json

  def index

  # @events = Event.joins(:agendamentos).where("sala_id in (?)", salaspermitidas).select("events.id, Concat(events.title,' - ' ,events.registropara) as title, 
  #  events.start_date, events.end_date, events.timeini, events.timefim, agendamentos.data_inicio, agendamentos.data_fim, 
  #  agendamentos.hora_inicio, agendamentos.hora_fim, events.descricao, events.registropara, events.usuario_id, events.sala_id")


    @events = Event.joins(:agendamentos).joins(" inner join salas on events.sala_id = salas.id ").where("sala_id in (?)", salaspermitidas).select("events.id, Concat(events.title,' - ' ,events.registropara) as title, 
    events.start_date, events.end_date, events.timeini, events.timefim, agendamentos.data_inicio, agendamentos.data_fim, 
    agendamentos.hora_inicio, agendamentos.hora_fim, events.descricao, events.registropara, events.usuario_id, events.sala_id, salas.cor")

    #json.backgroundColor '#9297dd'
    #json.borderColor '#9297dd'

  end

  def carrega_salas

    @permissao = Permissao.where(usuario_id: current_user.id)

    salaspermitidas = Array.new
    @permissao.each do |p|
      salaspermitidas << p.sala_id
    end

    @salas = Sala.where(" id in (?) ", salaspermitidas)

  end 

  def salaspermitidas

    @salas = carrega_salas

    salaspermitidas = Array.new

    @salas.each do |a|
      salaspermitidas << a.id
    end

    return salaspermitidas
  end

  def listagem

    @events = Event.where("sala_id in (?)", salaspermitidas)

  end

  def salaselecionada(sala)
 
    @salas = Sala.where(agenda_id: sala)
    salaselecionada  = Array.new

    @salas.each do |a|
      salaselecionada << a.id
    end

    return salaselecionada
  end

  def eventoagenda
   
    @agendasel = params[:id]
    #@@salamostrar = salaselecionada(params[:id])
    @@salamostrar = salaselecionada(@agendasel)
    
    @dadosagenda = Agenda.where(:id => @agendasel)
    
  end 

  def resultagenda
    
    @events = Event.joins(:agendamentos).joins(" inner join salas on events.sala_id = salas.id ").where("sala_id in (?)", @@salamostrar).select("events.id, Concat(events.title,' - ' ,events.registropara) as title, 
    events.start_date, events.end_date, events.timeini, events.timefim, agendamentos.data_inicio, agendamentos.data_fim, 
    agendamentos.hora_inicio, agendamentos.hora_fim, events.descricao, events.registropara, events.usuario_id, events.sala_id, salas.cor")

  end

  def agendamentos

    @agendamentos = Agendamento.where(event_id: params[:id])

  end

  def deleteagend

    @agendamento = Agendamento.find(params[:id])

    @evento = Event.find_by(id: @agendamento.event_id)

    @sala = Sala.find_by(id: @evento.sala_id)

    if @sala.avisoadmhoravaga == true

      @ini = @agendamento.data_inicio.strftime("%d/%m/%Y") + " - " + @agendamento.hora_inicio.strftime("%H:%M")
      @fim = @agendamento.data_fim.strftime("%d/%m/%Y") + " - " + @agendamento.hora_fim.strftime("%H:%M")

      @supers = Permissao.where(sala_id: @sala.id , perfil_id: 2)
      
      @supers.each do |s|
        @user = Usuario.find_by(id: s.usuario_id)

        NotificaMailer.avisohorariovago(@user.emailPrincipalUsuario, @ini, @fim, @sala.nome, @user.nomeUsuario).deliver_now!
      end 

    end

    @agendamento.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Agendamento na data escolhida apagado.' }
      format.json { head :no_content }
    end

  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @salas = salaspermitidas
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @salas = salaspermitidas
  end


  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    @sala = Sala.find_by(id: @event.sala_id)

    bEnviaEmailConfirmacao = false

    if @sala.confirmacao == true
      @event.pendente = true
      bEnviaEmailConfirmacao = true
    else 
      @event.pendente = false 
    end

    respond_to do |format|

        if @event.save

          horaini = @event.timeini.to_time
          horafim = @event.timefim.to_time
  
          diaini = @event.start_date.to_date
          diafim = @event.end_date.to_date

          diaini.upto(diafim) do |day|
            case day.wday       
              when 0
                if @event.domingo == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "111111111111111111111111111111111111"
                end   
              when 1
                if @event.segunda == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "22222222222222222222222222222222222"
                end               
              when 2 
                if @event.terca == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "33333333333333333333333333333333333"
                end
              when 3 
                if @event.quarta == true                  
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "444444444444444444444444444444444444"
                end
              when 4 
                if @event.quinta == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "555555555555555555555555555555555555"
                end
              when 5 
                if @event.sexta == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "6666666666666666666666666666666666666"
                end
              when 6 
                if @event.sabado == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "777777777777777777777777777777777777"
                end             
              end
            
          end
  
          if bEnviaEmailConfirmacao == true
            NotificaMailer.confirmacao(current_user.id, @event.title).deliver_now!
          end

          format.html { redirect_to @event, notice: 'Evento foi criado com sucesso.' }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end 
      end      
      
  end
 
  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Evento foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy

    @sala = Sala.find_by(id: @event.sala_id)

    if @sala.avisoadmhoravaga == true

      @ini = @event.start_date.strftime("%d/%m/%Y") + " - " + @event.timeini.strftime("%H:%M")
      @fim = @event.end_date.strftime("%d/%m/%Y") + " - " + @event.timefim.strftime("%H:%M")

      @supers = Permissao.where(sala_id: @event.sala_id, perfil_id: 2)
      
      @supers.each do |s|
        @user = Usuario.find_by(id: s.usuario_id)

        NotificaMailer.avisohorariovago(@user.emailPrincipalUsuario, @ini, @fim, @sala.nome, @user.nomeUsuario).deliver_now!
      end 

    end 

    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Evento foi apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def salvaAgendamento(start_date, end_date, horaini, horafim, event_id)

    @ag = Agendamento.new
    @ag.data_inicio = start_date
    @ag.data_fim = end_date
    @ag.hora_inicio = horaini
    @ag.hora_fim = horafim
    @ag.event_id = event_id

    @ag.save!

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :start_date, :timeini, :end_date, :timefim, :descricao, :domingo, :segunda, :terca, :quarta, :quinta, :sexta, :sabado, :pendente, :registropara, :sala_id, :usuario_id)
    end
end
