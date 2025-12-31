
class BirdWatcher {
    private final int[] birdsPerDay;

    public BirdWatcher(int[] birdsPerDay) {
        this.birdsPerDay = birdsPerDay.clone();
    }

    public int[] getLastWeek() {
        int[] lastWeekBirdsPerDay = {0, 2, 5, 3, 7, 8, 4};
        return lastWeekBirdsPerDay;
    }

    public int getToday() {
        return birdsPerDay[birdsPerDay.length - 1];
    }

    public void incrementTodaysCount() {
        birdsPerDay[birdsPerDay.length - 1] += 1;
    }

    public boolean hasDayWithoutBirds() {
        for (int birds : birdsPerDay) {
            if (birds == 0)
            return true;
        }
        return false;
    }

    public int getCountForFirstDays(int numberOfDays) {
        if (numberOfDays > birdsPerDay.length) {
            numberOfDays = birdsPerDay.length;
        }

        int birdCount = 0;
        for (int i = 0; i < numberOfDays; i++) {
            birdCount += birdsPerDay[i];
        }
        return birdCount;
    }

    public int getBusyDays() {
        int busyDays = 0;
        for (int birds : birdsPerDay) {
            if (birds >= 5)
            busyDays += 1;
        }
        return busyDays;
    }
}
