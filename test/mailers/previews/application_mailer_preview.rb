# In Rails 4.1 and above, visit:
# http://localhost:3000/rails/mailers
# to see a preview of the following 3 emails:

class ApplicationMailerPreview < ActionMailer::Preview

  def test_email
    ApplicationMailer.test_email
  end

end
