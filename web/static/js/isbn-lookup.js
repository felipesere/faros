export class IsbnLookup {
  constructor(form) {
    this.form  = form
    this.link  = form.find('[data-id="isbn-lookup"]')
    this.isbn =  form.find('[data-id="book-isbn"]')
    this.title = form.find('[data-id="book-title"]')
  }

  bindEvents() {
    this.link.on('click', (e) => {
      e.preventDefault()

      var isbn =  this.isbn.val()
      var title = this.title.val()
      $.get(`/api/books/lookup?isbn=${isbn}&title=${title}`, (res) => this.fillForm(res))
    })
  }

  fillForm(data) {
    let book = data.book

    this.form.find('[data-id="book-slug"]').val(book.slug)
    this.form.find('[data-id="book-isbn"]').val(book.isbn)
    this.form.find('[data-id="book-title"]').val(book.title)
    this.form.find('[data-id="book-description"]').val(book.description)
    this.form.find('[data-id="book-link"]').val(book.link)
  }
}
