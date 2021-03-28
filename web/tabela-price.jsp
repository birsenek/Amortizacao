<%-- 
    Document   : tabela-price
    Created on : 27 de mar. de 2021, 11:34:48
    Author     : BirseneK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    double valorPresente = 0, txJurosMes = 0, qtdeParcelas = 0, amortizacao = 0, parcela = 0, juros = 0;
    String errorMessage = null;
    try
    {
        valorPresente = Double.parseDouble(request.getParameter("valorPresente"));
        txJurosMes = Double.parseDouble(request.getParameter("txJurosMes"));
        qtdeParcelas = Double.parseDouble(request.getParameter("qtdeParcelas"));
        
        parcela = valorPresente * ((txJurosMes/100)/ (1 - (Math.pow((1 + txJurosMes/100), (qtdeParcelas*(-1))))));
        parcela = Math.round(parcela * 100d) / 100d;
    }
    catch (Exception ex)
    {
        errorMessage = "Erro na leitura dos parâmetros";
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cálculo de Amortização</title>
        <link rel="stylesheet" href="style.css"/>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <div id="body-content">
            <%@include file="WEB-INF/jspf/menu.jspf" %>
            <div id="text-content">
                <h1>Cálculo de Amortização</h1>
                <form action="tabela-price.jsp" id="form">
                    <p>Valor do Empréstimo:&nbsp;&nbsp; <input type="number" name="valorPresente"> </p>
                    <p>Taxa de juros ao mês:&nbsp;&nbsp;&nbsp; <input type="number" name="txJurosMes"></p>
                    <p>Quantidade de Parcelas: <input type="number" name="qtdeParcelas"></p>
                    <input type="submit" value="Calcular" id="calcButton">
                </form>  
                <section id="results">
                    <div id="section-break"></div>
                                                
                    <p>Valor do Empréstimo: <%= valorPresente%></p>
                    <p>Taxa de juros ao mês: <%= txJurosMes%>%</p>
                    <p>Quantidade de Parcelas: <%= qtdeParcelas%></p>
                    
                            <table id="tabela-resultados" border="1">
                                <tr>
                                    <th>Período</th>
                                    <th>Saldo Devedor</th>
                                    <th>Parcela</th>
                                    <th>Juros</th>
                                    <th>Amortização</th>
                                </tr>
                                <tr>
                                        <td>0</td>
                                        <td>R$ <%= valorPresente %></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                </tr>
                                
                                <%for(int i = 0; i < qtdeParcelas; i++){%>
                                    <tr>
                                        <%
                                        juros = Math.round((txJurosMes/100 * valorPresente) * 100d) / 100d;
                                        amortizacao = Math.round((parcela - juros) * 100d) / 100d;
                                        valorPresente = Math.round((valorPresente - amortizacao) * 100d) / 100d;
                                        valorPresente = valorPresente > 0 ? valorPresente : 0;
                                    %>
                                        <td><%= i+1 %></td>
                                        <td>R$ <%= valorPresente %></td>
                                        <td>R$ <%= parcela %></td>
                                        <td>R$ <%= juros %></td>
                                        <td>R$ <%= amortizacao %></td>
                                    </tr>                                   
                                <%}%>
                            </table>    
                </section>
            </div>
        </div>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
