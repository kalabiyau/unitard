Gem::Specification.new do |s|
  s.name = 'unitard'
  s.version = '0.1.0'
  s.authors = %w{ KalabiYau }
  s.date = '2013-07-05'
  s.description = 'allow you to limit troughput of via particular interface'
  s.email = 'skullzeek@gmail.com'
  s.executables = %w{ unitard }
  s.extra_rdoc_files = %w{ LICENSE.txt README.markdown }
  s.files = %w{ bin/unitard lib/unitard.rb }
  s.homepage = 'http://github.com/kalabiyau/unitard'
  s.licenses = %w{ MIT }
  s.require_paths = %w{ lib }
  s.rubygems_version = '2.0.3'
  s.summary = 'simple trafic shaper for MacOS'
  s.add_dependency 'thor', '~> 0.18.1'
end

