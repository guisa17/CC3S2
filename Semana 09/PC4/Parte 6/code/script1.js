function createUser(user, password) {
    var _password = password;
  
    function checkPassword(input) {
        return input === _password;
    }
    return {
        user: user,
        checkPassword: checkPassword
    };
  }
  
var user = createUser('Guillermo', 'contraseña123');
console.log(user._password); // Intentamos acceder
console.log(user.checkPassword('contraseña'));
console.log(user.checkPassword('contraseña123'));