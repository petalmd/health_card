Gem::Specification.new do |s|

  s.name        = 'health_card'
  s.version     = '0.1.0'
  s.date        = '2017-02-05'
  s.summary     = 'Health card validations.'
  s.description = 'Services and validations related to government health cards.'
  s.authors     = ['Simon Bernier']
  s.email       = 'sbernier@petalmd.com'
  s.homepage    = 'http://github.com/petalmd/health_card'
  s.license     = 'MIT'

  s.files       = %w(
      lib/health_card.rb
      lib/health_card/string.rb
      lib/health_card/errors/no_validator_error.rb
      lib/health_card/validators/base_validator.rb
      lib/health_card/validators/canada/quebec_validator.rb
      lib/health_card/validators/canada/ontario_validator.rb
  )

  s.add_development_dependency 'rspec', ['~> 3.5']

end
