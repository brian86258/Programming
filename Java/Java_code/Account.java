public class Account {
    private String name;
    // JAVA doesn't support default parameter type
    // To handle different situation needs to overloading consructors

    public Account() {
        System.out.println("In Constructor");
        this.name = "None";
    }

    // KEY, Constructor has no return type
    public Account(String name) {
        System.out.printf("In Constructor default name is %s%n", name);

        this.name = name;
    }

    public void set_name(String name) {
        this.name = name;
    }

    public String get_name() {
        return this.name;
    }

}
