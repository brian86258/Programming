import java.util.Scanner;

public class Addition {
    public static int main(String[] args) {
        Scanner input = new Scanner(System.in);

        int n1;
        int n2;

        System.out.println("Enter first num");
        n1 = input.nextInt();

        System.out.println("Enter second num");
        n2 = input.nextInt();

        System.out.println(n1 + n2);
        input.close();

        int sum = n1 + n2;

        return sum;

    }

}