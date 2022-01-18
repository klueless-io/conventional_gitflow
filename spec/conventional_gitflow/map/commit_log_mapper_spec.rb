# frozen_string_literal: true

require 'json'

RSpec.describe ConventionalGitflow::Map::CommitLogMapper do
  include KLog::Logging

  let(:instance) { described_class.new }
  
  describe '#map' do
    context 'when raw_commit_log' do
      subject { instance.map(raw_commit_log) }
    
      context "is nil" do
        let(:raw_commit_log) { nil }

        it "raises error" do
          expect { subject }.to raise_error(ConventionalGitflow::MappingError, "Raw commit not provided as string")
        end
      end

      context "uses invalid format" do
        let(:raw_commit_log) { 'invalid format for a commit log' }

        it "raises error" do
          expect { subject }.to raise_error(ConventionalGitflow::MappingError, "Invalid raw commit format")
        end
      end

      context "has a header message" do
        let(:raw_commit_log) { sample_raw_commit(header: "Did the thing") }
      
        it "return valid commit" do
          is_expected.to have_attributes(
            class: ConventionalGitflow::Entities::Commit,
            header: "Did the thing",
            id: "a034f2b97fc4b50c48e9874809cc933b0a705989",
            body: nil,
            footer: nil,
            breaking_change: nil,
            type: nil,
            scope: nil,
            subject: nil,
            mentions: [],
            revert: nil
          )
        end
      end

      context "has a type" do
        let(:raw_commit_log) { sample_raw_commit(header: "feat: Did the thing") }
      
        it "return valid commit" do
          is_expected.to have_attributes(
            class: ConventionalGitflow::Entities::Commit,
            header: "feat: Did the thing",
            id: "a034f2b97fc4b50c48e9874809cc933b0a705989",
            body: nil,
            footer: nil,
            breaking_change: nil,
            type: "feat",
            scope: nil,
            subject: "Did the thing",
            mentions: [],
            revert: nil
          )
        end
      end

      context "has a type and scope" do
        let(:raw_commit_log) { sample_raw_commit(header: "feat(some scope): Did the thing") }
      
        it "return valid commit" do
          is_expected.to have_attributes(
            class: ConventionalGitflow::Entities::Commit,
            header: "feat(some scope): Did the thing",
            id: "a034f2b97fc4b50c48e9874809cc933b0a705989",
            body: nil,
            footer: nil,
            breaking_change: nil,
            type: "feat",
            scope: "some scope",
            subject: "Did the thing",
            mentions: [],
            revert: nil
          )
        end
      end

      context "has a breaking change token in header (!)" do
        let(:raw_commit_log) { sample_raw_commit(header: "feat(scope)!: Did the thing") }
      
        it "return valid commit" do
          is_expected.to have_attributes(
            class: ConventionalGitflow::Entities::Commit,
            header: "feat(scope)!: Did the thing",
            id: "a034f2b97fc4b50c48e9874809cc933b0a705989",
            body: nil,
            footer: nil,
            breaking_change: "Did the thing",
            type: "feat",
            scope: "scope",
            subject: "Did the thing",
            mentions: [],
            revert: nil
          )
        end
      end

      context "has a breaking change in the body" do
        let(:raw_commit_log) {
          sample_raw_commit(
            header: "feat(scope): Did the thing",
            lines: [
              "This is just a normal body",
              "BREAKING CHANGE:",
              "This is the breaking change"
            ]
          )
        }
      
        it "return valid commit" do
          is_expected.to have_attributes(
            class: ConventionalGitflow::Entities::Commit,
            header: "feat(scope): Did the thing",
            id: "a034f2b97fc4b50c48e9874809cc933b0a705989",
            body: "This is just a normal body",
            footer: "BREAKING CHANGE:\nThis is the breaking change",
            breaking_change: "This is the breaking change",
            type: "feat",
            scope: "scope",
            subject: "Did the thing",
            mentions: [],
            revert: nil
          )
        end
      end

      context "has a body with mentions" do
        let(:raw_commit_log) {
          sample_raw_commit(
            header: "feat(scope): Did the thing",
            lines: [
              "This is just a normal body",
              "",
              "with some extra lines for my boy @frank",
              "an extra @sinatra",
              ""
            ]
          )
        }
      
        it "return valid commit" do
          is_expected.to have_attributes(
            class: ConventionalGitflow::Entities::Commit,
            header: "feat(scope): Did the thing",
            id: "a034f2b97fc4b50c48e9874809cc933b0a705989",
            body: "This is just a normal body\nwith some extra lines for my boy @frank\nan extra @sinatra",
            footer: nil,
            breaking_change: nil,
            type: "feat",
            scope: "scope",
            subject: "Did the thing",
            mentions: ["frank", "sinatra"],
            revert: nil
          )
        end
      end
    
      context "has a revert in the body" do
        let(:raw_commit_log) {
          sample_raw_commit(
            header: 'revert: "This is the commit message for a previous commit"',
            lines: [
              "This reverts commit 123423135."
            ]
          )
        }

        it "return valid commit" do
          is_expected.to have_attributes(
            class: ConventionalGitflow::Entities::Commit,
            header: 'revert: "This is the commit message for a previous commit"',
            id: "a034f2b97fc4b50c48e9874809cc933b0a705989",
            body: "This reverts commit 123423135.",
            footer: nil,
            breaking_change: nil,
            type: "revert",
            scope: nil,
            subject: '"This is the commit message for a previous commit"',
            mentions: [],
            revert: have_attributes(
              class: ConventionalGitflow::Entities::Commit::Revert,
              header: "This is the commit message for a previous commit",
              id: "123423135"
            )
          )
        end
      end
    end
  end

  describe '#map_entries' do
    subject { instance.map_entries(raw_commit_log_entries) }

    let(:raw_commit_log_entries) { ConventionalGitflow::Git::CommitLog.new.call }

    context 'when entire commit log' do
      it { 
        log.structure({ log: subject })
        # # puts raw_commit_log_entries.first
        # puts '--------------------------------------------------'
        # puts JSON.pretty_generate(subject[0].to_h)
        # puts '--------------------------------------------------'
        # puts JSON.pretty_generate(subject[1].to_h)
        # puts '--------------------------------------------------'
        # puts JSON.pretty_generate(subject[2].to_h)
        # puts subject.length
      }
    end
  end
end

# Produces a sample raw_commit in the following format:
#   a034f2b97fc4b50c48e9874809cc933b0a705989
#   <header>
#   <body (multiple lines)>
def sample_raw_commit(header:, lines: [])
  components = []

  components << "a034f2b97fc4b50c48e9874809cc933b0a705989"
  components << header
  components.concat(lines)
  components.join("\n") + "\n"
end
