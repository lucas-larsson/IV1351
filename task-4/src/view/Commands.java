package view;

/**
 * Author: DENNIS HADZIALIC
 * Date: 2022-01-06
 * Description:
 **/
public class Commands {
    private String[] command;

    public Commands() {
    }

    public String listCommands() {
        return "1. li <type> (List instruments with specific type)\n" +
                "2. rent <studentId> <instrumentId> (rent instrument with id to student with id)\n" +
                "3. terminate <instrumentId> (terminate rental for the student and instrument)\n" +
                "4. exit\n";
    }

    public String input(String in) {
        this.command = in.split("\\s+");
        return this.command[0];
    }

    public String getArgument(int arg) {
        if (this.command.length < arg) return null;
        return this.command[arg];
    }
}
