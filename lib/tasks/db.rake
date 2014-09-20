desc "load sample data to development env"
task "db:seed:dev" => :environment do
  load(File.join(Rails.root, 'db', 'seeds', 'development.rb'))
end

desc "drop existing development.sqlite3 and re-setup new one with seed"
task "db:dev" => :environment do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed:dev"].invoke
end
