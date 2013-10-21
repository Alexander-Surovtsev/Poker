class TablesController < ApplicationController
  def create
    @table = Table.new
    respond_to do |format|
      format.html
      format.json { render json: @table }
    end
  end

  def confirm_creation_table
    s = get_session
    if s == nil
      respond_to do |format|
        format.html { redirect_to(index_path, :notice => "your session is expired")}
        format.xml { head :ok}
      end
      return
    end
    
    t = Table.where(:session_id => s.id)
    if t.length != 0
      respond_to do |format|
        format.html { redirect_to(index_path, :notice => "you are now in game")}
        format.xml { head :ok}
      end
      return
    end
    
    table = Table.new
    table.name = params[:table][:name]
    table.session_id = s.id
    
    if table.save()
      respond_to do |format|
        format.html { redirect_to(t_path, :notice => "table is not created")}
        format.xml { head :ok}
      end
      return
    else
      respond do |format|
        format.html { redirect_to(index_path, :notice => "table is not created")}
        format.xml { head :ok}
      end
    end
    
  end
  
  def t
    
  end
end
