require 'csv'

namespace :db do
  namespace :seed do
    desc "Import Maryland Total Residential Sales CSV"
    task :import_mtrs => :environment do

      filename = File.join(Rails.root, 'db', 'data_files', 'data.csv')
      CSV.foreach(filename, :headers => true) do |row|
        puts $. if $. % 10000 == 0
        values = {
          :year                 => row['year'],
          :geo_code             => row['geo_code'],
          :jurisdiction         => row['jurisdictions'],
          :zipcode              => row['zipcode'],
          :total_sales          => row['total_sales'],
          :median_value         => row['median_value'],
          :mean_value           => row['mean_value'],
          :sales_inside_pfa     => row['sales_inside_pfa'],
          :median_value_in_pfa  => row['median_value_in_pfa'],
          :mean_value_in_pfa    => row['mean_value_in_pfa'],
          :sales_outside_pfa    => row['sales_outside_pfa'],
          :median_value_out_pfa => row['median_value_out_pfa'],
          :mean_value_out_pfa   => row['mean_value_out_pfa'],
          :latitude             => row['latitude'],
          :longitude            => row['longitude']
        }
        SalesFigure.create(values)
      end
    end