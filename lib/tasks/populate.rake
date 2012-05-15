# encoding: utf-8

# bundle exec rake db:populate

unless Rails.env.production?
  
  require 'factory_girl_rails'

  namespace :db do
  
    desc "Fill database with sample data"
    task :populate => :environment do
    
      if Rails.env.development?
    
        Rake::Task['db:reset'].invoke
    
        user = User.create!(  :email => 'nicolas@gouv.fr',
                              :nickname => 'nain', 
                              :lastname => 'SARKOZY', 
                              :firstname => 'Nicolas')

        puts "create le nain" 

        user = User.create!(  :email => 'françois@gouv.fr', 
                              :nickname => 'flanby',
                              :lastname => 'HOLLANDE', 
                              :firstname => 'François')
                      
        puts "create flanby"

      end
    end
  end
end