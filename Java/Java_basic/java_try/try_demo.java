package java_try;

import java.util.Scanner;

import org.w3c.dom.TypeInfo;

public class try_demo {

    public static void main(String[] args) {
        // int i = 9;
        Scanner sc = new Scanner(System.in);
        System.out.println("Please input");

        String i = sc.next();

        System.out.println(i);
        System.out.println(i.getClass().getName());

        double d = 90.30;
        System.out.println(d.getClass().getName());
    }

}
