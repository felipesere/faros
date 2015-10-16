import 'jasmine-fixture'
import 'jasmine-jquery'
import 'jquery'

import {IsbnLookup} from 'web/static/js/isbn-lookup.js'

describe('Isbn-Lookup', () => {
  var lookup = null

  beforeEach(() => {
   affix('form#the-form input[data-id="book-slug"] input[data-id="book-title"] input[data-id="book-description"] input[data-id="book-link"] input[data-id="book-isbn] a[data-id="isbn-lookup"]')

    lookup = new IsbnLookup($('#the-form'))
  })


  it('constructs the with an isbn query', () => {
    lookup.bindEvents()
    lookup.isbn.val("123") 

    let url = captureUrlOn(lookup)

    expect(url).toEqual("/api/books/lookup?isbn=123&title=")
  })

  it('constructs the with an title query', () => {
    lookup.bindEvents()
    lookup.title.val("the hunt for") 

    let url = captureUrlOn(lookup)

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

    lookup.fillForm(response)

    expect($('[data-id="book-slug"]').val()).toEqual('some-slug')
    expect($('[data-id="book-title"]').val()).toEqual('A Cinderella Story')
    expect($('[data-id="book-description"]').val()).toEqual('Bla Bla Bla')
    expect($('[data-id="book-link"]').val()).toEqual('http://example.com')
  })

  function captureUrlOn(isbnLookup) {
    var url = null
    spyOn($,"get").and.callFake( (arg, callback) => url = arg )
    lookup.link.click()
    return url
  }
})



