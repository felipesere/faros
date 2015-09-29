export class IsbnLookup {
  constructor(form) {
    this.form  = form
    this.link  = form.find('[data-id="isbn-lookup"]')
    this.input = form.find('[data-id="book-isbn"]')
  }

  bindEvents() {
    this.link.on('click', (e) => {
      e.preventDefault()

      $.get(`/api/books/lookup?isbn=${this.input.val()}`, (res) => this.fillForm(res))
    })
  }

  fillForm(response) {
    let book = JSON.parse(response)

    this.form.find('[data-id="book-slug"]').val(book.slug)
    this.form.find('[data-id="book-title"]').val(book.title)
    this.form.find('[data-id="book-description"]').val(book.description)
    this.form.find('[data-id="book-link"]').val(book.link)
  }
}
