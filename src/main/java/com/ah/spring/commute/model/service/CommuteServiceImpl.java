package com.ah.spring.commute.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ah.spring.commute.model.dao.CommuteDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommuteServiceImpl implements CommuteService {
	private final CommuteDao comDao;
	
    
    @Override
    public Map<String, Object> getCommuteStatus(Map<String, Object> params) {
        Map<String, Object> result = comDao.getCommuteStatus(params);
        System.out.println("ServiceImpl getCommuteStatus 결과: " + result);
        return result;
//        return comDao.getCommuteStatus(params);
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
	
	
    @Override
    public List<Map<String, Object>> getWeekCommuteStatus(Map<String, Object> params) {
        return comDao.selectWeekCommuteStatus(params);
    }
}
