package com.sbn.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sbn.interceptor.AuthInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	@Value("${part1.upload-path}")
	private  String           uploadPath;

	@Autowired
	private  AuthInterceptor  authInterceptor;

	public String getUploadPath() { return uploadPath; }

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// authInterceptor 를 동작시킬때 모든 페이지(/**)를 대상으로 한다
		// http://localhost:9090 밑의 모든 파일
		// 제외 "/css/**", "/img/**", "/js/**" 경로는 interceptor의 대상아님
		// .excludePathPatterns("/css/**", "/img/**", "/js/**")
		// .addPathPatterns("/Board/**")  
		//  -> http://localhost:9090/Board 밑의 모든 파일
		// 로그인 대상 페이지를 설정 "/**" : ** 는 하위폴더 포함
		registry.addInterceptor( authInterceptor )
			// .addPathPatterns("/**") -> 모든페이지 대신 "/Board/**" 
			// .addPathPatterns("/Board/**")
		    .addPathPatterns("/Team/**", "/Member/**", "/League/**", "/Board/**", "/Game/**")
			.excludePathPatterns("/css/**", "/img/**", "/js/**", "/Member/List",
					"/Team/List", "/League/List", "/Board/List", "/Member/SigninForm", 
				    "/Member/Signin", "/Member/IdDupCheck/**", "/Member/PhoneDupCheck/**",
				    "/Member/EmailDupCheck/**");
		
	    WebMvcConfigurer.super.addInterceptors(registry);
	}

	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
	    registry.addResourceHandler("/sbndata/**")
	            .addResourceLocations("file:///" + uploadPath);
	}
	

	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
	    return new BCryptPasswordEncoder();
	}
	
}



