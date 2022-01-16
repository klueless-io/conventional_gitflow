# frozen_string_literal: true

RSpec.describe ConventionalGitflow do
  it "has a version number" do
    expect(ConventionalGitflow::VERSION).not_to be nil
  end

  it "has a standard error" do
    expect { raise ConventionalGitflow::Error, "some message" }
      .to raise_error("some message")
  end
end
