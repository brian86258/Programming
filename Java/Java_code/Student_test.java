public class Student_test {
    public static void main(String[] args) {
        Student s1 = new Student("James");
        Student s2 = new Student(30);
        Student s3 = new Student("Kitty", 99);

        System.out.println(s1.get_name() + ' ' + s1.get_id() + ' ' + s1.get_count());
        System.out.println(s3.get_count());

    }
}
