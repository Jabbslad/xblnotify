class Notifier < ActionMailer::Base
  
  def status_notification(msg)
    recipients ["jabbslad@gmail.com"]
    from       "jabbslad@gmail.com"
    subject    "#{msg}"
    sent_on     Time.now
  end

end
