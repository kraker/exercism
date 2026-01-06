import java.math.BigInteger;

class Grains {

    BigInteger grainsOnSquare(final int square) {
        // Check if out of bounds. Chess board has 1 - 64 squares.
        if (square < 1 || square > 64) {
            throw new IllegalArgumentException("square must be between 1 and 64");
        }

        BigInteger seed = new BigInteger("2");
        return seed.pow(square - 1);
    }

    BigInteger grainsOnBoard() {
        BigInteger grainsOnBoard = new BigInteger("0");

        for (int i = 64; i > 0; i--) {
            grainsOnBoard = grainsOnBoard.add(grainsOnSquare(i));
        }
        return grainsOnBoard;
    }

}
