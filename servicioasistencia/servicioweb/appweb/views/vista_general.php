	<?php
	if (!isset($titlepage)) $titlepage = 'Bienvenid@ Usuario';
	if (!isset($contlrname)) $contlrname = 'indexcontroler';
	if (!isset($datacontent)) $datacontent = 'Disponible en esta seccion:';
	if (!isset($viewstyle)) $viewstyle = '';
	if (!isset($pagination) || empty($pagination)) $pagination = '';
	if (!isset($actionnow)) $actionnow = 0;
	if (!isset($cel1)) $cel1 = 'Informacion del Sistema';
	if (!isset($cel2)) $cel2 = 'Reportes';
	if (!isset($cel3)) $cel3 = 'Registros de Huellas';
	if (!isset($cel4)) $cel4 = 'Volver al inicio';
	$clasequasbut='rounded';
	echo heading($titlepage, 2, 'class="titlesubpage"'), PHP_EOL;
	echo '<div class="containerssearch">', PHP_EOL;
			$moretable = '';
			if ($contlrname == 'reportes_general')
			{
				$urlctr1 = 'reportes_registro_deta'; $urltxt1 = 'Asistencias Detalladas';
				$urlctr2 = 'reportes_registro_mens'; $urltxt2 = 'Asistencias Mensuales';
				$urlctr3 = 'reportes_enrolamientos'; $urltxt3 = 'Registros de Huellas';
				$urlctr4 = ''; $urltxt4 = 'Volver al inicio';
			}
			else if ($contlrname == 'consultas_general')
			{
				$urlctr1 = 'registrar_ficha_ide'; $urltxt1 = 'Registro Trabajador';
				$urlctr2 = 'consultas_busca_ide'; $urltxt2 = 'Consulta de Trabajador';
				$urlctr3 = 'consultas_busca_cri'; $urltxt3 = 'Consulta Hoja de Vida';
				$urlctr4 = 'gestiones_sistencia'; $urltxt4 = 'Totalizador Asistencias';
//				$urlctr5 = 'gestiones_nocturnos'; $urltxt5 = config_item('label'.$urlctr5);
			}
			else
			{
				$urlctr1 = 'indexcontroler/about'; $urltxt1 = 'Información';
				$urlctr2 = 'reportes_general'; $urltxt2 = 'Reportes';
				$urlctr3 = 'consultas_general'; $urltxt3 = 'Gestión';
				$urlctr4 = 'indexcontroler/logout'; $urltxt4 = 'Salir';
			}
			

			$cel1 = anchor($urlctr1, '<img src="'.base_url().APPPATH.'media/'.strtolower($urlctr1).'.png" alt="'.$urltxt1.'" height="120" width="120"  class="'.$clasequasbut.' btn-primary btn-large b10"/>', 'class="none"');
			$cel2 = anchor($urlctr2, '<img src="'.base_url().APPPATH.'media/'.strtolower($urlctr2).'.png" alt="'.$urltxt2.'" height="120" width="120"  class="'.$clasequasbut.' btn-primary btn-large b10"/>', 'class=""');
			$cel3 = anchor($urlctr3, '<img src="'.base_url().APPPATH.'media/'.strtolower($urlctr3).'.png" alt="'.$urltxt3.'" height="120" width="120"  class="'.$clasequasbut.' btn-primary btn-large b10"/>', 'class=""');
			$cel4 = anchor($urlctr4, '<img src="'.base_url().APPPATH.'media/'.strtolower($urlctr4).'.png" alt="'.$urltxt4.'" height="120" width="120"  class="'.$clasequasbut.' btn-primary btn-large b10"/>', 'class=""');
			$cet1 = '<div class="'.$clasequasbut.'">'.$urltxt1.'</div>';
			$cet2 = '<div class="'.$clasequasbut.'">'.$urltxt2.'</div>';
			$cet3 = '<div class="'.$clasequasbut.'">'.$urltxt3.'</div>';
			$cet4 = '<div class="'.$clasequasbut.'">'.$urltxt4.'</div>';
			$this->table->add_row($cet1,$cet2,$cet3,$cet4);
			$this->table->add_row($cel1,$cel2,$cel3,$cel4);
			$moretable=$this->table->generate();
			$this->table->clear();
	echo $moretable, PHP_EOL;
	?>
