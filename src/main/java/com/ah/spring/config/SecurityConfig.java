package com.ah.spring.config;

import org.springframework.context.annotation.Bean; 
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;

import com.ah.spring.common.security.UserAuthenticationProvider;

import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final UserAuthenticationProvider provider;

    @Bean
    public BCryptPasswordEncoder pwencoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    SecurityFilterChain authenticationFilter(HttpSecurity http) throws Exception {
        return http.csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(request -> request
                        .requestMatchers("/**","/main","login","/approve","/board").permitAll() // 특정 권한
                        .anyRequest().authenticated()
                )
                .authenticationProvider(provider)
                .formLogin(form -> form
                        .loginPage("/login")
                        .usernameParameter("empId")
                        .passwordParameter("empPw")
                        .loginProcessingUrl("/loginproc")
                        .defaultSuccessUrl("/main",true) // 로그인 성공 시 이동할 URL 설정
                        .permitAll() // 로그인 페이지 접근 허용
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login")
                        .permitAll() // 로그아웃 페이지 접근 허용
                )
                .exceptionHandling(exception -> exception
                        .accessDeniedHandler(accessDeniedHandler())
                )
                .build();
    }

    @Bean
    AccessDeniedHandler accessDeniedHandler() {
        return (request, response, accessDeniedException) -> {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Forbidden");
        };
    }
}
