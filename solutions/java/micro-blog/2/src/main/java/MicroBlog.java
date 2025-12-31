class MicroBlog {
    public String truncate(String input) {
        return input.codePoints()
          .limit(5)
          .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
          .toString();
    }
    // public void main(String[] args) {
    //     // String input = "Test case";
    //     String input = "Fly 🛫";
    //     System.out.println(truncate(input));
    // }
}
