class ProtectedController < ApplicationController
  include Aker::Rails::SecuredController

  def authentication_only
  end
end
