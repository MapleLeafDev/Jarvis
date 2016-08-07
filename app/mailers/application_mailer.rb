class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  def social_medium_stats(to, user, stats)
    @to_addresses = to
    @from_address = "reports@ml-family.com"
    @subject = t('social_media_activity_subject', name: user.name)
    @stats = stats

    mail(:to => @to_addresses, :from => @from_address, :subject => @subject, :stats => @stats)
  end
end
