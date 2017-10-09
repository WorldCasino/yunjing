package com.agdress.mongodb.impl;


import com.agdress.commons.utils.DateFormatUtil;
import com.agdress.commons.utils.DateUtil;
import com.agdress.commons.utils.StringUtils;
import com.agdress.enums.GamesStatusEnum;
import com.agdress.mongodb.DBOrderGamesDao;
import com.agdress.mongodb.model.DBLogger;
import com.agdress.mongodb.model.DBOrderGames;
import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationOperation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.group;
import static org.springframework.data.mongodb.core.aggregation.Aggregation.match;

/**
 * UserDaoImpl
 * Created by tl on 17/2/13.
 */
@Service("dBOrderGamesDao")
public class DBOrderGamesDaoImpl implements DBOrderGamesDao {

    //MongoTemplate是数据库和代码之间的接口，对数据库的操作都在它里面
    @Resource(name="mongoTemplate")
    private MongoTemplate mongoTemplate;

    /**
     * 保存用户
     *
     * @param dbOrderGames
     */
    @Override
    public void save(DBOrderGames dbOrderGames) {
        this.mongoTemplate.save(dbOrderGames);
    }

    /**
     * 根据id查询
     *
     * @param id
     * @return
     */
    @Override
    public DBOrderGames findOne(Long id) {
        Query query = new Query();
        Criteria criteria = Criteria.where("orderId").is(id);
        query.addCriteria(criteria);
        return this.mongoTemplate.findOne(query, DBOrderGames.class);
    }

    /**
     * 分页查询
     * @param dbOrderGames
     * @param skip(第一个坐标为0)
     * @param limit
     * @return
     */
    @Override
    public List<DBOrderGames> findList(DBOrderGames dbOrderGames, int skip, int limit) {
        // TODO Auto-generated method stub
        Query query = new Query();
        query.addCriteria(getQuery(dbOrderGames)) ;//模糊查询
        query.with(new Sort(new Sort.Order(Sort.Direction.DESC,"orderTime")));
        query.skip(skip);
        query.limit(limit);
        return mongoTemplate.find(query, DBOrderGames.class);
    }

    /**
     * 统计查询
     * @param dbOrderGames
     * @return
     */
    @Override
    public Map<String,String> countSum(DBOrderGames dbOrderGames) {
        Map<String,String> map=new HashMap<String,String>();
        Criteria criteria=getQuery(dbOrderGames);
        long countAll=mongoTemplate.count(new Query().addCriteria(criteria), DBOrderGames.class);
        map.put("countAll",countAll+"");
        Double allcome_onmoney=0.00;//入金总额
        Double allexpendmoney=0.00;//出金总额
        Double allzhuanmoney=0.00;//转码总量

        Aggregation aggregation = Aggregation.newAggregation(
                 match(criteria),
                group("agentId").sum("aAmount").as("atotal").sum("bAmount").as("btotal").sum("zmAmount").as("zmtotal")
        );

        AggregationResults<DBOrderGames> ar = mongoTemplate.aggregate(aggregation, "games", DBOrderGames.class);
        List<DBOrderGames> list = ar.getMappedResults();
        if(list.size() > 0){
            allexpendmoney = list.get(0).getBtotal();
            allcome_onmoney = list.get(0).getAtotal();
            allzhuanmoney=list.get(0).getZmtotal();
        }
        map.put("allcome_onmoney",String.valueOf(allcome_onmoney));
        map.put("allexpendmoney",String.valueOf(allexpendmoney));
        map.put("allzhuanmoney",String.valueOf(allzhuanmoney));
        return map;
    }

    /**
     * 条件查询需要的参数
     * <br>------------------------------<br>
     * @param criteriaUser
     * @return
     */
    private Criteria getQuery(DBOrderGames criteriaUser) {
        if (criteriaUser == null) {
            criteriaUser = new DBOrderGames();
        }
        Criteria criteria=new Criteria();
        if (criteriaUser.getUid() != null) {
            criteria = criteria.and("uid").is(criteriaUser.getUid());
        }
        if (criteriaUser.getLoginId() != null) {
            criteria = criteria.and("loginId").is(criteriaUser.getLoginId());
        }
        if (criteriaUser.getAgentId() != null) {
            criteria = criteria.and("agentId").is(criteriaUser.getAgentId());
        }
        if (criteriaUser.getShowOrderStatus() != null) {
            criteria = criteria.and("showOrderStatus").is(criteriaUser.getShowOrderStatus());
        }
        if (criteriaUser.getFromIp() != null) {
            criteria= criteria.and("fromIp").is(criteriaUser.getFromIp());
         }
        if (criteriaUser.getShowGameId() != null) {
            criteria = criteria.and("showGameId").is(criteriaUser.getShowGameId());
        }
        if(criteriaUser.getStarttime() != null && criteriaUser.getEndtime() != null ){
            criteria=criteria.and("orderTime").gte(criteriaUser.getStarttime()).lte(criteriaUser.getEndtime());
        }else if(criteriaUser.getStarttime() == null && criteriaUser.getEndtime() != null){
            criteria=criteria.and("orderTime").lte(criteriaUser.getEndtime());
        }else if(criteriaUser.getStarttime() != null && criteriaUser.getEndtime() == null){
            criteria=criteria.and("orderTime").gte(criteriaUser.getStarttime());
        }
        return criteria;
    }

    /**
     * 查询所有
     * @return
     */
    @Override
    public List<DBOrderGames> findAll() {

        return this.mongoTemplate.find(new Query(), DBOrderGames.class);
    }

}
