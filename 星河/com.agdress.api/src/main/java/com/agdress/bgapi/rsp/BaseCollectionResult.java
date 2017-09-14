package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */

@JsonIgnoreProperties(ignoreUnknown = true)
public class BaseCollectionResult<T> {

    private List<T> items;
    private int total;
    private int pageIndex;
    private int pageSize;
    private String etag;

    public List<T> getItems() {
        return items;
    }

    public int getTotal() {
        return total;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public int getPageSize() {
        return pageSize;
    }

    public String getEtag() {
        return etag;
    }
}
