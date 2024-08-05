package com.ah.spring.commute.model.dao;

import java.util.List;
import java.util.Map;

public interface CommuteDao {

    void saveArrivalTime(Map<String, Object> params);
    void updateLeaveTime(Map<String, Object> params);
    
	Map<String, Object> getCommuteStatus(Map<String, Object> params);
	List<Map<String, Object>> selectWeekCommuteStatus(Map<String, Object> params);


}
