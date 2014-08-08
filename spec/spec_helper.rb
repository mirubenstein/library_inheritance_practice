require 'rspec'
require 'pg'
require 'pry'
require './lib/crud'
require './lib/book'



DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.before(:each) do
    @new_book = Book.new({title: "Grapes of Wrath", author: "John Steinbeck", pages: 324})
  end

  config.after(:each) do
    DB.exec("DELETE FROM books *;")
  end

end
