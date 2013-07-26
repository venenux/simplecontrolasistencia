<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Indexcontroler extends CI_Controller {

	function __construct()
	{
		parent::__construct();
		$this->load->helper(array('form', 'url','html'));
		$this->load->library('table');
		$this->load->model('menu');
		 //el profiler esta dañado.. debido a una mala coarga de arreglos para los de idiomas
		$this->output->enable_profiler(TRUE);
	}

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/indexcontroler
	 *	- or -  
	 * 		http://example.com/index.php/indexcontroler/index
	 *	- or -
	 * Since this controller is set as the default controller in 
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/indexcontroler/<method_name>
	 * @see /user_guide/general/urls.html
	 */
	public function index()
	{
		$data['menu'] = $this->menu->general_menu();
		$this->load->view('header.php',$data);
		$this->load->view('inicion.php',$data);
		$this->load->view('footer.php',$data);
	}
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */
