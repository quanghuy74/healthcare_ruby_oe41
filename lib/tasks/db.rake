namespace :db do
  desc "Remake database"
  task remake_db: :environment do
    %w(db:reset db:migrate db:seed).each do |task|
      Rake::Task[task].invoke
    end
  end
end
