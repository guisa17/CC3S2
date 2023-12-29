# Parte 3: Rail

### Crear una nueva aplicación Rails

Para iniciar con este apartado, creamos nuestra nueva aplicación con el siguiente comando en el terminal.
![Alt text](img/image.png)

Se ha creado la carpeta rottenpotatoes, entramo en ella y ejecutamos el siguiente comando.
![Alt text](img/image-1.png)

Alguna gemas que se han incluido en el archivo Gemfile gracias a Rails de manera automática.
![Alt text](img/image-2.png)

Se agrega la versión de Ruby en el archivo Gemfile.
![Alt text](img/image-3.png)

Luego, actualizamos la versión de sqlite3 escribiendo sobre el Gemfile por la siguiente:
![Alt text](img/image-4.png)

Ahora, cuando ejecutamos bundle update, obtendremos el siguiente mensaje:
![Alt text](img/image-5.png)

Ejecutamos la aplicación localmente.
![Alt text](img/image-6.png)


![Alt text](img/image-7.png)

Con todo esto y habremos creado nuestra nueva aplicación de Rail "rottepotatoes" con las configuraciones y gemas necesarias. Ahora podremos desarrollarla en las siguientes partes. 


## Base de datos en diferentes entornos

Sabemos que la base de datos de prueba se gestionan automáticamente y se reestablece en cada ejecución de prueba. Por este motivo, no se debe modificar automáticamente. 
![Alt text](img/image-8.png)


## Crear la base de datos

De la imagen anterior, tenemos que la base de datos se almacenará en db/development.sqlite3. Además, nuestra base de datos no se generará automáticamente, podríamos pensar en crearlas manualmente; sin embargo, no es eficiente del todo.


## Crear y aplicar la migración

Una mejor alternativa al problema anterior es la migración. Como primer paso vamos a generar nuestra migración llamada create_movies, con el siguiente comando:
![Alt text](img/image-10.png)

Ahora encontraremos el siguiente archivo en db/migrate:
![Alt text](img/image-11.png)

En este archivo, editaremos nuestra migración, copiaremos el siguiente código:
![Alt text](img/image-12.png)

Seguidamente, ejecutaremos el siguiente comando para poder aplicar la migración a la base de datos de desarrollo. Asimismo, prepararemos nuestra base de datos de prueba con el comando rails db:test:prepare.
![Alt text](img/image-13.png)

Esto último nos asegurará que la base de datos de prueba tenga la misma estructura que la base de datos de desarrollo


## Crea el modelo inicial e inicializa la base de dato
Dado que las películas son un modelo, lo que se realiza a continuación es crear el modelo ActiveRecord que utiliza esta tabla. Para ello crearemos y versionaremos el archivo que se encuentra en app/models/movie.rb con lo siguiente:

![Alt text](img/image-14.png)

Esto nos creará el modelo ActiveRecord 'Movie' que mapea la tabla de películas en la base de datos.

Luego, verificamos el modelo Movie en Rails Console de la siguiente manera:

![Alt text](img/image-15.png)

En este entorno, crearemos una nueva instancia de Movie con atributos en blanco, y luego consultaremos el primer elemento de la base de datos con Movie.first.

![Alt text](img/image-16.png)

A continuación, agregaremos algunos datos iniciales a nuestra base de datos en el archivo seeds.rb que se encuentra en el directorio db/.

![Alt text](img/image-17.png)

Inmediatamente, ejecutaremos el siguiente comando para la siembra de dichos datos en la base de datos. Y consultaremos el primer elemento que tendremos en esta base de datos actualizada.

![Alt text](img/image-18.png)

![Alt text](img/image-19.png)
 

# Parte 4: Crear rutas, acciones y vistas CRUD para películas

Intentaremos ejecutar la aplicación nuevamente, y esta vez intentaresmos dirigirnos a /movies.

![Alt text](img/image-21.png)


![Alt text](img/image-22.png)

Para esta parte, queremos agregar rutas RESTful para el modelo 'Movie', lo cual configuraremos en el archivo config/routes.rb. 

![Alt text](img/image-20.png)

![Alt text](img/image-23.png)

Aún más importante, podremos encontrar el log en el archivo log/development.log y observamos que el mensaje de error se registra ahí.

![Alt text](img/image-24.png)

## Crear rutas CRUD

Editaremos el archivo config/routes.rb que fue generado automáticamente. Y reemplazaremos su contenigo por el siguiente código.

![Alt text](img/image-25.png)

Con esto estamos estableciendo rutas RESTful para el módulo 'Movie' utilizando el método resources. Además, la raíz se dirige a /movies.

Seguidamente, ejecutaremos el siguiente comando. Se nos mostrará una tabla que enumera las rutas generadas  
![Alt text](img/image-26.png)

Volvemos a ejecutar nuestro servidor, y nos dirigiremos a /movies. Sin embargo, ahora tendremos un diferente error, pues, no ha encontrado la clase 'MoviesController'. Esto es una buena señal, ya que la ruta se ha configura correctamente y Rails está buscando al controlador.
![Alt text](img/image-27.png)


## Crear acciones y vistas

Crearemos tanto el archivo del controlador como las vistas asociados. Empezamos ejecutando el siguiente comando:

![Alt text](img/image-28.png)

Esto último nos generará el controlador, las vistas y las rutas necesarias para las acciones CRUD del modelo 'Movie'. Ahora tendríamos una aplicación funcional.


## Cambiar la base datos para producción

Empezaremos agregando las siguientes gemas específicas de producción. Agregamos las siguientes gemas específicas en producción en el Gemfile.

![Alt text](img/image-29.png)

Por otro lado, moveremos la gema de sqlite3 para los grupos :development y :test y no en :production. Así se asegura que el sqlite use solo entornos de desarrollo y prueba.

![Alt text](img/image-30.png)

Ahora que se ha modificado el Gemfile, debemos volver a ejecutar el bundle install.

![Alt text](img/image-31.png)

Por último, se podría pensar que el archivo config/database.yml que se necesita modificar, pero no es así, la base de datos la configurará automáticamente en Heroku para utilizar Postgress. 

![Alt text](img/image-32.png)

Se muestra el resultado de ejecutar la aplicación de manera local. Solo quedaría realizar su deployment.


## Envío

Finalmente, se realiza el deployment en render: https://rottenpotatoes.onrender.com.

![Alt text](img/image-33.png)

