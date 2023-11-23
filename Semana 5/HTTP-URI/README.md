
# Tarea: Introducción a HTTP y URI
## Integrantes:
- Chavez Chico Joel Jhotan 20210058J
- Calagua Mallqui Jairo Andre 20210279F
- Salcedo Alvarez Guillermo Ronie 20210164D
***
## Ejecución del laboratorio
Empezamos abriendo nuestro terminal. Y ejecutaremos la siguiente línea de comando 
``curl 'http://randomword.saasbook.info'``. Nos muestra lo siguiente:
```bash
[06:20 AM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl 'http://randomword.saasbook.info'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <title>Random Word Generator</title>
  <body class="container">
    <div id="image">
      <img src="esaas.png">
    </div>
    <div id="word">
      travel
    </div>
  </body>
</html>
```
Ahora bien, vamos a guardar la salida del comando anterior en el archivo `a.html` 

```bash
[06:20 AM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl 'http://randomword.saasbook.info' > a.html
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   482  100   482    0     0   1123      0 --:--:-- --:--:-- --:--:--  1126

```
  
***
**Pregunta:**¿Cuáles son las dos diferencias principales que has visto anteriormente y lo que ves en un navegador web 'normal'? ¿Qué explica estas diferencias?
***
Vamos a abrir primero la página web mediante la URL original y luego abramos el archivo `a.html` que acabamos de crear.

![](img/pag_online.png)
![](img/pag_local.png)

Observamos que nuestro archivo solo muestra la pagina en texto plano, asimismo notar que la palabra **activity** fue aquella que se mostró cuando ejecutamos el comando `curl`, por lo tanto, por más que abramos una y otra vez la palabra será la misma, ya que solo hemos guardado el código html, para que funcione la aleatoriedad de estas palabras nos hace falta archivos adicionales como podría ser uno de tipo JavaScript.

***  

**Pregunta:** Suponiendo que estás ejecutando curl desde otro shell ¿qué URL tendrás que pasarle a curl para intentar acceder a tu servidor falso y por qué?
***
  
Abriremos un nuevo shell con el fin de hacernos pasar como un **Servidor Web** que escuchará el puerto 8081. Usaremos el comando: `nc -l 8081`

```bash
[06:49 AM]-[jhozzel@l3tsplay-ASUS]-[~]-
$ nc -l 8081
|
```
Ahora nuestro servidor esta a la espera que el cliente haga alguna interacción. Para poder acceder a este servidor usaremos nuevamente el `curl`, pero esta vez debido a que se trata de mi máquina local tendré enviarle la **ip local** de mi computadora que está representada mediante la URL: `http://localhost:8081`.

```bash
[06:26 AM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl 'http://localhost:8081'
|
```
Volvemos a la terminal anterior y vemos que nuestro servidor ha emitido el siguiente mensaje:
```bash
[06:49 AM]-[jhozzel@l3tsplay-ASUS]-[~]-
$ nc -l 8081
GET / HTTP/1.1
Host: localhost:8081
User-Agent: curl/7.81.0
Accept: */*
```
***  

**Pregunta:** La primera línea de la solicitud identifica qué URL desea recuperar el cliente. ¿Por qué no ves `http://localhost:8081` en ninguna parte de esa línea?

***
En nuestra primera línea de solicitud se muestra lo siguiente:
```
GET / HTTP/1.1
```
Sin embargo esta no especifica la dirección `http://localhost:8081` debido a que es una convención en las solicitudes HTTP que dicha URL no vuelva a aparecer cuando se solicita la página de inicio en el puerto por defecto. Para este tipo de casos lo que se suele hacer es utilizar la ruta "/" para representar la página incial.

***
**Pregunta:** Según los encabezados del servidor, ¿cuál es el código de respuesta HTTP del servidor que indica el estado de la solicitud del cliente y qué versión del protocolo HTTP utilizó el servidor para responder al cliente?
***

Para poder visualizar los encabezados del servidor vamos a aprovechar el comando `curl -i  [URL]` que a diferencia de ejecutar un `curl [URL]` común que solo nos muestra la respuesta del servidor, este comando nos proporciona además el encabezado de respuesta del servidor.

```bash
06:55 PM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl -i 'http://randomword.saasbook.info'
HTTP/1.1 200 OK 
Connection: keep-alive
Content-Type: text/html;charset=utf-8
Content-Length: 481
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Server: WEBrick/1.4.2 (Ruby/2.6.6/2020-03-31)
Date: Tue, 26 Sep 2023 00:11:10 GMT
Via: 1.1 vegur

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <title>Random Word Generator</title>
  <body class="container">
    <div id="image">
      <img src="esaas.png">
    </div>
    <div id="word">
      excited
    </div>
  </body>
</html>
```
Podemos identificar que el código de respuesta es: `HTTP/1.1 200 OK`. Asimismo podemos ver que la versión del protocolo es `1.1`  
***
**Pregunta:** Cualquier solicitud web determinada puede devolver una página HTML, una imagen u otros tipos de entidades. ¿Hay algo en los encabezados que crea que le dice al cliente cómo interpretar el resultado?.
***
Por supuesto, se trata del `Content-Type`, este nos indica el tipo de formato que me va a retornar, asimismo cabe resaltar  que además indica la codificación de caracterres utilizada.
```
Content-Type: text/html;charset=utf-8
```
***
**Pregunta:** ¿Cuál sería el código de respuesta del servidor si intentaras buscar una URL inexistente en el sitio generador de palabras aleatorias? Pruéba esto utilizando el procedimiento anterior.
***
Supongamos que quisieramos acceder a la siguiente URL: `http://randomword.saasbook.info/anything` que claramente no existe, volvamos a usar el comando `curl -i [URL]`.
```bash
[07:11 AM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl -i 'http://randomword.saasbook.info/anything'
HTTP/1.1 404 Not Found 
Connection: keep-alive
X-Cascade: pass
Content-Type: text/html;charset=utf-8
Content-Length: 13
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Server: WEBrick/1.4.2 (Ruby/2.6.6/2020-03-31)
Date: Tue, 26 Sep 2023 00:22:18 GMT
Via: 1.1 vegur

GET /anything
```
Vemos que el código de respuesta ahora es `HTTP/1.1 404 Not Found`, lo que nos indica que no existe dicho recurso al cual queremos acceder.

***
**Pregunta:** ¿Qué otros códigos de error HTTP existen? Utiliza Wikipedia u otro recurso para conocer los significados de algunos de los más comunes: `200`, `301`, `302`, `400`, `404`, `500`. Ten en cuenta que estas son familias de estados: todos los estados 2xx significan funcionó, todos los 3xx son redireccionar etc.  
Tanto el encabezado `4xx` como el `5xx` indican condiciones de error. ¿Cuál es la principal diferencia entre `4xx` y `5xx`?.

***
A continuación mostramos algunos de los códigos mencionados así como una breve descripción de esto.
- `200 OK`: La solicitud se ha procesado correctament
- `300 Moved Permanently`: El recurso solicitado a cambiado de ubicacion
permanentemente.
- `302 Found`: El recurso solicitado a cambiado de ubicacion temporalmente.
- `400 Bad Request`: No se comprende la solicitud del cliente debido a una sintaxis incorrecta
- `404 Not Found`: El recurso solicitado no se enucentra en el servidor.
- `500 Internal Server Error`: Error interno en el servidor que impide que la solicitud se procese.

Respecto a lo último es importante resaltar que los encabezados 4xx son errores por parte del cliente, y los 5xx por parte del servidor.

***  
**Pregunta:** Cuando se envía un formulario HTML, se genera una solicitud HTTP `POST` desde el navegador. Para llegar a tu servidor falso, ¿con qué URL deberías reemplazar `Url-servidor-falso` en el archivo anterior?
***
En la misma carpeta de trabajo crearemos el archivo `test.html` con el contenido dado en la guía pero en el apartado de `action` colocaremos `http://127.0.0.1:8081/` ya que se necesita la dirección local de nuestro sistema.
```html
 <!DOCTYPE html>
  <html>
  <head>
    </head>
    <body> <form method="post" action="http://127.0.0.1:8081/">
      <label>Email:</label>
       <input type="text" name="email">
        <label>Password:</label>
        <input type="password" name="password">
        <input type="hidden" name="secret_info" value="secret_value">
        <input type="submit" name="login" value="Log In!">
      </form>
    </body>
  </html> 
```  
Ejecutamos el archivo y nos muestra lo siguiete:

![](img/test_html.png)

***
**Pregunta:** ¿Cómo se presenta al servidor la información que ingresó en el formulario? ¿Qué tareas necesitaría realizar un framework SaaS como Sinatra o Rails para presentar esta información en un formato conveniente a una aplicación SaaS escrita, por ejemplo, en Ruby?
***
Volvemos a abrir un shell para actuar como un servidor, que estará a la escucha una vez más. Luego ejecutamos el archivo `test.html` y procedemos a llenar los campos de email y password.

![](img/test_completed.png)

Luego observamos que en la consola aparece lo siguiente:

```bash
[07:59 AM]-[jhozzel@l3tsplay-ASUS]-[~]-
$ nc -l 8081
POST / HTTP/1.1
Host: 127.0.0.1:8081
Connection: keep-alive
Content-Length: 87
Cache-Control: max-age=0
sec-ch-ua: "Google Chrome";v="117", "Not;A=Brand";v="8", "Chromium";v="117"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Linux"
Upgrade-Insecure-Requests: 1
Origin: null
Content-Type: application/x-www-form-urlencoded
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Sec-Fetch-Site: cross-site
Sec-Fetch-Mode: navigate
Sec-Fetch-User: ?1
Sec-Fetch-Dest: document
Accept-Encoding: gzip, deflate, br
Accept-Language: es-419,es;q=0.9

email=joel.chavez.c%40uni.pe&password=12345678&secret_info=secret_value&login=Log+In%21
```
Con la información anterior podemos concluir que dicha solicitud se presenta como un HTTP POST que contiene los datos del formulario. La solicitud POST incluirá los datos del formulario como parte de su cuerpo (body), y estos datos estarán codificados en un forma3333to específico.

Para presentar esta información en un formato conveniente a una aplicación SaaS escrita en Ruby, el framework (por ejemplo, Sinatra o Rails) realizaría las siguientes tareas:
- Análisis de los datos del formulario
- Validación de datos
- Procesamiento de datos
- Generación de una respuesta
- Envío de la respuesta

***
**Serie de preguntas:**  
***
**¿Cuál es el efecto de agregar parámetros `URI` adicionales como parte de la ruta `POST`?**

En una solicitud HTTP POST, los parámetros URI (por ejemplo, aquellos que se encuentran en la parte de la URL después del signo de interrogación "?") generalmente no tienen ningún efecto en el procesamiento de la solicitud por parte del servidor. Los parámetros URI adicionales no se utilizan típicamente para transmitir datos en una solicitud POST.
En lugar de eso, los datos enviados en una solicitud POST se encuentran en el cuerpo de la solicitud HTTP, no en la parte de la URL. Los parámetros de la URL generalmente se utilizan en solicitudes GET para transmitir datos al servidor, pero en una solicitud POST, los datos se envían en el cuerpo de la solicitud y pueden ser más extensos y complejos que los que se pueden transmitir a través de la URL.

***
**¿Cuál es el efecto de cambiar las propiedades de nombre de los campos del formulario?**

Cambiar las propiedades de nombre de los campos del formulario afectará la forma en que se envían y procesan los datos del formulario en el servidor.

***
**¿Puedes tener más de un botón `Submit`? Si es así, ¿cómo sabe el servidor en cuál se hizo clic? (Sugerencia: experimenta con los atributos de la etiqueta `<submit>`).**  

Sí, puedes tener más de un botón Submit en un formulario HTML. Cuando tienes varios botones Submit en un formulario, el servidor puede determinar cuál se hizo clic utilizando el atributo "name" de los botones.

***
**¿Se puede enviar el formulario mediante `GET` en lugar de `POST`? En caso afirmativo, ¿cuál es la diferencia en cómo el servidor ve esas solicitudes?**

Sí, se puede enviar un formulario mediante el método GET en lugar de POST en HTML. La diferencia principal entre estos dos métodos es cómo se transmiten los datos al servidor y cómo el servidor los interpreta.

***

**¿Qué otros verbos `HTTP` son posibles en la ruta de envío del formulario? ¿Puedes hacer que el navegador web genere una ruta que utilice `PUT`, `PATCH` o `DELETE`?.**

***
En un formulario HTML, el método más comúnmente utilizado es POST, seguido de GET. Sin embargo, HTTP admite varios otros verbos o métodos que pueden utilizarse en la ruta de envío del formulario, incluyendo PUT, PATCH y DELETE.  
Para que el navegador web genere una ruta que utilice PUT, PATH o DELETE generalmente se queriere de la ayuda de JavaScript, mediante la API Fetch o librerías de JavaScript como Axios.
***


### HTTP sin estados y cookies


**Pregunta:** Prueba las dos primeras operaciones `GET` anteriores. El cuerpo de la respuesta para la primera debe ser `"Logged in: false"` y para la segunda `"Login cookie set"`. ¿Cuáles son las diferencias en los encabezados de respuesta que indican que la segunda operación está configurando una cookie? (Sugerencia: usa `curl -v`, que mostrará tanto los encabezados de solicitud como los encabezados y el cuerpo de la respuesta, junto con otra información de depuración. `curl --help` imprimirá una ayuda voluminosa para usar `cURL` y `man curl` mostrará la página del manual de Unix para cURL en la mayoría de los sistemas.)

***
Primero probaremos la operación `GET/`, y luego usaremos la operación `GET/login` , asimismo notemos las diferencias de ambos outputs.

```bash
[12:22 PM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl -v "http://esaas-cookie-demo.herokuapp.com"
*   Trying 3.229.186.102:80...
* Connected to esaas-cookie-demo.herokuapp.com (3.229.186.102) port 80 (#0)
> GET / HTTP/1.1
> Host: esaas-cookie-demo.herokuapp.com
> User-Agent: curl/7.81.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Connection: keep-alive
< Content-Type: text/plain;charset=utf-8
< Content-Length: 16
< X-Content-Type-Options: nosniff
< Server: WEBrick/1.6.1 (Ruby/2.7.8/2023-03-30)
< Date: Tue, 26 Sep 2023 05:22:13 GMT
< Via: 1.1 vegur
< 
* Connection #0 to host esaas-cookie-demo.herokuapp.com left intact
Logged in: false

```

```bash
[12:22 PM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl -v "http://esaas-cookie-demo.herokuapp.com/login"
*   Trying 54.83.6.65:80...
* Connected to esaas-cookie-demo.herokuapp.com (54.83.6.65) port 80 (#0)
> GET /login HTTP/1.1
> Host: esaas-cookie-demo.herokuapp.com
> User-Agent: curl/7.81.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Connection: keep-alive
< Content-Type: text/plain;charset=utf-8
< Content-Length: 16
< X-Content-Type-Options: nosniff
< Server: WEBrick/1.6.1 (Ruby/2.7.8/2023-03-30)
< Date: Tue, 26 Sep 2023 05:25:15 GMT
< Set-Cookie: logged_in=true; domain=esaas-cookie-demo.herokuapp.com; path=/; HttpOnly
< Via: 1.1 vegur
< 
* Connection #0 to host esaas-cookie-demo.herokuapp.com left intact
Login cookie set
```

Podemos observar que para el primer caso la operación GET se mandó directamente a la raíz
```bash
> GET / HTTP/1.1
```
Mientras que para el otro llega a mandar la operación `GET/login` 
```bash
> GET /login HTTP/1.1
```
***
**Pregunta:** Bien, ahora supuestamente `"logged in"` porque el servidor configuró una cookie que indica esto. Sin embargo, si intentaa `GET /` nuevamente, seguirá diciendo `"Logged: false"`. ¿Qué está sucediendo? (Sugerencia: `usa curl -v` y observa los encabezados de solicitud del cliente).
***

Ahora bien lo que haremos para solucionar este problema, será almacenar los cookies relevantes que envía el servidor, para que sepa incluirlas en futuras solicitudes a ese servidor. Para ello ejecutaremos el siguiente comando:
```bash
[12:25 PM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl -i --cookie-jar cookies.txt http://esaas-cookie-demo.herokuapp.com/login
HTTP/1.1 200 OK
Connection: keep-alive
Content-Type: text/plain;charset=utf-8
Content-Length: 16
X-Content-Type-Options: nosniff
Server: WEBrick/1.6.1 (Ruby/2.7.8/2023-03-30)
Date: Tue, 26 Sep 2023 05:34:01 GMT
Set-Cookie: logged_in=true; domain=esaas-cookie-demo.herokuapp.com; path=/; HttpOnly
Via: 1.1 vegur

Login cookie set

[12:34 PM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ ls
a.html  cookies.txt  test.html
```

Observamos que el archivo cookies.txt fue creado exitosamente en nuestra carpeta de trabajo. Vamos a observar el contenido de este archivo y notamos que en efecto contiene información del encabezado `Set-Cookie`. Este archivo es cómo curl almacena la información de las cookies. Los navegadores pueden hacerlo de manera diferente.

```txt
# Netscape HTTP Cookie File
# https://curl.se/docs/http-cookies.html
# This file was generated by libcurl! Edit at your own risk.

#HttpOnly_.esaas-cookie-demo.herokuapp.com	TRUE	/	FALSE	0	logged_in	true
```
***

Ahora bien lo que haremos finalmente será usar este archivo `cookie.txt` para el siguiente curl.

```bash
[12:35 PM]-[jhozzel@l3tsplay-ASUS]-[~/Desktop/test]-
$ curl -v -b cookies.txt http://esaas-cookie-demo.herokuapp.com/
*   Trying 54.146.248.82:80...
* Connected to esaas-cookie-demo.herokuapp.com (54.146.248.82) port 80 (#0)
> GET / HTTP/1.1
> Host: esaas-cookie-demo.herokuapp.com
> User-Agent: curl/7.81.0
> Accept: */*
> Cookie: logged_in=true
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Connection: keep-alive
< Content-Type: text/plain;charset=utf-8
< Content-Length: 15
< X-Content-Type-Options: nosniff
< Server: WEBrick/1.6.1 (Ruby/2.7.8/2023-03-30)
< Date: Tue, 26 Sep 2023 05:39:30 GMT
< Via: 1.1 vegur
< 
* Connection #0 to host esaas-cookie-demo.herokuapp.com left intact
Logged in: true
```
***
**Pregunta:** Al observar el encabezado `Set-Cookie` o el contenido del archivo `cookies.txt`, parece que podría haber creado fácilmente esta cookie y simplemente obligar al servidor a creer que ha iniciado sesión. En la práctica, ¿cómo evitan los servidores esta inseguridad?
***

Para evitar que los clientes manipulen las cookies y se hagan pasar por otros usuarios se aplican los siguientes métodos de seguridad:

1. **Firmado de Cookies**: Los servidores pueden firmar las cookies antes de enviarlas al cliente. Esto significa que la cookie contiene un valor cifrado (o hash) que se basa en el contenido de la cookie y una clave secreta en el servidor. Cuando el cliente envía la cookie de vuelta al servidor, el servidor puede verificar la firma para asegurarse de que la cookie no ha sido modificada por el cliente. Si la firma no coincide, el servidor rechaza la cookie.

2. **Tokens de Sesión**: En lugar de almacenar información de sesión directamente en una cookie, muchos servidores generan tokens de sesión que se almacenan en una cookie. Estos tokens son aleatorios y únicos, y el servidor mantiene un registro de qué token de sesión pertenece a qué usuario. Esto hace que sea mucho más difícil para un atacante adivinar o manipular un token de sesión válido.

3. **Expiración de Cookies**: Las cookies suelen tener una fecha de vencimiento. Después de esta fecha, la cookie ya no es válida. Esto evita que un atacante utilice una cookie antigua para acceder a la cuenta de un usuario.

4. **Seguridad de la Conexión**: Los servidores a menudo requieren que las solicitudes con cookies válidas se realicen a través de una conexión segura (HTTPS) para proteger la transmisión de cookies de sesiones y otros datos confidenciales.


5. **Políticas de Cookies**: Los servidores pueden establecer políticas de cookies en el navegador del cliente para especificar cómo se deben manejar las cookies, como si deben enviarse solo a través de conexiones seguras, si deben estar disponibles solo para scripts del mismo origen (SameSite), etc.

6. **Control de Acceso**: Los servidores verifican que el usuario que envía una cookie realmente tenga permisos para acceder a los recursos o datos protegidos por esa cookie. Esto evita que los usuarios modifiquen sus cookies para acceder a información a la que no tienen derecho.

7. **Auditoría y Registros**: Los servidores suelen llevar un registro de las interacciones de los usuarios y las cookies para detectar patrones sospechosos o intentos de manipulación de sesiones.
