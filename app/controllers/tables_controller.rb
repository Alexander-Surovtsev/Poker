class TablesController < ApplicationController
#  layout false, :except => :index
  
  def index
    gC = GameController.instance
    @tables = GameController.getRooms
    respond_to do |format|
      format.html
      format.json { render json: @tables }
    end
  end
  
  def create
    @table = Table.new
  end

  def confirm_creation_table

    s = get_session
    if s == nil
      @notice = "your session is expired"
      redirect_to index_path
      return
    end


#    t = Table.where(:session_id => s.id)
#    if t.length != 0
#      @notice = "you can not create more than one table"
#      redirect_to tables_path
#      return
#    end
    
    #gC = GameController.instance  
#    table = Table.new
#    table.name = params[:table][:name]
    
    if GameController.addRoom(params[:table][:name], s.id)
      redirect_to table_path+"?name="+params[:table][:name]
      return
    else
      respond_to do |format|
        format.html { redirect_to(index_path, :notice => "table is not created")}
        format.xml { head :ok}
      end
    end
    
  end
  
  def table
    s = get_session
    if s == nil
      @notice = "your session is expired"
      redirect_to index_path
      return
    end

    #gC = GameController.instance  

    @table_name = params[:name]
    
    @tables = GameController.getRooms
    valid_name = false
    @tables.each do |table|
      if table == @table_name
        valid_name = true
      end
    end
    if not valid_name
      redirect_to tables_path
    end
    #gC = GameController.instance 
    @table_name = params[:name]
    @messages = GameController.getMessages(s.id, @table_name)

  end
  
  def process_message
    s = get_session
    if s == nil
      @notice = "your session is expired"
      redirect_to index_path
      return
    end
    gC = GameController.instance 
    @message = params[:message]
    @table_name = params[:name]
    logger.debug ">>>>>>>>>>>>>>>>>>>>"
      logger.debug "roomId " + @table_name
      logger.debug "messages" + @message
    logger.debug ">>>>>>>>>>>>>>>>>>>>"

    GameController.sendMessage(s.id, @table_name, @message)
    render "send_message", :layout => false
  end 
        
  def get_messages
    s = get_session
    if s == nil
      @notice = "your session is expired"
      redirect_to index_path
      return
    end
    gC = GameController.instance 
    @table_name = params[:name]
    @messages = GameController.getMessages(s.id, @table_name)

    logger.debug "-------------------------------------------------------"


      logger.debug "messages " + @messages
      render :layout => false
      #render "get_messages"
    
    
    logger.debug "-------------------------------------------------------"
    
    return @messages
#    respond_to do |format|
#      format.js {render :json => "ss".to_json }
#    end
    
  end    
    
end
