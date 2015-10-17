import {Socket} from 'deps/phoenix/web/static/js/phoenix'
import 'deps/phoenix_html/web/static/js/phoenix_html'

import {SearchHandler} from 'web/static/js/search-handler'
import {BookFinder} from "web/static/js/book_finder"

new SearchHandler($('[data-id=search]')).bindEvents()
new BookFinder($('#book-form')).bindEvents()
