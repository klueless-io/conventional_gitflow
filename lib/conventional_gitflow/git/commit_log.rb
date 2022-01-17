# frozen_string_literal: true

# (attribution) this code was based on:
# https://github.com/dabarrell/conventional/blob/master/lib/conventional/git/get_raw_commits.rb

module ConventionalGitflow
  module Git
    class CommitLog
      DELIMITER = '**** ---- ****'
      FORMAT = '%H%n%B'

      def call(from: nil, path: nil)
        build_cmd = ['git log --date=short']
        build_cmd << %(--format="#{FORMAT}%n#{DELIMITER}")
        build_cmd << [from, 'HEAD'].filter { |s| !s.nil? }.join('..')
        build_cmd << "-- #{path}" if path

        cmd = build_cmd.join(' ')

        KUtil.open3
             .capture2(cmd)
             .split("#{DELIMITER}\n")
      end
    end
  end
end
