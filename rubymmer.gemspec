# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "rubymmer"
  s.summary = "Insert Rubymmer summary."
  s.description = "Insert Rubymmer description."
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.version = "0.0.1"
  s.author = 'Kennet Calamay'
  s.email = 'kenneth@proudcloud.net'
  s.homepage = 'https://github.com/kennethcalamay/rubymmer'
  s.rubyforge_project = 'http://rubyforge.org/projects/rubymmer/'
end
