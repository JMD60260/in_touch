class ReportsController < ApplicationController
require 'pry-byebug'
  def index
    # Lists every reports that have been sent to the client
  end

  def new
    # Instanciate a new report to be modified and then created in the DB
    @project = Project.find(project_params[:project_id])
    @report  = Report.new
  end

  def create
    # Creates a new report in the DB, to be sent to the client
    @project = Project.find(project_params[:project_id])
    @report  = Report.new(client_email: report_params[:report_client_email], description: report_params[:report_description], report_topic: report_params[:report_topic])
    binding.pry
    if @report.save
      mail = ReportMailer.with(project: @project, content: @report.description).report
      mail.deliver_now
      redirect project_path(@project)
    else
      render :new
    end
  end

  private

  def project_params
    params.permit(:project_id)
  end

  def report_params
    params.permit(:report, :report_client_email, :report_description, :report_topic)
  end

end
