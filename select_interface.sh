#!/bin/bash


echo "Bienvenido al script para trabajar rapido con "
echo "una interfaz, de esta manera podrás activar y desactivar"
echo "rapidamente el modo monitor"
printf "\n\n\n"

CONTINUE=true

while true; do
	result=$(ifconfig | grep  flags | cut -d ' ' -f1 | tr -d ':')
	VAR=1
	for interfaces in ${result}; do
		printf "\t\t\t [$VAR] $interfaces\n"
		let VAR+=1
	done

	printf "Seleccione una interfaz para trabajar: "
	read opcion
	let VAR-=1

	if (( $opcion <= $VAR )) && (( $opcion >= 1)); then
		placa=$(echo ${result} | cut -d ' ' -f $opcion | tr -d '\n') # | xclip -selection clipboad -i)
		break
	fi
	printf "\n\n\nSeleccione un opción valida...\n\n\n"
done



printf "\n\n\tSeleccione una opción a realizar con la placa $placa:\n"
printf "\t\t\t[1]. Levantar en modo monitor\n"
printf "\t\t\t[2]. Dar de  baja Modo Monitor\n"
printf "\t\t\t[3]. Salir con el portapapeles\n"
printf "\t\t\t--> "
read eleccion
if (( $eleccion == 1 )); then	
	sudo airmon-ng start $placa
fi
if (( $eleccion == 2 )); then
	sudo airmon-ng stop $placa
fi
if (( $eleccion == 3 )); then
	printf $placa | xclip -selection clipboard -i
fi
