/**
 * automatizacion de verificacon campos
 * automatizacion, de validaciones y mensages
 * @author Lenz McKay Gerardo <mckaygerhard@gmail.com>
 * autodetecta codigo, si se cumpl estandar definido en la wiki
 *
 */
var er_numerico_only = /^([0-9]{9,10})$/ ;
var er_numerico_deci = /^([0-9])*[.]?[0-9]{1,2}$/ ;
var er_numerico_flui = /^([0-9]{1,6})$/ ;
var er_numerico_code = /^([0-9\-]{9,10})$/ ;
var er_codigos_prod = /^([A-Z0-9\-]{10,20})$/; ;
var er_codigos_only = /^([A-Z0-9\-]{2,16})$/; ;
var er_codigos_pequ = /^([A-Z0-9]{9,10})$/; ;
var er_codigos_idio = /(^[A-Z]{2,3})$/ ;
var er_codigos_acci = /(^[0-9]{8,9})$/ ;
var er_charset_idio = /^[a-z]+_[A-Z]+\.([A-Z]{2,4})+8$/;
var er_descripcione = /^[a-zA-Z0-9\,\.\-\&\:\(\)]{100}$/ ;

var er_descripcione_lleno = /^[a-zA-Z0-9\,\.\-\&]$/;


/*
 * name: refatorvalues
 * @description: validates all form cod_<name> inputs, are non empty
 * @param form object
 * @return none
 * 
 */
function refatorvalues(formdoc)
{
	var noret = 0;
	if ( (formdoc.name.indexOf('cod_') != -1) || (formdoc.name.indexOf('simbolo') != -1) )
	{	for ( i = 0; i < formdoc.value.length; i++ )	{	if ( formdoc.value.charAt(i) == " " ) { noret = 1; }	}	}
	if ( formdoc.value == "" )	{ noret = 1; }
	if ( noret == 1 ){	eval(formdoc.focus());	return true;	}
	else	return false;
}

/*
 * name: minimo
 * @description: detects value lenght
 * @param (objeto input)
 * @return none
 * 
 */
function minimo(obj, vl=3) 
{
	if(obj.value.length>0 AND obj.value != '') 
	{
		if (obj.value.length<vl) 
		{
			alert('Por favor ingrese al menos 3 caracteres en este campo');
			obj.focus();
		}
	}
}

/*
 * name: validanumerico
 * @description: validates input only acepts numeric chars
 * @param input object
 * @return none, lauch message
 * 
 */
function validanumerico(object)
{
		if(!er_numerico_flui.test(object.value))	return messag_eval(object);
}

/*
 * 
 * name: uppInput
 * @description: uppercase value of input dinamically
 * @param: object input
 * @return none
 * 
 */
function uppInput(object)
{
	object.value = object.value.toUpperCase();
}


/*
 * name: capiInput
 * @description: capitalize value of object input, dinamically in fact
 * @param object input
 * @return none
 * 
 */
function capiInput(object)
{
	object.value = object.value.capitalizeDescr();
}

/* sobreescritur de funcion para capitalizar */
String.prototype.capitalizeDescr = function()
{
	return this.toLowerCase().replace(/^.|\s\S/g, function(a) { return a.toUpperCase(); });
}

/*
 * name: messag_eval
 * @description take a input object and return message error depends of input name
 * @param object input
 * @return alert
 * 
 */
function messag_eval(object)
{
	var campohumname = object.name + ""; var digitosenabled = "";
	/* SE DEBE CUMPLIR LOS ESTANDARES DEFINIDO EN LA WIKI DEL PROYECTO PARA QUE FUNCIONE */
	campohumname = campohumname.replace("cod_","codigo de ");
	campohumname = campohumname.replace("can_","Cantidad de ");
	campohumname = campohumname.replace("des","descripcion ");
	campohumname = campohumname.replace("txt"," ");
	campohumname = campohumname.replace("ind","indicador");
	campohumname = campohumname.replace("num_iso","codigo iso tipo ");
	campohumname = campohumname.replace("_"," ");
	campohumname = campohumname.replace("_"," ");
	campohumname = campohumname.replace("_"," ");
	campohumname = campohumname.replace("_"," ");
	if(object.name.indexOf('can') != -1) {	digitosenabled = " no es numero o no tiene la cantidad de digitos necesarios o permitidos.";	}
	else {	digitosenabled = " o no tiene (la cantidad de) caracteres permitidos.";	}
	if(object.name.indexOf('charset') != -1){	digitosenabled +=" El codigo charset es de la forma xx_XX.UTF8. ";	}
	else if (object.name.indexOf('cod_perfil') != -1 )
	{	digitosenabled += "\n\nEl codigo de perfil debe ser numerico y nunca mayor a 99999991, dado codigos mayores estan reservados para el sistema, este codigo no puede ser alterado.";	}
	else if (object.name.indexOf('cod_idioma') != -1 )
	{	digitosenabled += "\n\nEl codigo de Idioma debe ser dos letras mayusculas que representen el idioma, concoordando con las primeras letras que lo describen (Nombre del Idioma).";	}
	else if (object.name.indexOf('cod_producto') != -1 )
	{	digitosenabled += "\n\nEl codigo es siempre mayusculas si incluye letras.";	}
	else if (object.name.indexOf('_retrieve') != -1 )
	{	digitosenabled += "\n\nEsta ingresando caracteres no permitidos.";	}
	else if (object.name.indexOf('cod') != -1)
	{	digitosenabled += "\n\nEl "+campohumname+" debe ser numerico de 10 digitos siempre.";	}
	alert("Campo "+campohumname+" vacio, invalido"+digitosenabled);	eval(object.focus());
	return false;
}

/*
 * name: validageneric
 * @description: validates some form inputs
 * @param form object
 * @return none, lauch message
 * 
 */
function validageneric(formobject)
{
	for(var i = 0; i < formobject.elements.length; i++)
	{
		if(formobject.elements[i].name.indexOf('cod_') != -1)
		{
			formobject.elements[i].value = formobject.elements[i].value.toUpperCase();
		}
		if(formobject.elements[i].name.indexOf('cod_idioma') != -1)
		{
			if(!er_codigos_idio.test(formobject.elements[i].value))	return messag_eval(formobject.elements[i]);
		}
		else if(formobject.elements[i].name.indexOf('cod_perfil') != -1)
		{
			return true;
		}
		else if(formobject.elements[i].name.indexOf('cod_talla') != -1)
		{
			if(!er_numerico_only.test(formobject.elements[i].value))	return messag_eval(formobject.elements[i]);
		}
		else if(formobject.elements[i].name.indexOf('charset') != -1)
		{
			if(!er_charset_idio.test(formobject.elements[i].value))	return messag_eval(formobject.elements[i]);
		}
		else if(formobject.elements[i].name.indexOf('cod_region') != -1)
		{
			if(!er_numerico_only.test(formobject.elements[i].value))	return messag_eval(formobject.elements[i]);
		}
		else if(formobject.elements[i].name.indexOf('cod_producto') != -1)
		{
			if(!er_codigos_prod.test(formobject.elements[i].value))	return messag_eval(formobject.elements[i]);
		}
		else if(formobject.elements[i].name.indexOf('cod_') != -1)
		{
			if(!er_numerico_only.test(formobject.elements[i].value))	return messag_eval(formobject.elements[i]);
		}
		else if(formobject.elements[i].name.indexOf('can_') != -1)
		{
			if(!er_numerico_only.test(formobject.elements[i].value))	return messag_eval(formobject.elements[i]);
		}
		else if(formobject.elements[i].type == "text" || formobject.elements[i].type == "input"  || formobject.elements[i].type == "textarea" )
		{
			refatorvalue(formobject.elements[i]) )	return messag_eval(formobject.elements[i]);
		}
	}
}

