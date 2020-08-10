#!/bin/bash


#Colours de S4vitar acortado
greenC="\e[0;32m\033[1m"
endC="\033[0m\e[0m"
redC="\e[0;31m\033[1m"
blueC="\e[0;34m\033[1m"
yellowC="\e[0;33m\033[1m"
purpleC="\e[0;35m\033[1m"
turquoiseC="\e[0;36m\033[1m"
grayC="\e[0;37m\033[1mi"

##############################################################
#  Funciones.
##############################################################

function change_mac {
	
	args
        :@required opcion
	
	sudo ifconfig $placa down
	sudo macchanger $opcion $placa
	sudo ifconfig $placa up

}


# limpiamos pantalla
clear

# imprimimos mensaje de lo que se podrá hacer
echo -e "\t\t\t${redC}+----------------------------------------------------------+${endC}"
echo -e "\t\t\t${redC}| ${endC}${greenC}Bienvenido al script para trabajar rapido con${endC}            ${redC}|${endC}"
echo -e "\t\t\t${redC}| ${endC}${greenC}una interfaz, de esta manera podrás activar y desactivar${endC} ${redC}|${endC}"
echo -e "\t\t\t${redC}| ${endC}${greenC}rapidamente el modo monitor${endC}                              ${redC}|${endC}"
echo -e "\t\t\t${redC}+----------------------------------------------------------+${endC}"
printf "\n\n\n"

# iniciamos un bucle hasta obtener una respuesta correcta.

while true; do
	result=$(ifconfig | grep  flags | cut -d ' ' -f1 | tr -d ':')
	VAR=1
	echo -e "${blueC}Ahora listamos las opciones de placas disponibles:${endC}"
	for interfaces in ${result}; do
		printf "\t\t\t\t\t\t ${redC}[$VAR]${endC} ${yellowC} $interfaces ${endC}\n"
		let VAR+=1
	done

	printf "${blueC}Seleccione una interfaz para trabajar:${endC} ${yellowC}"
	read opcion
	printf "${endC}"
	let VAR-=1

	if (( $opcion <= $VAR )) && (( $opcion >= 1)); then
		placa=$(echo ${result} | cut -d ' ' -f $opcion | tr -d '\n') # | xclip -selection clipboad -i)
		break
	fi
	printf "\n\n\n${redC}Seleccione un opción valida...{endC}\n\n\n"
done

# si salió la respuesta es correcta ahora seleccionaremos que hacer con la placa.

printf "\n\n\t${blueC}Seleccione una opción a realizar con la placa${endC} ${yellowC}$placa${endC}\n"
printf "\t\t\t${redC}[${endC}${yellowC}1${endC}${redC}]${endC} ${yellowC}  Levantar en modo monitor${endC}\n"
printf "\t\t\t${redC}[${endC}${yellowC}2${endC}${redC}]${endC} ${yellowC}  Dar de  baja Modo Monitor${endC}\n"
printf "\t\t\t${redC}[${endC}${yellowC}3${endC}${redC}]${endC} ${yellowC}  Salir con el portapapeles${endC}\n"
printf "\t\t\t${redC}[${endC}${yellowC}4${endC}${redC}]${endC} ${yellowC}  Modificar la MAC${endC}\n"
printf "\t\t\t${redC}[${endC}${yellowC}5${endC}${redC}]${endC} ${yellowC}  Restaurar la MAC${endC}\n"
printf "\t\t\t${blueC}--> "
read eleccion
printf "${endC}"

# controlamos la opción seleccionada

if (( $eleccion == 1 )); then	
	sudo airmon-ng start $placa
fi
if (( $eleccion == 2 )); then
	sudo airmon-ng stop $placa
fi
if (( $eleccion == 3 )); then
	printf $placa | xclip -selection clipboard -i
fi
if (( $eleccion == 4 ));  then
	change_mac -r
fi
if (( $eleccion == 5 )); then
	change_mac -p
fi
