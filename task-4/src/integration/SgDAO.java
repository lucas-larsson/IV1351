package integration;

import model.Instrument;

import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;

/**
 * Author: DENNIS HADZIALIC
 * Date: 2022-01-06
 * Description:
 **/
public class SgDAO {
    private Connection connection;
    private final String DATABASE_URL = "jdbc:postgresql://localhost:5432/sg";
    private PreparedStatement getInstruments;
    private PreparedStatement getNumberOfActiveRentsbyStudent;
    private PreparedStatement addRentalForStundent;
    private PreparedStatement removeRentalForStudent;
    private PreparedStatement insertRentalToArchive;

    public SgDAO() throws SgDBException {
        try {
            connect();
        } catch (Exception e) {
            throw new SgDBException("Connection to database failed", e);
        }
    }

    private void connect() throws SQLException {
        Properties properties = new Properties();
        properties.setProperty("user", "postgres");
        connection = DriverManager.getConnection(DATABASE_URL, properties);
        connection.setAutoCommit(false);
        prepareStatements();
    }

    public ArrayList<Instrument> getInstruments(String type) throws SgDBException {
        ResultSet res = null;
        try {
            getInstruments.setString(1, type);
            res = getInstruments.executeQuery();
            ArrayList<Instrument> i = new ArrayList<Instrument>();
            while (res.next()) {
                i.add(new Instrument(
                        res.getString("instrument_id"),
                        res.getString("instrument"),
                        res.getString("brand"),
                        res.getDouble("price"),
                        res.getBoolean("is_rented"))
                );
            }
            connection.commit();
            return i;
        } catch (SQLException throwables) {
            handleDatabaseException("Could not fetch instrument", throwables);
        }
        return null;
    }

    public int countRentals(String studentId) throws SgDBException {
        ResultSet res = null;
        try {
            getNumberOfActiveRentsbyStudent.setString(1, studentId);
            res = getNumberOfActiveRentsbyStudent.executeQuery();
            int count = 0;
            while (res.next()) {
                count = res.getInt("amount");
            }
            connection.commit();
            return count;
        } catch (SQLException throwables) {
            handleDatabaseException("Could not count rentals", throwables);
        }
        return 0;
    }

    public void rentInstrument(String studentId, String instrumentId) throws SgDBException {
        try {
            addRentalForStundent.setString(1, studentId);
            addRentalForStundent.setString(2, instrumentId);
            addRentalForStundent.executeUpdate();
            connection.commit();
        } catch (SQLException throwables) {
            handleDatabaseException("Could not rent instrument", throwables);
        }
    }

    public void terminateRental(String instrumentId) throws SgDBException {
        try {
            removeRentalForStudent.setString(1, instrumentId);
            removeRentalForStudent.executeUpdate();
            connection.commit();
        } catch (SQLException throwables) {
            handleDatabaseException("Could not terminate rental", throwables);
        }
    }

    public void addRentalToArchive(String instrumentId) throws SgDBException {
        try {
            insertRentalToArchive.setString(1, instrumentId);
            insertRentalToArchive.execute();
            connection.commit();
        } catch (SQLException throwables) {
            handleDatabaseException("Could not add rental to archive", throwables);
        }
    }


    private void prepareStatements() throws SQLException {
        getInstruments = connection.prepareStatement(
                "SELECT * FROM instruments WHERE instrument = ? AND is_rented = FALSE;"
        );

        getNumberOfActiveRentsbyStudent = connection.prepareStatement(
                "SELECT COUNT(*) AS amount FROM instrument_rental WHERE student_id = ? AND is_rented = TRUE;"
        );

        addRentalForStundent = connection.prepareStatement(
                "WITH  rented  AS (" +
                        "UPDATE instrument_rental " +
                        "SET is_rented = TRUE, student_id = ?, start_date = CURRENT_DATE, end_date = CURRENT_DATE + INTERVAL '1 year' " +
                        "WHERE instrument_id = ? RETURNING * ) " +
                        "UPDATE instruments SET is_rented = TRUE " +
                        "WHERE instrument_id IN (SELECT instrument_id FROM rented);"
        );

        insertRentalToArchive = connection.prepareStatement(
                "INSERT INTO rental_archive (instrument_id, instrument, brand , price, student_id, start_date, end_date) " +
                        "SELECT instrument_id, instrument, brand , price, student_id , start_date, CURRENT_DATE " +
                        "FROM instrument_rental WHERE instrument_id = ?;"
        );

        removeRentalForStudent = connection.prepareStatement(
                "WITH  rented  AS ( " +
                        "UPDATE instrument_rental " +
                        "SET is_rented = FALSE, end_date = CURRENT_DATE, student_id = null " +
                        "WHERE instrument_id = ? RETURNING * ) " +
                        "UPDATE instruments SET is_rented = FALSE " +
                        "WHERE instrument_id IN (SELECT instrument_id FROM rented);"
        );
    }

    public void handleDatabaseException(String message, Exception e) throws SgDBException {
        try {
            connection.rollback();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        if (e != null) throw new SgDBException(message, e);
        else throw new SgDBException(message);
    }

}
