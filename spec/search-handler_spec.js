import 'jasmine-fixture'
import 'jasmine-jquery'
import 'jquery'

import {SearchHandler} from 'web/static/js/search-handler.js'

describe('Search-Handler', () => {
  beforeEach(() => {
    affix('input#search]')
    affix('form input#keeps-focus input[type=text]')
  })


  it('focuses when key pressed', () => {
    new SearchHandler($('#search')).bindEvents()

    pressS($(document))

    expect('#search').toBeFocused()
  })

  it('does not move focus away', () => {
    new SearchHandler($('#search')).bindEvents()
    $('#keeps-focus').focus()

    pressS($('#keep-focus'))

    expect('#search').not.toBeFocused()
  })

  function pressS(where) {
    var event = jQuery.Event('keyup', { keyCode: 83, which: 83 })
    where.trigger(event)
  }
})



