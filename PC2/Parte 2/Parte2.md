# Parte 2: Introducción a Rails

1. En vez de redirigir a la acción Index tras un create exitoso, redirija a la acción show de la película recién creada. Pista: Puedes usar el método helper para URI movie_path, pero necesitarás darle un argumento para identificar la película. Para obtener este argumento, recuerda que si Movie.create se completa correctamente, devuelve el objeto recién creado, además de crearlo





2. El campo description de una película se creó como parte de la migración original, pero no se muestra y tampoco se puede editar. Realiza los cambios necesarios para que el campo de la descripción se vea y se pueda editar en las vistas de New y Edit. Pista: Debería cambiar sólo dos ficheros.




3. Los métodos actuales del controlador no son muy robustos: si el usuario introduce de manera manual un URI para ver (Show) una película que no existe (por ejemplo /movies/99999), verá un mensaje de excepción horrible. Modifique el método show del controlador para que, si se pide una película que no existe, el usuario sea redirigido a la vista Index con un mensaje más amigable explicando que no existe ninguna película con ese ID. (Pista: Usa begin. . . rescue. . . end para recuperar el control en la excepción ActiveRecord::RecordNotFound).



