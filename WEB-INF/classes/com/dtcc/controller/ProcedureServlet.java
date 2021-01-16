package com.dtcc.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.*;
import java.util.*;
import com.dtcc.dao.*;
import com.dtcc.model.*;
import com.dtcc.util.DBConnectionUtil;

@WebServlet("/ProcedureServlet")
public class ProcedureServlet extends HttpServlet{

	ProcedureDAO procedureDAO ;   //variable for ProcedureDAO
	RequestDispatcher dispatcher=null;

	public ProcedureServlet(){ //initialize the procedureDAO object
		procedureDAO=new ProcedureDAOImpl(); }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action=request.getParameter("action");

		if(action==null){
			action="LIST";
		}

		switch(action){
			case "LIST":
				listProcedures(request,response);
				break;

			case "EDIT" :
				getSingleProcedure(request,response);
				break;

			case "DELETE" :
				deleteProcedure(request,response);
				break;

			default:
				listProcedures(request,response);
				break;
		}
	}



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String procedureId=request.getParameter("procedureId");
		    String cpt=request.getParameter("cpt");
			String description=request.getParameter("description");
			String name=request.getParameter("cptName");
			String cost= request.getParameter("cost");

			Procedure procedure = new Procedure();
			procedure.setCpt(cpt);
			procedure.setDescription(description);
			procedure.setName(name);
			if(cost.equals("")){procedure.setCost(0.0);}
			else{procedure.setCost(Double.parseDouble(cost));}

			if(procedureId !=null && procedureId.length() > 0){	//update operation
				procedure.setProcedureId(Integer.parseInt(procedureId));
				if(procedureDAO.update(procedure)){ request.setAttribute("message","Procedure updated Successfully");}

			}
			else{	//add operation
				if(procedureDAO.save(procedure)){ request.setAttribute("message","Procedure saved Successfully");}
			}
			listProcedures(request,response);
	}

	public void listProcedures(HttpServletRequest request, HttpServletResponse response){
		List<Procedure> procedureList = procedureDAO.get();
		request.setAttribute("list", procedureList);	//add procedures to the request object
		dispatcher = request.getRequestDispatcher("/procedure/all_procedures.jsp"); //get the request dispatcher
		try {
			dispatcher.forward(request, response);		//forward the request and response object.
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public void getSingleProcedure(HttpServletRequest request, HttpServletResponse response){
		String procedureId=request.getParameter("procedureId");
		Procedure procedure=procedureDAO.get(Integer.parseInt(procedureId));
		request.setAttribute("procedure",procedure);
		dispatcher = request.getRequestDispatcher("/procedure/add_procedure.jsp");
		try {
			dispatcher.forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void deleteProcedure(HttpServletRequest request, HttpServletResponse response) {
		String procedureId=request.getParameter("procedureId");
		if(procedureDAO.delete(Integer.parseInt(procedureId))){
			request.setAttribute("message","Procedure is deleted successfully");
		}
		listProcedures(request,response);
	}
}