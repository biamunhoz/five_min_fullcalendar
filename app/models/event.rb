class Event < ApplicationRecord
    has_many :agendamentos, dependent: :delete_all
    validate :horariomarcado
    validate :tempolimite

    def tempolimite
      
      @sala = Sala.find_by(id: self.sala_id)

      valorlimite = 0
      if  @sala.limiteqtdeuso == true
        valorlimite = @sala.limitehoras

        valorlimite = valorlimite * 60

        horaini = (self.timeini.hour * 60) + self.timeini.min
        horafim = (self.timefim.hour * 60) + self.timefim.min

        tempo = horafim - horaini

        if tempo > valorlimite
          errors.add(:timefim, "Ha um limite de tempo definido, favor agendar com no maximo " + valorlimite.to_s + " minutos de uso.")
        end

      end

    end

    def horariomarcado
      if validaFinal == true
        errors.add(:start_date, "Periodo reservado anteriormente")
        errors.add(:end_date, "Periodo reservado anteriormente")
      end  
    end

    def validaFinal
    
      bAchou = false
      
      @horaini = self.timeini
      @horafim = self.timefim
  
      if new_record?
        @eventosdasala = Event.where(sala_id: self.sala_id).where(" start_date >= ? or end_date >= ? " , self.start_date, self.end_date)
      else
        @eventosdasala = Event.where(sala_id: self.sala_id).where(" start_date >= ? or end_date >= ? " , self.start_date, self.end_date).where.not(id: self.id )
      end  

      ids = Array.new
      @eventosdasala.each do |e|
        ids << e.id
      end
  
      if !ids.empty?
      
        @agendacad = Agendamento.where(" event_id in (?) ", ids)
  
        diaini = self.start_date.to_date
        diafim = self.end_date.to_date
  
        diaini.upto(diafim) do |day|
          case day.wday       
            when 0
              if self.domingo == true
                if verificaTempo(day, @horaini, @horafim) 
                  bAchou = true
                  break
                end 
              end    
            when 1
              if self.segunda == true
                if verificaTempo(day, @horaini, @horafim)
                  bAchou = true
                  break
                end
              end 
            when 2
              if self.terca == true
                if verificaTempo(day, @horaini, @horafim) 
                  bAchou = true
                  break
                end
              end 
            when 3
              if self.quarta == true
                if verificaTempo(day, @horaini, @horafim)
                  print " quarta feira"
                  bAchou = true
                  break
                end 
              end 
            when 4
              if self.quinta == true
                if verificaTempo(day, @horaini, @horafim)
                  bAchou = true
                  break
                end
              end
            when 5
              if self.sexta == true
                if verificaTempo(day, @horaini, @horafim) 
                  bAchou = true
                  break
                end 
              end 
            when 6
              if self.sabado == true
                if verificaTempo(day, @horaini, @horafim)
                  bAchou = true
                  break
                end
              end  
            end
        end  
      end 
  
      return bAchou
  
    end

    def verificaTempo(dia, horaini, horafim)

      bAchou = false
  
      horanewini = horaini.to_time.strftime("%H:%M")
      horanewfim = horafim.to_time.strftime("%H:%M")
  
      @agendacad.each do |a|
        if a.data_inicio == dia
  
          horacadini = a.hora_inicio.to_time.strftime("%H:%M")
          horacadfim = a.hora_fim.to_time.strftime("%H:%M")
          
          print "HORA INICIO JA AGENDADA ===>"
          print horacadini
          print "HORA INICIO DA FUNCAO ===>"
          print horanewini
  
          if horacadini == horanewini or horacadfim == horanewfim 
            print "===================================="
            bAchou = true
          end
          if horacadini > horanewini and horacadini < horanewfim 
            print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            bAchou = true
          end
          if horacadini < horanewini and horacadfim > horanewini
            print "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
            bAchou = true
          end  
  
        end    
  
      end
  
      return bAchou
  
    end

end
