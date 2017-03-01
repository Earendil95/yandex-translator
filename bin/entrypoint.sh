sudo service nginx start
RAKE_ENV=production puma -C config/puma.rb
