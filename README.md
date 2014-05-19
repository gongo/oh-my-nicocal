NicoNicoCalendar
==============================

What's NicoNicoCalendar?
------------------------------

- [ニコニコカレンダー - Wikipedia](http://ja.wikipedia.org/wiki/%E3%83%8B%E3%82%B3%E3%83%8B%E3%82%B3%E3%82%AB%E3%83%AC%E3%83%B3%E3%83%80%E3%83%BC)
- [Guide to Agile Practices](http://guide.agilealliance.org/guide/nikoniko.html)

Demo
------------------------------

http://oh-my-nicocal.herokuapp.com/

Getting Started
------------------------------

    $ git clone https://github.com/gongo/oh-my-nicocal.git
    $ cd oh-my-nicocal
    $ bundle install --path vendor/bundle --without production
    $ bundle exec rake db:migrate
    $ bundle exec rake db:seed
    $ bundle exec rails server

Access to [http://localhost:3000](http://localhost:3000)
