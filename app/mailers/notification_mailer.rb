class NotificationMailer < ActionMailer::Base
  default from: "kino@skrobul.com"

  def new_films_email(films)
    @films = films
    puts "Processing notifications for #{films.count} new films"
    recipients = [
        'alicja.kielbasa@gmail.com',
        'skrobul@skrobul.com',
    ]
    recipients.each do |recipient|
        puts "Sending notification email to: #{recipient}"
        mail(to: recipient, subject: "Nowe filmy: #{Date.today}")
    end
  end
end
