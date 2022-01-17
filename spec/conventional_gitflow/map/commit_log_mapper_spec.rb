# frozen_string_literal: true

require 'json'

RSpec.describe ConventionalGitflow::Map::CommitLogMapper do
  let(:instance) { described_class.new }

  let(:raw_commit_log_entries) { ConventionalGitflow::Git::CommitLog.new.call }

  describe '#map_entries' do
    subject { instance.map_entries(raw_commit_log_entries) }

    context 'when entire commit log' do
      it { 
        puts raw_commit_log_entries.first
        subject

        # puts subject.length
      }
    end
  end
end
