package com.ah.spring.common;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.ah.spring.employee.model.dao.EmployeeDao;
import com.ah.spring.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class UserAuthenticationProvider implements AuthenticationProvider{
	private final EmployeeDao dao;
	private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String empId = authentication.getName();
		String password = (String) authentication.getCredentials();
		
		Employee loginEmployee = null;//dao.selectEmpById(empId);
		if(loginEmployee!=null && encoder.matches(password, loginEmployee.getEmpPw())) {
			return new UsernamePasswordAuthenticationToken(
					loginEmployee, 
					loginEmployee.getEmpPw(),
					loginEmployee.getAuthorities());
		}else {
			throw new BadCredentialsException("인증실패");
		}
		
	}
	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}
	
	
	
}
