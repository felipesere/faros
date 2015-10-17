import 'jasmine-fixture'
import 'jasmine-jquery'
import 'jquery'

import {BookFinder} from 'web/static/js/book_finder.js'

describe('Book-Finder', () => {
  var finder = null

  beforeEach(() => {
   affix('form#the-form input[data-id="book-slug"] input[data-id="book-title"] input[data-id="book-description"] input[data-id="book-link"] input[data-id="book-isbn] a[data-id="isbn-lookup"]')

    finder = new BookFinder($('#the-form'))
  })


  it('constructs the with an isbn query', () => {
    finder.bindEvents()
    finder.isbn.val("123")

    let url = captureUrlOn(finder)

    expect(url).toEqual("/api/books/lookup?isbn=123&title=")
  })

  it('constructs the with an title query', () => {
    finder.bindEvents()
    finder.title.val("the hunt for")

    let url = captureUrlOn(finder)

    expect(url).toEqual("/api/books/lookup?isbn=&title=the hunt for")
  })

  it('updates the form', () => {
    var response  =  { book: {
                         slug: "some-slug",
                         title: "A Cinderella Story",
                         description: "Bla Bla Bla",
                         link: "http://example.com"
                        }
                     }

    finder.fillForm(response)

    expect($('[data-id="book-slug"]').val()).toEqual('some-slug')
    expect($('[data-id="book-title"]').val()).toEqual('A Cinderella Story')
    expect($('[data-id="book-description"]').val()).toEqual('Bla Bla Bla')
    expect($('[data-id="book-link"]').val()).toEqual('http://example.com')
  })

  function captureUrlOn(finder) {
    var url = null
    spyOn($,"get").and.callFake( (arg, callback) => url = arg )
    finder.link.click()
    return url
  }
})



