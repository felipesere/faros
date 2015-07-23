describe("Search-Handler", function() {
  beforeEach(function() {
    var fixture = [
          '<form action="/somewhere" method="post" >',
          '  <input data-id="search" type="text" placeholder="To search, press s"/>',
          '  <button type="submit">Go</button>',
          '</form>'
    ].join('');
    setFixtures(fixture);
  });

  it("focuses when key pressed", function() {
    SearchHandler.bindEvents("search");
    var pressS = jQuery.Event( 'keyup', { keyCode: 83, which: 83 } )
    $(document).trigger(pressS);

    expect("[data-id='search']").toBeFocused()
  });
});



