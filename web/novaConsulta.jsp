<%-- 
    Document   : novoCliente
    Created on : 04/05/2017, 21:37:03
    Author     : Amanda
--%>

<%@page import="java.util.Date"%>
<%@page import="dao.ConsultaJpaController"%>
<%@page import="modelo.Consulta"%>
<%@page import="dao.PacienteJpaController"%>
<%@page import="modelo.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Consultório Médico</title>
        <meta charset="utf-8">
        <link href="layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
    </head>
    <body id="top" class="bgded fixed" style="background-image:url('img/fundo.png');">

        <% String cpf = request.getParameter("cpf");
           String relatos = request.getParameter("relatos");
           String medicacoes = request.getParameter("medicacoes");
           String exames = request.getParameter("exames");

            Consulta consulta = new Consulta();

            PacienteJpaController daoPaciente = new PacienteJpaController();
            Paciente paciente = daoPaciente.findPaciente(cpf);
            
            System.out.println("testeeee "+paciente.getNome());

            consulta.setCpf(paciente);
            consulta.setData(new Date(2017, 11, 30));
            consulta.setRelatosPaciente(relatos);
            consulta.setMedicacoesPrescritas(medicacoes);
            consulta.setExamesSolicitados(exames);

            ConsultaJpaController dao = new ConsultaJpaController();
            dao.create(consulta);
        %>
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ -->
        <div class="wrapper row0">
            <header id="header" class="clear"> 
                <!-- ################################################################################################ -->
                <div id="logo">
                    <h1><a href="index.html">Consultório Médico</a></h1>
                </div>
                <!-- ################################################################################################ --> 
            </header>
        </div>
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ -->
        <div class="wrapper row1">
            <nav id="mainav" class="clear"> 
                <!-- ################################################################################################ -->
                <ul class="clear">
                    <li><a href="index.html">Home</a></li>
                    <li><a href="paciente.html">Paciente</a></li>
                    <li><a href="consulta.html">Consulta</a></li>
                </ul>
                <!-- ################################################################################################ --> 
            </nav>
        </div>
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ -->
        <div class="wrapper row2">
            <div id="breadcrumb"> 
                <!-- ############################################################################################################# -->
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a href="consulta.html">Consulta</a></li>
                </ul>
                <!-- ############################################################################################################# --> 
            </div>
        </div>
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ -->
        <div class="wrapper row3">
            <main id="container" class="clear"> 
                <!-- container body --> 
                <!-- ########################################################################################## -->
                <h1>Consulta salva com sucesso!</h1>
                <!-- ########################################################################################## --> 
                <!-- / container body -->
                <div class="clear"></div>
            </main>
        </div>
        <!-- ################################################################################################ --> 
        <!-- ################################################################################################ -->
        <div class="wrapper row5">
            <div id="copyright" class="clear"> 
                <!-- ################################################################################################ -->
                <p class="fl_left">Copyright &copy; 2017 - All Rights Reserved - <a href="#">Domain Name</a></p>
                <p class="fl_right">Template by <a target="_blank" href="http://www.os-templates.com/" title="Free Website Templates">OS Templates</a></p>
                <!-- ################################################################################################ --> 
            </div>
        </div>
    </body>
</html>
