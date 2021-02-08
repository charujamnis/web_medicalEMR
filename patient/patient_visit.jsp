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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script>

       /* $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();
        });*/

        function sendPatientIdToServlet(){
            var patientId=document.getElementById('patientSelect').value;
            window.location.href='${pageContext.request.contextPath}/PatientVisitServlet?select=YES&patientId='+patientId;
        }

        function validateForm(){
            if(document.getElementById('patientSelect').value==""){
                alert('Please select Patient');
                return false;
            }
            if(document.getElementById('procedureSelect').value==""){
                alert('Please select Procedure');
                return false;
            }
        }

        function deletePatientHistory(patientId,procedureId,purpose,dateOfVisit,nextAppointment){

            const result = confirm("Are you sure, you want to delete the row?");
            if(result){
                window.location.href='${pageContext.request.contextPath}/PatientVisitServlet?select=DELETEHISTORY&patientId='+patientId+'&procedureId='+procedureId+'&purpose='+purpose+'&dateOfVisit='+dateOfVisit+'&nextAppointment='+nextAppointment;
            }
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
        <a href="PatientServlet?action=LIST">Patient</a>
        <a href="ProcedureServlet?action=LIST">Procedure</a>
        <a href="PatientVisitServlet?select=NO">Patient Visit</a>
    </div>

    <div class="row">
        <h6>${message}</h6>
        <h6>${deleteMessage}</h6>

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




                    <div class="form-group">
                        <!--  <label>Select Patient</label> -->
                        <select id="patientSelect" name="patient" required placeholder="Select Patient" class="form-control" onchange="sendPatientIdToServlet();">
                            <option value="">Select Patient</option>
                            <c:forEach items="${patientList}" var="patient">

                                <option value="${patient.patientId}" ${patient.patientId == selectedPatientId ? 'selected' : ''}>${patient.first_name} ${patient.last_name} - ${patient.accountnumber}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <br/>


                    <div class="form-group">
                        <!-- <label>Select Procedure</label> -->
                        <select id="procedureSelect" name="pSelect" required class="form-control">
                            <option value="">Select Procedure</option>
                            <c:forEach items="${procedureList}" var="procedure">
                                <option value="${procedure.procedureId}" ${procedure.procedureId == selectedProcdureId ? 'selected' : ''}>${procedure.cpt} ${procedure.description}</option>
                            </c:forEach>

                        </select>
                    </div>

                    <br/>

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
                </form>
            </div>

            <div class="col-md-8">
                <form name="form-visit2"/>
                <div class="table-responsive text-nowrap">
                    <table class="table table-striped table-hover table-bordered" width="80%">
                        <tr>
                            <th>Name</th>
                            <th>Account</th>
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

                               <td> <a href="#" style="text-decoration:none" data-toggle="tooltip" title="${patientHistory.desc}">Description</a></td>
                                <!-- <td><input type="button" name="update" value="Update" onclick="window.location.href='${pageContext.request.contextPath}/ProcedureServlet?action=EDIT&procedureId=${procedure.procedureId}'"/></td> -->
                                <td><input type="button" name="delete" value="Delete" onclick="deletePatientHistory(${patientHistory.patientId},${patientHistory.procedureId},'${patientHistory.purpose}','${patientHistory.dateOfVisit}','${patientHistory.nextAppointment}')"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                </form>
            </div>
    </div>

</div>

<div class="footer">
    <p> All Rights Reserved. Copyright &copy; 2021</p>
</div>

</body>
</html>
