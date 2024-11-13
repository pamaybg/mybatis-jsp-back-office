 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.annotation.handler;

import java.lang.reflect.Field;
import java.util.Optional;

import com.icignal.common.base.dto.request.BaseReqDto;
import com.icignal.common.base.service.EnDeCryptedService;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * 1. FileName	: PersonalDataEncodeHandler.java
 * 2. Package	: com.icignal.core.annotation.handler
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 28. 오후 3:36:57
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 28.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: PersonalDataEncodeHandler
 * 2. 파일명	: PersonalDataEncodeHandler.java
 * 3. 패키지명	: com.icignal.core.annotation.handler
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 28.
 */
/**
 * <PRE>
 * 1. 설명
 * 개인정보필드에 대한 암호화 처리 핸들러 클래스
 * </PRE>
 */

public class PersonalDataEncodeHandler extends AnnotationHandler {
	
	
	
	public  PersonalDataEncodeHandler(Object obj) {		
		super.item = obj;
		if(isAnotationObject( item , PersonalData.class ))  proceed(item);
		
	}
	
	/*
	 * 1. 메소드명: proceed
	 * 2. 클래스명: PersonalDataEncodeHandler
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 3. 2.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *	암호화 필드의 값을 AES256으로 암호화 한다.
	 * </PRE>
	 *   @param targetObj	
	 */ 
	@Override
	protected  void proceed(Object targetObj) {
		if(isProceed(targetObj)) {	// 암호화 수행 여부 체크
			 
			   Field[] fields = targetObj.getClass().getDeclaredFields();
			   String dataKey = BeansUtil.getDbEncryptDataKey();
			   
			   for (Field field : fields) {
			   	   Encrypted annotation = field.getAnnotation(Encrypted.class);
			       if(annotation != null && field.getType() == String.class) {
			            field.setAccessible(true);  
			            String fieldVal = null;
			            String encVal = null;
						try {
							fieldVal = (String)Optional.ofNullable(field.get(targetObj)).orElse("");
							String encrypted = BeansUtil.getApplicationProperty("icignal.security.endecrytped.endecrypted");
	  	            		if("Java".equals(encrypted)) {
							    encVal = SecurityUtil.encodeDbAES256(dataKey, fieldVal);
	  	            		} else if("DB".equals(encrypted)) {
	  	            			EnDeCryptedService enDeCryptedService = (EnDeCryptedService) BeansUtil.getBean("enDeCryptedService");
		  	            		encVal = enDeCryptedService.getDbEncrypted(fieldVal);
	  	            		}
			  	            field.set(targetObj,  encVal );
						} catch (IllegalArgumentException | IllegalAccessException e) {	 LogUtil.error(e); }
			
			       }  
			   }
			   
			   finish(targetObj);// 암호화 처리 완료 flag setting (BaseReqDto.class isEncrypted = true)
		}
	   
	   
	}
	
	
	 /*
	  * 1. 메소드명: finish
	  * 2. 클래스명: PersonalDataEncodeHandler
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 BaseReqDto 객체의 isEncrypted 값을 true로 변경함.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param obj	
	 */
	private void finish( Object obj) {
		Class<?> cls =  obj.getClass().getSuperclass();
		while(cls != Object.class ) {		
			  if( cls == BaseReqDto.class) {
					try {
						Field f = cls.getDeclaredField("isEncrypted");
						 f.setAccessible(true);
						 try {
							f.set(obj, true);
						} catch (IllegalArgumentException | IllegalAccessException e) {	 LogUtil.error(e); }
					} catch (NoSuchFieldException | SecurityException e) {	LogUtil.error(e); } 
					
					break;
			  }  cls = cls.getSuperclass(); 
		}
	}
	
	
	 /*
	  * 1. 메소드명: isProceed
	  * 2. 클래스명: PersonalDataEncodeHandler
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	  BaseReqDto 클래스의 isEncrypted 값을 체크하여 true/false를 리턴한다.
	 *    호출한 함수에서는 true일 경우 암호화 수행, flase일 경우 암호화 미수행한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param obj
	 *   @return	
	 */
	private boolean isProceed(Object obj) {
		Class<?> cls =  obj.getClass().getSuperclass();
		while(cls != Object.class ) {
			  if( cls == BaseReqDto.class) {
					try {
						Field f = cls.getDeclaredField("isEncrypted");
						 try {
						   f.setAccessible(true);
						   if(!(boolean)f.get(obj)) return true;
						   else return false;
						} catch (IllegalArgumentException | IllegalAccessException e) {	LogUtil.error(e); }
					} catch (NoSuchFieldException | SecurityException e) {	LogUtil.error(e); }
					return false;
			  }else cls = cls.getSuperclass();  //부모클래스 찾음.
		}
		return false;
	}

	
}

