package com.agdress.commons.utils;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * Created by Administrator on 2017/5/12.
 * Description: *_*
 */
@Component
public class JacksonSerializer {

    private ObjectMapper objectMapper;

    public JacksonSerializer() {
        objectMapper = new ObjectMapper();
        objectMapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
    }

    public <T> T fromJson(String str, TypeReference<T> valueTypeRef) throws IOException {
        return objectMapper.readValue(str, valueTypeRef);
    }

    public <T> String toJson(T t) throws IOException {
        return objectMapper.writeValueAsString(t);
    }
}
