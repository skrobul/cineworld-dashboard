namespace :cineworld do
    desc "Sends an email to all subscribers about new films"
    task :send_emails => [:environment] do
        @films =  Film.notification_candidates
        if @films.length > 0
            NotificationMailer.new_films_email(@films).deliver!
            @films.update_all(:notified => true)
        end
    end
end
