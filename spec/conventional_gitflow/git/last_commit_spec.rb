# frozen_string_literal: true

require 'json'

RSpec.describe ConventionalGitflow::Git::LastCommit do
  let(:instance) { described_class.new }

  describe '#initialize' do
    it do
      expect(instance.branch).not_to be_nil
      expect(instance.commit_message).not_to be_nil
      expect(instance.commit_hash).not_to be_nil
      expect(instance.commit_hash_short).not_to be_nil
      expect(instance.author_name).not_to be_nil
      expect(instance.author_email).not_to be_nil
      expect(instance.authored_date).not_to be_nil
      expect(instance.authored_time).not_to be_nil
      expect(instance.commit_tag).not_to be_nil
      expect(instance.repo_last_tag).not_to be_nil
    end
    it { puts JSON.pretty_generate(subject.to_h) }
  end
end
