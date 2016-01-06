# RSpec Matcher `define_constant(constant_name).of_type(Type)`

[![Gem Version](https://badge.fury.io/rb/rspec_matcher_define_constant.svg)](http://badge.fury.io/rb/rspec_matcher_define_constant)
[![Code Climate GPA](https://codeclimate.com/github/pekhee/rspec_matcher_define_constant.svg)](https://codeclimate.com/github/pekhee/rspec_matcher_define_constant)
[![Code Climate Coverage](https://codeclimate.com/github/pekhee/rspec_matcher_define_constant/coverage.svg)](https://codeclimate.com/github/pekhee/rspec_matcher_define_constant)
[![Gemnasium Status](https://gemnasium.com/pekhee/rspec_matcher_define_constant.svg)](https://gemnasium.com/pekhee/rspec_matcher_define_constant)
[![Travis CI Status](https://secure.travis-ci.org/pekhee/rspec_matcher_define_constant.svg)](https://travis-ci.org/pekhee/rspec_matcher_define_constant)

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [Tests](#tests)
- [Versioning](#versioning)
- [Code of Conduct](#code-of-conduct)
- [Contributions](#contributions)
- [License](#license)
- [History](#history)
- [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

# Features
Makes sure block defines a constant and removes the constant after block is done.

# Requirements

0. [MRI 2.x](https://www.ruby-lang.org)
1. [RSpec 3.x](http://rspec.info)

# Setup
To install, type the following:

    gem install rspec_matcher_define_constant

Add the following to your Gemfile:

    gem "rspec_matcher_define_constant"

# Usage

    RSpec.describe "a block that defines a constant" do
      subject do
        proc do
          Object.const_set "Stuff", 1
        end
      end

      it "defines Stuff" do
        expect { subject.call }.to define_constant "Stuff"
        # Stuff is not defined here.
      end
    end

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2016 [Pooyan Khosravi]().
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Pooyan Khosravi]().
