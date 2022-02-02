package startup;

import controller.Controller;
import integration.SgDBException;
import view.CommandLine;

/**
 * Author: DENNIS HADZIALIC
 * Date: 2022-01-06
 * Description:
 **/
public class Main {
    public static void main(String[] args) {
        try {
            new CommandLine(new Controller());
        } catch (SgDBException e) {
            e.printStackTrace();
        }
    }
}
