namespace :pricing do
  desc "TODO"
  task fetch_and_save_data: :environment do
    puts "fetching data"
    PricingService.fetch_and_save_data()
    puts "#{Time.now} — Success!"
  end

end
