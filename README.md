
    $ mkdir kablammo-bot
    $ cd kablammo-bot
    $ git init
    $ bundle init
    $ echo "gem 'kablammo', github: 'carbonfive/kablammo-strategy'" >> Gemfile
    $ bundle install
    $ touch strategy.rb
    $ echo "on_turn do" >> strategy.rb
    $ echo "  'f'" >> strategy.rb
    $ echo "end" >> strategy.rb
