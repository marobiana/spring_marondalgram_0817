package com.hagulu.marondalgram.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/images/**") // 내가 url로 접근하고 싶은 path /images/10_1231212312/test.png
		.addResourceLocations("file:///D:\\김인규강사\\web\\0415\\spring_test\\upload\\marondalgram\\images/");
	}
}