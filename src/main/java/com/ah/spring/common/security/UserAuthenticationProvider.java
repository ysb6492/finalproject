package com.ah.spring.common.security;

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
public class UserAuthenticationProvider implements AuthenticationProvider {
	 private final EmployeeDao dao;
	 private final BCryptPasswordEncoder pwencoder = new BCryptPasswordEncoder();

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String empId = authentication.getName();
        String password = (String) authentication.getCredentials();
        System.out.println("인증아뒤: " + empId); // 디버그 로그

        Employee loginEmployee = dao.selectEmpById(empId);
        System.out.println(loginEmployee);
        if (loginEmployee != null && pwencoder.matches(password, loginEmployee.getEmpPw())) {
            System.out.println("인증성공아뒤: " + empId);
            return new UsernamePasswordAuthenticationToken(
                loginEmployee,
                loginEmployee.getEmpPw(),
                loginEmployee.getAuthorities()
            );
        } else {
            System.out.println("No employee found with ID: " + empId);
            throw new BadCredentialsException("인증 실패");
        }
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
