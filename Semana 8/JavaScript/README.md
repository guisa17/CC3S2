# JavaScript

- Guillermo Ronie Salcedo Alvarez - 20210164D

La comunidad de JavaScript ha florecido en los últimos años y frameworks como React y Node.js hacen posible escribir aplicaciones completas en JavaScript. Nos centraremos principalmente en el lenguaje JavaScript, AJAX, DOM y Eventos/Callback.

## Preguntas conceptuales

- **En JavaScript, todas las operaciones de red son asíncronas. ¿Por qué es esto importante?**

    La asincronía en JavaScript es importante para garantizar que las operaciones de red no bloqueen la ejecución del programa. Un claro ejemplo son las solicitudes HTTP. La asicronía nos permite que el programa continúe ejecutándose mientras espera respuestas, mejorando la eficiencia y capacidad de respuesta de las aplicaciones web.


- **En Javascript, queremos realizar acciones tras una operación/solicitud de red completa. ¿Qué paradigma de programación hace esto posible?**

    El paradigma de JavaScript utiliza para realizar acciones tras una operación/solicitud es el paradigma de programación basado en eventos o asíncrono. Por medio de callbacks, promesas y async/await es posible ejecutar código después de que se completa una operación de red.


- **¿Javascript proporciona soporte limitado para la herencia a través de qué mecanismo?**

    JavaScript proporciona la herencia mediante prototipos, cada objeto hereda propiedades y métodos de un prototipo, permitiendo la creación de cadenas de prototipos para compartir comportamientos entre objetos.


- **¿Qué es el DOM? ¿Qué librería nos ayuda a usar Javascript para manipular el DOM?**

    El DOM (*Document Object Model*) es una interfaz que representa la estructura de un documento HTML o XML. La librería que nos ayuda a manipular el DOM es `jQuery`, el cual facilita manipulación del DOM a través de métodos abreviados y funciones para trabajar con la estructura e interactividad del documento de manera sencilla.


## ¿Qué puede hacer JavaScript?

JavaScript comparte el paradigma "todo es un objeto" con Ruby, con algunas excepciones notables. Su lista de primitivas incluye `String`, `Number`, `undefined`, `null`, `Boolean` y `BigInt`. Al igual que en Ruby, los valores se escriben dinámicamente, utilizando `var` o `let` para declarar variables en lugar de tipos. A pesar de estas similitudes, JavaScript tiene idiosincrasias únicas que impactan la codificación efectiva. 

### Booleano

Debido a la flexibilidad en la escritura dinámica de variables en JavaScript, algunos valores evalúan como Verdadero/Falso al convertirse en booleanos, pero al compararse entre sí, pueden dar resultados inesperados. Para realizar dichas comparaciones, tenemos el siguiente script:

```js
console.log(undefined == null);
console.log(NaN == NaN);
console.log(null == false);
console.log(0 == false);
console.log("" == false);
```

Los resultados obtenidos son los siguientes:
![Alt text](image.png)

- `undefined == null` es `true` debido a que ambos representan valor nulo y son tratados iguales en comparaciones estrictas `===`. 

- `Nan == Nan` es `false` debido a que `NaN` (*Not a Number*) nunca será igual a otro `NaN`.

- `null == false` es `false` debido a que estos son diferentes en comparación estricta `===`, además se tiene así por definición en JavaScript.

- `0 == false` es `true` debido a que al realizar la conversión booleana, todos los booleanos se convertirán en `true`, a excepcioń del `0` que se convertirá en `false`.


- `"" == false` es `true` debido a que la cadena vacía se convertirá en `0` y `false` se convierte en `0`.


### Arrays

