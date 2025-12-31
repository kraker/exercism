public class JedliksToyCar {

    private int drivenMeters = 0;
    private int batteryRemaining = 100;

    public static JedliksToyCar buy() {
        return new JedliksToyCar();
    }

    public String distanceDisplay() {
        return "Driven " + drivenMeters +" meters";
    }

    public String batteryDisplay() {
        return (batteryRemaining > 0) ? "Battery at " + batteryRemaining + "%"
            : "Battery empty";
    }

    public void drive() {
        if (batteryRemaining > 0) {
            drivenMeters += 20;
            batteryRemaining -= 1;
        }
    }
}
