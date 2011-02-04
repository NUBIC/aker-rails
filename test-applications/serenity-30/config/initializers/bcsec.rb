Bcsec.configure do
  portal :Serenity

  api_mode :http_basic

  authority Bcsec::Authorities::Static.from_file(File.expand_path("../../users.yml", __FILE__))
end
