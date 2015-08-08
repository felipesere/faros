export var SearchHandler = {
  bindEvents: (target) => {
    let targetSelector = `[data-id='${target}']`

    $(document).keyup((e) => {
      let code = e.which ? e.which : e.keyCode

      if(83 === code) {
        $(targetSelector).focus()
      }
    })
  }
}
