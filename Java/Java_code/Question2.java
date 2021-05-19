
public class Question2 {

    public static void main(String[] args) {
        int[] nums = { 9, 50, 82, 12, 27, 84, 92, 22, 96, 31 };
        // for (int i = 0; i < nums.length; i++)
        // System.out.println(nums[i]);

        // selection_sort(nums);
        quick_sort(nums);

        System.out.println("********");
        for (int i = 0; i < nums.length; i++)
            System.out.println(nums[i]);

    }

    private static void swap(int[] number, int i, int j) {
        int t = number[i];
        number[i] = number[j];
        number[j] = t;
    }

    // Selection Sort
    public static void selection_sort(int[] nums) {

        for (int i = 0; i < nums.length; i++) {
            int min = i;
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[j] < nums[min]) {
                    min = j;
                }
            }

            // Swap i-th element with minimum from the unsorted part
            swap(nums, i, min);
        }
    }

    // Quick Sort
    public static void quick_sort(int[] nums) {
        quick_sort(nums, 0, nums.length - 1);

    }

    public static void quick_sort(int[] nums, int left, int right) {
        // KEY base case
        if (left >= right)
            return;

        int pivotIndex = (left + right) / 2;
        int pivot = nums[pivotIndex];
        // swap the pivot to the rightmost
        // System.out.println("--" + pivot);
        swap(nums, pivotIndex, right);

        int swapIndex = left;

        for (int i = left; i < right; i++) {
            if (nums[i] <= pivot) {
                swap(nums, i, swapIndex);
                swapIndex += 1;
            }
        }
        // swap the pivot to original position
        swap(nums, swapIndex, right);
        // System.out.printf("%d %d %d%n", left, right, swapIndex);
        quick_sort(nums, left, swapIndex - 1);
        quick_sort(nums, swapIndex + 1, right);
    }
}
