package com.dtcc.dao;

import com.dtcc.model.Procedure;

import java.sql.PreparedStatement;
import java.util.List;

public interface ProcedureDAO{
	List<Procedure> get(); //Get all the procedures
	boolean save(Procedure procedure);	//add the procedure into the database
	Procedure get(int procedureId);
	boolean update(Procedure procedure); //edit the procedure
	boolean delete(int procedureId);
}