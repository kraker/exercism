class MicroBlog {
    public String truncate(String input) {
        // https://www.baeldung.com/java-truncating-strings
        return input.codePoints()
          .limit(5)
          .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
          .toString();
    }
}
