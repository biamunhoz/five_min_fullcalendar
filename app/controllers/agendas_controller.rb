class AgendasController < ApplicationController
  before_action :set_agenda, only: [:show, :edit, :update, :destroy]

  # GET /agendas
  # GET /agendas.json
  def index

    if session[:admingeral] == true
      @agendas = Agenda.all
    else
      @agendas = carrega_agendas
    end   

  end

  def inscricao

    if session[:login] == nil      
      redirect_to login_path
    else  

      @agenda = params[:id]

      @tipoagenda = Agenda.find_by(id: @agenda)

      @valida = Inscricao.find_by(usuario_id: current_user.id, agenda_id:@agenda)

      if @valida.nil?

        if @tipoagenda.tipo == 'Publica'
          @insc = Inscricao.new
          @insc.usuario_id = current_user.id
          @insc.agenda_id = @agenda
          @insc.tipo = "Inscrito"
          @insc.save!

          addpermissao(@agenda, current_user.id)
          @confirmado = true

        else

          @insc = Inscricao.new
          @insc.usuario_id = current_user.id
          @insc.agenda_id = @agenda
          @insc.tipo = "Pendente"
          @insc.save!

          NotificaMailer.permissaoagenda(@agenda, current_user.id).deliver_now!
          @confirmado = false
        end

      else
        @confirmado = false
      end

    end  
    
  end  

  def verinscritos

    @agenda = params[:id]

    @insc = Inscricao.joins(:usuario).joins(:agenda).where(agenda_id: @agenda)

  end

  def alternegar
    @insc = Inscricao.find_by(:id => params[:id])
    
    @insc.tipo = "Negado"
    @insc.save!
  end

  def alterinscrito
    
    @insc = Inscricao.find_by(:id => params[:id])

    @insc.tipo = "Inscrito"
    @insc.save!

  end

  ### Adiciona usuario em salas com permissao automatica
  def addpermissao(agenda, usuario)

    @salas = Salas.where(agenda_id: agenda, permissaoauto: true)

    @salas.each do |s|

      @p = Permissao.new
      @p.usuario_id = usuario
      @p.sala_id = s.id
      @p.perfil_id = Perfil.find_by(:nomeperfil => 'Simples').id

      @p.save!
    end 

  end

  # GET /agendas/1
  # GET /agendas/1.json
  def show
  end

  # GET /agendas/new
  def new
    @agenda = Agenda.new
  end

  # GET /agendas/1/edit
  def edit
  end

  # POST /agendas
  # POST /agendas.json
  def create
    @agenda = Agenda.new(agenda_params)

    respond_to do |format|
      if @agenda.save
        format.html { redirect_to @agenda, notice: 'Agenda was successfully created.' }
        format.json { render :show, status: :created, location: @agenda }
      else
        format.html { render :new }
        format.json { render json: @agenda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agendas/1
  # PATCH/PUT /agendas/1.json
  def update
    respond_to do |format|
      if @agenda.update(agenda_params)
        format.html { redirect_to @agenda, notice: 'Agenda was successfully updated.' }
        format.json { render :show, status: :ok, location: @agenda }
      else
        format.html { render :edit }
        format.json { render json: @agenda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agendas/1
  # DELETE /agendas/1.json
  def destroy
    @agenda.destroy
    respond_to do |format|
      format.html { redirect_to agendas_url, notice: 'Agenda was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agenda
      @agenda = Agenda.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def agenda_params
      params.require(:agenda).permit(:nome, :apresentacaotelaini, :observacao, :tipo)
    end
end

=begin

 Eu preciso criar sempre uma agenda ;
 Ela precisa ter pelo menos uma sala;
 E tambem um supervisor 
 
=end