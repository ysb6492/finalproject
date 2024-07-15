package com.ah.spring.common;

import java.io.Serializable;
import java.time.LocalDate;

import lombok.Getter;


@Getter
public class BadAuthenticationException extends RuntimeException implements Serializable{
	//BadAuthenticationException 클릭 => add generated serial version ID 클릭
	
	
	private static final long serialVersionUID = 5789655269828820041L;
	private LocalDate eventDate;
	
	public BadAuthenticationException(String msg) {
		super(msg);
		eventDate = LocalDate.now();
		
	}
}
