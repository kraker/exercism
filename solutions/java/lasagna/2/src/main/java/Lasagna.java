public class Lasagna {
    public int expectedMinutesInOven() {
        return 40;
    }
    public int remainingMinutesInOven(int currentMinutes) {
        return expectedMinutesInOven() - currentMinutes;
    }
    public int preparationTimeInMinutes(int numLayers) {
        return numLayers * 2;
    }
    public int totalTimeInMinutes(int numLayers, int currentMinutes) {
        int prepMinutes = preparationTimeInMinutes(numLayers);
        return prepMinutes + currentMinutes;
    }
}
