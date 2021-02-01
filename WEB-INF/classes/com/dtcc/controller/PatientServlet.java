package com.dtcc.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.*;
import java.util.*;
import com.dtcc.dao.*;
import com.dtcc.model.*;

@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {

    PatientDAO patientDAO;   //variable for PatientDAO
    RequestDispatcher dispatcher = null;

    public PatientServlet() { //initialize the patientDAO object
        patientDAO = new PatientDAOImpl();
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "LIST";
        }

        switch (action) {
            case "LIST":
                listPatient(request, response);
                break;

            case "EDIT":
                getSinglePatient(request, response);
                break;

            case "DELETE":
                deletePatient(request, response);
                break;

            default:
                listPatient(request, response);
                break;
        }
    }

    private void listPatient(HttpServletRequest request, HttpServletResponse response) {
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String patientId = request.getParameter("patientId");
        String accountnumber = request.getParameter("accountnumber");
        String addressId = request.getParameter("addressId");
        String first_name= request.getParameter("first_name");
        String last_name= request.getParameter("last_name");
        String dob = request.getParameter("dob");
        String gender= request.getParameter("gender");
        String height= request.getParameter("height");
        String weight= request.getParameter("weight");
        String email= request.getParameter("email");
        String phonenumber= request.getParameter("phonenumber");
        String maritalstatus= request.getParameter("maritalstatus");
        String ssn= request.getParameter("ssn");
        String emergencyname= request.getParameter("emergencyname");
        String emergencycontact= request.getParameter("emergencycontact");
        String employmentstatus= request.getParameter("employmentstatus");
        String medicalhistory= request.getParameter("medicalhistory");
        String allergies= request.getParameter("allergies");
        String medicine= request.getParameter("medicine");
        //String createdDate= request.getParameter("createdDate");

        Patient patient = new Patient();
        patient.setPatientId(Integer.parseInt(patientId));
        patient.setDescription(description);
        patient.setName(name);
        if (cost.equals("")) {
            patient.setCost(0.0);
        } else {
            patient.setCost(Double.parseDouble(cost));
        }

        if (patientId != null && patientId.length() > 0) {    //update operation
            patient.setPatientId(Integer.parseInt(patientId));
            if (patientDAO.update(patient)) {
                request.setAttribute("message", "Patient updated Successfully");
            }

        } else {    //add operation
            if (patientDAO.save(patient)) {
                request.setAttribute("message", "Patient saved Successfully");
            }
        }
        listPatients(request, response);
    }

    public void listPatients(HttpServletRequest request, HttpServletResponse response) {
        List<Patient> patientList = patientDAO.get();
        request.setAttribute("list", patientList);    //add patients to the request object
        dispatcher = request.getRequestDispatcher("/patient/all_patients.jsp"); //get the request dispatcher
        try {
            dispatcher.forward(request, response);        //forward the request and response object.
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public void getSinglePatient(HttpServletRequest request, HttpServletResponse response) {
        String patientId = request.getParameter("patientId");
        Patient patient = patientDAO.get(Integer.parseInt(patientId));
        request.setAttribute("patient", patient);
        dispatcher = request.getRequestDispatcher("/patient/add_patient.jsp");
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void deletePatient(HttpServletRequest request, HttpServletResponse response) {
        String patientId = request.getParameter("patientId");
        if (patientDAO.delete(Integer.parseInt(patientId))) {
            request.setAttribute("message", "Patient is deleted successfully");
        }
        listPatients(request, response);
    }
}
}