#!/usr/bin/env rake

desc "Runs foodcritic linter"
task :foodcritic do
  if Gem::Version.new("2.0.0") <= Gem::Version.new(RUBY_VERSION.dup)
    sh "foodcritic --tags ~FC001 --tags ~FC019 --tags ~FC048 ."
  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 2.0.0."
  end
end

task :default => 'foodcritic'
