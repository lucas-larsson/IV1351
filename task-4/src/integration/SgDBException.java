package integration;

/**
 * Author: DENNIS HADZIALIC
 * Date: 2022-01-06
 * Description:
 **/
public class SgDBException extends Exception{
 public SgDBException(String error){
     super(error);
 }

 public SgDBException(String error, Throwable t){
     super(error, t);
 }
}
