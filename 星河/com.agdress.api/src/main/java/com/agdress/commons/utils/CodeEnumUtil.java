package com.agdress.commons.utils;


import com.agdress.enums.CodeBaseEnum;

/**
 * Created by Administrator on 2017/4/28.
 */
public class CodeEnumUtil {
    /**
     * @param enumClass
     * @param code
     * @param <E>
     * @return
     */
    public static <E extends Enum<?> & CodeBaseEnum> E codeOf(Class<E> enumClass, int code) {
        E[] enumConstants = enumClass.getEnumConstants();
        for (E e : enumConstants) {
            if (e.getCode() == code)
                return e;
        }
        return null;
    }
}