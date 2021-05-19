public class Student {
    static private int students_count = 0;
    String name;
    int Id;

    public Student(String name) {
        System.out.printf("In Constructor%nThe students count is %d%n", students_count);
        System.out.printf("The student's name is %s%n", name);
        this.name = name;
        System.out.printf("The student's Id is %d%n", Id);
        students_count += 1;
    }

    public Student(int Id) {
        System.out.printf("In Constructor%nThe students count is %d%n", students_count);
        System.out.printf("The student's name is %s%n", name);
        System.out.printf("The student's Id is %d%n", Id);
        this.Id = Id;
        students_count += 1;

    }

    public Student(String name, int Id) {
        System.out.printf("In Constructor%nThe students count is %d%n", students_count);
        System.out.printf("The student's name is %s%n", name);
        this.name = name;
        System.out.printf("The student's Id is %d%n", Id);
        this.Id = Id;
        students_count += 1;

    }

    public String get_name() {
        return this.name;
    }

    public int get_id() {
        return this.Id;
    }

    public int get_count() {
        return students_count;
    }
}
