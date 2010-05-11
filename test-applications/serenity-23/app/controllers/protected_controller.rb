class ProtectedController < ApplicationController
  include Bcsec::SecuredController

  def authentication_only
  end
end
