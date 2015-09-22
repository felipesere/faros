import {Socket} from 'deps/phoenix/web/static/js/phoenix'
import 'deps/phoenix_html/web/static/js/phoenix_html'

import {SearchHandler} from 'web/static/js/search-handler'
import {IsbnLookup} from "web/static/js/isbn-lookup"

new SearchHandler('search').bindEvents()
new IsbnLookup($('[create-book-form]')).bindEvents()
