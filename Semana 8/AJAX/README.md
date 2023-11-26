# AJAX: Asynchronous JavaScript y XML

- Guillermo Ronie Salcedo Alvarez - 20210164D

Iniciaremos con esta actividad instalando las gemas necesarias `bundle` y realizando la migración respectiva `rails db:migrate`.

## Parte 1

Nos dirigiremos a nuestro controlador `show` que se encuentra en `app/controllers/movies_controller.rb`, de esta manera, ya no será necesario definir una nueva ruta. Luego, modificaremos nuestra vista `show`, tal que se incluya:

```rb
# show.html.erb
<h1>Details about <%= @movie.title %></h1>

<div id="metadata">
  <ul id="details">
    <li> Rating: <%= @movie.rating %> </li>
    <li> Released on: <%= @movie.release_date.strftime('%F') %> </li>
  </ul>
</div>

<div id="description">
  <h2>Description:</h2>
  <p> <%= @movie.description %> </p>
</div>

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

