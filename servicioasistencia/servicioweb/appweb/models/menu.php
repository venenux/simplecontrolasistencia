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

	function general_menu($params='inparametro')
	{
		$menu = new MenuLib;
		$nodes = new MenuNodes;

		$n400000=anchor('indexcontroler','Inicio');
		$m400000['m400000']=anchor('indexcontroler/logout','Salir');

		$n010000=anchor('#','Otro');

		$header['1'] = $nodes->m_header_nodes($n400000,$m400000);
		$header['2'] = $nodes->m_header_nodes($n010000,$m010000);
	
		$menu->m_create_headers($header);
		return $menu->show_menu();
	}

}
