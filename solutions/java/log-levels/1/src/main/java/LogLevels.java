public class LogLevels {
    
    public static String message(String logLine) {
        // Split at first ":" and return array of strings
        String[] logLineArr = logLine.split(":", 2);
        // Assign 2nd string element in array which is the message and trim
        // whitespace on either end.
        String message = logLineArr[1].trim();
        return message;
    }

    public static String logLevel(String logLine) {
        String[] logLineArr = logLine.split(":", 2);
        String logLevel = logLineArr[0];
        int logLevelLength = logLevel.length();
        return logLevel.substring(1, logLevelLength - 1).toLowerCase();
    }

    public static String reformat(String logLine) {
        return message(logLine) + " (" + logLevel(logLine) + ")";
    }
}
