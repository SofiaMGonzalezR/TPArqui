#!/bin/bash

# Función para ejecutar la solicitud REST
function execute_rest {
    local url="$1"
    local response=$(curl -s "$url")
    echo "$response"
}

# Función para validar el género
function validate_gender {
    local gender="$1"
    
    if [[ "$gender" == "male" ]]; then
        return 0
    elif [[ "$gender" == "female" ]]; then
        return 1
    else
        return 2
    fi
}

# Función para validar el nombre
function validate_name {
    local name="$1"
    # Verificar que el nombre no esté vacío
    if [[ -z "$name" ]]; then
        return 1
    fi

    # Verificar que el nombre solo contenga letras (puede ajustarse según las necesidades)
    if [[ ! "$name" =~ ^[a-zA-Z]+$ ]]; then
        return 2
    fi

    return 0
}

# Loop principal
while true; do
    while true; do
        # Pedir al usuario que ingrese un nombre
        read -p "Ingrese un nombre (o 'salir' para finalizar): " nombre
        
        if [[ "$nombre" == "salir" ]]; then
            echo "Fin del programa."
            exit 0
        fi

        # Validar el nombre
        validate_name "$nombre"
        valid_name=$?

        if [[ $valid_name -eq 0 ]]; then
            break
        elif [[ $valid_name -eq 1 ]]; then
            echo "Error: El nombre no puede estar vacío. Intente de nuevo."
        elif [[ $valid_name -eq 2 ]]; then
            echo "Error: El nombre solo puede contener letras. Intente de nuevo."
        fi
    done
    
    # Construir la URL
    URL="https://api.genderize.io/?name=${nombre}"
    
    # Llama a la función y almacena la respuesta
    respuesta=$(execute_rest "$URL")
    
    # Extraer el valor del campo 'gender'
    gender=$(echo "$respuesta" | grep -o '"gender":"[^"]*' | cut -d'"' -f4)
    
    # Validar el género
    validate_gender "$gender"
    gender_code=$?
    
    # Mostrar el género basado en el código
    if [[ $gender_code -eq 0 ]]; then
        echo "El nombre ingresado es del género: Masculino"
    elif [[ $gender_code -eq 1 ]]; then
        echo "El nombre ingresado es del género: Femenino"
   
    else
        echo "No pudimos determinar un género para el nombre ingresado :("
    fi
    
    # Preguntar si el usuario quiere consultar otro nombre
    read -p "¿Deseas consultar otro nombre? (s/n): " response
    if [[ $response != "s" ]]; then
        echo "Fin del programa."
        break
    fi
    clear
done
