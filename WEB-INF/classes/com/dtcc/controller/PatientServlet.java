package com.dtcc.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
                listPatients(request, response);
                break;

            case "EDIT":
                getSinglePatient(request, response);
                break;

            case "DELETE":
                deletePatient(request, response);
                break;

            default:
                listPatients(request, response);
                break;
        }
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
        String medicines= request.getParameter("medicines");
        //String createdDate= request.getParameter("createdDate");
        String address1=request.getParameter("address1");
        String address2=request.getParameter("address2");
        String district=request.getParameter("district");
        String city=request.getParameter("city");
        String postalcode=request.getParameter("postalcode");
        String country=request.getParameter("country");


        Patient patient = new Patient();
        Address address=new Address();

       // patient.setPatientId(Integer.parseInt(patientId));
        patient.setAccountnumber(Integer.parseInt(accountnumber));
        //patient.setAddressId(Integer.parseInt(addressId));
        patient.setFirst_name(first_name);
        patient.setLast_name(last_name);
        try {
            if(dob.equals(null) || dob.equals("") ||dob.isEmpty()){
                patient.setDob(null);
            }else{
                patient.setDob((new SimpleDateFormat("yyyy-MM-dd").parse(dob)));
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }
        patient.setGender(gender.charAt(0));
        if(height==null || height.equals("") ||height.isEmpty()) {
            patient.setHeight(0);
        }else{ patient.setHeight(Double.parseDouble(height));}

        if(weight==null || weight.equals("") ||weight.isEmpty()) {
            patient.setWeight(0);
        }else{ patient.setWeight(Double.parseDouble(weight));}

        patient.setEmail(email);
        patient.setPhonenumber(phonenumber);
        patient.setMaritalstatus(maritalstatus);

        if(ssn==null || ssn.equals("") || ssn.isEmpty()){
            patient.setSsn(0L);
        }else{ patient.setSsn(Long.parseLong(ssn));}

        patient.setEmergencyname(emergencyname);
        patient.setEmergencycontact(emergencycontact);
        patient.setEmploymentstatus(employmentstatus);
        patient.setMedicalhistory(medicalhistory);
        patient.setAllergies(allergies);
        patient.setMedicines(medicines);

        //Address Information

        address.setAddress1(address1);
        address.setAddress2(address2);
        address.setDistrict(district);
        address.setCity(city);
        address.setPostalcode(postalcode);
        address.setCountry(country);


        if (patientId != null && patientId.length() > 0) {    //update operation
            patient.setPatientId(Integer.parseInt(patientId));
            if (patientDAO.update(patient,address)) {
                request.setAttribute("message", "Patient updated Successfully");
            }

        } else {    //add operation
            if (patientDAO.save(patient,address)) {
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
            //System.out.println("The address ID ::::::: "+patient.getAddressId());
            Address address=patientDAO.getPatientAddress(patient.getAddressId());

            request.setAttribute("patient", patient);
            request.setAttribute("address", address);
            request.setAttribute("selectedGender",patient.getGender()+"");
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
        String addressId = request.getParameter("addressId");
        System.out.println("The patientId: "+patientId+" addressID :"+addressId);

        if (patientDAO.delete(Integer.parseInt(patientId))) {
            request.setAttribute("message", "Patient is deleted successfully");
        }
        listPatients(request, response);
    }
}
//}