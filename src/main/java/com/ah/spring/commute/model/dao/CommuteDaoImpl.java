package com.ah.spring.commute.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CommuteDaoImpl implements CommuteDao {

	
    private final SqlSession sqlSession;
    

    
    @Override
    public Map<String, Object> getCommuteStatus(Map<String, Object> params) {
    	 System.out.println("DAO getCommuteStatus params: " + params);
    	    Map<String, Object> result = sqlSession.selectOne("commute.getCommuteStatus", params);
    	    System.out.println("DAO getCommuteStatus 결과: " + result);
    	    return result;
    }
    @Override
    public void saveArrivalTime(Map<String, Object> params) {
    	System.out.println("DAO saveArrivalTime params: " + params);
        sqlSession.insert("commute.saveArrivalTime", params);
        System.out.println("DAO saveArrivalTime 완료");
    }
    @Override
    public void updateLeaveTime(Map<String, Object> params) {
    	System.out.println("DAO updateLeaveTime params: " + params);
        sqlSession.update("commute.updateLeaveTime", params);
        System.out.println("DAO updateLeaveTime 완료");
    }

    @Override
    public List<Map<String, Object>> selectWeekCommuteStatus(Map<String, Object> params) {
        return sqlSession.selectList("commute.getWeekCommuteStatus", params);
    }
}
