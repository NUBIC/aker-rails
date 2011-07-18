Aker-Rails
===========

`aker-rails` is the Rails plugin for Aker 3.0 and later.  It is a
thin wrapper around Aker's rack support.

There are separate plugins for Rails 3.x and Rails 2.3.x. You're
looking at the version for **Rails 2.3.x**. The version for Rails 3.x
has a version number with major version 3.

Setup
-----

### Prerequisites

`aker-rails` requires Rails ~> 2.3.5.

Since `aker-rails` is just a thin wrapper, you'll want to be familiar
with [Aker][] before you get started.

[Aker]: http://rubydoc.info/github/NUBIC/aker/master/file/README.md

### Get the gem

`aker-rails` is a gem plugin.  In order to use it, either install the
gem at the system level or (better) include it in your bundler-using
application's Gemfile.

#### Okay

    !!!plain
    $ gem install aker-rails

#### Better

    # in your Gemfile
    gem 'aker-rails', '~> 2.0'

### Add it to the application

Next, configure the gem into your Rails application's environment.
(This is necessary for gem plugins even if you are using bundler.)

    # In config/environment.rb's initializer block
    config.gem "aker-rails", :lib => 'aker/rails', :version => '~> 2.0'

### Add an initializer for aker

Put your global configuration in an initializer. By _global
configuration_ I mean the parts that are the same no matter which
environment you are using, like the portal name and the modes.  (N.b.:
You have to put it in an initializer &mdash; if you just put it at the
end of `config/environment.rb` it won't work.)

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
env-specific. E.g., the LDAP server you use in production might not be
visible from your workstation. This means that the `authorities` line
will be env-specific.

    # In config/environments/production.rb, for example
    config.after_initialize do
      Aker.configure do
        # The authorities to use.  See the aker API documentation
        # for `Aker::Authorities` for options.
        authorities :ldap

        # The server-central parameters file for authority
        # and policy parameters (optional). See
        # `Aker::CentralParameters` for a discussion of why this is a
        # good idea.
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

    class ManuscriptController < ActionController::Base
      include Aker::Rails::SecuredController
      permit :editor
    end

### Partial authorization

Aker also supports resources which are only partially limited to a
particular group or groups.  The helper for this is also called
{Aker::Rails::Application#permit? permit}:

    # In a controller action
    class DashboardController < ActionController::Base
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

This permit helper is available to all controllers and views, not just
ones that mix in {Aker::Rails::SecuredController}.  This means you
can have a publically-accessible page which has additional/different
content for a logged-in user.

### The current user

Aker provides a method {Aker::Rails::Application#current_user
current_user} to all controllers and views.  It will return a
{Aker::User} object for the current user, or `nil` if there isn't
one.
