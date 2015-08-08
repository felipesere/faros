import 'jasmine-fixture'
import 'jasmine-jquery'
import 'jquery'

import {SearchHandler} from 'web/static/js/search-handler.js'

describe('Search-Handler', () => {
  beforeEach(() => {
    affix('input[data-id=search]')
  })

  it('focuses when key pressed', () => {
    SearchHandler.bindEvents('search')
    let pressS = jQuery.Event('keyup', { keyCode: 83, which: 83 })

    $(document).trigger(pressS)

    expect('[data-id="search"]').toBeFocused()
  })
})



