 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.component;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.icignal.common.util.BeansUtil;
import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;

/**
 * 1. FileName	: WebMvcConfig.java
 * 2. Package	: com.icignal.core.component
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 24. 오후 1:22:52
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 24.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: WebMvcConfig
 * 2. 파일명	: WebMvcConfig.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	@Override
	public void addViewControllers (ViewControllerRegistry registry) {
	      registry.addRedirectViewController("/", "/login");
	  }
	
	
	
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new BaseInterceptor())     
                .addPathPatterns("/**")                
                ;
        
        registry.addInterceptor(localeChangeInterceptor());     
    }    
         
       
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {   	
    	String ImgFilePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadImgPath");
    	
        registry.addResourceHandler("/clubMbrFile/**").addResourceLocations("file:"+ImgFilePath+"clubMbrFile/");
    }
    
    
    @Bean
    public SessionLocaleResolver localeResolver() {
        SessionLocaleResolver slr = new SessionLocaleResolver();
        slr.setDefaultLocale(Locale.KOREA);
        return slr;
    }

    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
        lci.setParamName("lang");
        return lci;
    }
    

    
    
/*	@Bean
    public ReloadableResourceBundleMessageSource messageSource() {

	ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource();

	// 메세지 프로퍼티파일의 위치와 이름을 지정한다.

        source.setBasename("classpath:/messages/message");

        // 기본 인코딩을 지정한다.

        source.setDefaultEncoding("UTF-8");

        // 프로퍼티 파일의 변경을 감지할 시간 간격을 지정한다.

        source.setCacheSeconds(60);

        // 없는 메세지일 경우 예외를 발생시키는 대신 코드를 기본 메세지로 한다.

        source.setUseCodeAsDefaultMessage(true);

        return source;

    }


*/

    
    
    
    @Bean("messageSource")
    public ReloadableResourceBundleMessageSource messageSource(
            @Value("${spring.messages.basename}") String basename,
            @Value("${spring.messages.encoding}") String encoding
    ) {
    	ReloadableResourceBundleMessageSource ms = new ReloadableResourceBundleMessageSource();
       
        //ms.setBasename(basename);
    	ms.setBasename("classpath:/Messages");
    							  // Messages
    							  // Messages_ko.properties
        ms.setDefaultEncoding(encoding);
        ms.setAlwaysUseMessageFormat(true);
        ms.setUseCodeAsDefaultMessage(true);
        ms.setFallbackToSystemLocale(false);
        ms.setCacheSeconds(5);
        return ms;
    }
    
    @Bean("messageSourceAccessor")
    public MessageSourceAccessor messageSourceAccessor(MessageSource ms) {
    	return new MessageSourceAccessor(ms);
    }
    
    
    
    @Bean("message")
    public Messages message( MessageSourceAccessor msa) {
    	Messages msg = new Messages();
    	msg.setMessageSourceAccessor(msa);
    	return msg;
    }
    
    @Bean
    public FilterRegistrationBean<XssEscapeServletFilter> XssFilterRegistrationBean(){
        FilterRegistrationBean<XssEscapeServletFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new XssEscapeServletFilter());
        registrationBean.setOrder(1);
        registrationBean.addUrlPatterns("/*");
        return registrationBean;
    }
    

}