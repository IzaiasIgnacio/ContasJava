<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	    <title>Contas</title>
	    <!-- Bootstrap -->
	    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
	    <link href="css/estilo.css" rel="stylesheet">
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	    <script src="js/jquery.js"></script>
	    <script src="js/jquery-ui.js"></script>
	    <script src="js/jquery.maskedinput.js"></script>
	    <script src="js/jquery.maskmoney.js"></script>
	    <!-- Include all compiled plugins (below), or include individual files as needed -->
	    <script src="bootstrap/js/bootstrap.min.js"></script>
	    <script type="text/javascript">
	    	$(function() {
	    		var tb = 0;
	    		var linha;
	    		$(".btn_recalcular").click(function() {
	    			window.location=window.location;
	    		});
	    		$(".btn_saldo").click(function() {
	    			$("#formulario_saldo").modal('show');
	    			$("#form_saldo #valor_saldo").focus();
	    		});
	    		$('.modal').on('shown.bs.modal', function () {
	    			$('input:text:visible:first').focus();
	    		})
	    		$(".btn_renda").click(function() {
	    			$("#formulario_renda").modal('show');
	    		});
	    		$(".btn_meses").click(function() {
	    			$("#formulario_mes_inicial").modal('show');
	    		});
	    		$(".btn_add_gasto").click(function() {
	    			tb = $(this).closest('table').attr('id');
	    			var titulo = "Adicionar Gasto ou Renda ("+$(this).closest('table').find('thead th').html()+")";
	    			$("#formulario_gasto .modal-title").html(titulo);
	    			var data = $(this).closest('table').find('input[type=hidden]').val().split("|");
	    			$("#formulario_gasto #mes_gasto").val(data[0]);
	    			$("#formulario_gasto #ano_gasto").val(data[1]);
	    			$("#formulario_gasto #descricao").val('');
	    			$("#formulario_gasto #valor").val('');
	    			$("#formulario_gasto #parcelas").val('1');
	    			$("#formulario_gasto").modal('show');
	    		});
	    		
	    		$("tbody tr").click(function() {
	    			linha = $(this);
	    			var titulo = "Editar Gasto ou Renda ("+$(this).closest('table').find('thead th').html()+")";
	    			$("#formulario_editar_gasto .modal-title").html(titulo);
	    			var data = $(this).closest('table').find('input[type=hidden]').val().split("|");
	    			$("#formulario_editar_gasto #mes_gasto").val(data[0]);
	    			$("#formulario_editar_gasto #ano_gasto").val(data[1]);
	    			if ($(this).hasClass("success")) {
	    				$("#formulario_editar_gasto #tipo_registro_gasto").prop('checked',false);
	    				$("#formulario_editar_gasto #tipo_registro_renda").prop('checked',true);
	    			}
	    			if ($(this).hasClass("active")) {
	    				$("#formulario_editar_gasto #tipo_registro_gasto").prop('checked',true);
	    				$("#formulario_editar_gasto #tipo_registro_renda").prop('checked',false);
	    			}
	    			$("#formulario_editar_gasto #descricao").val($(this).find('td:eq(0)').html());
	    			/*var p = $(this).find('td:eq(1)').html().split("/");
	    			$("#formulario_editar_gasto #parcelas").val(p[1]);*/
	    			$("#formulario_editar_gasto #valor").val($(this).find('td:eq(2)').html());
	    			$("#formulario_editar_gasto #id_gasto").val($(this).find("input[name=id_registro]").val());
	    			$("#formulario_editar_gasto").modal('show');
	    		});
	    		
	    		$("#formulario_gasto .salvar").click(function() {
	    			if (validar("formulario_gasto")) {
		    			$.post('IncluirGasto.action',{tipo:$("#formulario_gasto input[name=tipo_registro]:checked").val(),
		    			descricao:$("#formulario_gasto #descricao").val(),valor:$("#formulario_gasto #valor").val().replace(",","."),
		    			parcelas:$("#formulario_gasto #parcelas").val(),mes_gasto:$("#formulario_gasto #mes_gasto").val(),
		    			ano_gasto:$("#formulario_gasto #ano_gasto").val()},
		    			function(resposta) {
		    				var parcelas = $("#formulario_gasto #parcelas").val();
		    				var p = tb.split("_");
		    				var proxima = parseInt(p[1]);
		    				for (var i=1;i<=parcelas;i++) {
		    					if (proxima <= 4) {
			    					var html = '';
			    	    			html += "<tr class='info'>";
			    	    			html += "	<td width='65%''>"+$("#formulario_gasto #descricao").val()+"</td>";
			    	    			html += "	<td width='10%' align='center'>"+i+"/"+parcelas+"</td>";
			    	    			html += "	<td width='25%' align='right'>"+$("#formulario_gasto #valor").val()+"</td>";
			    	    			html += "</tr>";
			    	    			$("#"+tb+" tbody tr:last").after(html);
			    	    			p = tb.split("_");
			    	    			if (i < parcelas) {
			    	    				proxima = (parseInt(p[1])+1);
			    	    				tb = tb.slice(0,-1) + proxima;
			    	    			}
		    					}
		    				}
		    				$("#formulario_gasto").modal('hide');
		    			});
	    			}
	    		});
	    		
	    		$("#formulario_editar_gasto .salvar").click(function() {
	    			if (validar("formulario_editar_gasto")) {
		    			$.post('EditarGastos.action',{id:$("#formulario_editar_gasto #id_gasto").val(),
		    			tipo:$("#formulario_editar_gasto input[name=tipo_registro]:checked").val(),
		    			descricao:$("#formulario_editar_gasto #descricao").val(),
		    			valor:$("#formulario_editar_gasto #valor").val().replace(",","."),
		    			mes_gasto:$("#formulario_editar_gasto #mes_gasto").val(),ano_gasto:$("#formulario_editar_gasto #ano_gasto").val()},
		    			function(resposta) {
		    				$(linha).find('td:eq(0)').html($("#formulario_editar_gasto #descricao").val());
		    				$(linha).find('td:eq(2)').html($("#formulario_editar_gasto #valor").val());
		    				$("#formulario_editar_gasto").modal('hide');
		    				$(linha).switchClass("active","warning",1000);
		    			});
	    			}
	    		});
	    		
	    		$("#formulario_saldo .salvar").click(function() {
	    			if (validar("formulario_saldo")) {
		    			$.post('ConfigurarSaldo.action',{saldo:$("#formulario_saldo #valor_saldo").val().replace(",",".")},
		    			function(resposta) {
		    				$("#formulario_saldo").modal('hide');
		    			});
	    			}
	    		});
	    		
	    		$("#formulario_renda .salvar").click(function() {
	    			if (validar("formulario_renda")) {
		    			$.post('ConfigurarRenda.action',{renda:$("#formulario_renda #valor_renda").val().replace(",",".")},
		    			function(resposta) {
		    				$("#formulario_renda").modal('hide');
		    			});
	    			}
	    		});
	    		
	    		$("#formulario_mes_inicial .salvar").click(function() {
	    			if (validar("formulario_mes_inicial")) {
		    			$.post('ConfigurarMesInicial.action',{mes:$("#formulario_mes_inicial #mes_inicial").val()},
		    			function(resposta) {
		    				$("#formulario_mes_inicial").modal('hide');
		    			});
	    			}
	    		});
	    		
	    		$("#form_saldo #valor_saldo, #form_renda #valor_renda, #form_gasto #valor, #form_editar_gasto #valor").maskMoney({
					thousands:'',
					decimal:','
				});
	    		$("#form_gasto #parcelas, #form_editar_gasto #parcelas").mask("9?9");
	    		$("#formulario_mes_inicial #mes_inicial").mask("99/9999");
	    		
	    		$("#formulario_editar_gasto .excluir").click(function() {
	    			$.post('ExcluirGastos.action',{id:$("#formulario_editar_gasto #id_gasto").val()},
	    			function(resposta) {
	    				$(linha).switchClass("active","danger",1000);
	    				$("#formulario_editar_gasto").modal('hide');
	    			});
	    		});
	    		
	    		$("input[type=text]").focus(function() {
	    			$(this).tooltip("destroy");
	    			$(this).removeClass("erro");
	    		});
	    	});
	    	function validar(formulario) {
	    		var retorno = true;
	    		$("#"+formulario+" input[type=text]").each(function() {
	    			if ($(this).val() == '') {
	    				$(this).addClass('erro');
	    				$(this).tooltip({
	    						delay: {show: 0, hide: 200},
	    						trigger: "manual"
	    				});
	    				$(this).tooltip("show");
	    				retorno = false;
	    			}
	    		});
	    		return retorno;
	    	}
	    </script>
	    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	    <% double saldo; %>
	</head>
	<body>
		<fmt:setLocale value="pt_BR"/>
		<div id="formulario_saldo" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Saldo atual</h4>
					</div>
					<div class="modal-body">
						<form id='form_saldo'>
							<div class="form-group">
								<label for="valor_saldo">Valor</label>
								<input type="text" value='<fmt:formatNumber type="number" value="${saldo}" groupingUsed="false" maxFractionDigits="2"/>' title="Informe o saldo atual" class="form-control" name="valor_saldo" id="valor_saldo" placeholder="Valor">
							</div>
							<button type="button" class="btn btn-info salvar">Salvar</button>
							<button type="button" class="btn btn-warning" data-dismiss="modal">Cancelar</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div id="formulario_renda" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Renda mensal</h4>
					</div>
					<div class="modal-body">
						<form id='form_renda'>
							<div class="form-group">
								<label for="valor_renda">Valor</label>
								<input type="text" value='<fmt:formatNumber type="number" value="${renda_mensal}" groupingUsed="false" maxFractionDigits="2"/>' title="Informe a renda mensal" class="form-control" name="valor_renda" id="valor_renda" placeholder="Renda">
							</div>
							<button type="button" class="btn btn-info salvar">Salvar</button>
							<button type="button" class="btn btn-warning" data-dismiss="modal">Cancelar</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div id="formulario_mes_inicial" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Mês inicial</h4>
					</div>
					<div class="modal-body">
						<form id='form_mes'>
							<div class="form-group">
								<label for="mes_inicial">Mês inicial</label>
								<input type="text" value="${mes_inicial}" title="Informe o mês inicial" class="form-control" name="mes_inicial" id="mes_inicial" placeholder="Mês">
							</div>
							<button type="button" class="btn btn-info salvar">Salvar</button>
							<button type="button" class="btn btn-warning" data-dismiss="modal">Cancelar</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div id="formulario_gasto" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<form id='form_gasto'>
							<input type='hidden' id='mes_gasto'>
							<input type='hidden' id='ano_gasto'>
							<label class="radio-inline tipo_registro">
								<input type="radio" name="tipo_registro" id="tipo_registro_gasto" value="gasto" checked='true'> Gasto
							</label>
							<label class="radio-inline tipo_registro">
								<input type="radio" name="tipo_registro" id="tipo_registro_renda" value="renda"> Renda
							</label>
							<br>
							<br>
							<div class="form-group">
								<label for="descricao">Descrição</label>
								<input title="Informe a descrição" type="text" class="form-control" name="descricao" id="descricao" placeholder="Descrição">
							</div>
							<div class="form-group">
								<label for="valor">Valor</label>
								<input type="text" title="Informe o valor" class="form-control" name="valor" id="valor" placeholder="Valor">
							</div>
							<div class="form-group">
								<label for="valor">Nº de parcelas</label>
								<input type="text" title="Informe o nº de parcelas" class="form-control" name="parcelas" id="parcelas" placeholder="Parcelas">
							</div>
							<button type="button" class="btn btn-info salvar">Salvar</button>
							<button type="button" class="btn btn-warning" data-dismiss="modal">Cancelar</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div id="formulario_editar_gasto" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<form id='form_editar_gasto'>
							<input type='hidden' id='id_gasto'>
							<input type='hidden' id='mes_gasto'>
							<input type='hidden' id='ano_gasto'>
							<label class="radio-inline tipo_registro">
								<input type="radio" name="tipo_registro" id="tipo_registro_gasto" value="gasto" checked='true'> Gasto
							</label>
							<label class="radio-inline tipo_registro">
								<input type="radio" name="tipo_registro" id="tipo_registro_renda" value="renda"> Renda
							</label>
							<br>
							<br>
							<div class="form-group">
								<label for="musica">Descrição</label>
								<input type="text" title="Informe a descrição" class="form-control" name="descricao" id="descricao" placeholder="Descrição">
							</div>
							<div class="form-group">
								<label for="valor">Valor</label>
								<input type="text" title="Informe o valor" class="form-control" name="valor" id="valor" placeholder="Valor">
							</div>
							<!--<div class="form-group">
								<label for="valor">Nº de Parcelas</label>
								<input type="text" title="Informe o nº de parcelas" class="form-control" name="parcelas" id="parcelas" placeholder="Parcelas">
							</div>-->
							<button type="button" class="btn btn-info salvar">Salvar</button>
							<button type="button" class="btn btn-warning" data-dismiss="modal">Cancelar</button>
							<button type="button" class="btn btn-danger excluir" data-dismiss="modal">Excluir</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<button type="button" class="btn btn-primary btn_saldo">Saldo atual</button>
			<button type="button" class="btn btn-primary btn_renda">Renda mensal</button>
			<button type="button" class="btn btn-primary btn_meses">Mês inicial</button>
			<button type="button" class="btn btn-danger btn_recalcular">Atualizar</button>
		</div>
		<div class="container">
			<c:set var="total" value="0"/>
			<table class="table table-hover table-condensed table-bordered" id='tb_1'>
				<input type='hidden' name='data' value='${m1}|${ano1}'>
				<thead>
					<tr>
						<th colspan='3'>${mes1}</th>
					</tr>
					<tr>
						<td colspan='3'><fmt:formatNumber type="currency" currencySymbol="R$ " value="${saldo}" groupingUsed="false" maxFractionDigits="2"/></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gastos1" items="${gastos1}">
						<tr class='${gastos1.tipo == "gasto" ? "active" : "success"}'>
							<td width='65%'>${gastos1.descricao}</td>
							<td width='10%' align='center'>${gastos1.parcela}/${gastos1.total_parcelas}</td>
							<td width='25%' align='right'><fmt:formatNumber type="number" value="${gastos1.valor}" groupingUsed="false" maxFractionDigits="2"/></td>
							<input type='hidden' name='id_registro' value='${gastos1.id}'>
						</tr>
						<c:choose>
							<c:when test="${gastos1.tipo == 'gasto'}">
								<c:set var="total" value="${total + gastos1.valor}"/>
							</c:when>
							<c:when test="${gastos1.tipo == 'renda'}">
								<c:set var="total" value="${total - gastos1.valor}"/>
							</c:when>
						</c:choose>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan='2'>Total</td>
						<td align='right'><fmt:formatNumber type="number" value="${total}" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td colspan='2'>Sobra</td>
						<c:set var="sobra" value="${saldo - total}"/>
						<td align='right'><fmt:formatNumber type="number" value="${sobra}" groupingUsed="false" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td colspan='3' class='td_add_gasto'>
							<button type="button" class="btn btn-info btn_add_gasto">
								<span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
							</button>
						</td>
					</tr>
				</tfoot>
			</table>
			<c:set var="total" value="0"/>
			<c:set var="saldo" value="${sobra + renda_mensal}"/>
			<table class="table table-hover table-condensed table-bordered" id='tb_2'>
				<input type='hidden' name='data' value='${m2}|${ano2}'>
				<thead>
					<tr>
						<th colspan='3'>${mes2}</th>
					</tr>
					<tr>
						<td colspan='3'><fmt:formatNumber type="currency" currencySymbol="R$ " value="${saldo}" groupingUsed="false" maxFractionDigits="2"/></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gastos2" items="${gastos2}">
						<tr class='${gastos2.tipo == "gasto" ? "active" : "success"}'>
							<td width='65%'>${gastos2.descricao}</td>
							<td width='10%' align='center'>${gastos2.parcela}/${gastos2.total_parcelas}</td>
							<td width='25%' align='right'><fmt:formatNumber type="number" value="${gastos2.valor}" groupingUsed="false" maxFractionDigits="2"/></td>
							<input type='hidden' name='id_registro' value='${gastos2.id}'>
						</tr>
						<c:choose>
							<c:when test="${gastos2.tipo == 'gasto'}">
								<c:set var="total" value="${total + gastos2.valor}"/>
							</c:when>
							<c:when test="${gastos2.tipo == 'renda'}">
								<c:set var="total" value="${total - gastos2.valor}"/>
							</c:when>
						</c:choose>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan='2'>Total</td>
						<td align='right'><fmt:formatNumber type="number" value="${total}" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td colspan='2'>Sobra</td>
						<c:set var="sobra" value="${saldo - total}"/>
						<td align='right'><fmt:formatNumber type="number" value="${sobra}" groupingUsed="false" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td colspan='3' class='td_add_gasto'>
							<button type="button" class="btn btn-info btn_add_gasto">
								<span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
							</button>
						</td>
					</tr>
				</tfoot>
			</table>
			<c:set var="total" value="0"/>
			<c:set var="saldo" value="${sobra + renda_mensal}"/>
			<table class="table table-hover table-condensed table-bordered" id='tb_3'>
				<input type='hidden' name='data' value='${m3}|${ano3}'>
				<thead>
					<tr>
						<th colspan='3'>${mes3}</th>
					</tr>
					<tr>
						<td colspan='3'><fmt:formatNumber type="currency" currencySymbol="R$ " value="${saldo}" groupingUsed="false" maxFractionDigits="2"/></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gastos3" items="${gastos3}">
						<tr class='${gastos3.tipo == "gasto" ? "active" : "success"}'>
							<td width='65%'>${gastos3.descricao}</td>
							<td width='10%' align='center'>${gastos3.parcela}/${gastos3.total_parcelas}</td>
							<td width='25%' align='right'><fmt:formatNumber type="number" value="${gastos3.valor}" groupingUsed="false" maxFractionDigits="2"/></td>
							<input type='hidden' name='id_registro' value='${gastos3.id}'>
						</tr>
						<c:choose>
							<c:when test="${gastos3.tipo == 'gasto'}">
								<c:set var="total" value="${total + gastos3.valor}"/>
							</c:when>
							<c:when test="${gastos3.tipo == 'renda'}">
								<c:set var="total" value="${total - gastos3.valor}"/>
							</c:when>
						</c:choose>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan='2'>Total</td>
						<td align='right'><fmt:formatNumber type="number" value="${total}" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td colspan='2'>Sobra</td>
						<c:set var="sobra" value="${saldo - total}"/>
						<td align='right'><fmt:formatNumber type="number" value="${sobra}" groupingUsed="false" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td colspan='3' class='td_add_gasto'>
							<button type="button" class="btn btn-info btn_add_gasto">
								<span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
							</button>
						</td>
					</tr>
				</tfoot>
			</table>
			<c:set var="total" value="0"/>
			<c:set var="saldo" value="${sobra + renda_mensal}"/>
			<table class="table table-hover table-condensed table-bordered" id='tb_4'>
				<input type='hidden' name='data' value='${m4}|${ano4}'>
				<thead>
					<tr>
						<th colspan='3'>${mes4}</th>
					</tr>
					<tr>
						<td colspan='3'><fmt:formatNumber type="currency" currencySymbol="R$ " value="${saldo}" groupingUsed="false" maxFractionDigits="2"/></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gastos4" items="${gastos4}">
						<tr class='${gastos4.tipo == "gasto" ? "active" : "success"}'>
							<td width='65%'>${gastos4.descricao}</td>
							<td width='10%' align='center'>${gastos4.parcela}/${gastos4.total_parcelas}</td>
							<td width='25%' align='right'><fmt:formatNumber type="number" value="${gastos4.valor}" groupingUsed="false" maxFractionDigits="2"/></td>
							<input type='hidden' name='id_registro' value='${gastos4.id}'>
						</tr>
						<c:choose>
							<c:when test="${gastos4.tipo == 'gasto'}">
								<c:set var="total" value="${total + gastos4.valor}"/>
							</c:when>
							<c:when test="${gastos4.tipo == 'renda'}">
								<c:set var="total" value="${total - gastos4.valor}"/>
							</c:when>
						</c:choose>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan='2'>Total</td>
						<td align='right'><fmt:formatNumber type="number" value="${total}" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td colspan='2'>Sobra</td>
						<c:set var="sobra" value="${saldo - total}"/>
						<td align='right'><fmt:formatNumber type="number" value="${sobra}" groupingUsed="false" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td colspan='3' class='td_add_gasto'>
							<button type="button" class="btn btn-info btn_add_gasto">
								<span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
							</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>	
	</body>
</html>