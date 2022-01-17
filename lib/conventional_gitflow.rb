# frozen_string_literal: true

require 'k_util'

require 'conventional_gitflow/version'
require 'conventional_gitflow/current_commit'

module ConventionalGitflow
  # raise ConventionalGitflow::Error, 'Sample message'
  Error = Class.new(StandardError)

  # Your code goes here...
end

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = 'ConventionalGitflow::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('conventional_gitflow/version') }
  version   = ConventionalGitflow::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
