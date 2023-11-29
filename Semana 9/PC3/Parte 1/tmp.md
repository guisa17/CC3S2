Aquí tienes un ejemplo simple de cómo podrías implementar un comando grep simplificado en JavaScript utilizando Node.js:

javascript
Copy code
#!/usr/bin/env node

const fs = require('fs');

// Recuperar argumentos de la línea de comandos
const args = process.argv.slice(2);

// Manejar argumentos
let lineNumber = false;
let showFileNamesOnly = false;
let caseInsensitive = false;
let invertMatch = false;
let matchWholeLine = false;
let searchString = '';
let files = [];

// Analizar argumentos
while (args.length > 0) {
    const arg = args.shift();
    switch (arg) {
        case '-n':
            lineNumber = true;
            break;
        case '-l':
            showFileNamesOnly = true;
            break;
        case '-i':
            caseInsensitive = true;
            break;
        case '-v':
            invertMatch = true;
            break;
        case '-x':
            matchWholeLine = true;
            break;
        default:
            // Si no es un indicador, asumimos que es la cadena de búsqueda o el nombre del archivo
            if (searchString === '') {
                searchString = arg;
            } else {
                files.push(arg);
            }
            break;
    }
}

// Función principal de búsqueda
function grep(file, content) {
    const lines = content.split('\n');
    const matchedLines = [];

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        const lineToMatch = matchWholeLine ? line : caseInsensitive ? line.toLowerCase() : line;

        if ((caseInsensitive ? searchString.toLowerCase() : searchString) === lineToMatch) {
            if (invertMatch) {
                continue;
            }

            const result = lineNumber ? `${i + 1}:${line}` : line;
            matchedLines.push(result);
        } else {
            if (!invertMatch) {
                continue;
            }
            const result = lineNumber ? `${i + 1}:${line}` : line;
            matchedLines.push(result);
        }
    }

    return matchedLines;
}

// Realizar la búsqueda en cada archivo
function searchInFiles() {
    files.forEach(file => {
        try {
            const content = fs.readFileSync(file, 'utf8');
            const matchedLines = grep(file, content);

            if (showFileNamesOnly && matchedLines.length > 0) {
                console.log(file);
            } else {
                console.log(matchedLines.join('\n'));
            }
        } catch (error) {
            console.error(`Error reading file ${file}: ${error.message}`);
        }
    });
}

// Iniciar la búsqueda
searchInFiles();
Este script implementa las funcionalidades básicas de grep en JavaScript utilizando Node.js. Puedes ejecutar este script desde la línea de comandos con los argumentos deseados, por ejemplo:

bash
Copy code
./grep.js -n -i "searchString" file1.txt file2.txt
Asegúrate de dar permisos de ejecución al script con chmod +x grep.js si estás en un entorno tipo Unix.