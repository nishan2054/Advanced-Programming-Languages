import java.util.ArrayList;

public class MemoryDemo {
    public static void main(String[] args) {
        ArrayList<Integer> data = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            data.add(i);
        }

        print(data);
        data = null;  //GC will clean up
        System.gc(); //Garbage collection
    }

    public static void print(ArrayList<Integer> data) {
        for (int val : data) {
            System.out.println("Java value: " + val);
        }
    }
}