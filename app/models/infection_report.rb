class InfectionReport < ApplicationRecord
    after_save :check_infection_report_count
    belongs_to :survivor, class_name: 'Survivor'
    belongs_to :reporter, class_name: 'Survivor'
    validates_with InfectionReportValidator

    private
    
    def check_infection_report_count
        count = InfectionReport.where(survivor: self.survivor).count
        if count == 5
            self.survivor.infected = true
            self.survivor.save
        end
    end

    
end
