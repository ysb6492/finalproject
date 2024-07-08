package com.ah.spring.employee.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.ah.spring.common.MyAuthority;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
/*
 * @ToString(exclude = {"deptCode"})
 */
public class Employee implements UserDetails {

	private String empNo;
	@NotEmpty(message = "id는 필수입력 사항입니다")
	private String empId;
    @NotEmpty(message = "비밀번호는 필수입력 사항입니다")
	private String empPw;
	
    @NotEmpty(message = "이름은 필수입력 사항입니다")
	private String empName;
	private String empResidentNo;
	private String empPhone;
	
	@Email(message="이메일형식에 맞지 않습니다")
	private String empEmail;
	private String empPostcode;
	private String empAddress;
	private String empDetailAddress;
	private Date empHiredDate;
	private Date empRetiredDate;
	private String empRetiredYn;
	private String empProfileOriName;
	private String empProfileReName;
	private String empRole;
	private Department deptCode;
	private Job jobCode;
	

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> auth=new ArrayList<>();
		if(deptCode != null && deptCode.getDeptCode().equals("D1")) {
			auth.add(new SimpleGrantedAuthority(MyAuthority.ADMIN.name()));
		}else if(deptCode != null && deptCode.getDeptCode().equals("D2")){
			auth.add(new SimpleGrantedAuthority(MyAuthority.HR.name()));
		}else {
			auth.add(new SimpleGrantedAuthority(MyAuthority.EMP.name()));
		}
		return auth;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return empId;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return empPw;
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
