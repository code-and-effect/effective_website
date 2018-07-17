class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'

  layout 'mailer'

  def test_email
    mail(to: 'matthew@codeandeffect.com', subject: 'Active job and email systems functioning normally')
  end

  def test_exception
    raise 'this is an intention exception. An Active Job has raised this exception.'
  end

end
