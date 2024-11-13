package com.icignal.core.annotation.handler;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.apache.commons.lang3.StringUtils;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.service.EnDeCryptedService;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.PersonalDataUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

public class PersonalDataDecodeHandler <T> extends AnnotationHandler {
    GridPagingResDto<T> gridObj;
    Object obj;
	// 
	//masking:	full -> 전체 문자열 마스킹, tel -> 전화번호 마스킹 , custNm -> 고객명, email -> 이메일,   none -> 전체문자열 복호화,  cardNum -> 카드번호,   webId -> 웹ID
	public final static String [] masking = {"tel", "custNm","email", "cardNum", "webId", "none"};

	
	public  PersonalDataDecodeHandler(GridPagingResDto<T> gridObj) {		
		this.gridObj = gridObj;
		decryptedPersonalData(this.gridObj);		
	}

	public  PersonalDataDecodeHandler(Object obj) {
		this.obj = obj;
		super.item = this.obj;
		decryptedPersonalData(this.obj);
	}
	
	
	
	 /*
	  * 1. 메소드명: get
	  * 2. 클래스명: PersonalDataHandler
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 *  GridPagingResponseDTO 객체 반환
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public GridPagingResDto<T> getGridPagingResDto() {
		return this.gridObj;		
	}
	
	
	
	 /*
	  * 1. 메소드명: decryptedPersonalData
	  * 2. 클래스명: PersonalDataHandler
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 *  개인정보데이터 복호화 수행
	 *		 *		
	 * </PRE>	
	 */
	public  void decryptedPersonalData(GridPagingResDto<T> dto) {
	      List<T> items =	dto.getRows();
	      if( items.size() > 0 &&  isAnotationObject( items.get(0) , PersonalData.class)) {
	    	   for(T item : items) {
	    		   proceed(item);      		
	    	   }
	    	}
    }
	
	
	    /*
	  * 1. 메소드명: decryptedPersonalData
	  * 2. 클래스명: PersonalDataHandler
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	개인정보 데이터 복호화 함수.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param item	
	 */
	public  void decryptedPersonalData(Object item) {
		   if(isAnotationObject( item , PersonalData.class)) {
			   proceed(item);
		   }
	   }
   
	
   
   
	/*
	 * 1. 메소드명: proceed
	 * 2. 클래스명: PersonalDataDecodeHandler
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 3. 2.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *	개인정보 필드에 대해 복호화 및 마스킹 처리를 수행한다.
	 * </PRE>
	 *   @param targetObj	
	 */
	@Override
	protected  void proceed(Object targetObj) { 
			 
	       Field[] fields = targetObj.getClass().getDeclaredFields();
	       String dataKey = BeansUtil.getDbEncryptDataKey();
	       for (Field field : fields) {
	       	     
				Decrypted annotation = field.getAnnotation(Decrypted.class);
	  	        if(annotation != null && field.getType() == String.class) {
	  	            field.setAccessible(true);
	  	            try { 
	  	            	String maskedVal = annotation.masked();	   	            	
	  	                 String fieldVal = (String)Optional.ofNullable(field.get(targetObj)).orElse("");
	  	                 
	  	            	if( !StringUtils.isAnyBlank(maskedVal, fieldVal)) {  // masked 값 과 필드값이 모두 존재할 경우
	  	            		  	            		
	                       //마스킹 타입이 full 일 경우 **** 값으로 치환 -> 문자열 복호화 처리 안함.	   	            			   	            		
	  	            		if(maskedVal.equals("full")) { field.set(targetObj, "****"); continue; }
	  	            		
	  	            		//마스킹 유형에 맞지 않을 경우 마스킹 문자열로 치환 안함.  
	  	            		if ( Arrays.asList(masking).stream().noneMatch(str -> str.equals(maskedVal))) continue;
	  	            		
	  	            		LogUtil.info("****field.getName: " + field.getName() + " value: " + fieldVal );
	  	            		// 마스킹 유형에 따라 문자열 마스킹 문자열로 치환
	  	            		String decVal=null;
	  	            		String decrypted = BeansUtil.getApplicationProperty("icignal.security.endecrytped.endecrypted");
	  	            		
	  	            		if("JAVA".equals(decrypted)) {
	  	            			decVal = SecurityUtil.decodeDbAES256(dataKey, fieldVal);
	  	            		} else if("DB".equals(decrypted)) {
	  	            			EnDeCryptedService enDeCryptedService = (EnDeCryptedService) BeansUtil.getBean("enDeCryptedService");
		  	            		decVal = enDeCryptedService.getDbDecrypted(fieldVal);
	  	            		}
	  	            		
	  	            		if (maskedVal.equals(masking[0])) field.set(targetObj, PersonalDataUtil.maskedTelephone(decVal));
	  	            		else if (maskedVal.equals(masking[1])) field.set(targetObj,  PersonalDataUtil.maskedCustNm(decVal)); 
	  	            		else if (maskedVal.equals(masking[2])) field.set(targetObj,  PersonalDataUtil.maskedEmail(decVal));
	  	            		else if (maskedVal.equals(masking[3]))field.set(targetObj,  PersonalDataUtil.maskedCardNum(decVal));
	  	            		else if (maskedVal.equals(masking[4]))	field.set(targetObj,  PersonalDataUtil.maskedWebId(decVal));
	  	            		else if (maskedVal.equals(masking[5]))field.set(targetObj, SecurityUtil.decodeDbAES256(dataKey, fieldVal));	
	  	            	}
	  	            	
	  	            }catch (IllegalAccessException e) { 
	  	            	LogUtil.error(e); 
	  	            }
	  	        }  
	       }
	     
	   }
	  
}
