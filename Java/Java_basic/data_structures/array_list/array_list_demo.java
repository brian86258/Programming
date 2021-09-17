package array_list;

import java.util.ArrayList;
import java.util.Collections;

public class array_list_demo {
    public static void main(String[] args) {
        // ArrayList<OBJECT_TYPE> OBJECTNAME = new ArrayList<OBJECT_TYPE>()
        // ArrayList := c++ vector
        ArrayList<String> cars = new ArrayList<String>();

        // ArrayList: Add Items
        cars.add("Volvo");
        cars.add("BMW");
        cars.add("Ford");
        cars.add("Mazda");

        System.out.println(cars);
        System.out.println(cars.get(3));

        String tmp_car = cars.get(0);
        System.out.println(tmp_car);

        cars.set(0, "Volvo_truck");

        cars.add(3, "Benz");
        System.out.println(cars);
        Collections.reverse(cars);
        System.out.println(cars);

        // int list

        ArrayList<Integer> myNumbers = new ArrayList<Integer>();
        Collections.addAll(myNumbers, 5, 2, 3, 6, 7, 2, 13, 5, 7);

        System.out.println(myNumbers);
        Collections.sort(myNumbers);
        System.out.println(myNumbers);
        for (int i : myNumbers) {
            System.out.println(i);
        }
        Collections.sort(myNumbers, Collections.reverseOrder());
        System.out.println(myNumbers);
    }

}
