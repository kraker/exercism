public class CarsAssemble {

    public double productionRatePerHour(int speed) {
        if (speed > 0 && speed <= 4) {
            return speed * 221 * 1.0;

        } else if (speed > 4 && speed <= 8) {
            return speed * 221 * 0.9;

        } else if (speed == 9) {
            return speed * 221 * 0.8;

        } else if (speed == 10) {
            return speed * 221 * 0.77;
            
        } else {
            // Speed out of bounds
            System.out.println("Speed must be between 1 - 10.");
            return 0.0;
        }
    }

    public int workingItemsPerMinute(int speed) {
        double itemsPerHour = productionRatePerHour(speed);
        return (int) (itemsPerHour / 60);
    }
}
