# Código limpio, manejo de excepciones, depuración

- Guillermo Ronie Salcedo Alvarez - 20210164D

## Primera parte

Para esta primera parte, haremos uso de `myrottenpotatoes` realizado para la actividad de `Depuracion-Rails`. Sobre este vamos a trabajar el siguiente tutorial: https://www.toptal.com/abap/clean-code-and-the-art-of-exception-handling.

### Jerarquía de excepciones

Empezaremos con lo que más se recalca en el tutorial: siempre crear nuestra jerarquía de excepciones. Para nuestro caso, crearemos el directorio y archivo `exceptions/application_error.rb`, nuestrar jerarquía quedaría como:

```ruby

class ApplicationError < StandardError; end
# Errores de validación
class ValidationError < ApplicationError; end
class RequiredFieldError < ValidationError; end
class UniqueFieldError < ValidationError; end

# Errores de respuesta HTTP 4XX
class ResponseError < ApplicationError; end
class BadRequestError < ResponseError; end
class UnauthorizedError < ResponseError; end
```
Por otro lado, para asegurar que nuestro archivo sea cargado automáticamente agregaremos la siguiente línea en `config/application.rb`.

```ruby
config.autoload_paths += %W(#{config.root}/app/exceptions)
```

Con esto en mente, podremos pasar a realizar los cambios respectivos en nuestros controladores, para `movies_controller.rb` realizaremos el siguiente cambio para el método `create`.

```ruby
def create
    begin
        @movie = Movie.create!(movie_params)
        redirect_to movies_path, notice: "#{@movie.title} created."
    rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = "Movie could not be created: #{e.record.errors.full_messages.join(', ')}"
        render 'new'
end
```
En donde esta vez iniciaremos con un bloque para manejar excepciones, tal que si hay un error en la creación, se capturará dicha excepción gracias a `rescue`, y se guardará en `e`. Seguidamente, se configura el mensaje de alerta que nos indicará que no se pudo crear y mostrará el error.

1. Asimismo, algo que se nos menciona es nunca rescatar `Exception`, pues puede ocultar errores graves y hacer que el código sea más difícil de depurar, ya que no se podrá distinguir entre diferentes tipos de excepciones. Además, puede llevar a un manejo inadecuado de excepciones y a la introducción de errores sutiles y difíciles de rastrear en el código. Es una mejor práctica rescatar excepciones específicas que se esperan y que el código pueda manejar.

2. Por otro lado, también se menciona el principio de nunca rescatar más excepciones de las que necesitemos, pues, así mejoramos la claridad, simplificación del código y evita ambigüedades. Por ejemplo, de nuestro controlador, podríamos modificar nuestro método `update` de la siguiente manera:

```ruby
def update
    @movie = Movie.find(params[:id])
    begin
        if @movie.update!(movie_params)
            redirect_to movie_path(@movie), notice: "#{@movie.title} updated."
        end
    rescue ActiveRecord::RecordInvalid => e
        flash[:alert] = "#{@movie.title} could not be updated: #{e.record.errors.full_messages.join(', ')}"
        render 'edit'
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Movie not found."
        redirect_to movies_path
    end
end
```
3. Otro punto mencionado es el resistir la urgencia de manejar execepciones inmediatamente, lo cual nos indica que debemos ser más selectivos a la hora de manejar excepciones y no tratar de manejar cada exepción tan pronto como se produce. Por ejemplo, del método `update` anterior, se puede realizar una modificación con este enfoque: en lugar de envolver toda la lógica del método en un bloque, se ha movido la operación principal fuera y luego se manejan las excepciones.

```ruby
def update
  @movie = Movie.find(params[:id])

  if @movie.update!(movie_params)
    redirect_to movie_path(@movie), notice: "#{@movie.title} updated."
  end

rescue ActiveRecord::RecordInvalid => e
  flash[:alert] = "#{@movie.title} could not be updated: #{e.record.errors.full_messages.join(', ')}"
  render 'edit'
rescue ActiveRecord::RecordNotFound
  flash[:alert] = "Movie not found."
  redirect_to movies_path
end
```

4. Un punto más que se sigue es el principio de no todas las excepciones necesitan manejarse. En lugar de intentar manejar todas las excepciones posibles, algunas excepciones pueden dejarse sin procesar para permitir que se propaguen hacia arriba en la pila de llamadas.

5. Finalmente, se hace énfasis en logger todas las excepciones, por lo que al modificar nuestro controlador, con este punto mencionado, y todos los anteriores, tendremos:

```ruby
class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end 

  def create
    @movie = Movie.create!(movie_params)
    redirect_to movies_path, notice: "#{@movie.title} created."
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update!(movie_params)
    redirect_to movie_path(@movie), notice: "#{@movie.title} updated."
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: "#{@movie.title} deleted."
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date)
  end

  def handle_record_not_found
    flash[:alert] = "Movie not found."
    redirect_to movies_path
    logger.error("Movie not found with ID=#{params[:id]}")
  end

  def handle_record_invalid(exception)
    flash[:alert] = "Movie could not be created or updated: #{exception.record.errors.full_messages.join(', ')}"
    render 'new'
    logger.error("Error creating or updating movie: #{exception.message}")
  end
end
```


### ¿Qué diferencias se encuentran entre lo indicado y https://codedamn.com/news/javascript/error-handling-debugging para JavaScript?

La primera gran diferencia es que el primer tutorial trabaja en Rail, mientras que el segundo, en JavaScript. Mientras que el primero está mas centrado en programación orientada a objetos en Ruby, el otro, en la naturaleza asincrónica de JavaScript y herramientas de desarrollador del navegador.

El primero utiliza ejemplos relacionados con la gestión de excepciones en una aplicación Rails que trabaja con base de datos en ActiveRecord; el segundo, técnicas de manejo de errores asincrónicos, uso de constructores de errores personalizados y técnicas de depuración del navegador.

Mientras que en Ruby usamos bloques `begin-end` con ayuda de `rescue`; en JavaScript, se usan bloques `try-catch`, asimismo, hace uso de `console.log` para mensajes de depuración y `debugger`.


## Segunda parte

El siguiente tutorial nos ayuda a cómo configurar una arquitectura de microservicios en Ruby.

Los microservicios representan un cambio en las aplicaciones tradicionales cliente-servidor, sustituyendo los back-ends monolíticos con una red de servicios independientes. Esta arquitectura ofrece beneficios como mayor flexibilidad, escalabilidad y tolerancia a fallos. Sin embargo, surgen desafíos en la gestión de condiciones de carrera y en la depuración a lo largo de servicios distribuidos. Es crucial seguir las mejores prácticas. Si estás listo para adoptar este paradigma, exploremos la construcción de tu propio back-end de microservicios.

### Configurando un Microservicio

Empezaremos clonando el proyecto dado en el tutorial, nos moveremos a ese directorio e instalaremos las dependencias respectivas.

```bash
$ git clone git@github.com:dadah/zmq-broker-bootstrap.git
$ cd zmq-broker-bootstrap
$ npm install
$ bin/zss-broker run
```

```bash
$ git clone git@github.com:dadah/zmq-service-suite-ruby-bootstrap.git
$ cd zmq-service-suite-ruby-bootstrap
$ bundle install
$ bin/zss-service run
```

Respecto a la base de datos

```bash
$ rake db:create
$ touch db/migrate/000_creates_persons_table.rb
```

```bash
$ rake db:migrate
== 0 CreatesPersons: migrating ================================================
-- create_table(:persons)
DEPRECATION WARNING: `#timestamp` was called without specifying an option for `null`. In Rails 5, this behavior will change to `null: false`. You should manually specify `null: true` to prevent the behavior of your existing migrations from changing. (called from block in change at /Users/francisco/Code/microservices-tutorial/db/migrate/000_creates_persons.rb:6)
   -> 0.0012s
== 0 CreatesPersons: migrated (0.0013s) =======================================
```


### Principales diferencias en utilizar una arquitectura orientada  a Microservicios y la de Cliente-Servidor vista en clase con Rails

1. Descomposición del monolito:

En la arquitectura de microservicios, la aplicación se divide en servicios independientes que se desarrollan y despliegan de forma separada. Cada microservicio es autónomo y puede implementarse en diferentes lenguajes o tecnologías. Mientras que en Cliente-Servidor, en frameworks como Rails, las aplicaciones suelen seguir una arquitectura monolítica, donde todo el código está contenido en una sola aplicación del lado del servidor.

2. Escalabilidad:

En microservicios, se permite la escalabilidad independiente de cada servicio. Puedes escalar solo los microservicios que necesitas, lo que es útil para gestionar la carga de trabajo de manera eficiente. Mientrsas que en Cliente-Servidor (Rails), la escalabilidad se logra escalando toda la aplicación. Si una parte de la aplicación experimenta un aumento en la demanda, toda la aplicación debe escalarse, incluso si otras partes no lo necesitan.

3. Tecnologías y herramientas:

Cada microservicio puede usar tecnologías diferentes según sus requisitos. Esto brinda flexibilidad y permite a los equipos utilizar la mejor herramienta para cada tarea.Por otro lado, en Cliente-Servidor (Rails), todos los componentes de la aplicación comparten la misma tecnología y se implementan juntos.

4. Despliegue Independiente:

Los microservicios se puede desplegar de forma independiente, lo que facilita la implementación continua y la entrega continua. En Cliente-Servidor (Rails), generalmente se implementa toda la aplicación a la vez, lo que puede requerir más coordinación y planificación.


5. Complejidad:

Respecto a los microservicios, aunque ofrecen beneficios en términos de mantenibilidad y escalabilidad, también introducen complejidad adicional en la gestión de la comunicación entre servicios, la consistencia de datos y la monitorización de múltiples componentes. Respecto a Cliente-Servidor (Rails), este suele ser más sencilla de entender y desarrollar inicialmente, pero puede volverse más compleja a medida que la aplicación crece.

