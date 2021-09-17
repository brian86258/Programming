package array;

import java.util.Random;
import java.util.Scanner;

public class array_demo {
    static void min(int arr[]) {
        int min = arr[0];
        for (int tmp : arr) {
            if (tmp < min) {
                min = tmp;
            }
        }
        System.out.println("**********");
        System.out.println(min);
    }

    static int[] get() {
        return new int[] { 1, 2, 3, 5, 9 };
    }

    static void init_dynamic_array() {
        System.out.println("Enter the size of the desired array");
        Scanner sc = new Scanner(System.in);
        int size = sc.nextInt();
        int[] array = new int[size];
        Random ran = new Random();

        for (int i = 0; i < array.length; i++) {
            array[i] = ran.nextInt(30);

        }
        for (int i : array) {
            System.out.println(i);
        }
        // // Or directly use random to generate random integer
        // For example if you want to generate five random integers (or a single one) in
        // the range [0, 10], just do:
        int[] random_nums = ran.ints(5, 0, 11).toArray();
        System.out.println(random_nums);
        for (int i : random_nums) {
            System.out.println(i);
        }

        //
        // System.out.println("/////");
        // System.out.println(ran.ints(-1, 3).findFirst().getAsInt());
    }

    static void jagged_array() {
        System.out.println("Jagged Array***");
        int arr[][] = new int[3][];
        arr[0] = new int[3];
        arr[1] = new int[4];
        arr[2] = new int[2];
        // initializing a jagged array
        int count = 0;
        for (int i = 0; i < arr.length; i++)
            for (int j = 0; j < arr[i].length; j++)
                arr[i][j] = count++;

        // printing the data of a jagged array
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr[i].length; j++) {
                System.out.print(arr[i][j] + " ");
            }
            System.out.println();// new line
        }
    }

    static void matrix_multiplication() {
        int a[][] = { { 1, 1, 1 }, { 2, 2, 2 } };
        int b[][] = { { 1, 1, 1 }, { 2, 2, 2 }, { 3, 3, 3 } };
        int c[][] = new int[3][3]; // 3 rows and 3 columns

        for (int i = 0; i < 2; i++) {

            for (int j = 0; j < 3; j++) {
                c[i][j] = 0;
                for (int k = 0; k < 3; k++)
                    c[i][j] += a[i][k] * b[k][j];
                System.out.print(c[i][j] + "  ");
            }
            System.out.println("");
        }

    }

    public static void main(String[] args) {
        int a[] = new int[5]; // five integer elements in a array
        a[0] = 99;
        a[2] = 29;
        a[3] = 39;
        a[1] = 49;

        System.out.println(a.getClass().getName());
        System.out.println(a);

        for (int i : a) {
            System.out.println(i);
        }

        int b[] = { 1, 2, 3, 4, 8, 9 };
        System.out.println(b);
        for (int i : b) {
            System.out.println(i);
        }
        min(b);

        int[] got_array = get();
        for (int i : got_array) {
            System.out.println(i);
        }
        // init_dynamic_array();
        // jagged_array();
        // matrix_multiplication();
        int a2[][] = { { 1, 1, 1 }, { 2, 2, 2 } };
        System.out.println(a2.length);
        System.out.println(a2[0].length);

    }
}
