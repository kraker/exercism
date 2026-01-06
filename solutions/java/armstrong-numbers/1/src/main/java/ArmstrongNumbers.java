
import java.util.ArrayList;

class ArmstrongNumbers {

    boolean isArmstrongNumber(int numberToCheck) {
        int num = numberToCheck;
        ArrayList<Integer> numsList = new ArrayList<>();
        while (num > 0) {
            numsList.add(num % 10);
            num /= 10;
        }
        int numsLength = numsList.size();
        int armSum = 0;
        for (int n : numsList) {
            armSum += Math.pow(n, numsLength);
        }
        return numberToCheck == armSum;
    }
}
