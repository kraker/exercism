

class ArmstrongNumbers {

    boolean isArmstrongNumber(int numberToCheck) {
        int digits = String.valueOf(numberToCheck).length();
        int num = numberToCheck;
        int sum = 0;

        while (num > 0) {
            int digit = num % 10;
            sum += (int) Math.pow(digit, digits);
            num /= 10;
        }

        return numberToCheck == sum;
    }
}
