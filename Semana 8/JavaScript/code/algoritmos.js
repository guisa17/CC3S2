// Algoritmos

function greatestNumber(array) {
    let max = array[0];
    for (let i of array) 
    {
        if (i > max) {
            max = i;
        }
    }
    return max;
}
// console.log(greatestNumber([2, 4, 5, 6, 10, 8]));


function containsX(string) {
    for (let s of string) {
        if (s == 'X') {
            return true;
        }
    }
    return false;
}
// console.log(containsX('Los archivos X'));


function firstDuplicate(string) {
    // Diccionario para las frecuencias
    let freq = {}
    for (let s of string) {
        // Verificamos si ya tenemos algún elemento para freq
        // de lo contrario, será 0
        freq[s] = (freq[s] || 0) + 1;
    }

    for (let s of string) {
        if (freq[s] == 1) {
            return s;
        }
    }
    return 'Not found';
}
// console.log(firstDuplicate('minimum'));


class Pokemon {
    constructor(HP, ataque, defensa) {
        this.HP = HP;
        this.ataque = ataque;
        this.defensa = defensa;
        this.movimiento = "";
        this.nivel = 1;
        this.tipo = "";
    }

    fight() {
        if (!this.movimiento) {
            throw new Error("No se especifica ningún movimiento.")
        }
    }

    canFly() {
        if (!this.tipo) {
            throw new Error("No se especifica ningún.")
        }
        return this.tipo.includes('volar');
    }
}


class Charizard extends Pokemon {
    constructor(HP, ataque, defensa, movimiento) {
        super(HP, ataque, defensa)
        this.movimiento = movimiento;
        this.tipo = "disparar/volar"
    }

    fight() {
        if (!this.movimiento) {
            throw Error("No se especifica ningún movimiento.")
        }
        console.log(`Se está utilizando el movimiento ${this.movimiento}.`)
        return this.ataque;
    }
}

// Ejemplo de uso
try {
    const poke = new Pokemon(100, 70, 30);
    poke.fight();
} catch(e) {
    console.log(e.message);
}

const chari = new Charizard(200, 80, 80, "Onda ígnea");
chari.fight();
console.log(chari.canFly());
