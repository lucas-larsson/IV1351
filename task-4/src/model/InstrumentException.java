package model;

/**
 * Author: DENNIS HADZIALIC
 * Date: 2022-01-06
 * Description:
 **/
public class InstrumentException extends Exception{
    public InstrumentException(String error){
        super(error);
    }

    public InstrumentException(String error, Throwable t){
        super(error, t);
    }
}
