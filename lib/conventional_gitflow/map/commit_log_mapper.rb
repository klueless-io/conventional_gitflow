# frozen_string_literal: true

module ConventionalGitflow
  module Map
    class CommitLogMapper
      # feat: what she said                   type: feat, scope:      ,subject: what she said
      # feat(xmen): what she said             type: feat, scope: xmen , subject: what she said
      # feat(ouch)!: what she said            type: feat, scope: ouch , subject: what she said, breaking: true, breaking_change: what she said
      HEADER_PATTERN = /^(?<type>\w*)(?:\((?<scope>.*)\))?(?<breaking>!?): (?<subject>.*)$/i.freeze
      BREAKING_CHANGE_BODY_PATTERN = /^[\\s|*]*(?:BREAKING CHANGE)[:\\s]+(?<contents>.*)/.freeze
      REVERT_PATTERN = /^(?:Revert|revert:)\s"?(?<header>[\s\S]+?)"?\s*This reverts commit (?<id>\w*)\./i.freeze
      MENTION_PATTERN = /@([\w-]+)/.freeze

      def map_entries(commit_log_entries)
        commit_log_entries.map { |commit_log_entry| map(commit_log_entry) }
      end

      def map(raw_commit_log)
        raise ConventionalGitflow::MappingError, 'Raw commit not provided as string' unless raw_commit_log.is_a?(String)

        id, header, *lines = trim_new_lines(raw_commit_log).split(/\r?\n+/)

        raise ConventionalGitflow::MappingError, 'Invalid raw commit format' if id.nil? || header.nil?

        commit_hash = build_commit(id, header, lines, raw_commit_log)

        ConventionalGitflow::Entities::Commit.new(commit_hash)
      end

      private

      def build_commit(id, header, lines, raw_commit_log)
        commit = {
          id: id,
          **split_header(header),
          **parse_content(lines),
          header: header,
          mentions: match_mentions(raw_commit_log),
          revert: match_revert(raw_commit_log)
        }

        commit[:breaking] = true if commit[:breaking_change]
        commit[:breaking_change] = commit[:subject] if commit[:breaking_change].nil? && commit[:breaking]
        commit[:subject] = commit[:header] if commit[:subject].nil?
        commit
      end

      def split_header(header)
        match = header.match HEADER_PATTERN
        {
          type: match ? match[:type] : nil,
          scope: match ? match[:scope] : nil,
          subject: match ? match[:subject] : nil,
          breaking: match ? match[:breaking] == '!' : false
        }
      end

      def parse_content(lines)
        contents = {
          body: nil,
          footer: nil,
          breaking_change: nil
        }

        initial_state = {
          continue_breaking_change: false
        }
        contents, = lines.reduce([contents, initial_state]) do |input, line|
          acc, state = input
          next process_line(line, acc, state)
        end

        # contents[:breaking_change] ||= match_breaking_change_header(header)

        contents.transform_values { |v| trim_new_lines(v) }
      end

      def process_line(line, contents, state)
        contents[:breaking_change] ||= match_breaking_change_body(line)

        if contents[:breaking_change]
          contents[:breaking_change] = append(contents[:breaking_change], line) if state[:continue_breaking_change]

          state[:continue_breaking_change] = true
          contents[:footer] = append(contents[:footer], line)
          return [contents, state]
        end

        contents[:body] = append(contents[:body], line)

        [contents, state]
      end

      def match_breaking_change_body(line)
        match = line.match BREAKING_CHANGE_BODY_PATTERN
        match[:contents] || '' if match
      end

      # def match_breaking_change_header(header)
      #   match = header.match BREAKING_CHANGE_HEADER_PATTERN
      #   match[:subject] if match
      # end

      def match_mentions(raw_commit)
        raw_commit.scan(MENTION_PATTERN).flatten.uniq
      end

      def match_revert(raw_commit)
        match = raw_commit.match REVERT_PATTERN
        return unless match

        {
          header: match[:header],
          id: match[:id]
        }
      end

      def append(src, line)
        return line unless src

        "#{src}\n#{line}"
      end

      def trim_new_lines(raw)
        raw&.gsub(/\A(?:\r\n|\n|\r)+|(?:\r\n|\n|\r)+\z/, '')
      end
    end
  end
end
