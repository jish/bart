Gem::Specification.new do |s|
  s.name = "bart"
  s.version = "0.3.0"

  s.summary = "A ruby wrapper around the BART API."
  s.description = "Access the Bay Area Rapid Transit API in Ruby."
  s.homepage = "https://github.com/jish/bart"
  s.authors = ["Josh Lubaway"]
  s.email = "josh.lubaway@gmail.com"
  s.license = 'MIT'

  s.require_path = "lib"
  s.files = Dir["lib/**/*.rb"]

  s.add_dependency "nokogiri", "~> 1.6"
  s.add_development_dependency "fakeweb", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest", "~> 5.0"
end
