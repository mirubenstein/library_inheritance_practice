require 'spec_helper'

#new_book is a Book title Grapes of Wrath

describe :Book do
  it 'initilizes with title and id' do
    expect(@new_book).to be_a Book
    expect(@new_book.title).to eq 'Grapes of Wrath'
  end

  it 'saves to the database' do
    @new_book.save
    expect(@new_book.id).to be_a Fixnum
  end

  it 'finds a book based on table column and search term' do
    @new_book.save
    new_book2 = @new_book.read('title', 'Grapes of Wrath')
    expect(@new_book.title).to eq new_book2[0].title
  end

  it 'updates a book based on table column and search term' do
    @new_book.save
    @new_book.update('title', 'new-name')
    expect(@new_book.title).to eq 'new-name'
  end
end
