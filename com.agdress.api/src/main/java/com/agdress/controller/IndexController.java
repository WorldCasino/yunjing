package com.agdress.controller;

import com.agdress.commons.Exception.ApiException;
import org.springframework.web.bind.annotation.*;

/**
 * Created by Administrator on 2017/7/25.
 * Description: *_*
 */

@RestController
@RequestMapping("/")
public class IndexController extends BaseController {

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "hello";
    }

    @RequestMapping(value = "/find/{id}", method = RequestMethod.POST)
    public String copy(@PathVariable String id) {
        return id;
    }
}
