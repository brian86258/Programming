import java.util.Scanner;

public class Question3 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);

        int num;
        num = input.nextInt();

        boolean prime = true;
        for (int i = 2; i <= Math.floor(Math.sqrt(num)); i++) {
            if (num % i == 0) {
                prime = false;
                System.out.printf("%d can divide %d, %d is not prime%n", i, num, num);
                break;
            }
        }
        if (prime)
            System.out.printf("%d is  prime%n", num);
    }
}
