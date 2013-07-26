<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

		$giflogo = base_url() . APPPATH . 'media/01.gif';

		$pathcss = base_url() . APPPATH . 'styles/'; $typcs='text/css';
		$pathjsc = base_url() . APPPATH . 'scripts/'; $typjs='text/javascript';

		$metaline1 = array('name' => 'description', 'content' => 'Sistema Repositorio de Catalago');
		$metaline2 = array('name' => 'keywords', 'content' => 'productos, administracion, catalogo, sistemas');
		$metaline3 = array('name' => 'Content-type', 'content' => 'text/html; charset='.config_item('charset'), 'type' => 'equiv');

		$linkdefcss = array('type'=>$typcs,'rel'=>'stylesheet','href' => $pathcss.'defaultstyle.css');

		$linkbrownavdecsjs = array('type'=>$typjs,'src' => $pathjsc.'brownavdec.js',);
		$linkvalidaformsjs = array('type'=>$typjs,'src' => $pathjsc.'valida.js',);
		$linktabberdetaljs = array('type'=>$typjs,'src' => $pathjsc.'tabber.js',);
		$linkdatepickerugl = array('type'=>$typjs,'src' => $pathjsc.'datetimepicker.js');

		$meta = array( $metaline1, $metaline2, $metaline3 );
?>
