class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all    
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end
  
  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

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
                  print "111111111111111111111111111"
                end   
              when 1
                if @event.segunda == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "2222222222222222222222222222"
                end               
              when 2 
                if @event.terca == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "3333333333333333333333333"
                end
              when 3 
                if @event.quarta == true                  
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "444444444444444444444444444444444444"
                end
              when 4 
                if @event.quinta == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "555555555555555555555555"
                end
              when 5 
                if @event.sexta == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "666666666666666666666666"
                end
              when 6 
                if @event.sabado == true
                  salvaAgendamento(day, day, horaini, horafim, @event.id)
                  print "7777777777777777777777777777777"
                end             
              end
            
          end
  
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
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
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
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
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
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
