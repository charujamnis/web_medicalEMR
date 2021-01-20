package com.dtcc.controller;

import com.dtcc.dao.*;
import com.dtcc.model.Patient;
import com.dtcc.model.PatientHistoryInformation;
import com.dtcc.model.Procedure;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/PatientVisitServlet")
public class PatientVisitServlet extends HttpServlet {
    ProcedureDAO procedureDAO ;
    PatientDAO patientDAO;
    PatientVisitDAO patientVisitDAO;
    RequestDispatcher dispatcher=null;

    public PatientVisitServlet(){
        patientDAO=new PatientDAOImpl();
        procedureDAO=new ProcedureDAOImpl();
        patientVisitDAO=new PatientVisitDAOImpl();

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String select=request.getParameter("select");
        String patientId=request.getParameter("patientId");
        String procedureId=request.getParameter("procedureId");
        String purpose=request.getParameter("purpose");
        String dateOfVisit=request.getParameter("dateOfVisit");
        String nextAppointment=request.getParameter("nextAppointment");

        if(select==null){
            select="NO";
        }
        switch(select){
            case "YES" :
                showSelectedPatientData(request,response);
                break;

            case "NO" :
                showPatientData(request,response);
                break;

            case "PATIENTVISIT":
                try {
                    insertPatientVisitRow(request,response);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                break;

            case "DELETEHISTORY" :
                try {
                    deletePatientHistory(request,response,patientId,procedureId,purpose,dateOfVisit,nextAppointment);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    public void showSelectedPatientData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        String patientId=request.getParameter("patientId");
        String message=request.getParameter("message");

        List<PatientHistoryInformation> patientHistoryList=patientVisitDAO.getPatientHistory(Integer.parseInt(patientId));
        request.setAttribute("patientHistoryList",patientHistoryList);

        List<Patient> patientList = patientDAO.get();
        request.setAttribute("patientList", patientList);

        List<Procedure> procedureList = procedureDAO.get();
        request.setAttribute("procedureList", procedureList);
        request.setAttribute("selectedPatientId", request.getParameter("patientId"));

        dispatcher = request.getRequestDispatcher("/patient/patient_visit.jsp");
        dispatcher.forward(request, response);//get the request dispatcher
    }

    public void showPatientData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        List<Patient> patientList = patientDAO.get();
        request.setAttribute("patientList", patientList);

        List<Procedure> procedureList = procedureDAO.get();
        request.setAttribute("procedureList", procedureList);

        dispatcher = request.getRequestDispatcher("/patient/patient_visit.jsp");
        dispatcher.forward(request, response);//get the request dispatcher
    }

    public void insertPatientVisitRow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException {
        try{
            String patientId=request.getParameter("patient");
            String procedureId=request.getParameter("pSelect");
            String purpose=request.getParameter("purpose");
            String dateOfVisit=request.getParameter("nextAppointment");

            PatientHistoryInformation pInformation = new PatientHistoryInformation();
            pInformation.setPatientId(Integer.parseInt(patientId));
            pInformation.setProcedureId(Integer.parseInt(procedureId));
            pInformation.setPurpose(purpose);
            if(dateOfVisit==null || dateOfVisit.equals("")) {
               // System.out.println("in if ======");
                pInformation.setDateOfVisit(null);
            }else{
               // System.out.println("in else =============");
                Date dateVisit = new SimpleDateFormat("yyyy-MM-dd").parse(dateOfVisit);
                pInformation.setNextAppointment(dateVisit);
            }

            if(patientVisitDAO.save(pInformation)){ request.setAttribute("message","Patient Visit saved Successfully");}

            List<PatientHistoryInformation> patientHistoryList=patientVisitDAO.getPatientHistory(Integer.parseInt(patientId));
            request.setAttribute("patientHistoryList",patientHistoryList);

            List<Patient> patientList = patientDAO.get();
            request.setAttribute("patientList", patientList);

            List<Procedure> procedureList = procedureDAO.get();
            request.setAttribute("procedureList", procedureList);
            request.setAttribute("selectedPatientId", patientId);

            dispatcher = request.getRequestDispatcher("/patient/patient_visit.jsp");
            dispatcher.forward(request, response);//get the request dispatcher
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void deletePatientHistory(HttpServletRequest request, HttpServletResponse response,String patientId,String procedureId,String purpose, String dateOfVisit,String nextAppointment) throws ServletException, IOException, ParseException {

        PatientHistoryInformation pInformation=new PatientHistoryInformation();
        pInformation.setPatientId(Integer.parseInt(patientId));
        pInformation.setProcedureId(Integer.parseInt(procedureId));
        pInformation.setPurpose(purpose);
        Date dateVisit = new SimpleDateFormat("yyyy-MM-dd").parse(dateOfVisit);
        pInformation.setDateOfVisit(dateVisit);

        if(nextAppointment==null || nextAppointment.equals("")) {
            pInformation.setNextAppointment(null);
        }else{
            Date nextAppDate = new SimpleDateFormat("yyyy-MM-dd").parse(nextAppointment);
            pInformation.setNextAppointment(nextAppDate);
        }

        if(patientVisitDAO.delete(pInformation)){
            request.setAttribute("deleteMessage","Patient History row is deleted successfully");
        }

        getPatientVisitPage(request,response,patientId);
    }

    public void getPatientVisitPage(HttpServletRequest request, HttpServletResponse response,String patientId)throws ServletException, IOException, ParseException {
        //String patientId=request.getParameter("patientId");
        List<PatientHistoryInformation> patientHistoryList=patientVisitDAO.getPatientHistory(Integer.parseInt(patientId));
        request.setAttribute("patientHistoryList",patientHistoryList);

        List<Patient> patientList = patientDAO.get();
        request.setAttribute("patientList", patientList);

        List<Procedure> procedureList = procedureDAO.get();
        request.setAttribute("procedureList", procedureList);
        request.setAttribute("selectedPatientId", patientId);

        dispatcher = request.getRequestDispatcher("/patient/patient_visit.jsp");
        dispatcher.forward(request, response);//get the request dispatcher
    }
}
