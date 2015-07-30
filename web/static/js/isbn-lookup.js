export class IsbnLookup {
  constructor(form) {
    this.form  = form
    this.link  = form.find('[book-isbn-lookup]')
    this.input = form.find('[book-isbn-input]')
  }

  bindEvents() {
    this.link.on('click', (e) => {
      e.preventDefault()

      $.get(`/api/books/lookup?isbn=${this.input.val()}`, (res) => this.fillForm(res))
    })
  }

  fillForm(response) {
    let book = JSON.parse(response)

    this.form.find('[book-title-input]').val(book.title)
    this.form.find('[book-description-input]').val(book.description)
    this.form.find('[book-link-input]').val(book.link)
  }
}
