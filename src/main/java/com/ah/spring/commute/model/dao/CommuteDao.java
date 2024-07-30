package com.ah.spring.commute.model.dao;

import java.util.Map;

public interface CommuteDao {

    void saveArrivalTime(Map<String, Object> params);
    void updateLeaveTime(Map<String, Object> params);
    
	Map<String, Object> getCommuteStatus(Map<String, Object> params);


}
