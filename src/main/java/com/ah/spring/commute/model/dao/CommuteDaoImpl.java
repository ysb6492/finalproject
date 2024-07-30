package com.ah.spring.commute.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CommuteDaoImpl implements CommuteDao {

	
    private final SqlSession sqlSession;
    
//    @Override
//    public Map<String, Object> getCommuteStatus(Map<String, Object> params) {
////        System.out.println("DAO: getCommuteStatus with params: " + params);
////        return sqlSession.selectOne("commute.getCommuteStatus", params);
//        System.out.println("DAO 조회 params: " + params);
//
//    	 Map<String, Object> result = sqlSession.selectOne("commute.getCommuteStatus", params);
//         System.out.println("DAO 조회 결과: " + result); // 로그 추가
//         return result;
//    }
    
    @Override
    public Map<String, Object> getCommuteStatus(Map<String, Object> params) {
        return sqlSession.selectOne("commute.getCommuteStatus", params);
    }
    @Override
    public void saveArrivalTime(Map<String, Object> params) {
        //System.out.println("DAO 출근 params: " + params);
        sqlSession.insert("commute.saveArrivalTime", params);
    }
    @Override
    public void updateLeaveTime(Map<String, Object> params) {
        //System.out.println("DAO 퇴근 params: " + params);
        sqlSession.update("commute.updateLeaveTime", params);
    }

}
