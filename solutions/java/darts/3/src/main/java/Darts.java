class Darts {
    private static final double OUTER_RADIUS = 10.0;
    private static final double MIDDLE_RADIUS = 5.0;
    private static final double INNER_RADIUS = 1.0;

    int score(double xOfDart, double yOfDart) {
        double radius = Math.hypot(xOfDart, yOfDart);

        if (radius > OUTER_RADIUS) return 0;
        if (radius > MIDDLE_RADIUS) return 1;
        if (radius > INNER_RADIUS) return 5;
        return 10;
    }
}
