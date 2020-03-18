# http://localhost:3000/rails/mailers

class DeviseMailerPreview < ActionMailer::Preview
  def self.devise?(devise_module)
    (@devise_modules ||= User.new().devise_modules).include?(devise_module)
  end

  TOKEN = '0211$0x1sy2'

  if devise?(:confirmable)
    def confirmation_instructions
      Devise::Mailer.confirmation_instructions(User.first, TOKEN)
    end
  end

  if devise?(:invitable)
    def invitation_instructions
      Devise::Mailer.invitation_instructions(User.first, TOKEN)
    end
  end

  if devise?(:lockable)
    def unlock_instructions
      Devise::Mailer.unlock_instructions(User.first, TOKEN)
    end
  end

  if devise?(:recoverable)
    def password_change
      Devise::Mailer.password_change(User.first)
    end

    def reset_password_instructions
      Devise::Mailer.reset_password_instructions(User.first, TOKEN)
    end
  end

end
