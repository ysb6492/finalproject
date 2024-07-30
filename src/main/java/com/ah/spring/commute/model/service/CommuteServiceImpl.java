package com.ah.spring.commute.model.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.ah.spring.commute.model.dao.CommuteDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommuteServiceImpl implements CommuteService {
	private final CommuteDao comDao;
	
	
//    @Override
//    public Map<String, Object> getCommuteStatus(Map<String, Object> params) {
////        System.out.println("Service: Getting commute status with params: " + params);
////        return comDao.getCommuteStatus(params);
//        System.out.println("Service 조회 params: " + params);
//
//    	 Map<String, Object> result = comDao.getCommuteStatus(params);
//         System.out.println("Service 조회 결과: " + result); // 로그 추가
//         return result;
//    }
    
    @Override
    public Map<String, Object> getCommuteStatus(Map<String, Object> params) {
        return comDao.getCommuteStatus(params);
    }
	@Override
    public void saveArrivalTime(Map<String, Object> params) {
        //System.out.println("Service 출근 params: " + params);

		comDao.saveArrivalTime(params);
    }
	@Override
    public void updateLeaveTime(Map<String, Object> params) {
        //System.out.println("Service 퇴근 params: " + params);

		comDao.updateLeaveTime(params);
    }
}
