class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[show]

  def index
    @applications = Application.order(created_at: :desc)
    render(json: @applications, include: [])
  end

  def show
    render(json: @application, include: ['sections', 'sections.rows', 'sections.rows.columns'])
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      render(json: @application)
    else
      render_422(@application.errors)
    end
  end

  private

  def application_params
    params.require(:application).permit(:title, :details)
  end

  def set_application
    @application = Application.find(params[:id])
  end
end
