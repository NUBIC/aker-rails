Aker-Rails History
==================

2.0.2
-----

### Development

- First open-source version.
- Project renamed from `bcsec-rails` to `aker-rails` to match the
  renaming of the main project.
- Switch integration test suite from Celerity to Mechanize. (#3931)
  This eliminates the JRuby dependency for integration testing.

Bcsec-Rails History
===================

2.0.1
-----

### Fixed

- The bcsec middleware is no longer appended to the stack multiple
  times when class reloading is active. (#4486)

### Development

- Use bundler 1.0. (#3930)
- CI builds use most-recent-available gems for all dependencies,
  including prerelease versions of bcsec. (#4422, #4427)

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
