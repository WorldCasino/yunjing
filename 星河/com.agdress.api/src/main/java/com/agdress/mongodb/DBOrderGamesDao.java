package com.agdress.mongodb;


import com.agdress.mongodb.model.DBLogger;
import com.agdress.mongodb.model.DBOrderGames;

import java.util.List;
import java.util.Map;

/**
 * UserDao
 * Created by tl on 17/2/13.
 */
public interface DBOrderGamesDao {

    /**
     * 保存用户
     *
     * @param dbOrderGames
     */
    void save(DBOrderGames dbOrderGames);

    /**
     * 根据id查询
     *
     * @param  id
     * @return
     */
    DBOrderGames findOne(Long  id);


    /**
     * 用于分页查询
     *
     * @param skip(第一个坐标为0)
     * @param limit
     * @return
     */
    List<DBOrderGames> findList(DBOrderGames dbOrderGames,int skip, int limit);

    /**
     * 统计查询
     * @param dbOrderGames
     * @return
     */
    Map<String,String> countSum(DBOrderGames dbOrderGames);

    /**
     * 查询所有数据
     *
     * @return
     */
    List<DBOrderGames> findAll();

}
