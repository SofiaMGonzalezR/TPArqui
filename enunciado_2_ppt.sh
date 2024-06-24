#!/bin/bash

# Función que valida el ingreso del usuario
function validateOption {
    if [[ $1 =~ ^[1-3]$ ]]; then
        return 0  # Entrada válida
    else
        return 1  # Entrada inválida
    fi
}

# Función que genera un número aleatorio entre 1 y 3 para la máquina
function generateRandomNumber() {
    echo $((RANDOM % 3 + 1))
}

function welcome() {
    echo "BIENVENIDO A ..."
    echo "PIEDRA"
    echo "    _______"
    echo "---'   ____)"
    echo "      (_____)"
    echo "      (_____)"
    echo "      (____)"
    echo "---.__(___)"
    sleep .5
    clear

    echo "BIENVENIDO A ..."
    echo "PAPEL"
    echo "    _______"
    echo "---'   ____)____"
    echo "          ______)"
    echo "          _______)"
    echo "         _______)"
    echo "---.__________)"
    sleep .5
    clear

    echo "BIENVENIDO A ..."
    echo "TIJERAS"
    echo "    _______"
    echo "---'   ____)____"
    echo "          ______)"
    echo "       __________)"
    echo "      (____)"
    echo "---.__(___)"
    sleep .5
    clear
}

function animateHand() {
    local user_hand="$1"
    local machine_hand="$2"
    local result_message="$3"

    echo "$user_hand"      # Muestra la mano del usuario
    sleep 1
    clear

    echo "$machine_hand"   # Muestra la mano de la máquina
    sleep 1
    clear

    echo "$result_message" # Muestra el mensaje de resultado (emoticones)
    sleep 2
}

function bothRockAnimation() {
    animateHand \
    "Tu: PIEDRA
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)" \
    "PC: PIEDRA
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)" \
    "😐 ¡Empate! 😐"
}

function bothPaperAnimation() {
    animateHand \
    "Tu: PAPEL
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)" \
    "PC: PAPEL
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)" \
    "😐 ¡Empate! 😐"
}

function bothScissorsAnimation() {
    animateHand \
    "Tu: TIJERAS
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)" \
    "PC: TIJERAS
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)" \
    "😐 ¡Empate! 😐"
}

function userRockMachineScissorsAnimation() {
    animateHand \
    "Tu: PIEDRA
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)" \
    "PC: TIJERAS
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)" \
    "😄 ¡Ganaste! 😄 La piedra aplasta las tijeras."
}

function userRockMachinePaperAnimation() {
    animateHand \
    "Tu: PIEDRA
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)" \
    "PC: PAPEL
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)" \
    "😞 ¡Perdiste! 😞 El papel envuelve la piedra."
}

function userPaperMachineRockAnimation() {
    animateHand \
    "Tu: PAPEL
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)" \
    "PC: PIEDRA
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)" \
    "😄 ¡Ganaste! 😄 El papel envuelve la piedra."
}

function userPaperMachineScissorsAnimation() {
    animateHand \
    "Tu: PAPEL
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)" \
    "PC: TIJERAS
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)" \
    "😞 ¡Perdiste! 😞 Las tijeras cortan el papel."
}

function userScissorsMachineRockAnimation() {
    animateHand \
    "Tu: TIJERAS
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)" \
    "PC: PIEDRA
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)" \
    "😞 ¡Perdiste! 😞 La piedra aplasta las tijeras."
}

function userScissorsMachinePaperAnimation() {
    animateHand \
    "Tu: TIJERAS
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)" \
    "PC: PAPEL
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)" \
    "😄 ¡Ganaste! 😄 Las tijeras cortan el papel."
}


# Función que compara la opción ingresada por el usuario contra la de la máquina y determina el resultado
function determineResult() {
    local user="$1"
    local machine="$2"

    case "$user" in
        1)  # Piedra
            case "$machine" in
                1) bothRockAnimation ;;
                2) userRockMachinePaperAnimation ;;
                3) userRockMachineScissorsAnimation ;;
            esac
            ;;
        2)  # Papel
            case "$machine" in
                1) userPaperMachineRockAnimation ;;
                2) bothPaperAnimation ;;
                3) userPaperMachineScissorsAnimation ;;
            esac
            ;;
        3)  # Tijeras
            case "$machine" in
                1) userScissorsMachineRockAnimation ;;
                2) userScissorsMachinePaperAnimation ;;
                3) bothScissorsAnimation ;;
            esac
            ;;
        *) echo "Entrada inválida." ;;
    esac
}

# Programa principal
while true; do
    welcome

    while true; do
        echo "PIEDRA, PAPEL O TIJERAS"
        echo "1)  PIEDRA "
        echo "2)  PAPEL"
        echo "3)  TIJERA"
        
        read -p "Ingrese un número entre (1 y 3) de acuerdo a lo que desees seleccionar: " user_selection

        if validateOption "$user_selection"; then
            machine_selection=$(generateRandomNumber)
            determineResult "$user_selection" "$machine_selection"
            break
        else
            echo "Entrada inválida, debes ingresar un número entre 1 y 3."
        fi
    done

    read -p "¿Deseas seguir jugando? (s/n): " response
    if [[ $response != "s" ]]; then
        clear
        break
    fi
    clear
done
