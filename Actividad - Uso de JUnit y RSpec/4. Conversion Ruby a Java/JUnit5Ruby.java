import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class JUnit5Ruby {

    @Test
    public void sumTest1() {
        int result = StringCalculator.add("2,4");
        assertEquals(6, result);
    }

    @Test
    public void sumTest2() {
        int result = StringCalculator.add("17,100");
        assertEquals(117, result);
    }
}
