namespace :cineworld do    
    desc "Sends an email to all subscribers about new films"
    task :send_emails => [:environment] do
        @films =  Film.where(notified: false)
        NotificationMailer.new_films_email(@films).deliver
    end
end