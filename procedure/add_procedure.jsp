
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Medical EMR</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script>
        function validation(){

        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="header">
        <h1>MedicalEMR</h1>
    </div>


    <div class="topnav">
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="#">Patient</a>
        <a href="${pageContext.request.contextPath}/ProcedureServlet?action=LIST">Procedure</a>
        <a href="${pageContext.request.contextPath}/PatientVisitServlet?select=NO">Patient Visit</a>
    </div>

        <h5>Procedure Screen</h5>
        <div class=""row>
            <div class="column side small">
            </div>
            <div class="column middle small">
                <form action="${pageContext.request.contextPath}/ProcedureServlet" method="POST">
                    <div class="form-group">
                        <input type="hidden" name="procedureId" value="${procedure.procedureId}" />
                    </div>
                    <div class="form-group">
                        <input type="text" name="cpt" value="${procedure.cpt}" maxlength="6" required placeholder="Enter CPT" class="form-control"/><br/>
                    </div>
                    <div class="form-group">
                        <textarea name="description" rows="3" required placeholder="Enter Description" class="form-control">${procedure.description}</textarea><br/>
                    </div>
                    <div class="form-group">
                        <input type="text" name="cptName" value="${procedure.name}" placeholder="Enter name" class="form-control"/><br/>
                    </div>
                    <div class="form-group">
                        <input type="text" name="cost" value="${procedure.cost}" placeholder="Enter cost" class="form-control"/><br/>
                    </div>

                    <button class="btn btn-primary" type="submit" onclick="return validation()">Save Procedure</button>
                </form>
            </div>

            <div class="column side small">

            </div>
        </div>
    </div>
</body>
</html>
