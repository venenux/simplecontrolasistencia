<?php
/*
 * menulib.php , web browser need have ccs level 2 support as minimun
 *
 * Copyright 2012 PICCORO Lenz McKAY <mckaygerhard@gmail.com>
 *
 */


/*
 * name: MenuLib
 * @description: menu class implementation for codeigniter used in catalogo
 * @author: PICCORO Lenz McKAY <mckaygerhard@gmail.com>
 */
class MenuLib
{
	/** member to out put the build menu nodes */
	public $outputmenu = '';

	function __construct()
	{
		$obj = & get_instance(); /* load objects for build */
		$obj->load->helper('url'); /* need for use the anchor function and makes urls */
	}

	/**
	 * @author: PICCORO Lenz McKAY <mckaygerhard@gmail.com>
	 * @name: m_create_headers
	 * @params: array of nodes (pairs of destination/names)
	 * @description: make the main tabs of menus where nodes will be hooked
	 */
	function m_create_headers($param)
	{
		$menu = '<table class="menutable menubackground ">';
		//$menu .= '<tbody>';
		$menu .= '<tr >';
		foreach($param as $prm)
		{
			$menu .= $prm;
		}
		$menu .= '</tr>';
		//$menu .= '</tbody>';
		$menu .= '</table>';
		$this->outputmenu=$menu;
	}

	/**
	 * @author: PICCORO Lenz McKAY <mckaygerhard@gmail.com>
	 * @name: show_menu
	 * @params: none BUT must previosly make nodes with m_header_nodes and m_create_headers
	 * @description: build menu html final structure for output in view
	 */
	function show_menu()
	{
		return $this->outputmenu;
	}
}

/*
 * name: MenuNodes
 * @description: menu helper class implementation for codeigniter used in catalogo
 * @author: PICCORO Lenz McKAY <mckaygerhard@gmail.com>
 */
class MenuNodes
{

	/**
	 * @author: PICCORO Lenz McKAY <mckaygerhard@gmail.com>
	 * @name: m_header_nodes
	 * @param: menu_name: node names of main header menu
	 * @param: param: array of links for corresponden menu node names
	 * @description: make the nodes for each main header menu name parsed
	 */
	function m_header_nodes($menu_name,$param)
	{
		// TODO: PENDING perfiles here, get user and set menu by perfil
		$menu = '<td class="menuheaders menubackground">' . $menu_name;
		$menu .= '<ul class="menunodes menubackground">';
		foreach($param as $prm)
		{
			$menu .= '<li class=" btn b10">' . $prm . '</li>';
		}
		$menu .= '</ul>';
		$menu .= '</td>';
		return $menu;
	}
}
/*EOF*/
