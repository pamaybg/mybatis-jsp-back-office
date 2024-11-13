package com.icignal;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ImportResource;

@EnableCaching
@SpringBootApplication
@MapperScan(basePackages = "com.icignal")
@ImportResource( value = {
		"classpath:conf/beans/database-context.xml"
//		, "classpath:conf/beans/database-context-Mart.xml"
//		, "classpath:conf/beans/database-context-Eshop.xml"
//		, "classpath:conf/beans/database-context-Api.xml"
//		, "classpath:conf/beans/database-context-BoMart.xml"
})
public class ICignalBoT10BootApplication extends SpringBootServletInitializer {

	
	
	public static void main(String[] args) {
	//	SpringApplication.run(ICignalBoT10BootApplication.class, args);
		SpringApplication app = new SpringApplication(ICignalBoT10BootApplication.class);
		app.run(args);
		
		
	}

}
