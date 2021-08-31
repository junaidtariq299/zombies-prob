class Api::V1::ReportsController < ApplicationController
    def index
        begin
            report = ReportService.new.create_report
            render json: { report: report }
        rescue => e
            render json: { error: true, message: e.message }
        end
    end
end