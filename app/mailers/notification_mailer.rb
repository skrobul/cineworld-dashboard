class NotificationMailer < ActionMailer::Base
  default from: "kino@skrobul.com"

  def new_films_email(films)
    @films = films
    recipients = [
        #'alicja.kielbasa@gmail.com'
        'skrobul@skrobul.com',
    ]
    recipients.each do |recipient|
        mail(to: recipient, subject: "Nowe filmy: #{Date.today}")
    end
  end
end
