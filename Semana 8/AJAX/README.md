# AJAX: Asynchronous JavaScript y XML

- Guillermo Ronie Salcedo Alvarez - 20210164D

Iniciaremos con esta actividad instalando las gemas necesarias `bundle`, crear la tabla `Moviegoers` a través de `rails generate migration CreateMoviegoers` realizando la migración respectiva `rails db:migrate`.

## Parte 1

Nos dirigiremos a nuestro controlador `show` que se encuentra en `app/controllers/movies_controller.rb`, de esta manera, ya no será necesario definir una nueva ruta. Luego, crearemos nuestra vista parcial como `_movies.html.erb`.

```rb
# _movie.html.erb
<p> <%= movie.description %> </p>
<%= link_to 'Edit Movie', edit_movie_path(movie), :class => 'btn btn-primary' %>
<%= link_to 'Close', '', :id => 'closeLink', :class => 'btn btn-secondary' %>
```

Asimismo, realizamos modificaciones en el controlador:
```rb
# movies_controller.rb
def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    render(:partial => 'movie', :object => @movie) if request.xhr?
    # will render render app/views/movies/show.html.haml by default
end
```

**¿Cómo sabe la acción de controlador si show fue llamada desde código JavaScript o mediante una petición HTTP normal iniciada por el usuario?**
La acción del controlador sabe si `show` fue llamada desde JavaScript o por HTTP gracias a la condición `request.xhr?`, el cual es un método que retornará `true` si la solicitud fue hecha por `AJAX` (JavaScript), luego, se nos renderizará una vista parcial.


## Parte 2
**
**¿Cómo debería construir y lanzar la petición XHR el código JavaScript?** Queremos que la ventana flotante aparezca cuando clickeamos en el enlace que tiene el nombre de la película, para ello, crearemos el archivo `movie_popup.js` en el directorio `app/assets/javascripts`, y haremos uso del siguiente bloque de código.


```js
var MoviePopup = {
  setup: function() {
    // add hidden 'div' to end of page to display popup:
    let popupDiv = $('<div id="movieInfo"></div>');
    popupDiv.hide().appendTo($('body'));
    $(document).on('click', '#movies a', MoviePopup.getMovieInfo);
  }
  ,getMovieInfo: function() {
    $.ajax({type: 'GET',
            url: $(this).attr('href'),
            timeout: 5000,
            success: MoviePopup.showMovieInfo,
            error: function(xhrObj, textStatus, exception) { alert('Error!'); }
            // 'success' and 'error' functions will be passed 3 args
           });
    return(false);
  }
  ,showMovieInfo: function(data, requestStatus, xhrObject) {
    // center a floater 1/2 as wide and 1/4 as tall as screen
    let oneFourth = Math.ceil($(window).width() / 4);
    $('#movieInfo').
      css({'left': oneFourth,  'width': 2*oneFourth, 'top': 250}).
      html(data).
      show();
    // make the Close link in the hidden element work
    $('#closeLink').click(MoviePopup.hideMovieInfo);
    return(false);  // prevent default link action
  }
  ,hideMovieInfo: function() {
    $('#movieInfo').hide();
    return(false);
  }
};
$(MoviePopup.setup);
```
