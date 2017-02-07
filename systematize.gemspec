require File.expand_path("../lib/systematize/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name                   = 'systematize'
  spec.version                = Systematize::VERSION
  spec.date                   = Date.today.to_s
  spec.license                = 'MIT'
  spec.required_ruby_version  = '>= 1.9.3'
  spec.files                  = Dir['LICENSE.md', 'README.md', 'lib/**/*']
  spec.test_files             = Dir['spec/**/*']
  spec.require_paths          = ['lib']

  spec.summary                = "Structure and data migrations as one"
  spec.description            = "Systematize will order your data and struture migrations so you don't have to think which one to run first."

  spec.authors                = ['Ricardo Brazão']
  spec.email                  = ['ricardo.p.brazao@gmail.com']
  spec.homepage               = 'http://github.com/RicardoBrazao/systematize'

  spec.add_dependency('activerecord', '>= 3.2')
  spec.add_dependency('railties', '>= 3.2')

  spec.add_development_dependency('pry')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('sqlite3')

end