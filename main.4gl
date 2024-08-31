database gen
main
	defer interrupt


	call menu_principal_0001()	
end main	

function menu_principal_0001()
	define
		v_opc smallint
	
	open window w_menu_principal_0001 at 2,2 with 2 rows, 70 columns attributes (border)
	   menu "MENU PRINCIPAL"
		command "Mantenimiento" "Insercion de datos"
			let v_opc = 1
			exit menu

		command "Consulta" "Consulta de datos insertados"
			let v_opc = 2
			exit menu

		command "Reporte" "Reporte de informacion insertada"
			let v_opc = 3
			exit menu

		command "Auditoria" "Reporte de auditoria de la informacion insertada"
			let v_opc = 4
			exit menu

		command "Depuracion" "Depurar la informacion existente en tablas"
			let v_opc = 5
			exit menu

		command "Correo" "Envio de informacion existente por correo"
			let v_opc = 6
			exit menu

		command "Masiva" "Insercion masiva de informacion"
			let v_opc = 7
			exit menu

		command "Interfaz" "Generacion de interfaz de informacion"
			let v_opc = 8
			exit menu

		command "Salir" "Salir del programa"
			exit menu
	   end menu

	   call mant_opciones_0001(v_opc)

	close window w_menu_principal_0001

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
		v_tf smallint,
		rl_cliente  record like dat_clie_0001.*	,
		v_last_opc  char(15)

	##Llamado de la ventana de insercion de datos
	open window w_ins_datos_0001 at 7,5 with form "inserta" attributes (border)
		input by name rl_cliente.nombres thru rl_cliente.nit_rol
			before field nombres
				let v_last_opc = "nombres"

			after field nombres
				let v_last_opc = "nombres"

			before field apellidos
				let v_last_opc = "apellidos"

			after field apellidos
				let v_last_opc = "apellidos"

			before field documento
				let v_last_opc = "documento"

			after field documento
				let v_last_opc = "documento"

			before field telefono
				let v_last_opc = "telefono"
	
			after field telefono
				let v_last_opc = "telefono"

                        before field telefono2
				let v_last_opc = "telefono2"

                        after field telefono2
				let v_last_opc = "telefono2"

                        before field correo
				let v_last_opc = "correo"

                        after field correo
				let v_last_opc = "correo"

                        before field fecha_nacimiento
				let v_last_opc = "fecha_nacimiento"

                        after field fecha_nacimiento
				let v_last_opc = "fecha_nacimiento"

                        before field pais_residencia
				let v_last_opc = "pais_residencia"

                        after field pais_residencia
				let v_last_opc = "pais_residencia"

                        before field ciudad_residencia
				let v_last_opc = "ciudad_residencia"

                        after field ciudad_residencia
				let v_last_opc = "ciudad_residencia"

                        before field pais_nacimiento
				let v_last_opc = "pais_nacimiento"

                        after field pais_nacimiento
				let v_last_opc = "pais_nacimiento"

                        before field ciudad_nacimiento
				let v_last_opc = "ciudad_nacimiento"

                        after field ciudad_nacimiento
				let v_last_opc = "ciudad_nacimiento"

                        before field nit_rol
				let v_last_opc = "nit_rol"

                        after field nit_rol
				let v_last_opc = "nit_rol"
		end input
	close window w_ins_datos_0001

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
