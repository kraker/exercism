class MicroBlog {
    public String truncate(String input) {
        if (input.length() < 6) {
            return input;
        }
        else {
            return input.substring(0, 6);
        }
    }
}
