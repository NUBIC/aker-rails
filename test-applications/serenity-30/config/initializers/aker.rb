Aker.configure do
  portal :Serenity

  api_mode :http_basic

  authority Aker::Authorities::Static.from_file(File.expand_path("../../users.yml", __FILE__))
end
