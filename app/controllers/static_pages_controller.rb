class StaticPagesController < ApplicationController
  skip_authorization_check # CanCanCan

  def home
    @page_title = 'Effective Website'
  end

  def exception
    raise 'this is an intentional exception'
  end
end
