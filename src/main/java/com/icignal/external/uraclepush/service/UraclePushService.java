 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.external.uraclepush.service;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.http.Consts;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.external.uraclepush.dto.request.UraclePushReqDto;

/**
 * 1. FileName	: UraclePushService.java
 * 2. Package	: com.icignal.external.uraclepush.service
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 19. 오후 10:04:29
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 19.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: UraclePushService
 * 2. 파일명	: UraclePushService.java
 * 3. 패키지명	: com.icignal.external.uraclepush.service
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class UraclePushService {
	
	
	/**
	* @programId :
	* @name : sendPushUracle
	* @date : 2018. 12. 11.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 유라클 push api 발송
	* 
	*	구분		항목				타입		필수	반복	설명
	*	HEADER	RESULT_CODE		String	Y	N	0000 : 응답 성공
	*											그외 : 에러 메시지
	*			RESULT_BODY		String	Y	N	OK : 응답 성공
	*											그외 : 에러 메시지
	*			SERVICE			String	N	N	처리 Controller
	*	BODY	RESERVE_SEQNO	String			발송메세지 고유  번호. 예약발송 취소시 사용
	*/
	
	 /*
	  * 1. 메소드명: sendPushUracle
	  * 2. 클래스명: UraclePushService
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 유라클사 푸시서버에 푸시 메시지 발송 서비스
	 *   유라클 push api 발송(webservice)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto sendPushUracle(UraclePushReqDto param) {
		
		JSONObject rtnObj = new JSONObject();
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		String url = BeansUtil.getApplicationProperty("uracle.push.api-url");
		BufferedReader rd = null;

		try {
			HttpClient client = HttpClientBuilder.create().build();
			HttpPost request = new HttpPost(url);
	    	
			// add request header
			request.addHeader("Content-Type", "application/x-www-form-urlencoded");

			// add parameter
			List<NameValuePair> form = new ArrayList<>();
			Field[] fields = param.getClass().getDeclaredFields();
			for(Field field : fields) {
				field.setAccessible(true);
				
				PropertyDescriptor propDesctr = new PropertyDescriptor(field.getName(), param.getClass());
				Method mtd = propDesctr.getReadMethod(); //getter
				String value = (String) mtd.invoke(param);
				
				if(ObjectUtil.isNotEmpty(value)) {
					form.add(new BasicNameValuePair(field.getName().toUpperCase(), value));
				}
			}
			
			UrlEncodedFormEntity entity = new UrlEncodedFormEntity(form, Consts.UTF_8);
			request.setEntity(entity);
			
			//call api
			HttpResponse response = client.execute(request);
			
			rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
			
			StringBuffer result = new StringBuffer();
			String line = "";
			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
			JSONParser parser = new JSONParser();
			rtnObj = (JSONObject) parser.parse(result.toString());
			
			@SuppressWarnings("unchecked")
			HashMap<String, String> header = (HashMap<String, String>) rtnObj.get("HEADER");
			String resultCode = header.get("RESULT_CODE");
			String resultBody = header.get("RESULT_BODY");
			
			if(resultCode.equals("0000")) {
				rtnValue.setSuccess(true);
				
				LogUtil.debug("ChnlTransService.sendPushUracle() >>> success = " + rtnValue.getSuccess()); 
				LogUtil.debug("ChnlTransService.sendPushUracle() >>> message = " + rtnValue.getMessage()); 
				
			} else {
				rtnValue.setMessage("[" + resultCode + "] " + resultBody);
				
				LogUtil.error("ChnlTransService.sendPushUracle() >>> success = " + rtnValue.getSuccess()); 
				LogUtil.error("ChnlTransService.sendPushUracle() >>> message = " + rtnValue.getMessage());
				LogUtil.error("ChnlTransService.sendPushUracle() >>> rtnObj = " + rtnObj.toJSONString());
			}
			
		} catch (UnsupportedOperationException e) {
			LogUtil.error(e);			
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e.getMessage());
		} catch (IOException e1) {
			LogUtil.error(e1);
			
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e1.getMessage());
		} catch (ParseException e2) {
			LogUtil.error(e2);
			
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e2.getMessage());
		} catch(IntrospectionException e3) {
			LogUtil.error(e3);
			
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e3.getMessage());
		} catch(IllegalAccessException | IllegalArgumentException | InvocationTargetException e4) {
			LogUtil.error(e4);			
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e4.getMessage());
		} finally {
			if(rd != null) {
				try {
					rd.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
		}
		
		return rtnValue;
	}

}

