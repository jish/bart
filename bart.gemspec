Gem::Specification.new do |s|
  s.name = "bart"
  s.version = "0.0.1"
  s.date = "2010-11-13"

  s.summary = "A ruby wrapper around the BART API."
  s.homepage = "https://github.com/jish/bart"
  s.authors = ["Josh Lubaway"]
  s.email = "josh.lubaway@gmail.com"

  s.require_path = "lib"
  s.files = Dir["lib/**/*.rb"]
  s.add_dependency "nokogiri"
end
