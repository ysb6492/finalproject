package com.ah.spring.commute.model.service;

import java.util.List;
import java.util.Map;

public interface CommuteService {

    void saveArrivalTime(Map<String, Object> params);
    void updateLeaveTime(Map<String, Object> params);
    
	Map<String, Object> getCommuteStatus(Map<String, Object> params);
    List<Map<String, Object>> getWeekCommuteStatus(Map<String, Object> params);


}
