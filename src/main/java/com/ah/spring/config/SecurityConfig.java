package com.ah.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.ah.spring.common.UserAuthenticationProvider;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
	private final UserAuthenticationProvider provider;
	@Bean
	SecurityFilterChain authenticationFilter(HttpSecurity http) throws Exception{
		return http.csrf(csrf->csrf.disable())
				.authorizeHttpRequests(request->request
						.requestMatchers(CorUtils::isPreFlightRequest).permitAll()
						.requestMatchers("/loginpage","/WEB-INF/views/error/**").permitAll()
						.
				)
	}
}
