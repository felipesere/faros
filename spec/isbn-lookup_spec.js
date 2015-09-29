import 'jasmine-fixture'
import 'jasmine-jquery'
import 'jquery'

import {IsbnLookup} from 'web/static/js/isbn-lookup.js'

describe('Isbn-Lookup', () => {
  beforeEach(() => {
    affix('form#the-form input[data-id="book-slug"] input[data-id="book-title"] input[data-id="book-description"] input[data-id="book-link"]')
  })


  it('knows the truth', () => {
    var response  =  JSON.stringify({
                       slug: "some-slug",
                       title: "A Cinderella Story",
                       description: "Bla Bla Bla",
                       link: "http://example.com"
                     })

    let lookup = new IsbnLookup($('#the-form'))
    lookup.fillForm(response)

    expect($('[data-id="book-slug"]').val()).toEqual('some-slug')
    expect($('[data-id="book-title"]').val()).toEqual('A Cinderella Story')
    expect($('[data-id="book-description"]').val()).toEqual('Bla Bla Bla')
    expect($('[data-id="book-link"]').val()).toEqual('http://example.com')
  })
})



