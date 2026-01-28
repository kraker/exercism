class SqueakyClean {
    static String clean(String identifier) {
        char[] charArray = identifier.toCharArray();
        StringBuilder builder = new StringBuilder();
         
        for (int i = 0; i < charArray.length; i++) {
            if (Character.isWhitespace(charArray[i])) {
                builder.append('_');
            } else if (Character.isDigit(charArray[i])) {
                // Convert leetspeak to regular text
                switch (charArray[i]) {
                    case '0' -> builder.append('o');
                    case '1' -> builder.append('l');
                    case '3' -> builder.append('e');
                    case '4' -> builder.append('a');
                    case '7' -> builder.append('t');
                    default -> builder.append(charArray[i]);
                }
            } else if (charArray[i] == '-') {
                charArray[i + 1] = Character.toUpperCase(charArray[i + 1]);
            } else if (Character.isLetter(charArray[i])) {
                builder.append(charArray[i]);
            }
        }
        return builder.toString();
    }
}
