class SalasController < ApplicationController
  before_action :set_sala, only: [:show, :edit, :update, :destroy]

  def versalas
    @agenda = params[:id]
    @salas = Sala.where(agenda_id: @agenda)
  end   

  def permissao
    @sala = params[:id]

    @permitidos = Permissao.joins(:usuario).joins(:perfil).where(sala_id: @sala).select("usuario_id, nomeUsuario, emailUspUsuario, sala_id, nomeperfil")

    @usuarios = Permissao.where(sala_id: @sala).select("usuario_id")

    @negados = Usuario.joins(:tipo_vinculos).where('usuarios.id not in (?)', @usuarios).select("usuarios.id, nomeUsuario, emailUspUsuario, tipoVinculo, nomeSetor, siglaUnidade")

  end 

  def salvaperfil(perfil, sala, user)
    
    @permissao = Permissao.find_by(sala_id: sala, usuario_id: user)

    if @permissao.nil?
      @p = Permissao.new
      @p.usuario_id = user
      @p.sala_id = sala
      @p.perfil_id = perfil

      @p.save!
    
      return true 
    else
      @permissao.perfil_id = @perfil 
      @permissao.save!

      return false
    end 
    
  end

  def addadmin
 
    @perfil = Perfil.find_by(:nomeperfil => 'Admin').id

    @registrado = salvaperfil(@perfil, params[:sala], params[:id])

  end 

  def altersuper
    @perfil = Perfil.find_by(:nomeperfil => 'Supervisor').id

    @registrado = salvaperfil(@perfil, params[:sala], params[:id])
  end  

  def altersimples
    @perfil = Perfil.find_by(:nomeperfil => 'Simples').id

    @registrado = salvaperfil(@perfil, params[:sala], params[:id])
  end   

  # GET /salas
  # GET /salas.json
  def index
    @salas = Sala.all
  end

  # GET /salas/1
  # GET /salas/1.json
  def show
  end

  # GET /salas/new
  def new
    @sala = Sala.new
  end

  # GET /salas/1/edit
  def edit
  end

  # POST /salas
  # POST /salas.json
  def create
    @sala = Sala.new(sala_params)

    respond_to do |format|
      if @sala.save
        format.html { redirect_to @sala, notice: 'Sala was successfully created.' }
        format.json { render :show, status: :created, location: @sala }
      else
        format.html { render :new }
        format.json { render json: @sala.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salas/1
  # PATCH/PUT /salas/1.json
  def update
    respond_to do |format|
      if @sala.update(sala_params)
        format.html { redirect_to @sala, notice: 'Sala was successfully updated.' }
        format.json { render :show, status: :ok, location: @sala }
      else
        format.html { render :edit }
        format.json { render json: @sala.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salas/1
  # DELETE /salas/1.json
  def destroy
    @sala.destroy
    respond_to do |format|
      format.html { redirect_to salas_url, notice: 'Sala was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sala
      @sala = Sala.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sala_params
      params.require(:sala).permit(:nome, :cor, :permissaoauto, :observacao, :confirmacao, :agenda_id)
    end
end
