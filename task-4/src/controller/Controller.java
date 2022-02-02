package controller;

import integration.SgDAO;
import integration.SgDBException;
import model.Instrument;
import model.InstrumentException;

import java.util.ArrayList;

/**
 * Author: DENNIS HADZIALIC
 * Date: 2022-01-06
 * Description:
 **/
public class Controller {
    private final SgDAO sgDAO;

    public Controller() throws SgDBException {
        sgDAO = new SgDAO();
    }

    public ArrayList<Instrument> listInstrumentRental(String type) throws InstrumentException {
        final String baseError = "Query for listInstrumentRental with type " + type + " is unsuccessful";
        if (type == null)
            throw new InstrumentException(baseError);
        try {
            return sgDAO.getInstruments(type);
        } catch (SgDBException e) {
            throw new InstrumentException("Did not manage to update database");
        }
    }

    public int checkRentPossibility(String studentId) throws Exception {
        final String baseError = "Could not check availability for student,";
        if (studentId == null) throw new Exception(baseError + " studentId was 'null'");
        try {
            return sgDAO.countRentals(studentId);
        } catch (SgDBException e) {
            throw new Exception("Was not able to fetch data from databse", e);
        }
    }

    public void rentInstrument(String studentId, String instrumentId) throws InstrumentException {
        final String baseError = "Could not rent instrument, ";
        if (studentId == null) throw new InstrumentException(baseError + "studentId was 'null'");
        if (instrumentId == null) throw new InstrumentException(baseError + "instrumentId was 'null'");
        try {
            sgDAO.rentInstrument(studentId, instrumentId);
        } catch (SgDBException e) {
            throw new InstrumentException("Did not manage to update database");
        }
    }

    public void terminateRental(String instrumentId) throws InstrumentException{
        final String baseError = "Could not terminate rental, ";
        if(instrumentId == null) throw new InstrumentException(baseError + "instrumentId was 'null'");
        try{
            sgDAO.addRentalToArchive(instrumentId);
            sgDAO.terminateRental(instrumentId);
        } catch(SgDBException e){
            throw new InstrumentException("Did not manage to update database");
        }
    }
}
