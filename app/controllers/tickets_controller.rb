class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_tickets, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def show
  end

  def create
    @ticket = @project.tickets.build(ticket_params)

    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [ @project, @ticket ]
    else
      flash[:alert] = "Ticket was not created."
      render "new"
    end
  end

  private
  def ticket_params
    params.require(:ticket).permit(:name,:description)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_tickets
    @ticket = @project.tickets.find(params[:id])
  end
end
