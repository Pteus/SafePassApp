class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.entries.order(created_at: :desc)
  end

  def show
    @entry = current_user.entries.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)
    if @entry.save
      flash[:notice] = "Entry created and saved!"
      redirect_to root_path
    else
      flash[:alert] = "Entry could not be created."
      render :new, status: :unprocessable_content
    end
  end

  private

  def entry_params
    # params.require(:entry).permit(:name, :url, :username, :password) # old way (< rails 8)
    params.expect(entry: [:name, :url, :username, :password])
  end
end
