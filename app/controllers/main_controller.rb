class MainController < ApplicationController

  def index
    @lanes = Lane.query(params[:date], params[:time], params[:lanes])
    @time = params.has_key?(:time) ? DateTime.parse(params[:time], "%H").to_time.strftime("%H") : Time.now.strftime("%H")
    @date = params.has_key?(:date) ? Date.strptime(params[:date], "%d-%m-%Y").strftime("%d-%m-%Y").to_s : Date.today.strftime("%d-%m-%Y").to_s
  end

  def create
    Lane.update(params[:date], params[:time], params[:lanes])
    redirect_to action: :index, params: {date: params[:date], time: params[:time], lanes: params[:lanes]}
  end
end
