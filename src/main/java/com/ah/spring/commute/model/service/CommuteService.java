package com.ah.spring.commute.model.service;

import java.util.Map;

public interface CommuteService {

    void saveArrivalTime(Map<String, Object> params);
    void updateLeaveTime(Map<String, Object> params);
    
	Map<String, Object> getCommuteStatus(Map<String, Object> params);

}
