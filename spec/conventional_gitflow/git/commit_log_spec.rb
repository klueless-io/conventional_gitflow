# frozen_string_literal: true

require 'json'

RSpec.describe ConventionalGitflow::Git::CommitLog do
  let(:instance) { described_class.new }

  describe '#call' do
    subject { instance.call }

    context 'when entire commit log' do
      it { puts subject.length }
    end
  end
end
