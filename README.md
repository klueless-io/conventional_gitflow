# FlowingGit
# GitFlowed
# GitFlowing
# ContinuousGit
# GitCi

  ## Conventional commits
  ## Automated SemVer
  ## Automatic ChangeLog

# Conventional Gitflow

> Conventional Gitflow provides tools for conventional git workflows including changelogs and SemVer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'conventional_gitflow'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install conventional_gitflow
```

## Stories

### Main Story

As a Developer, I want to use conventional commits, so that I can build conventional git based workflows such as SemVer and ChangeLogs

See all [stories](./STORIES.md)


## Usage

See all [usage examples](./USAGE.md)



## Development

Checkout the repo

```bash
git clone https://github.com/klueless-io/conventional_gitflow
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

```bash
bin/console

Aaa::Bbb::Program.execute()
# => ""
```

`conventional_gitflow` is setup with Guard, run `guard`, this will watch development file changes and run tests automatically, if successful, it will then run rubocop for style quality.

To release a new version, update the version number in `version.rb`, build the gem and push the `.gem` file to [rubygems.org](https://rubygems.org).

```bash
rake publish
rake clean
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/klueless-io/conventional_gitflow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Conventional Gitflow project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/klueless-io/conventional_gitflow/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) David Cruwys. See [MIT License](LICENSE.txt) for further details.
