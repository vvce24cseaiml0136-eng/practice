
package com.example.vvce.evenodd;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;



public class AppTest {

	@Test
    void testTotal() {
        assertEquals(225,
            App.calculateTotal(75, 68, 82));
    }

    @Test
    void testAverage() {
        assertEquals(75.0,
            App.calculateAverage(75, 68, 82));
    }

    @Test
    void testPass() {
        assertTrue(App.isPass(75.0));
    }

    @Test
    void testFail() {
        assertFalse(App.isPass(35.0));
    }
}
