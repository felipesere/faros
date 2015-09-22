export class SearchHandler {
  constructor(target) {
    this.target = target
  }

  bindEvents() {
    $(document).keyup((e) => {
      if( $(e.target).is( 'input' )) {
        return;
      }

      let code = e.which ? e.which : e.keyCode

      if(83 === code) {
        this.target.focus()
      }
    })
  }
}
