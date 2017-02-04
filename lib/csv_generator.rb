class CsvGenerator < Struct.new(:records, :attributes)

  def export_csv
    CSV.generate(headers: true) do |csv|
      csv << attributes

      records.each do |record|
        csv << attributes.map{ |attr| record.send(attr) }
      end
    end
  end
end
