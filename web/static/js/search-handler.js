export var SearchHandler = {
  bindEvents: (target) => {
    let targetSelector = `[data-id='${target}']`

    $(document).keyup((e) => {
      if( $(e.target).is( 'input' )) {
        return;
      }

      let code = e.which ? e.which : e.keyCode

      if(83 === code) {
        $(targetSelector).focus()
      }
    })
  }
}
