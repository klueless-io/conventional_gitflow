# frozen_string_literal: true

# (attribution) this code was based on:
# https://github.com/NARKOZ/git-revision/blob/master/lib/git-revision.rb

module ConventionalGitflow
  module Git
    class LastCommit
      include KUtil::Data::InstanceVariablesToH

      attr_accessor :branch
      attr_accessor :commit_message
      attr_accessor :commit_hash
      attr_accessor :commit_hash_short
      attr_accessor :author_name
      attr_accessor :author_email
      attr_accessor :authored_date
      attr_accessor :authored_time
      attr_accessor :commit_tag
      attr_accessor :repo_last_tag

      def initialize
        @branch             = `git rev-parse --abbrev-ref HEAD`.strip
        @commit_message     = `git log -1 --pretty="format:%s"`
        @commit_hash        = `git log -1 --pretty="format:%H"`
        @commit_hash_short  = `git log -1 --pretty="format:%h"`
        @author_name        = `git log -1 --pretty=format:"%an"`
        @author_email       = `git log -1 --pretty=format:"%ae"`
        @authored_date      = `git log -1 --pretty="format:%ad"`
        @authored_time      = `git log -1 --pretty="format:%at"`
        @commit_tag         = `git describe --exact-match #{@commit_hash}`.strip
        @repo_last_tag      = `git describe --tags --abbrev=0`.strip
      end
    end
  end
end
