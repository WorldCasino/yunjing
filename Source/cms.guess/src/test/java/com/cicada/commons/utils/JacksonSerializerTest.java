package com.cicada.commons.utils;

import com.fasterxml.jackson.core.type.TypeReference;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/5/12.
 * Description: jackson 对象与json转化测试
 */
public class JacksonSerializerTest {

    private JacksonSerializer serializer = new JacksonSerializer();

    @Before
    public void setUp() throws Exception {

    }

    @After
    public void tearDown() throws Exception {

    }

    @Test
    public void fromJson() throws Exception {
        String jsonStr = "{\n" +
                "    \"success\": true,\n" +
                "    \"code\": 0,\n" +
                "    \"message\": \"succeed\",\n" +
                "    \"body\": {\n" +
                "        \"a\": \"abc\",\n" +
                "        \"b\": 10,\n" +
                "        \"c\": false\n" +
                "    }\n" +
                "}";

        ResponseWrapper<TestObj> wrapper = serializer.fromJson(jsonStr, new TypeReference<ResponseWrapper<TestObj>>() {});
        assertNotNull(wrapper);
        assertEquals(true, wrapper.isSuccess());
        assertEquals(10, wrapper.getData().b);
    }

    @Test
    public void fromJsonArray() throws Exception {
        String jsonStr = "[\n" +
                "    {\n" +
                "        \"a\": \"abc\",\n" +
                "        \"b\": 100,\n" +
                "        \"c\": false\n" +
                "    },\n" +
                "    {\n" +
                "        \"a\": \"abc\",\n" +
                "        \"b\": 100,\n" +
                "        \"c\": false\n" +
                "    },\n" +
                "    {\n" +
                "        \"a\": \"abc\",\n" +
                "        \"b\": 100,\n" +
                "        \"c\": false\n" +
                "    }\n" +
                "]";

        List<TestObj> objList = serializer.fromJson(jsonStr, new TypeReference<List<TestObj>>() {});
        assertNotNull(objList);
        assertEquals(3, objList.size());
    }

    @Test
    public void fromJsonComplexArray() throws Exception {
        String jsonStr = "{\n" +
                "    \"success\": false,\n" +
                "    \"code\": 100,\n" +
                "    \"message\": \"error\",\n" +
                "    \"body\": [\n" +
                "        {\n" +
                "            \"a\": \"abc\",\n" +
                "            \"b\": 100,\n" +
                "            \"c\": false\n" +
                "        },\n" +
                "        {\n" +
                "            \"a\": \"abc\",\n" +
                "            \"b\": 100,\n" +
                "            \"c\": false\n" +
                "        },\n" +
                "        {\n" +
                "            \"a\": \"abc\",\n" +
                "            \"b\": 100,\n" +
                "            \"c\": false\n" +
                "        }\n" +
                "    ]\n" +
                "}";

        ResponseWrapper<List<TestObj>> wrapper = serializer.fromJson(jsonStr, new TypeReference<ResponseWrapper<List<TestObj>>>() {});
        assertNotNull(wrapper);
        assertEquals(3, wrapper.getData().size());
    }

    @Test
    public void toJson() throws Exception {

        String expectStr = "[{\"a\":\"abc\",\"b\":10,\"c\":true},{\"a\":\"abc\",\"b\":10,\"c\":true}]";

        List<TestObj> objList = new ArrayList<>();
        TestObj obj1 = new TestObj("abc", 10, true);
        TestObj obj2 = new TestObj("abc", 10, true);
        objList.add(obj1);
        objList.add(obj2);

        String jsonStr = serializer.toJson(objList);

        assertNotNull(jsonStr);
        assertEquals(expectStr, jsonStr);
    }
}