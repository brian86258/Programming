public class Question1 {
    public static void main(String[] args) {
        int prime_count = 1;
        int num = 1;
        while (prime_count <= 100) {
            // For each num to test whether is prime
            boolean is_prime = true;
            for (int i = 2; i <= Math.floor(Math.sqrt(num)); i++) {
                if (num % i == 0) {
                    is_prime = false;
                    // System.out.printf("%d is not prime%n", num);
                    break;
                }
            }
            if (is_prime) {
                prime_count += 1;
                System.out.printf("%d is prime%n", num);
            }
            num += 1;
        }

    }

}
