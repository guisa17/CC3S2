describe('MoviePopup', function() {
    describe('setup', function() {
      it('adds popup Div to main page', function() {
        expect($('#movieInfo')).toExist();
      });
      it('hides the popup Div', function() {
        expect($('#movieInfo')).toBeHidden();
      });
    });
    describe('clicking on movie link', function() {
      beforeEach(function() { loadFixtures('movie_row.html'); });
      it('calls correct URL', function() {
        spyOn($, 'ajax');
        $('#movies a').trigger('click');
        expect($.ajax.calls.mostRecent().args[0]['url']).toEqual('/movies/1');
      });
      describe('when successful server call', function() {
        beforeEach(function() {
          let htmlResponse = readFixtures('movie_info.html');
          spyOn($, 'ajax').and.callFake(function(ajaxArgs) { 
            ajaxArgs.success(htmlResponse, '200');
          });
          $('#movies a').trigger('click');
        });
        it('makes #movieInfo visible', function() {
          expect($('#movieInfo')).toBeVisible();
        });
        it('places movie title in #movieInfo', function() {
          expect($('#movieInfo').text()).toContain('Casablanca');
        });
      });
    });
  });