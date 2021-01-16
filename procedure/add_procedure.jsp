
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add / Edit Procedure</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script>
        function validation(){

        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Procedure Screen</h1>
        <div class=""row>
            <div class="col-md-4">
                <form action="${pageContext.request.contextPath}/ProcedureServlet" method="POST">
                    <div class="form-group">
                        <input type="hidden" name="procedureId" value="${procedure.procedureId}" />
                    </div>
                    <div>
                        <input type="text" name="cpt" value="${procedure.cpt}" maxlength="6" required placeholder="Enter CPT" class="form-control"/><br/>
                    </div>
                    <div>
                        <textarea name="description" rows="3" required placeholder="Enter Description" class="form-control">${procedure.description}</textarea><br/>
                    </div>
                    <div>
                        <input type="text" name="cptName" value="${procedure.name}" placeholder="Enter name" class="form-control"/><br/>
                    </div>
                    <div>
                        <input type="text" name="cost" value="${procedure.cost}" placeholder="Enter cost" class="form-control"/><br/>
                    </div>

                    <button class="btn btn-primary" type="submit" onclick="return validation()">Save Procedure</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
