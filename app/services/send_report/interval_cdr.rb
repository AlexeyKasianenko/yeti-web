# frozen_string_literal: true

module SendReport
  class IntervalCdr < Base
    private

    def csv_data
      [
        CsvData.new(report.csv_columns, report.report_records)
      ]
    end

    def email_data
      [
        EmailData.new(email_columns, report.report_records)
      ]
    end

    def email_columns
      report.csv_columns
    end

    def email_subject
      'Interval CDR report'
    end
  end
end
