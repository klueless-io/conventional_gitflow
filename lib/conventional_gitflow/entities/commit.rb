# frozen_string_literal: true

# (attribution) this code was based on:
# https://github.com/dabarrell/conventional/blob/master/lib/conventional/entities/commit.rb

require 'dry-struct'
require 'conventional_gitflow/types'

module ConventionalGitflow
  module Entities
    # TODO: rename to ConventionalCommit
    class Commit < Dry::Struct
      class Revert < Dry::Struct
        attribute :header, Types::String
        attribute :id, Types::String
      end

      # WHY:
      # Automatically generating CHANGELOGs.
      # Automatically determining a semantic version bump (based on the types of commits landed).
      # Communicating the nature of changes to teammates, the public, and other stakeholders.
      # Triggering build and publish processes.
      # Making it easier for people to contribute to your projects, by allowing them to explore a more structured commit history.
      # Need to add support for trailers

      # FORMAT
      # https://cdn.hashnode.com/res/hashnode/image/upload/v1577374984862/Q7QGKgtEB.png?auto=compress

      attribute :id, Types::String
      # fix: a commit of the type fix patches a bug in your codebase (affects PATCH#)
      # feat: a commit of the type feat introduces a new feature to the codebase (affects MINOR#)
      # feat!: send an email to the customer when a product is shipped (SEE: The ! next to feat)
      # style: Feature and updates related to styling ()
      # cop: Feature and updates related to styling ()
      # refactor: Refactoring a specific section of the codebase
      # test: Everything related to testing
      # docs: Everything related to documentation
      # chore: Regular code maintenance.[ You can also use emojis to represent commit types]

      # or
      # BREAKING CHANGE: a commit that has a footer BREAKING CHANGE:, or appends a ! after the type/scope, introduces a breaking API change (affects MAJOR!). A BREAKING CHANGE can be part of commits of any type.
      attribute :type, Types::String.optional
      # A scope may be provided to a commit’s type, to provide additional contextual information and is contained within parenthesis, e.g., feat(parser): add ability to parse arrays
      # A scope MUST consist of a noun describing a section of the codebase surrounded by parenthesis, e.g., fix(parser):
      attribute :scope, Types::String.optional
      # Do not end the subject line with a period
      # Capitalize the subject line and each paragraph
      attribute :subject, Types::String.optional
      attribute :header, Types::String # full_message
      attribute :body, Types::String.optional
      attribute :footer, Types::String.optional
      attribute :breaking, Types::Bool.optional.default(false)
      # feat: allow provided config object to extend other configs

      # BREAKING CHANGE: `extends` key in config file is now used for extending other config files
      attribute :breaking_change, Types::String.optional
      attribute :mentions, Types::Array.of(Types::Coercible::String)
      attribute :revert, Revert.optional
    end
  end
end
