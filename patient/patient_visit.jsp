<%@ page import="java.sql.Connection" %>
<%@ page import="com.dtcc.util.DBConnectionUtil" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Patient Visit</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script>

        function sendPatientIdToServlet(){
            var patientId=document.getElementById('patientSelect').value;
           // alert(patientId);
            window.location.href='${pageContext.request.contextPath}/PatientVisitServlet?select=YES&patientId='+patientId;
        }

        function validateForm(){
            if(document.getElementById('patientSelect').value==0){
                alert('Please select Patient');
                return false;
            }
            if(document.getElementById('procedureSelect').value==0){
                alert('Please select Procedure');
                return false;
            }
        }

        function deletePatientHistory(patientId,procedureId,purpose,dateOfVisit,nextAppointment){

           // var form = document.forms[0];
            const result = confirm("Are you sure, you want to delete the row?");
            if(result){
                //form.action='/PatientVisitServlet?select=DELETEHISTORY&patientId='+patientId+'&procedureId='+procedureId+'&purpose='+purpose+'&dateOfVisit='+dateOfVisit+'&nextAppointment='+nextAppointment;
               // form.action='/PatientVisitServlet?select=DELETEHISTORY';
               // form.method = "POST";
                //form.submit();
                window.location.href='${pageContext.request.contextPath}/PatientVisitServlet?select=DELETEHISTORY&patientId='+patientId+'&procedureId='+procedureId+'&purpose='+purpose+'&dateOfVisit='+dateOfVisit+'&nextAppointment='+nextAppointment;
            }
        }
        function getProcedureIdValue(){
            var selectedProcdureId=document.getElementById('procedureSelect').value;
            //window.location.reload(true);
        }
    </script>
</head>
<body>

    <div class="container">
        <h4>Patient Visit Screen</h4>
        <h6>${message}</h6>
        <h6>${deleteMessage}</h6>
        <div class=""row>
            <div class="col-md-4">
                <form name="form-visit"  method="POST" onsubmit="return validateForm()" action="${pageContext.request.contextPath}/PatientVisitServlet?select=PATIENTVISIT">
                    <div class="form-group">
                        <input type="hidden" name="patientId" value="${patient.patientId}" />
                    </div>

                    <div class="form-group">
                        <input type="hidden" name="procedureId" value="${procedure.procdeureId}" />
                    </div>

                    <div class="form-group">
                        <input type="hidden" name="addressId" value="${procedure.addressId}" />
                    </div>


                    <div class="form-group">
                        <input type="hidden" name="patientList" value="${patientList}" />
                    </div>

                    <div class="form-group">
                        <input type="hidden" name="procedureList" value="${procedureList}" />
                    </div>

                    <br/>


                    <div class="form-group">
                        <!--  <label>Select Patient</label> -->
                        <select id="patientSelect" name="patient" required placeholder="Select Patient" class="form-control" onchange="sendPatientIdToServlet();">
                            <option value="0">Select Patient</option>
                            <c:forEach items="${patientList}" var="patient">

                                <option value="${patient.patientId}" ${patient.patientId == selectedPatientId ? 'selected' : ''}>${patient.first_name} ${patient.last_name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <br/>


                    <div class="form-group">
                        <!-- <label>Select Procedure</label> -->
                        <select id="procedureSelect" name="pSelect" required class="form-control" onchange="getProcedureIdValue()">
                            <option value="0">Select Procedure</option>
                            <c:forEach items="${procedureList}" var="procedure">
                                <option value="${procedure.procedureId}" ${procedure.procedureId == selectedProcdureId ? 'selected' : ''}>${procedure.cpt}</option>
                            </c:forEach>

                        </select>
                    </div>


                    <br/>

                    <%! String desc="";%>
                    <%
                       //String pID = request.getParameter("pSelect");
                        //System.out.println("The PID is outherdddddddddd "+pID);
                       // if(pID!=null) {
                       //    System.out.println("The PID is "+pID);
                       //     // request.setAttribute("procedure",procedure);
                       //    Connection connection = DBConnectionUtil.getConnection();
                       //    String sql = "select description from procedures where procedureId=?";
                        //  PreparedStatement ps = connection.prepareStatement(sql);
                         //  ps.setInt(1, Integer.parseInt(pID));
                         //  ResultSet rs = ps.executeQuery();
                         //  while (rs.next()) {
                         //     desc = rs.getString("description");
                         //  }
                       //}
                        %>

                    <div>
                         <label>Procedure Description</label>
                        <textarea id="txtArea" name="description" rows="2" cols="50" readonly class="form-control"><%=desc%></textarea>
                        <!-- <input type="text" name="name" value="" readonly class="form-control"/> -->
                    </div>


                    </br>
                    <div class="form-group">
                        <!-- <label>Purpose Of Visit</label> -->
                        <input type="text" name="purpose" value="" placeholder="Purpose of visit" class="form-control"/>
                    </div>

                    <br/>

                    <div class="form-group">
                         <label>Next Appointment</label>
                        <input type="date" name="nextAppointment" value="" placeholder="Next Appointment" class="form-control"/>
                    </div>

                    </br>
                    <button class="btn btn-primary" type="submit">Save</button>

                    <hr>

                    <table class="table table-striped table-hover" width="80%">
                        <tr>
                            <th>Name</th>
                            <th>Account Number</th>
                            <th>CPT</th>
                            <th>Date Of Visit </th>
                            <th>Purpose</th>
                            <th>Next Appointment</th>
                            <th>Description</th>
                            <th>Delete</th>
                        </tr>

                        <c:forEach items="${patientHistoryList}" var="patientHistory">
                            <tr>
                                <td>${patientHistory.firstName} ${patientHistory.lastName} </td>
                                <td>${patientHistory.accountNumber}</td>
                                <td>${patientHistory.cpt}</td>
                                <td>${patientHistory.dateOfVisit}</td>
                                <td>${patientHistory.purpose}</td>
                                <td>${patientHistory.nextAppointment}</td>
                                <td>${patientHistory.desc}</td>
                                <!-- <td><input type="button" name="update" value="Update" onclick="window.location.href='${pageContext.request.contextPath}/ProcedureServlet?action=EDIT&procedureId=${procedure.procedureId}'"/></td> -->
                                <td><input type="button" name="delete" value="Delete" onclick="deletePatientHistory(${patientHistory.patientId},${patientHistory.procedureId},'${patientHistory.purpose}','${patientHistory.dateOfVisit}','${patientHistory.nextAppointment}')"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
