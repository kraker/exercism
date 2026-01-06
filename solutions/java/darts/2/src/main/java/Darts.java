class Darts {
    int score(double xOfDart, double yOfDart) {
        double xyLength = Math.hypot(xOfDart, yOfDart);

        if (xyLength > 10) return 0;
        else if (xyLength > 5) return 1;
        else if (xyLength > 1) return 5;
        else return 10;
    }
}
