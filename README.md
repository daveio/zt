# zt

Utilities and glue to make working with ZeroTier networks a bit more
friendly

[![gem version][img-badge-gem]][link-badge-gem]

This document assumes a UNIX-like operating system.

For the vast majority of people, that means Linux, *BSD, and macOS.

It might work with Windows, but Ruby on Windows is an adventure in
itself so I'm afraid you're on your own. If you're stuck with Windows,
try setting one of the [Windows Subsystem for Linux][link-wsl] sandboxes
up - they work surprisingly well.

## Installation

At this point, `zt` is intended as a command-line tool first and a
library second (if at all). As such, instructions for usage with Bundler
or similar are not given.

If `zt` becomes useful as a library, instructions will be provided, and
if you want to try using it as a library anyway, then best of luck to
you.

`zt` can be installed with RubyGems, and is published to the default
repository. Simply install it like any other gem.

```bash
gem install zt
```

Depending on how your Ruby installation is set up, you may need to
install it as a superuser. If you're not sure, and if commands like
`rvm`, `rbenv`, and/or `ruby-build` don't ring any bells, you probably
need to install as a superuser using `sudo`.

```bash
sudo gem install zt
```

## Usage

<!-- TODO: the bit we're all here to see in the first place -->

## Development

- Fork the repository on GitHub.
  -  ![gem version][img-fork_button]
-  Check out your fork.
   -  `git clone https://github.com/yourusername/zt`
-  Enter the checkout directory.
   - `cd zt`
- Install dependencies.
  - `bin/setup`
- Run the tests.
  - `rake spec`
- Make a new branch for your feature.
  - `git branch your-amazing-new-feature`
- Check out your new branch.
  - `git checkout your-amazing-new-feature`
- Hack away.
  - `(you have to come up with this bit yourself)`
- Make sure you add tests for your work.
  - `(this bit is boring but REALLY IMPORTANT)`
- Make sure all the tests pass, both old and new.
  - `rake spec`
- Commit and push your now-tested work to your fork.
  - `git commit && git push origin your-amazing-new-feature`
- Open a pull request and wait for a response.

**PROTIP:** You can also run `bin/console` for an interactive prompt
that will allow you to experiment.

The [Bundler guide to gem development][link-bundler-guide] may be
helpful if this is your first gem. It certainly helped me.

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
[link-mitlic]: https://opensource.org/licenses/MIT
[link-bundler-guide]: https://bundler.io/v2.0/guides/creating_gem.html
[link-badge-gem]: https://badge.fury.io/rb/zt
[link-wsl]: https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux
[img-badge-gem]: https://badge.fury.io/rb/zt.svg
[img-fork_button]: https://zt.dave.io/images/fork_button.png
