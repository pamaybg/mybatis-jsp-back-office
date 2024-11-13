 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.core.annotation.handler;


/**
 * 1. FileName	: AnnotationHelper.java
 * 2. Package	: com.icignal.core.annotation.handler
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 3. 4. 오후 8:33:49
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 3. 4.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: AnnotationHelper
 * 2. 파일명	: AnnotationHelper.java
 * 3. 패키지명	: com.icignal.core.annotation.handler
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 3. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class AnnotationHelper<T> {
	
	private T item;
	
	
 public static	enum AnnotationType {
		PersonalData,
		CommCode,
		ALL ,
		Nothing
	}	
 
	public AnnotationHelper() {
		
	}
	
    public AnnotationHelper(AnnotationType type , T obj) {
    	this.item = obj;
	  	if( type == AnnotationType.PersonalData) {
	  		//복호화 & 마스킹
	  		//proceedPersonalDataDecode( this.item);
	  		//마스킹
	  		proceedPersonalData( this.item);
	  	}
	  			
	  	else if ( type == AnnotationType.CommCode) 	proceedCommCode(this.item);
	  	else  { 	
	  		//복호화 & 마스킹
	  		//proceedPersonalDataDecode( this.item);
	  		//마스킹
	  		proceedPersonalData( this.item);
	  		proceedCommCode(this.item);
	  	}
    	
	}
	

	public AnnotationHelper<T> proceedCommCode ( T obj) {
		 this.item = obj;
		 new CommCodeHandler(item);
		return this;
	}
	
	public AnnotationHelper<T> proceedPersonalDataDecode ( T obj) {
		  this.item = obj;
		 new PersonalDataDecodeHandler<>(item);
		return this;
	}
	
	//데상트용 마스킹 처리
	public AnnotationHelper<T> proceedPersonalData ( T obj) {
		  this.item = obj;
		 new PersonalDataHandler<>(item);
		return this;
	}	
	
	
	public T getItem() {
		return item;
	}
	
	
}

