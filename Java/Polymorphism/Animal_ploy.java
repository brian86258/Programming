package Java.Polymorphism;
// KEY, package name should reflect the file structure

// Abstract class polymorphism
abstract class Animal {
    public abstract void animalSound();
}

interface Animal_template {
    public void animalSound();
}

// class Pig implements Animal_template
class Pig extends Animal {
    public void animalSound() {
        System.out.println("PIG says ssss");
    }
}

// class Dog implements Animal_template
class Dog extends Animal {
    public void animalSound() {
        System.out.println("Dogs says DDDDDDD");
    }
}

public class Animal_ploy {
    public static void main(String[] args) {
        // Animal myAnimal = new Animal();
        Animal myDog = new Dog();
        Animal myPig = new Pig();

        // Animal_template myPig = new Pig();
        // Animal_template myDog = new Dog();
        // myAnimal.animalSound();
        myDog.animalSound();
        myPig.animalSound();

    }
}
