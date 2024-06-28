package com.ah.spring.employee.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.ah.spring.common.MyAuthority;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Employee implements UserDetails {
	private String empNo;
	private String empId;
	private String empPw;
	private String empName;
	private String empResidentNo;
	private String empPhone;
	private String empEmail;
	private String empPostcode;
	private String empAddress;
	private String empDetailAddress;
	private Date empHiredDate;
	private Date empRetiredDate;
	private String empRetiredYn;
	private String empProfileOriName;
	private String empProfileReName;
	private String deptCode;
	private String jobCode;
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> auth=new ArrayList<>();
		if(empId.equals("admin")) {
			auth.add(new SimpleGrantedAuthority(MyAuthority.ADMIN.name()));
		}
		auth.add(new SimpleGrantedAuthority(MyAuthority.USER.name()));
		return null;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.empId;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.empPw;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	
	
	
}
