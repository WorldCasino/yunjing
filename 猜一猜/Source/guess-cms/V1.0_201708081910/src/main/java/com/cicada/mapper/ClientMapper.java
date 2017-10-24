package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.vo.ClientVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface ClientMapper extends BaseMapper<ClientEntity> {

    List<ClientVo> selectClientVoList(Map<String,Object> params);

    long selectClientTotal(Map<String,Object> params);

    ClientVo selectClientVo(Map<String,Object> params);
}
