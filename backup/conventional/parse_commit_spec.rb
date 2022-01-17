# frozen_string_literal: true

# require "json"
# require "conventional/utils"
# require "conventional/git/get_raw_commits"
# require "conventional/entities/commit"
# require "conventional/git/parse_commit"

# RSpec.describe Conventional::Git::ParseCommit do
#   let(:source) { Conventional::Git::GetRawCommits.new.call(from: from, path: path) }

#   let(:commits) { source.map { |raw_commit| described_class.new.call(raw_commit: raw_commit) } }
#   let(:dom) do
#     {
#       commits: source.map { |raw_commit| described_class.new.call(raw_commit: raw_commit).to_h }
#     }
#   end

#   subject { commits }

#   context "from is nil" do
#     let(:from) { nil }

#     context "path is nil" do
#       let(:path) { nil }

#       fit "executes git log command" do
#         # puts subject
#         puts JSON.pretty_generate(dom)
#       end
#     end

#     context "path is not nil" do
#       let(:path) { "spec/" }

#       it "executes git log command" do
#         # puts subject
#         puts JSON.pretty_generate(source)
#       end
#     end
#   end

# end
