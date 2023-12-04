# Testing JavaScript y AJAX

- Guillermo Ronie Salcedo Alvarez - 20210164D

Empezaremos con el uso de `Jasmine` insertando `gem "jasmine"` en nuestro Gemfile, y volvemos a ejecutar `bundle`. Luego, ejecutamos los siguientes comandos:

```bash
rails generate jasmine:install 
mkdir spec/javascripts/fixtures 
git add spec/javascripts 
```
![Alt text](image.png)

Una vez realizado esto, pasaremos a crear nuestro archivo `basic_check_spec.js`, en donde incluiremos el siguiente código:

```js
describe ('Jasmine basic check', function() { 
    it('works', function() { expect(true).toBe(true); }); 
});
```



