class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'

  layout 'mailer'

  def test_email
    mail(to: 'developer@example.com', subject: 'Active job and email systems functioning normally')
  end

  def test_exception
    raise 'this is an intention exception. An Active Job has raised this exception.'
  end

  def user_invited_to_client(user_id, client_id)
    @user = User.find_by_id(user_id)
    @client = Client.find_by_id(client_id)

    return false unless @user && @client && @user.email

    mail(to: @user.email, subject: "Added to #{@client}")
  end

end
