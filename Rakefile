# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "white"
  gem.homepage = "http://github.com/andreyvit/white"
  gem.license = "MIT"
  gem.summary = %Q{Fix whitespace errors before committing to Git}
  gem.description = %Q{Run from your project folder before committing to Git to avoid whitespace errors}
  gem.email = "andreyvit@gmail.com"
  gem.authors = ["Andrey Tarantsov"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new
