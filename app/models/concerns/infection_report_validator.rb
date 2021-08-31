class InfectionReportValidator < ActiveModel::Validator
  def validate(record)
    survivor = record.survivor
    reporter = record.reporter
    errors = record.errors
    if survivor.present? && reporter.present?
      if survivor.infected?
        errors.add( :survivor,"Survivor already infected.")
        return
      end

      if reporter.infected?
        errors.add( :reporter, "Reporter must not be infected.")
        return
      end

      if reporter == survivor
        errors.add( :reporter,"Reporter can't report himself.")
        return
      end
      
      count=InfectionReport.where(survivor: survivor).where(reporter: reporter).count
      if count >= 1
        errors.add( :reporter,"a reporter can't report twice the same survivor.")
      end
    else
      errors.add(:reporter, "reporter does not exist") if reporter.nil?
      errors.add(:survivor, "survivor does not exist") if survivor.nil?
    end
  end
end