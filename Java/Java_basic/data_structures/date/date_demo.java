package date;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class date_demo {
    public static void main(String[] args) {
        LocalDate myObj = LocalDate.now();
        LocalDateTime myDt = LocalDateTime.now();
        System.out.println(myObj);
        System.out.println(myDt);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy dd MM ");
        String formattedDate = myDt.format(formatter);

        System.out.println("After formating:" + formattedDate);

    }
}
