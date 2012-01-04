Aker-Rails History
==================

3.0.2
-----

### Fixes

- CSRF token verification in Rails >= 3.0.4 is now properly handled (#4).

### Development

- Added missing LICENSE. Aker-Rails is made available under the MIT
  license.

3.0.1
-----

### Fixes

- Non-form UI modes can have their middleware correctly applied
  (#1). This requires a rearrangement of your application's
  configuration code; see the README for details.

### Development

- First open-source version.
- Project renamed from `bcsec-rails` to `aker-rails` to match the
  renaming of the main project.
- Switch integration test suite from Celerity to Mechanize. (#3931)
  This eliminates the JRuby dependency for integration testing.

Bcsec-Rails History
===================

3.0.0
-----

### Features

- Rails 3.0 support

2.0.0
-----

### Features

- Package bcsec-rails as a gem
- Namespace everything under `Bcsec::Rails`

### Development

- Full integrated test suite with cucumber, celerity, and a sample app
- Full API documentation
- Start tracking changes to the plugin
- Move to internal git repo
