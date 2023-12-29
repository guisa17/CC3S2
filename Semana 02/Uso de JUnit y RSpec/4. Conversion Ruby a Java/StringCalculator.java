public class StringCalculator {

    public static int add(String input) {
        if (input.isEmpty()) {
            return 0;
        } else {
            String[] numbers = input.split(",");
            int sum = 0;
            for (String number : numbers) {
                sum += Integer.parseInt(number);
            }
            return sum;
        }
    }
}