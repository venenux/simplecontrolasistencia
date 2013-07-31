<?php
class Menu extends CI_Model
{
	function __construct()
	{
		parent::__construct();
		$obj = & get_instance();
		//$this->load->library('session');
		$obj->load->library('menulib');
	}

	function general_menu($params='')
	{
		$menu = new MenuLib;
		$nodes = new MenuNodes;

		$n100000=anchor('indexcontroler','Inicio');
		$m100000['m100000']=anchor('indexcontroler/logout','Salir');

		$n200000=anchor('reportes_general','Reportes');
		$m200001['m200002']=anchor('reportes_registro_deta','Asistencias Detallados');
		$m200001['m200003']=anchor('reportes_registro_mens','Asistencias Mensuales');
		$m200001['m200004']=anchor('reportes_enrolamientos','Registros de Huellas');

		$n300000=anchor('consultas_general','Gestion');
		$m300001['m300000']=anchor('registrar_ficha_ide','Registro Trabajador');
		$m300001['m300001']=anchor('consultas_busca_ide','Consultar Trabajador(es)');
		$m300001['m300002']=anchor('consultas_busca_cri','Consultar Hoja de vida');
		$m300001['m300003']=anchor('gestiones_sistencia','Totalizador Asistencias');
		$m300001['m300004']=anchor('gestiones_nocturnos','Totalizador Recargos');

		$n010000=anchor('#','Otro');
		$m010000['m010000']=anchor('#',' ');

		$header['1'] = $nodes->m_header_nodes($n100000,$m100000);
		$header['2'] = $nodes->m_header_nodes($n200000,$m200001);
		$header['3'] = $nodes->m_header_nodes($n300000,$m300001);
		$header['4'] = $nodes->m_header_nodes($n010000,$m010000);
	
		$menu->m_create_headers($header);
		return $menu->show_menu();
	}

}
