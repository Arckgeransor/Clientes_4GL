main
	call menu_principal_0001()	
end main	

function menu_principal_0001()
	define
		v_opc smallint
	
	open window w_menu_principal_0001 at 2,2 with 2 rows, 70 columns attributes (border)
	   menu "MENU PRINCIPAL"
		command "Mantenimiento" "Insercion de datos"
			let v_opc = 1

		command "Consulta" "Consulta de datos insertados"
			let v_opc = 2

		command "Reporte" "Reporte de informacion insertada"
			let v_opc = 3

		command "Auditoria" "Reporte de auditoria de la informacion insertada"
			let v_opc = 4

		command "Depuracion" "Depurar la informacion existente en tablas"
			let v_opc = 5

		command "Correo" "Envio de informacion existente por correo"
			let v_opc = 6

		command "Masiva" "Insercion masiva de informacion"
			let v_opc = 7

		command "Interfaz" "Generacion de interfaz de informacion"
			let v_opc = 8

		command "Salir" "Salir del programa"
			exit menu
	   end menu
	close window w_menu_principal_0001

	call mant_opciones_0001(v_opc)
end function

function mant_opciones_0001(v_opc)
	define 
		v_opc, v_tf smallint

	let v_tf = FALSE

	case v_opc
		when 1 call mantenimiento_0001(v_tf) returning v_tf	
		when 2 call consulta_0001(v_tf) returning v_tf
		when 3 call reporte_0001(v_tf) returning v_tf
		when 4 call auditoria_0001(v_tf) returning v_tf
		when 5 call depuracion_0001(v_tf) returning v_tf
		when 6 call correo_0001(v_tf) returning v_tf
		when 7 call masiva_0001(v_tf) returning v_tf
		when 8 call interfaz_0001(v_tf) returning v_tf
	end case
end function

function mantenimiento_0001(v_tf)
	define
		v_tf smallint	

	return v_tf
end function


function consulta_0001(v_tf)
        define
                v_tf smallint

	return v_tf
end function


function reporte_0001(v_tf)
        define
                v_tf smallint

        return v_tf
end function


function auditoria_0001(v_tf)
        define
                v_tf smallint

        return v_tf
end function


function depuracion_0001(v_tf)
        define
                v_tf smallint

        return v_tf
end function


function correo_0001(v_tf)
        define
                v_tf smallint

        return v_tf
end function


function masiva_0001(v_tf)
        define
                v_tf smallint

        return v_tf
end function


function interfaz_0001(v_tf)
        define
                v_tf smallint

        return v_tf
end function
