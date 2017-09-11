import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/5/16.
 * Description: *_*
 */
public class PlaygroundTest {
    @Before
    public void setUp() throws Exception {

    }

    @After
    public void tearDown() throws Exception {

    }

    @Test
    public void HexTest() throws Exception {
        byte[] b1 = new byte[1];
        b1[0] = 10;
        String hex = bytes2HexString(b1);
        assertEquals("0A", hex);

        byte[] b2 = new byte[4];
        b2[0] = 0;
        b2[1] = 16;
        b2[2] = 32;
        b2[3] = 127;
        hex = bytes2HexString(b2);
        assertEquals("0010207F", hex);

    }

    public String bytes2HexString(byte[] b) {
        StringBuffer result = new StringBuffer();
        String hex;
        for (int i = 0; i < b.length; i++) {
            hex = Integer.toHexString(b[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            result.append(hex.toUpperCase());
        }
        return result.toString();
    }
}
