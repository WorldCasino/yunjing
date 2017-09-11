DROP trigger if EXISTS ut_recharge_update;  
/**

	充值成功后，生成收支明细并更新充值金额合计
 
 */
CREATE TRIGGER ut_recharge_update 
AFTER UPDATE 
ON t_recharges FOR each row 
BEGIN 
	declare v_account_id int;

	if new.recharge_status = 1 and old.recharge_status != 1 then
		select account_id into v_account_id
		from t_user_account 
		where user_id = new.user_id;
		
		-- 更新金额合计
		update t_user_account 
		set recharge_amount = recharge_amount + new.recharge_amount
		    ,coin_balance = coin_balance + new.recharge_coins + new.activity_coins
		    ,coin_income = coin_income + new.recharge_coins + new.activity_coins
		where t_user_account.account_id = v_account_id;
		
		-- 生成账户收支明细
	    /*
	    收支来源 
	    
	    Recharge(0,"充值金币"),
	    RechargeReward(1,"充值送金币"),
	    TaskReward(2,"竞猜收入"),
	    TaskCost(3,"竞猜下注"),
	    ItemExchange(4,"商品兑换"),
	    TaskLotteryIncome(5,"发布竞猜盈利"),
	    TaskLotteryExpend(6,"发布竞猜赔付"),
	    RegisterReward(7,"新用户注册奖励"),
	    LoginReward(8,"登录奖励");
	    */
		insert into t_user_account_detail(account_id,user_id,coins,from_type,recharge_id)
		values(v_account_id,new.user_id,new.recharge_coins,0,new.recharge_id);
			
		-- 充值有活动赠送金币时，生成收入明细
		if new.activity_id > 0 and new.activity_coins > 0 then
			insert into t_user_account_detail(account_id,user_id,coins,from_type,recharge_id,activity_id)
			values(v_account_id,new.user_id,new.activity_coins,1,new.recharge_id,new.activity_id);
		end if;
	    
	end if;
	
	-- TODO 计算积分
		
END;