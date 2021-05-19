import java.util.ArrayList;
import java.util.Scanner;

public class Question0 {

    public static void main(String[] args) {
        ArrayList<Integer> primes = new ArrayList<Integer>();
        Scanner input = new Scanner(System.in);

        int limit;
        limit = input.nextInt();

        for (int num = 1; num <= limit; num++) {
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
}
