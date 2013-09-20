
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
    $ git add .
    $ git commit -m 'A terrible strategy.'

    $ git create subakva/kablammo-bot
    $ # OR....
    $ git remote add origin git@github.com:subakva/kablammo-bot.git
    $ git push origin master


Register your bot at: http://kablammo.io/strategies/new

