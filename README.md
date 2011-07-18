Aker-Rails
===========

`aker-rails` is the Rails plugin for Aker 2.1 and later.  It is a
thin wrapper around Aker's rack support.

Setup
-----

### Prerequisites

`aker-rails` requires Rails ~> 3.0.

### Get the gem

`aker-rails` is a gem plugin.  In order to use it, include it in your
application's Gemfile:

    source 'http://download.bioinformatics.northwestern.edu/gems'

    gem 'aker-rails'

Between this and the `Bundler.require` that most Rails 3 applications do
as part of their initialization process, that's all you usually need to
do to get aker and aker-rails loaded in your Rails application.

### Add an initializer for aker

Put your global configuration in an initializer. By _global
configuration_ I mean the parts that are the same no matter which
environment you are using, like the portal name and the modes.

    # In config/initializers/aker.rb
    Aker.configure do
      # The authentication protocol to use for interactive access.
      # `:form` is the default.
      ui_mode :form

      # The authentication protocol(s) to use for non-interactive
      # access.  There is no default.
      api_mode :http_basic

      # The portal to which this application belongs.  Optional.
      portal :ENU
    end

For more information on the configuration syntax and options, see the
aker API documentation for {Aker::Configuration}.

### Add per-environment configurations

In the environment initializer for each of your application's
environments, put the parts of the Aker configuration which are
env-specific.  E.g., you might only use the `netid` authority in staging
and production since full access to the NU LDAP servers is only
available from behind the firewall.  This means that the `authorities`
line will be env-specific.

    # In config/environments/production.rb, for example
    config.after_initialize do
      Aker.configure do
        # The authorities to use.  See the aker API documentation
        # for `Aker::Authorities` for options.
        authorities :netid, :pers

        # The server-central parameters file for cc_pers, NU LDAP,
        # CAS, and policy parameters.
        central '/etc/nubic/aker-prod.yml'
      end
    end

Integration into your app
-------------------------

With the plugin installed, Aker provides a general infrastructure for
supporting authentication and authorization in your application.  If
you want to _require_ authentication or authorization for particular
resources (and I think you do), you need to do a bit more
configuration.

### Securing pages

In any controller which authentication is required, include
{Aker::Rails::SecuredController}.  If authentication is required for
all controllers, you can include this module in
`ApplicationController`.

If you want to further require that all actions in a controller
require that the user be a member of a certain group, you can use the
{Aker::Rails::SecuredController::ClassMethods#permit permit} method:

    class ManuscriptController < ApplicationController
      include Aker::Rails::SecuredController
      permit :editor
    end

### Partial authorization

Aker also supports resources which are only partially limited to a
particular group or groups.  The helper for this is also called
{Aker::Rails::Application#permit? permit}:

    # In a controller action
    class DashboardController < ApplicationController
      # ...
      def index
        if permit?(:editor)
          @manuscripts = Manuscript.all
        end
      end
    end

    # Or in a view
    <%= permit?(:editor) do %>
       @manuscripts.collect { |m| m.title }.join(', ')
    <% end %>

This permit helper is available to all subclasses of
`ApplicationController`, not just ones that mix in
{Aker::Rails::SecuredController}.  This means you can have a
publically-accessible page which has additional/different content for a
logged-in user.

### The current user

Aker provides a method {Aker::Rails::Application#current_user
current_user} to all controllers and views.  It will return a
{Aker::User} object for the current user, or `nil` if there isn't
one.

### Overriding the unauthorized view

The message that your users will see if they try to access a resource
for which they don't have sufficient privileges is pretty spare and
unfriendly.  Applications can replace it with something prettier and
application-appropriate via rack middleware which intercepts 403
responses.  (TODO: more details and an example.)

### Overriding the login and logout views

You can supply custom login and logout views by providing routes for `/login`
and `/logout`:

    # In config/routes.rb
    match '/login' => 'accounts#login'
    match '/logout' => 'accounts#logout'

Aker will now use the views provided by `AccountsController#login` and
`AccountsController#logout`; however, credential verification and session
management is still performed by Aker.

When overriding the login view, you are responsible for providing a login form
that satisfies the interface for Aker's credential verifier.  Your login form
should, at minimum, look like this:

    # In app/views/accounts/login.html.erb
    <%= form_tag('/login') do %>
      <%= text_field_tag "username" %>
      <%= password_field_tag "password" %>
      <%= submit_tag %>
    <%= end %>

If you want to carry attempted paths across multiple login attempts, you'll
also need a field for storing a `url` parameter.
