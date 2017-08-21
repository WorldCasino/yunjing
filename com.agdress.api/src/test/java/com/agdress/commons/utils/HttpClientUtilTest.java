package com.agdress.commons.utils;

import io.reactivex.Flowable;
import io.reactivex.functions.Function;
import io.reactivex.schedulers.Schedulers;
import io.reactivex.subscribers.TestSubscriber;
import org.apache.commons.lang3.tuple.ImmutablePair;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/7/26.
 * Description: *_*
 */
public class HttpClientUtilTest {

    @Test
    public void testGet() throws Exception {
        HttpGet method = new HttpGet("http://localhost:8085/api/");
        byte[] response = HttpClientUtil.toByteArray(HttpClientUtil.request(method));
        assertNotNull(response);
        String expect = "index";
        String actual = new String(response);
        assertEquals(expect, actual);
    }

    @Test
    public void testPost() throws Exception {
        HttpPost method = new HttpPost("http://localhost:8085/api/find/101");
        byte[] resp = HttpClientUtil.toByteArray(HttpClientUtil.request(method));
        assertNotNull(resp);
        String expect = "101";
        String actual = new String(resp);
        assertEquals(expect, actual);
    }

    @Test
    public void testPostGroupSerial() throws Exception {
        for (int i = 0; i < 100; i++) {
            String url = "http://localhost:8085/api/find/" + i;
            HttpPost method = new HttpPost(url);
            byte[] resp = HttpClientUtil.toByteArray(HttpClientUtil.request(method));
            assertNotNull(resp);
            String expect = String.valueOf(i);
            String actual = new String(resp);
            assertEquals(expect, actual);
            System.out.print(actual);
        }
    }

    @SuppressWarnings("unchecked")
    @Test
    public void testPostGroupConcurrently() throws Exception {
        TestSubscriber consumer = new TestSubscriber();
        Flowable.range(0, 100)
                .map((Function<Integer, Pair<Integer, String>>) i -> {
                    String url = "http://localhost:8085/api/find/" + i;
                    try {
                        HttpPost method = new HttpPost(url);
                        HttpEntity entity = HttpClientUtil.request(method);
                        byte[] resp = HttpClientUtil.toByteArray(entity);
                        assertNotNull(resp);

                        String expect = String.valueOf(i);
                        String actual = new String(resp);
                        assertEquals(expect, actual);

                        return new ImmutablePair(i, new String(resp));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    return new ImmutablePair<>(i, "");
                })
                .subscribeOn(Schedulers.io())
                .observeOn(Schedulers.single())
                .subscribe(consumer);
//                .subscribe(new Consumer<Pair<Integer, String>>() {
//                    @Override
//                    public void accept(Pair<Integer, String> integerStringPair) throws Exception {
//                        String expect = String.valueOf(integerStringPair.getLeft());
//                        String actual = integerStringPair.getRight();
//                        assertEquals(expect, actual);
//                    }
//                });

        assertTrue(consumer.awaitTerminalEvent());
        List<List<Object>> lists = consumer.getEvents();
        assertEquals(100, lists.get(0).size());
        assertEquals(0, lists.get(1).size());
        consumer.assertComplete();
        consumer.assertNoErrors();
    }

}