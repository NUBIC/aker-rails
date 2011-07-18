class PermitController < ApplicationController
  include Aker::Rails::SecuredController

  permit :owners

  def owners_only
  end
end
