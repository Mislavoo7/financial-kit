# lib/tasks/update_popularity.rake
namespace :names do
  desc "Update popularity scores from CSV data"
  task update_popularity: :environment do
    require 'csv'
    
    csv_path = Rails.root.join('firstnames.csv')
    updated_count = 0
    skipped_count = 0
    
    CSV.foreach(csv_path, headers: true, col_sep: ';') do |row|
      next if row[0].nil?
      
      name_value = row[0].strip
      
      # Collect all numeric values from country columns
      popularity_values = []
      row.headers[2..-1].each do |country|
        value = row[country]
        # Check if the value contains a number (including negative)
        if value.to_s =~ /-?\d+/
          # Extract the number and make it positive
          number = value.to_s.match(/-?\d+/)[0].to_i.abs
          popularity_values << number
        end
      end
      
      # Calculate average if we have values
      if popularity_values.any?
        average_popularity = (popularity_values.sum.to_f / popularity_values.size).round
        
        # Find and update the name
        name_record = Name.find_by(name: name_value)
        if name_record
          name_record.update!(popularity: average_popularity)
          updated_count += 1
       #   puts "Updated #{name_value}: popularity = #{average_popularity} (from values: #{popularity_values.join(', ')})"
        else
          skipped_count += 1
       #   puts "Skipped #{name_value}: not found in database"
        end
      end
    end
    
    puts "\n" + "="*50
    puts "Update finished!"
    puts "Names updated: #{updated_count}"
    puts "Names skipped: #{skipped_count}"
    puts "="*50
  end
end
