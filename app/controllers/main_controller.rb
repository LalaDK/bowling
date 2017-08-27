class MainController < ApplicationController

  def index
    @lanes = Lane.query(params[:date], params[:time], params[:lanes])
    @lane_count = params.has_key?(:lanes) ? params[:lanes].to_i : 1
    @time = params.has_key?(:time) ? DateTime.parse(params[:time], "%H").to_time.strftime("%H") : "17"
    @date = params.has_key?(:date) ? Date.strptime(params[:date], "%d-%m-%Y").strftime("%d-%m-%Y").to_s : Date.today.strftime("%d-%m-%Y").to_s
  end

  def create
    Lane.update(params[:date], params[:time], params[:lanes])
    redirect_to root: :index, params: {date: params[:date], time: params[:time], lanes: params[:lanes]}
  end
end
