Sidekiq.configure_server do |config|
    # config.on(:startup) do
    #   schedule_file = "config/users_schedule.yml"
  
    #   if File.exist?(schedule_file)
    #     Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    #   end
    # end
    Sidekiq::Cron::Job.create(name: 'Delete expired - every 5min', cron: '*/5 * * * *', class: 'DeleteExpiredJob')
  end