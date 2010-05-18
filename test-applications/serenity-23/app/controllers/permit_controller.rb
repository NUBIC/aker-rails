class PermitController < ApplicationController
  include Bcsec::Rails::SecuredController

  permit :owners

  def owners_only
  end
end
