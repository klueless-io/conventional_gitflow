# frozen_string_literal: true

# require "json"
# require "conventional/utils"
# require "conventional/git/get_raw_commits"

# RSpec.describe Conventional::Git::GetRawCommits do
#   let(:instance) { described_class.new.call(from: from, path: path) }

#   subject { { commits: instance } }

#   context "from is nil" do
#     let(:from) { nil }

#     context "path is nil" do
#       let(:path) { nil }

#       it "executes git log command" do
#         puts JSON.pretty_generate(subject)
#       end
#     end

#     context "path is not nil" do
#       let(:path) { "spec/" }

#       it "executes git log command" do
#         puts JSON.pretty_generate(subject)
#       end
#     end
#   end

# end
