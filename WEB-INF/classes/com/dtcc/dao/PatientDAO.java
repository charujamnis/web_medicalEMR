package com.dtcc.dao;
import com.dtcc.model.Address;
import com.dtcc.model.Patient;
import com.dtcc.model.Procedure;
import java.util.List;

public interface PatientDAO {
    List<Patient> get(); //Get all the procedures
    Address getPatientAddress(int addressId);   //Get Patient Address by providing addressId

}

