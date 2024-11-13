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

import com.icignal.common.base.service.CommonService;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 1. FileName	: CommonCodeHandler.java
 * 2. Package	: com.icignal.core.annotation.handler
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 3. 4. 오전 11:32:56
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 3. 4.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: CommCodeHandler
 * 2. 파일명	: CommCodeHandler.java
 * 3. 패키지명	: com.icignal.core.annotation.handler
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 3. 4.
 */
/**
 * <PRE>
 * 1. 설명
 * 공통코드 어노테이션이션을 처리하는 핸들러 클래스
 * </PRE>
 */

public class CommCodeHandler extends AnnotationHandler {
	
	public  CommCodeHandler(Object obj) {
		super.item = obj;
		
		Optional.ofNullable(item)
				.filter(x -> isAnotationObject( x , CommCode.class ))
				.ifPresent(o -> proceed(o));
		
	}

	/*
	 * 1. 메소드명: proceed
	 * 2. 클래스명: AnnotationHandler
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 3. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *	공콩코드 어노테이션를 처리한다.
	 *  MarkName 어노테이션을 찾아 CommCodeList에 저장된 markName를  markName 적용필드에 할당한다.	
	 * </PRE>
	 *   @param targetOb	
	 */
	
	@Override
	protected void proceed(Object targetObj) {
		
		Field[] fields = targetObj.getClass().getDeclaredFields();
		for (Field field : fields) {
			 MarkName annotation = field.getAnnotation(MarkName.class);			 
			 Optional.ofNullable(annotation).filter(o -> field.getType() == String.class).ifPresent(x -> {
				  String groupCode = annotation.groupCode();
				  String codeName = annotation.codeField();
				try {
					
					  Field codeNameField = targetObj.getClass().getDeclaredField(codeName);
					  codeNameField.setAccessible(true);
				      codeName = (String)codeNameField.get(targetObj);
						      
					  String lang = annotation.lang();
					 
					 CommonService commonService = (CommonService)BeansUtil.getBean("commonService");
					 String markName = commonService.getCommCodeMarkName(groupCode, codeName,  lang);
					 Optional.ofNullable(markName).ifPresent(o ->  {
				            field.setAccessible(true);			            
				            try {
								field.set(targetObj, markName);
							} catch (IllegalArgumentException | IllegalAccessException e) {LogUtil.error(e);}
					 });
					
				} catch (NoSuchFieldException | IllegalArgumentException | IllegalAccessException e ) {	LogUtil.error(e);}
		
				
			 });
	   } // end for

	}
}

