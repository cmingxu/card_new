namespace :generate_rspec_for_existig do

  task :models => [:environment]  do
    Dir["#{Rails.root}/app/models/*"].each do |file|
      require file
    end
    (ActiveRecord::Base.send :subclasses).each do |model|
      ap model.to_s
      system "cd #{Rails.root} && rails generate model #{model.to_s}"
    end
  end

  task :controllers  => [:environment] do
    Dir["#{Rails.root}/app/controllers/*"].each do |file|
      require file
    end
    (ApplicationController.send :subclasses).each do |model|
      system "cd #{Rails.root} && rails generate controller #{model.to_s}"
    end

  end

end
