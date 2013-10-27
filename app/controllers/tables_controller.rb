class TablesController < ApplicationController
  def index
    gC = GameController.instance
    @tables = gC.getRooms
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
    
    gC = GameController.instance  
#    table = Table.new
#    table.name = params[:table][:name]
    
    if gC.addRoom(params[:table][:name], s.id)
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
    @table_name = params[:name]
    return
    t = Table.find_by_name(@table_name)
    if t == nil
      redirect_to tables_path
    end
  end
end
