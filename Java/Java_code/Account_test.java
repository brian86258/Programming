import java.util.Scanner;

public class Account_test {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        Account myAccount = new Account();
        System.out.printf("The initial name is %s%n%n", myAccount.get_name());

        System.out.println("Please enter the name");
        // myAccount.set_name(new Scanner(System.in).nextLine());
        myAccount.set_name(input.nextLine());
        System.out.printf("The after name is %s%n%n", myAccount.get_name());

        Account myAccount2 = new Account("John");
        System.out.println("Please enter second person's name");

        myAccount2.set_name(input.nextLine());
        System.out.printf("The after name is %s%n%n", myAccount2.get_name());

        input.close();
    }

}
