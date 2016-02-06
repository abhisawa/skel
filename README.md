# Skel

[![Build Status](https://travis-ci.org/abhisawa/skel.svg?branch=master)](https://travis-ci.org/abhisawa/skel)

This is skeleton gem template for writing command line utilities which provides barebone command and option parsing with help of `Thor` and basic logging structure.


## Usage

Checkout this repo and refactor it (rubymine term) to replace ``skel`` to your utility name. ``bin/skel`` is top level executable which get called with various command options like below there is ``example`` is option

```
[abhisawa@xxxx ]$ skel help
Commands:
  skel example         # example command
  skel help [COMMAND]  # Describe available commands or one specific command
  


[abhisawa@xxxx skel]$ skel help example
Usage:
  skel example

Options:
  -v, [--verbose], [--no-verbose]  # Turn on verbosity , default: false
  -o1, [--opt1], [--no-opt1]       # option 1 for example command, default: false
  -o2, [--opt2=OPT2]               # option 2 for example command

example command  

[abhisawaxxxx skel]$ skel example  --opt1  --opt2=value2 -v
D, [2016-02-03T05:17:00.861339 #32346] DEBUG -- : Logging this because verbositry set to true
Option 1 is true
Option 2 is  value2

```

## Structure

```
.
├── bin
│   └── skel                            # executable to call
├── lib
│   ├── skel
│   │   ├── cli.rb                      # registery of all commands with their options defined
│   │   ├── command
│   │   │   └── example.rb              # 'example' is one of command.  
│   └── skel.rb                         # singleton defined to manage logging and constants
└── spec
    ├── command
    │   └── example_spec.rb             # specs for 'example' command
    ├── skel_spec.rb 
    └── spec_helper.rb
```

### To add new commands
- Refer ``lib/skel/command/example.rb`` where ``Skel::Command::Example`` class has been defined which ``initialization()`` and ``call()`` which are command interfaces spawned by ```Skel::CLI::ExecCommand`` during runtime.
- Refer ``lib/skel/cli.rb`` where each command and required options gets defined in ``Thor`` framework.
- Refer ``spec/command/example_spec.rb`` to write specs which can test individual methods in command namespace.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abhisawa/skel.

