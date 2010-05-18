class ProtectedController < ApplicationController
  include Bcsec::Rails::SecuredController

  def authentication_only
  end
end
