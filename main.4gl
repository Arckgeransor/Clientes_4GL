database gen
main
	defer interrupt
	call main_0001()
end main

function main_0001()
	display "    INSERCION DE CLIENTES VERSION 1.0    " at 2,21 attributes (reverse)
	open window w_main_0001 at 5,2 with 2 rows, 80 columns attributes (border)
		menu "MENU PRINCIPAL"
			command "Insertar" "Insertar informacion de Clientes"
				call ins_clientes_0001()

			command "Consultar" "Consultar datos de Clientes"
				call cons_clientes_0001()

			command "Modificar" "Modificar datos de Clientes"
				call modi_clientes_0001()

			command "Eliminar" "Eliminar datos de Clientes"
				call eli_clientes_0001()

			command "Reporte" "Reporte de datos de Clientes"
				call rep_clientes_0001()

			command "Auditoria" "Auditoria de informacion de Clientes"
				call audi_clientes_0001()

			command "Depuracion" "Depurar informacion de Clientes"
				call depu_clientes_0001()

			command "Masiva" "Insercion masiva de datos de Clientes"
				call ins_mas_clientes()

			command "Correo" "Envio de correos a Clientes"
				call envio_mail_cliente_0001()

			command "Programa" "Informacion y Ayuda acerca del Programa"
				call acerca_programa_0001()

			command "Salir" "Salir del Menu Principal"
				exit menu
		end menu
	close window w_main_0001
end function

--Funcion para Insertar Datos de Clientes
function ins_clientes_0001()
	define
		v_tf smallint

	let v_tf = FALSE

	call window_datos_bas_0001(v_tf) returning v_tf
	call window_datos_pago_0001(v_tf) returning v_tf
	call window_datos_preferencias(v_tf) returning v_tf
end function

--Funcion para Consultar Datos de Clientes
function cons_clientes_0001()
	
end function

--Funcion para Modificar Datos de Clientes
function modi_clientes_0001()

end function

--Funcion para Eliminar Datos de Clientes
function eli_clientes_0001()

end function

--Funcion para generar Reporte de Datos de Clientes
function rep_clientes_0001()

end function

--Funcion para generar Reporte de Auditoria de Clientes
function audi_clientes_0001()
	
end function

--Funcion para Depurar Informacion de Clientes
function depu_clientes_0001()

end function

--Funcion para Insertar de forma Masiva Datos de Clientes
function ins_mas_clientes()

end function

--Funcion para Envio de Correos a Clientes
function envio_mail_cliente_0001()

end function

--Funcion de ayuda para Revisar Informacion del Programa
function acerca_programa_0001()

end function

--Function para ingresar Datos basicos del Cliente
function window_datos_bas_0001(v_tf)
	define
		v_tf, v_nn, length_campo,	
		v_is_tel2, v_is_tel1, v_tip_tel       smallint,
		rl_dat_clie_0001    record like dat_clie_0001.*,
		v_last_opc   char(20),
		v_edad char(3)

	open window w_datos_bas_0001 at 5,2 with form "dat_bas_0001" attributes (border, message line 20)

		message " F10 = Siguiente Ventana  CTRL-C = Cancelar Proceso " attributes (reverse)
		input by name rl_dat_clie_0001.nombres thru rl_dat_clie_0001.ciudad_nacimiento	
			after field nombres
				let v_last_opc = "nombres"
				if rl_dat_clie_0001.nombres is null or rl_dat_clie_0001.nombres = "" then
					error "El campo de Nombres no puede ser nulo"
					next field nombres
				end if

				call valida_dato_caracter_0001(rl_dat_clie_0001.nombres, TRUE) returning v_tf

				if v_tf = 0 then
					next field nombres
				end if

			after field apellidos
				let v_last_opc = "apellidos"
				if rl_dat_clie_0001.apellidos is null or rl_dat_clie_0001.apellidos = "" then
                                        error "El campo de Apellidos no puede ser nulo"
                                        next field apellidos
                                end if

				call valida_dato_caracter_0001(rl_dat_clie_0001.apellidos, TRUE) returning v_tf

                                if v_tf = 0 then
                                        next field apellidos
                                end if

			after field documento
				let v_last_opc = "documento"
				let length_campo = 0
				if rl_dat_clie_0001.documento is null or rl_dat_clie_0001.documento = "" then
                                        error "El campo de Documento no puede ser nulo"
                                        next field documento
                                end if

				let length_campo = length(rl_dat_clie_0001.documento)

				if length_campo < 5 or length_campo > 11 then
					error "Cantidad invalida de digitos en documento, por favor verificar"
					next field documento
				end if

				call valida_dato_numerico_0001(rl_dat_clie_0001.documento, TRUE) returning v_tf

				if v_tf = 0 then
					next field documento
				end if

				if v_is_tel2 and v_last_opc = "telefono2" then
					next field telefono2
				end if

				if v_last_opc = "documento" and v_nn = 1 then
					let v_nn = 0
					initialize rl_dat_clie_0001.telefono to null
					initialize rl_dat_clie_0001.telefono2 to null
					display by name rl_dat_clie_0001.telefono, rl_dat_clie_0001.telefono2
				end if

##Se cambia funcionalidad de Telefono y se deja comentada para tener en cuenta los cambios respectivo
{
			before field telefono
				if v_last_opc = "correo" then
					let v_last_opc = "correo"
				else
					let v_last_opc = "telefono"
				end if

				if v_nn = 0 then
					call valida_fijo_movil_0001() returning v_tip_tel, v_nn
				end if

				if v_tip_tel = 0 and v_last_opc = "telefono" then
                                        next field correo
                                end if

				if v_tip_tel = 2 and v_last_opc = "telefono" then
					next field telefono2
				end if

                                if v_tip_tel = 2 and v_last_opc = "correo" then
                                        next field documento
                                end if

				if v_is_tel2 and v_tip_tel = 2 then
					next field correo
				end if

				if v_tf = 2 and v_last_opc = "telefono2" and v_is_tel2 then
					next field correo
				end if

				
			after field telefono
				let length_campo = 0

				if v_tf = 1 then
					let v_last_opc = "telefono"
					let length_campo = length(rl_dat_clie_0001.telefono)

					if rl_dat_clie_0001.telefono is null or rl_dat_clie_0001.telefono = "" then
                                        	error "El campo de Telefono no puede ser nulo"
                                        	next field telefono
                                	end if

					if length_campo != 10 then
                                        	error "Cantidad invalida de digitos en telefono fijo, por favor verificar"
                                        	next field telefono
                                	end if

					if rl_dat_clie_0001.telefono[1] != 6 then
                                                error "Telefono fijo nivel Colombia debe iniciar por 6, por favor revise"
                                                next field telefono
                                        end if

                                        call valida_dato_numerico_0001(rl_dat_clie_0001.telefono, TRUE) returning v_tf

                                        if v_tf = 0 then
                                                next field telefono
                                        end if				

					if v_last_opc = "telefono" and v_is_tel1 = 0 then
						next field correo
					end if
				end if

				if v_tf = 2 then
					let v_last_opc = "telefono2"
					let length_campo = length(rl_dat_clie_0001.telefono2)

					if rl_dat_clie_0001.telefono2 is null or rl_dat_clie_0001.telefono2 = "" then
                                                error "El campo de Telefono no puede ser nulo"
                                                next field telefono2
                                        end if

                                        if length_campo < 5 or length_campo > 11 then
                                                error "Cantidad invalida de digitos en documento, por favor verificar"
                                                next field telefono2
                                        end if

                                        if rl_dat_clie_0001.telefono2[1] != 3 then
                                                error "Telefono fijo nivel Colombia debe iniciar por 6, por favor revise"
                                                next field telefono2
                                        end if

                                        call valida_dato_numerico_0001(rl_dat_clie_0001.telefono2, TRUE) returning v_tf

                                        if v_tf = 0 then
                                                next field telefono2
                                        end if

					let v_nn = 0

					if v_last_opc = "telefono2" then
						next field correo
					end if
				end if

				if v_tf = 3 then
					
				end if
}

			before field telefono
				if v_nn = 0 then
					call valida_fijo_movil_0001() returning v_tip_tel, v_nn
				end if

				if v_tip_tel = 0 then
					next field correo
				end if

				if v_tip_tel = 2 then
					next field telefono2
				end if 

			after field telefono
				if v_last_opc = "correo" then
					let v_last_opc = "correo"
				else
					let v_last_opc = "telefono"
				end if

				let length_campo = length(rl_dat_clie_0001.telefono)

                                if rl_dat_clie_0001.telefono is null or rl_dat_clie_0001.telefono = "" then
                                        error "El campo de Telefono no puede ser nulo"
                                        next field telefono
                                end if

                                if length_campo != 10 then
                                        error "Cantidad invalida de digitos en telefono fijo, por favor verificar"
                                        next field telefono
                                end if

                                if rl_dat_clie_0001.telefono[1] != 6 then
                                        error "Telefono fijo nivel Colombia debe iniciar por 6, por favor revise"
                                        next field telefono
                                end if

                                call valida_dato_numerico_0001(rl_dat_clie_0001.telefono, TRUE) returning v_tf

				if not v_tf then
					next field telefono
				end if

				if v_tip_tel = 1 and (fgl_lastkey() = fgl_keyval("down") or 
						      fgl_lastkey() = fgl_keyval("return")) then
					next field correo
				end if

				if v_tip_tel = 1 and fgl_lastkey() = fgl_keyval("up") then
					next field documento
				end if

			before field telefono2

			after field telefono2
				if v_last_opc = "correo" then
                                        let v_last_opc = "correo"
                                else
                                        let v_last_opc = "telefono2"
                                end if
{
				if v_last_opc = "correo" then
                                        next field documento
                                end if
}

				let length_campo = length(rl_dat_clie_0001.telefono2)

                                if rl_dat_clie_0001.telefono2 is null or rl_dat_clie_0001.telefono2 = "" then
                                        error "El campo de Telefono Movil no puede ser nulo"
                                        next field telefono2
                                end if

                                if length_campo != 10 then
                                        error "Cantidad invalida de digitos en telefono movil, por favor verificar"
                                        next field telefono2
                                end if

                                if rl_dat_clie_0001.telefono2[1] != 3 then
                                        error "Telefono movil nivel Colombia debe iniciar por 3, por favor revise"
                                        next field telefono2
                                end if

                                call valida_dato_numerico_0001(rl_dat_clie_0001.telefono2, TRUE) returning v_tf

                                if not v_tf then
                                        next field telefono2
                                end if

				if v_tip_tel = 2 and fgl_lastkey() = fgl_keyval("up") then
					next field documento
				end if

			before field correo
				let v_last_opc = "correo"

			after field correo
				let v_last_opc = "correo"

				if rl_dat_clie_0001.correo = " " or rl_dat_clie_0001.correo is null then
					error "El campo de correo no puede estar vacio"
					next field correo
				end if

				call valida_mail_0001(rl_dat_clie_0001.correo, TRUE) returning v_tf

				if not v_tf then
                                        next field correo
                                end if

				if v_tip_tel = 0 and fgl_lastkey() = fgl_keyval("up") then
                                        next field documento
                                end if

				if v_tip_tel = 1 and fgl_lastkey() = fgl_keyval("up") then
					next field telefono
				end if

				if v_tip_tel = 2 and fgl_lastkey() = fgl_keyval("up") then
					next field telefono2
                                end if

				if v_tip_tel = 3 and fgl_lastkey() = fgl_keyval("up") then
					next field telefono2
				end if

			before field fecha_nacimiento
				let v_last_opc = "fecha_nacimiento"
			
			after field fecha_nacimiento
				let v_last_opc = "fecha_nacimiento"
				if rl_dat_clie_0001.fecha_nacimiento >= today -18 units year then
					error "Solo se pueden registrar mayores de edad, por favor verificar"
					next field fecha_nacimiento
				end if

			before field ciudad_residencia
				let v_last_opc = "ciudad_residencia"


			after field ciudad_residencia
				let v_last_opc = "ciudad_residencia"
				if upshift(rl_dat_clie_0001.ciudad_residencia) not matches "*BOGOTA*" then
					error "Sistema de Clientes presente solo en Bogota, por favor revise"
					next field ciudad_residencia
				end if

			before field ciudad_nacimiento
				let v_last_opc = "ciudad_nacimiento"

			after field ciudad_nacimiento
                                let v_last_opc = "ciudad_nacimiento"
				if v_last_opc = "ciudad_nacimiento" and fgl_lastkey() = fgl_keyval("up") then
					next field pais_nacimiento
				end if

				if v_last_opc = "ciudad_nacimiento" 
				and (fgl_lastkey() = fgl_keyval("down") or fgl_lastkey() = fgl_keyval("return")) then
                                        next field nombres
                                end if
{
			on key (RETURN)
				if v_last_opc = "ciudad_nacimiento" and fgl_lastkey() = fgl_keyval("return") then
					next field nombres
				end if
}

			on key (INTERRUPT)
				error "Proceso Cancelado"
				exit input

			on key (F10)
				call window_datos_pago_0001(FALSE)
				
				error "Siguiente ventana en proceso"
				exit input

			if v_last_opc = "ciudad_nacimiento" then
				next field nombres
			end if

		end input
	close window w_datos_bas_0001

	return v_tf
end function

--Funcion para ingresar Datos de Pago del Cliente
function window_datos_pago_0001(v_tf)
        define
                v_tf smallint,
		rl_dat_pag_0001  record
			tipo_pago1 char(1),
			tipo_pago2 char(1),
			tipo_pago3 char(1),
			tipo_pago4 char(1)
		end record

	open window w_dat_pag_0001 at 5,5 with form "dat_pag_0001" attributes (border)
		input by name rl_dat_pag_0001.tipo_pago1 thru rl_dat_pag_0001.tipo_pago4
			on key (F7)
				if infield(tipo_pago1) 
				and (rl_dat_pag_0001.tipo_pago1 is null 
				or rl_dat_pag_0001.tipo_pago1 = "") then
					let rl_dat_pag_0001.tipo_pago1 = "X" 
					display by name rl_dat_pag_0001.tipo_pago1 attributes(reverse)
				end if
		end input
	close window w_dat_pag_0001

        return v_tf
end function
	
--Funcion para ingresar Datos de Preferencia del Cliente
function window_datos_preferencias(v_tf)
        define
                v_tf smallint

        return v_tf
end function

--Funcion que valide el formato del correo electronico
function valida_mail_0001(mail, v_tf)
	define 
		mail   char(100),
		v_tf, v_i, length_mail, length_dominio,   
		count_points, length_dom_empresa,  
		length_dom_comercial, length_dominio2, count_dom_com smallint,
		dominio, dominio2, dom_empresa, dom_comercial  char(100)
		
		
	let length_mail = length(mail)
	
	let dominio = " "

	--Extrae el dominio del cliente
	for v_i = 1 to length_mail
		let dominio[v_i] = mail[v_i]
		if mail[v_i] = "@" then
			exit for
		end if
	end for

	let length_dominio = length(dominio)

	if length_dominio = 0 then
		let length_dominio = 1
	end if

	let dominio2 = dominio

	let length_dominio2 = length(dominio2)

	let dominio = dominio[1, length_dominio -1]

	for v_i = 1 to length_dominio
		if dominio[v_i] != " " and dominio[v_i] is not null then
		   if dominio[v_i] not matches "[a-z]" then
			error "Dominio personal con formato errado, por favor verificar"
			return FALSE
		   end if
		else
			exit for
		end if
	end for
{
	if dominio not matches "[abcdefghijklmnopqrstuvwxyz]" then
		error "Dominio personal con formato errado, por favor verificar"
		return FALSE
	end if
}

	--if dominio[length_dominio] not matches "*@*" then
	if dominio2[length_dominio] != "@" then

		error "El correo no se encuentra con el simbolo '@', por favor verifique"
		return FALSE
	end if


	let length_dominio = length(dominio)

	if length_dominio < 5 or length_dominio > 11 then
		error "Dominio debe estar parametrizado con cantidad de caracteres entre 5 y 11, por favor verificar"
		return FALSE
	end if

	--let length_dominio = length_dominio - 1

	--Extrae el dominio de Empresa
	for v_i = length_dominio2 + 1 to length_mail
		if mail[v_i] = "." then
			--let count_points = 1
			exit for
		end if
		let dom_empresa[v_i - length_dominio2] = mail[v_i]
	end for

	let length_dom_empresa = length(dom_empresa)

	--if dom_empresa not matches "*mercaderiag*" then
	if dom_empresa != "mercaderiag" or dom_empresa is null then
		--error "Dominio de empresa debe ser unicamente mercaderiag, por favor revise"
		error "Dominio de empresa diferente a mercaderiag o nulo, por favor revise"
		return FALSE
	end if

	--Espacio para determinar el dominio comercial
	if length_dominio > 1 then
		for v_i = v_i to length_mail
			let dom_comercial[v_i - length_dominio2	- length_dom_empresa] = mail[v_i]
			if mail[v_i] = "" then
				exit for
			end if
		end for

		if dom_comercial != ".com" and dom_comercial != ".com.co" and dom_comercial != ".es" then
			error "El dominio comercial debe ser .com, .com.co o .es, por favor verificar"
			return FALSE
                end if

		if dom_comercial = ".com" or dom_comercial = ".com.co" or dom_comercial = ".es" then
			let count_dom_com = 1
		end if

		if count_dom_com = 0 then
			error "El correo debe contar con un dominio comercial, por favor verificar"
			return FALSE
		end if
	end if
{
	if 
	     mail[length_mail - 3, length_mail] not matches "*.com" and
	     mail[length_mail - 7, length_mail] not matches "*.com.co" and
	     mail[length_mail - 2, length_mail] not matches "*.es"
	then
		error "El correo debe contar con dominio comercial, por favor verificar"
		return FALSE
	end if
}
	 

		

	if dom_comercial not matches "*.com" and 
	   dom_comercial not matches "*.com.co" and
	   dom_comercial not matches "*.es"
	then
		error "Dominio comercial debe ser .com, .com.co o .es, por favor verificar"
		return FALSE
	end if
	

	return v_tf
end function

--Funcion que valida el numero de documento
function valida_documento_0001(v_documento)
	define 
		v_tt, length_documento, v_i smallint,
		v_documento  char(10)

	let length_documento = length(v_documento)

	if length_documento < 5 and length_documento > 10 then
		error "Cantidad de digitos de documento errado, por favor verificar"
		return FALSE
	end if

	for v_i = 1 to length_documento
		if v_documento[v_i] not matches "[1234567890]" then
			error "Formato de documento invalido, por favor verificar"
			return FALSE
		end if
	end for

		
end function

--Funcion que valida si un campo numerico es invalido
function valida_dato_numerico_0001(dato, v_tf)
	define
		dato   char(50),
		v_tf, 
		length_dato,
		v_i    smallint

		let length_dato = length(dato)

		let v_i = 1

		for v_i = 1 to length_dato
			if dato[v_i] not matches "[1234567890]" then
				error "Formato de dato invalido, por favor verificar"
				return FALSE
			end if
		end for

	return v_tf
end function

--Funcion que valida si un campo de caracter es invalido
function valida_dato_caracter_0001(dato, v_tf)
	define
		dato   char(50),
		v_tf,
		length_dato,
		v_i   smallint

		let length_dato = length(dato)

		let v_i = 1

		for v_i = 1 to length_dato
                        if dato[v_i] not matches "[a-z]" and dato[v_i] not matches "[A-Z]" then
                                error "Formato de dato invalido, por favor verificar"
                                return FALSE
                        end if
                end for

        return v_tf
end function

--Funcion para determinar si el cliente desea registrar Telefono Movil, Fijo o Ambos
function valida_fijo_movil_0001()
	define
		v_tf, v_nn smallint

	let v_tf = 0
	let v_nn = 0

	open window w_tel_fij_mov_0001 at 15,7 with 2 rows, 40 columns attributes (border)
		menu "REGISTRO TELEFONO"
			command "Fijo" "Registrar Numero Fijo"
				let v_tf = 1
				let v_nn = 1
				exit menu

			command "Movil" "Registrar Numero Movil"
				let v_tf = 2
				let v_nn = 1
				exit menu

			command "Ambos" "Registrar Numeros Fijo y Movil"
				let v_tf = 3
				let v_nn = 1
				exit menu

			command "N/A" "No Registrar Numero"
				exit menu
		end menu
	close window w_tel_fij_mov_0001

	return v_tf, v_nn
end function

function ins_dat_ini_clie_0001(v_tf)
	define
		v_tf smallint

	
end function
