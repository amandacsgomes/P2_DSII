<%-- 
    Document   : novoCliente
    Created on : 04/05/2017, 21:37:03
    Author     : Amanda
--%>

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
            String nome = request.getParameter("nome");
            String endereco = request.getParameter("endereco");
            String celular = request.getParameter("celular");
            String email = request.getParameter("email");
            String tipo = request.getParameter("tipo");
            String rh = request.getParameter("rh");

            Paciente paciente = new Paciente();
            paciente.setCpf(cpf);
            paciente.setNome(nome);
            paciente.setEndereco(endereco);
            paciente.setCelular(celular);
            paciente.setEmail(email);
            paciente.setTipoSanguineo(tipo);
            paciente.setFatorRh(rh);

            PacienteJpaController dao = new PacienteJpaController();
            dao.create(paciente);
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
                    <li><a href="paciente.html">Paciente</a></li>
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
                <h1>Paciente inserido com sucesso!</h1>
                <p><a href="paciente.html">Inserir novo paciente</a></p>
                <p><a href="consulta.html">Consultar paciente</a></p>
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
