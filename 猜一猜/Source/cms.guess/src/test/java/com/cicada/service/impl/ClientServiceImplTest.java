package com.cicada.service.impl;

import com.cicada.pojo.vo.NewUserVo;
import org.junit.Test;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;

/**
 * Created by Administrator on 2017/5/19.
 */
public class ClientServiceImplTest {
    @Test
    public void fastLogin() throws Exception {
        ClientServiceImpl svc= new ClientServiceImpl();
        NewUserVo u = svc.fastLogin("15901794296","1234","阳光",1);
    }

    @Test
    public void numberFormat() {
        Double a = 3.353;
        Double b = 3.300;
        Double c = 3.000;

        BigDecimal bg = new BigDecimal(a);
        double f1 = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        System.out.println(f1);

        DecimalFormat df = new DecimalFormat("#.00");
        System.out.println(df.format(a));
        System.out.println(df.format(b));
        System.out.println(df.format(c));

        System.out.println(String.format("%.2f", a));
        System.out.println(String.format("%.2f", b));
        System.out.println(String.format("%.2f", c));

        NumberFormat nf = NumberFormat.getNumberInstance();
        nf.setMaximumFractionDigits(2);
        System.out.println(nf.format(a));
        System.out.println(nf.format(b));
        System.out.println(nf.format(c));
    }
}