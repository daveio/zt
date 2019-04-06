# zt

Utilities and glue to make working with ZeroTier networks a bit more
friendly

## Installation

At this point, `zt` is intended as a command-line tool first and a
library second (if at all). As such, instructions for usage with Bundler
or similar are not given.

If `zt` becomes useful as a library,
instructions will be provided, and if you want to try using it as a
library anyway, then best of luck to you.

`zt` can be installed with RubyGems, and is published to the default
repository. Simply do

```bash
gem install zt
```

to make the `zt` command available. Depending on your Ruby setup, you
may need to install it as a superuser, with

```bash
sudo gem install zt
```

instead.

## Usage

TODO: Usage details

## Development

- Fork the repository on GitHub.
  -  
-  Check out the repository.
   -  `git clone https://github.com/daveio/zt`
-  Enter the checkout directory.
   - `cd zt`
- Install dependencies.
  - `bin/setup`
- Run the tests.
  - `rake spec`
- Make a new branch for your feature.
  - git branch

to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the
`.gem` file to [rubygems.org][link-rubygems].

## Contributing

Bug reports and pull requests are welcome [on GitHub][link-repo]. This
project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [code of conduct][link-coc].

## License

The gem is available as open source under the terms of the
[MIT License][link-mitlic].

## Code of Conduct

Everyone interacting in the zt project’s codebases, issue trackers, chat
rooms, and mailing lists, including the original author, is expected to
follow the [code of conduct][link-coc].

[link-repo]: https://github.com/daveio/zt
[link-coc]: https://github.com/daveio/zt/blob/master/CODE_OF_CONDUCT.md
[link-cocov]: http://contributor-covenant.org
[link-mitlic]: https://opensource.org/licenses/MIT
[link-rubygems]: https://rubygems.org
