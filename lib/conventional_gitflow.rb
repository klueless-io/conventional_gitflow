# frozen_string_literal: true

require 'k_log'
require 'k_util'

require 'conventional_gitflow/version'
require 'conventional_gitflow/git/last_commit'
require 'conventional_gitflow/git/commit_log'
require 'conventional_gitflow/map/commit_log_mapper'
require 'conventional_gitflow/entities/commit'

module ConventionalGitflow
  # raise ConventionalGitflow::Error, 'Sample message'
  # Error = Class.new(StandardError)
  MappingError = Class.new(StandardError)

  # Your code goes here...
end

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'ConventionalGitflow::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('conventional_gitflow/version') }
  version   = ConventionalGitflow::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
