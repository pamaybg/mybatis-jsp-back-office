package com.icignal.core.component;


import java.util.HashMap;
import java.util.Optional;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.catalina.Context;
import org.apache.catalina.Wrapper;
import org.apache.jasper.servlet.JspServlet;
import org.apache.tomcat.util.scan.StandardJarScanner;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.web.servlet.ServletWebServerFactoryCustomizer;
import org.springframework.boot.web.embedded.tomcat.TomcatConnectorCustomizer;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.embedded.undertow.UndertowServletWebServerFactory;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.boot.web.servlet.server.Jsp;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.web.context.request.RequestContextListener;

import com.icignal.common.cache.ehcache.CacheCommon;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.session.SessionUtility;
import com.icignal.common.util.LogUtil;
import com.icignal.core.Factory;
import com.icignal.core.exception.ApplicationPropertiesException;
import com.icignal.core.security.dataencryption.DataEncryption;
import com.icignal.core.security.dataencryption.DataEncryptionFactory;
import com.icignal.core.security.dbconinfo.DBConnectionInfo;
import com.icignal.core.security.dbconinfo.DBConnectionInfoFactory;
import com.icignal.external.aws.exception.SecretsManagerExecption;



/*
 * 1. 클래스명	: CommonComponent
 * 2. 파일명	: CommonComponent.java
 * 3. 패키지명	: com.icignal.component
 * 4. 작성자명	: knlee
 * 5. 작성시간	: 2020. 1. 31. 오후 5:26:30
 */

/**

 * <PRE>

 * 1. 공통 컴포넌트 빈
 *		
 * </PRE>

 */ 
@Configuration
public class CommonBean {
	private final Logger log = LoggerFactory.getLogger(this.getClass().getName());	
	 /*
	  * 1. 메소드명: createDBConnectionInfo
	  * 2. 클래스명: iCignalComponent
	  * 3. 작성자명: knlee
	  * 4. 작성시간: 2020. 1. 31. 오후 5:27:11
	  */	
	/**
	
	 * <PRE>
	
	 * 1.데이터베이스연결정보를 빈으로 생생한다.	
	 *			
	 * 2.사용법	
	 *			
	 * </PRE>	
	 *   @return DBConnectionInfo 데이터베이스 연결 정보	
	 *   @param env	Appliction Properties Bean
	 *   @throws SecretsManagerExecption
	 *   @throws InstantiationException
	 *   @throws IllegalAccessException
	 *   @throws ClassNotFoundException	
	 * @throws ApplicationPropertiesException 
	
	 */
	@Bean(name="dbcon")
	public DBConnectionInfo createDBConnectionInfo( Environment env) 
			throws  InstantiationException, IllegalAccessException, ClassNotFoundException, ApplicationPropertiesException {
	
		Factory factory = new DBConnectionInfoFactory();
		DBConnectionInfo dbConInfo = (DBConnectionInfo)factory.create(Optional.ofNullable(env.getProperty("icignal.db-connection-info.management-type"))
					.orElseThrow(() -> new ApplicationPropertiesException("Messsage Properties Key value not found. : [icignal.db-connection-info.management-type]")));
		dbConInfo.registerProps(env);
		
		log.debug("\n######## DBConnectionInfomation ##########\n"	+ 	
					dbConInfo.toString() +
				 "\n##########################################\n"
				);
		
	    return dbConInfo;
	}

//	@Bean(name="dbconMart")
//	public DBConnectionInfo createDBConnectionInfoMart( Environment env)
//			throws  InstantiationException, IllegalAccessException, ClassNotFoundException, ApplicationPropertiesException {
//
//		Factory factoryMart = new DBConnectionInfoFactory();
//		DBConnectionInfo dbConInfoMart = (DBConnectionInfo)factoryMart.create(Optional.ofNullable(env.getProperty("icignal.db-connection-info.management-typeMart"))
//					.orElseThrow(() -> new ApplicationPropertiesException("Messsage Properties Key value not found. : [icignal.db-connection-info.management-typeMart]")));
//		dbConInfoMart.registerProps(env);
//
//		log.debug("\n######## DBConnectionInfomation ##########\n"	+
//					dbConInfoMart.toString() +
//				 "\n##########################################\n"
//				);
//
//	    return dbConInfoMart;
//	}

	 /*
	  * 1. 메소드명: createDBCryptorKey
	  * 2. 클래스명: CommonComponent
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 1. 31.
	  */
	/**	
	 * <PRE>
	 * 1. 설명
	 *	  데이터베이스 데이터키를 암호화할 키를 생성하는 빈
	 * 2. 사용법
	 *		
	 * </PRE>
	 * @param env
	 * @param encryptor
	 * @return	
	 * @throws Exception 
	 */
	@Bean(name="dbCryptorKey")
	public String createDBCryptorKey (Environment env,  StandardPBEStringEncryptor encryptor ) throws Exception {
		String keyMgtType = env.getProperty("icignal.security.data-encryption.database.key-managemnet-type");		
		Factory factory = new DataEncryptionFactory();
		DataEncryption dataEncryption = (DataEncryption)factory.create(keyMgtType);
		String dataKey = dataEncryption.getDataEncryptionKey(env, encryptor);		
		//System.out.println("dataKey: " + dataKey);
		return dataKey;
	}
	
	@Bean(name="env")
	public Environment getEnv(Environment env) {
		
		return env;
	}
	
	
	@Bean(name="fileCryptorKey")
	public String createFileCryptorKey (Environment env,  StandardPBEStringEncryptor encryptor ) throws Exception {
		String keyMgtType = env.getProperty("icignal.security.data-encryption.file.key-managemnet-type");		
		Factory factory = new DataEncryptionFactory();
		DataEncryption dataEncryption = (DataEncryption)factory.create(keyMgtType);
		String dataKey = dataEncryption.getDataEncryptionKey(env, encryptor);		
		return dataKey;
	}
	
	
	
	@Bean(name="mybatisLoyDbStatementHandlerIntercepter")
	public String createMybatisLoyDbStatementHandlerIntercepter (Environment env) throws Exception {
		String dbType = env.getProperty("icignal.db-connection-info.local.loy-db.master.db-type" , String.class, "oracle");		
		LogUtil.info("dbType::: " +dbType);
		return "com.icignal.core.mybastis.intercepter." + dbType.substring(0, 1).toUpperCase() + dbType.substring(1) +"StatementHandlerInterceptor";
	
	}
	
	
	
     /*
      * 1. 메소드명: httpSessionListener
      * 2. 클래스명: CommonBean
      * 3. 작성자명: knlee 
      * 4. 작성일자: 2020. 2. 13.
      */
    /**
     * <PRE>
     * HttpSessionListener 빈으로  생성(created) 소멸(destoryed)시 자동 호출 되는 리스너임.
     * 구현 사항 :
     * sessionDestroyed : eHcach에 저장되어 있는 로그인 아이디의 권한객체정보를 삭제시킴. 
     *		
     * </PRE>
     *   @return	
     */
    @Bean                           // bean for http session listener
    public HttpSessionListener httpSessionListener() {
        return new HttpSessionListener() {
            @Override
            public void sessionCreated(HttpSessionEvent se) {               // This method will be called when session created
                LogUtil.debug("Session Created with session id+" + se.getSession().getId());
            }

            @Override
            public void sessionDestroyed(HttpSessionEvent se) {         // This method will be automatically called when session destroyed
            	LogUtil.debug("Session Destroyed, Session id:" + se.getSession().getId());
            	// session.setAttribute(MKTSessionCommon.SESSION_USER_KEY_PROP, result.getId())
            	CacheCommon cacheCommon = new CacheCommon();
            	//해당 세션을 세션이 끊어질때 지워준다.
        	    SessionUtility.removeSession(se.getSession());
        		  	
            	String userId = (String)se.getSession().getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
            	
            	//캐시로직에서 해당 캐시저장소를 캐시에서 삭제하는 메소드 호출
            	cacheCommon.cacheRemove(userId,"ProgramCache");

            }
        };
    }
	
	
	 /*
	  * 1. 메소드명: requestContextListener
	  * 2. 클래스명: CommonBean
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 11.
	  */
	/**
	 * <PRE>
	 * RequestContextListener를 빈으로 등록한다.
	 * </PRE>
	 *   @return	
	 */
	@Bean public RequestContextListener requestContextListener(){
	    return new RequestContextListener();
	} 
	   
	

	 /*
	  * 1. 메소드명: modelMapper
	  * 2. 클래스명: CommonComponent
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 5.
	  */
	/**
	 * <PRE>	 
	 * 특정 객체를  대상객체로 자동 매핑해준다.	
	 * </PRE>
	 *   @return	
	 */
	@Bean
	public ModelMapper modelMapper(){
	    return new ModelMapper();
	}
	
	
	/**
	 * jasypt 암호화 객체 생성
	 * @Method Name : standardPBEStringEncryptor
	 * @작성일   		: 2020. 1. 30.
	 * @작성자   		: knlee
	 * @변경이력  		:
	 * @Method 설명 	:
	 * @param env
	 * @return
	 */
    @Bean(name="encryptor")
	public StandardPBEStringEncryptor standardPBEStringEncryptor(Environment env) {
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		encryptor.setPassword(env.getProperty("icignal.security.properties-data-encryption.password"));
		return encryptor;
	}
    
  
	
    @Bean(name="accesskey")
    public String getAwsAccessKey( Environment env, StandardPBEStringEncryptor encryptor ) {
    	return encryptor.decrypt(env.getProperty("aws.credentials.access-key"));
    }
	
    
    
    @Bean(name="secretkey")
    public String getAwsSecretKey( Environment env,  StandardPBEStringEncryptor encryptor ) {
    	return encryptor.decrypt(env.getProperty("aws.credentials.secret-key"));
    }
    
    
    
     /*
      * 1. 메소드명: tomcatFactory
      * 2. 클래스명: CommonBean
      * 3. 작성자명: knlee 
      * 4. 작성일자: 2020. 4. 8.
      */
    /**
     * <PRE>
     * 1. 설명
     *	 이클립스 로컬에서 실행시 톰캣 로딩시 "The Class-Path manifest attribute in... WARN o.a.t.u.s.StandardJarScanner - Failed to scan" 오류 발생에 따른 Manifest scan을 fale 처리함.
     * 2. 사용법
     *		
     * </PRE>
     *   @return	
     */
    @Bean
    public TomcatServletWebServerFactory tomcatFactory() {
      return new TomcatServletWebServerFactory() {
        @Override
        protected void postProcessContext(Context context) {
          ((StandardJarScanner) context.getJarScanner()).setScanManifest(false);
        }
      };
    }
    
   //
//    @Bean
//    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> 
//        containerCustomizer(){
//        return new EmbeddedTomcatCustomizer();
//    }
//    protected static class EmbeddedTomcatCustomizer implements WebServerFactoryCustomizer<TomcatServletWebServerFactory> {
//        @Override
//        public void customize(TomcatServletWebServerFactory factory) {
//            HashMap<String, String> initParams = new HashMap<>();
//            initParams.put("mappedfile", "false");
//            factory.getJsp().setInitParameters(initParams);
//            factory.setJsp(factory.getJsp());
//        }
//    }
    
    
	/*
	 * @Bean public WebServerFactoryCustomizer<ConfigurableServletWebServerFactory>
	 * webServerFactoryCustomizer() { return (factory) ->
	 * factory.setInitParameters(new HashMap() {
	 * 
	 * @Override public Object put(Object key, Object value) { return
	 * super.put("development", "false"); }
	 * 
	 * }); //factory.addErrorPages(new ErrorPage(HttpStatus.UNAUTHORIZED,
	 * "/unauthorized")); }
	 */
//    @Bean
//    public ServletWebServerFactoryCustomizer  servletContainerCustomizer() {
//   
//    	
//        return new ServletWebServerFactoryCustomizer () {
//
//            @Override
//            public void customize(ConfigurableEmbeddedServletContainer container) {
//                if (container instanceof TomcatEmbeddedServletContainerFactory) {
//                    customizeTomcat((TomcatEmbeddedServletContainerFactory)container); 
//                }
//            }
//
//            private void customizeTomcat(TomcatEmbeddedServletContainerFactory tomcatFactory) {
//                tomcatFactory.addContextCustomizers(new TomcatContextCustomizer() {
//
//                    @Override
//                    public void customize(Context context) {
//                        Container jsp = context.findChild("jsp");
//                        if (jsp instanceof Wrapper) {
//                            ((Wrapper)jsp).addInitParameter("development", "false");
//                        }
//
//                    }
//
//                });
//            }
//
//        };
        
  //  }
    
	
}
