<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$this->load->helper('html');
$this->load->helper('html');
	echo doctype('xhtml1-trans'), PHP_EOL,'<html xmlns="http://www.w3.org/1999/xhtml">', PHP_EOL;
	echo '<head>', PHP_EOL;
	include FCPATH.APPPATH.config_item('defsview').'/headersets.php';
		echo meta($meta);
		echo link_tag($linkdefcss);
		echo script_tag($linkbrownavdecsjs);
		echo script_tag($linkvalidaformsjs);
		echo script_tag($linktabberdetaljs);
		echo script_tag($linkdatepickerugl);
	echo '</head>', PHP_EOL;
	?>
	<body onload = 'checkAvailable()' >
		<div class="menu ">
			<center>
				<!--<img src="<?php echo $giflogo ?>" alt="Logo VNX Codeigniter" width="880" height="24" />-->
				<?=$menu.PHP_EOL?>
			</center>
		</div>
	<center>
