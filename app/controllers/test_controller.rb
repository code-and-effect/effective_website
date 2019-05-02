class TestController < ApplicationController
  skip_authorization_check # CanCanCan

  def exception
    raise 'this is an intentional exception'
  end

  def email
    ApplicationMailer.test_email().deliver_later
    ApplicationMailer.test_exception().deliver_later
    
    flash[:success] = 'Successfully queued test emails for deliver_later'

    redirect_to root_path
  end

end
