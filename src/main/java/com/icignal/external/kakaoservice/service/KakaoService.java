package com.icignal.external.kakaoservice.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.external.kakaoservice.dto.request.LoyChannelAdrSearchReqDto;
import com.icignal.external.kakaoservice.dto.request.LoyChannelLocationReqDto;
import com.icignal.external.kakaoservice.dto.response.KakaoLoginResDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlMasterReqDto;
import com.icignal.loyalty.channel.mapper.LoyChannelMapper;
/*
 * 1. 클래스명	: KakaoService
 * 2. 파일명	: KakaoService.java
 * 3. 패키지명	: com.icignal.external.kakaoservice.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KakaoService")
public class KakaoService {

	@Autowired
	LoyChannelMapper loyChannelMapper;

	 /*
	  * 1. 메소드명: callGetAddrApi
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: hy.jun 
	  * 4. 작성일자: 2018. 10. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	public JSONObject callGetAddrApi(LoyChannelAdrSearchReqDto param) {

//		String key = "KakaoAK " + Common.getInstance().getServletProp("loyalty.kakao.restapi.key");
		/*String key = "KakaoAK " + BeansUtil.getApplicationProperty("kakao.api.key");*/
		String key ="KakaoAK " +"1a9826f73511a3a2e1aa79462087bd98";
		JSONObject rtnValue = new JSONObject();


		/*String url = CommonUtil.getInstance().getServletProp("daiso.b2c.host") + 
				CommonUtil.getInstance().getServletProp("daiso.b2c.rcpt.api");*/
		HttpClient client = HttpClientBuilder.create().build();
		//HttpPost request = new HttpPost(url);

		JSONObject requestObject;
		ObjectMapper oMapper = new ObjectMapper();
		BufferedReader br = null;
		try {
			String addr =URLEncoder.encode(param.getQuery(),"UTF-8");
			/*String url = BeansUtil.getApplicationProperty("kakao.api.url") + addr;*/
			String url="https://dapi.kakao.com/v2/local/search/address.json";
			String buf;
			

			
			String query = "query=" + addr;
			StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(url)
            			.append("?")
            			.append(query);
            URL link = new URL(stringBuffer.toString());
            HttpsURLConnection hc = (HttpsURLConnection)link.openConnection();
            hc.setRequestMethod("GET");
			//hc.setRequestProperty("User-Agent", "Java-Client");
			//hc.setRequestProperty("Host", "dapi.kakao.com");
            hc.setRequestProperty("X-Requested-With", "curl");
			hc.setRequestProperty("Authorization", key);
			br = new BufferedReader(new InputStreamReader(hc.getInputStream(),"UTF-8")); // byte 스트림 -> 문자 스트림  ->
			
			StringBuffer result = new StringBuffer();
			
			while((buf = br.readLine()) != null) {
				result.append(buf);
			}
			JSONParser parser = new JSONParser();
			rtnValue = (JSONObject) parser.parse(result.toString());
			rtnValue.put("success", true);
			LogUtil.info(rtnValue.toString());
		} catch (IOException | ParseException e) {
			LogUtil.error(e);
			rtnValue.put("success", false);
		} finally {
			if(br != null) {
				try {
					br.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
		}
		
		return rtnValue;
		
	}
	

	 /*
	  * 1. 메소드명: callGetAddrXYApi
	  * 2. 클래스명: KakaoService
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 서버의 웹서비스를 이용하여 채널 위경도를 가져옴
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public JSONObject callGetAddrXYApi(LoyChannelAdrSearchReqDto param) {
		
		JSONObject rtnValue = new JSONObject();
		
		String url =  BeansUtil.getApplicationProperty("icignal.api-server.ip-address")
				+ CommonUtil.getInstance().getServletProp("icignal.api-server.service.getAddressXY");
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost request = new HttpPost(url);
		
		JSONObject requestObject;
		ObjectMapper oMapper = new ObjectMapper();
		BufferedReader rd = null;

		try {
			//set request parameter
			param.setQuery(URLEncoder.encode(param.getQuery(), "UTF-8")); //한글깨짐
			
			request.addHeader("Content-Type", "application/json");
			requestObject = oMapper.convertValue(param, JSONObject.class);
			StringEntity entity = new StringEntity(requestObject.toString());
			request.setEntity(entity);
			
			//call api
			HttpResponse response = client.execute(request);
			
			rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
			
			StringBuffer result = new StringBuffer();
			String line = "";
			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
			if(!result.toString().equals("NULL")) {
				String[] addrXY = result.toString().split(",");
				rtnValue.put("success", true);
				rtnValue.put("latitude", addrXY[0]);
				rtnValue.put("longitude", addrXY[1]);
				
				
			}
		} catch (IOException e) {
			LogUtil.error(e);
		} finally {
			if (rd != null) {
				try {
					rd.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
		}
		
//		if(!(rtnValue).containsKey("success")) {
//			rtnValue.put("success", false);
//			rtnValue.put("message", "99");
//		}
		
		return rtnValue;
	}
	

	 /*
	  * 1. 메소드명: callKakaoApi
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: dw.keum
	  * 4. 작성일자: 2019. 10. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카카오 주소 -> 경도 API 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	@SuppressWarnings("unchecked")
	public JSONObject callKakaoApi(LoyChnlMasterReqDto reqDto) {
		
//		String key = "KakaoAK " + Common.getInstance().getServletProp("loyalty.kakao.restapi.key");
		String key = "KakaoAK " + BeansUtil.getApplicationProperty("kakao.api.key");
		JSONObject rtnValue = new JSONObject();
		BufferedReader br = null;
		try {
			String addr =URLEncoder.encode(reqDto.getAdres(),"UTF-8");
			String url = BeansUtil.getApplicationProperty("kakao.api.url") + addr;
			String buf;
			
			URL link = new URL(url);
			HttpsURLConnection hc = (HttpsURLConnection)link.openConnection();
			hc.setRequestMethod("GET");
			//hc.setRequestProperty("User-Agent", "Java-Client");
			hc.setRequestProperty("X-Requested-With", "curl");
			hc.setRequestProperty("Authorization", key);
			
			br = new BufferedReader(new InputStreamReader(hc.getInputStream(),"UTF-8")); // byte 스트림 -> 문자 스트림  ->
			
			StringBuffer result = new StringBuffer();
			
			while((buf = br.readLine()) != null) {
				result.append(buf);
			}
			JSONParser jsonParser = new JSONParser();
			JSONObject json = (JSONObject)jsonParser.parse(result.toString());
			JSONArray jsonArray;
			
				jsonArray = (JSONArray) json.get("documents");
				if(jsonArray.size() > 0) {
					JSONObject temObj = (JSONObject) jsonArray.get(0);
					
					if(ObjectUtil.isNotEmpty(temObj)) {
						rtnValue.put("success", true);
						rtnValue.put("latitude", temObj.get("y"));
						rtnValue.put("longitude", temObj.get("x"));
					}
				}
				

		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e);
		} catch (MalformedURLException e) {
			LogUtil.error(e);
		} catch (IOException e) {
			LogUtil.error(e);
		} catch (ParseException e) {
			LogUtil.error(e);
		} finally {
			if(br != null){
				try {
					br.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
		}
		
//		if(!rtnValue.containsKey("success")) {
//			rtnValue.put("success", false);
//		}
		
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: getAuthorizationUrl
	  * 2. 클래스명: KakaoService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 카카오 아이디 로그인 인증  URL 생성		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param userId
	 *   @return KakaoLoginResDto	
	 */
	public KakaoLoginResDto getAuthorizationUrl(String userId) {
		KakaoLoginResDto kakaResDto = new KakaoLoginResDto();
		String dataKey = BeansUtil.getDbEncryptDataKey();
		// 카카오 개발자 어플리케이션에 등록된 ClientID,AccessKey 요청 URL값 조회
		String clientId = SecurityUtil.decodeDbAES256(dataKey,BeansUtil.getApplicationProperty("kakao.api.service-id",String.class,""));
		String kakaoUrl = BeansUtil.getApplicationProperty("kakao.login.kakao-url",String.class,"");
		String redirectUrl;
		
		/* 현재 로그인전인 상태인지 로그인후 상태인지 체크
		   (인증키등록인지, SNS로그인일때 다른 Redierect URL을 타기때문)*/
		if(userId != null)
			redirectUrl = BeansUtil.getApplicationProperty("kakao.login.redirect-uri",String.class,"");
		else 
			redirectUrl = BeansUtil.getApplicationProperty("kakao.login.login-redirect-uri",String.class,"");
		
		//KAKAO 로그인 URL 생성
	    String kakaoLoginUrl = kakaoUrl
	        + "client_id=" + clientId + "&redirect_uri="
	        + redirectUrl + "&response_type=code";
	    
	    kakaResDto.setKakaoAuthUrl(kakaoLoginUrl);
	    kakaResDto.setSuccess(true);
	    
	    return kakaResDto;
	}
	
	  /*
	  * 1. 메소드명: getAccessToken
	  * 2. 클래스명: KakaoService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 카카오 아이디 로그인 AccessToken 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param autorize_code
	 *   @param userId
	 *   @return String
	 */
	public String getAccessToken(String autorize_code) {
		
		 String dataKey = BeansUtil.getDbEncryptDataKey();
		 // 카카오 개발자 어플리케이션에 등록된 ClientID,AccessKey 요청 Reuqest URL값 조회
		 String clientId = SecurityUtil.decodeDbAES256(dataKey,BeansUtil.getApplicationProperty("kakao.login.client-id",String.class,""));
		 String RequestUrl = BeansUtil.getApplicationProperty("kakao.login.request-url",String.class,"");
		 String redirectUrl;
		 
		 /* 현재 로그인전인 상태인지 로그인후 상태인지 체크
		   (인증키등록인지, SNS로그인일때 다른 Redierect URL을 타기때문)*/
				redirectUrl = BeansUtil.getApplicationProperty("kakao.login.login-redirect-uri",String.class,"");
		  
	      List<NameValuePair> postParams = new ArrayList<NameValuePair>();
	      postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
	      postParams.add(new BasicNameValuePair("client_id", clientId)); // REST API KEY
	      postParams.add(new BasicNameValuePair("redirect_uri", redirectUrl)); // 리다이렉트 URI
	      postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정 중 얻은 code 값

	      /*
	       Post방식으로 카카오 사용자정보 조회 Request URL 요청
	       */
	      HttpClient client = HttpClientBuilder.create().build();
	      HttpPost post = new HttpPost(RequestUrl);
	      JsonNode returnNode = null;
	      
	      try {

	        post.setEntity(new UrlEncodedFormEntity(postParams));
	        HttpResponse response = client.execute(post);
	        
	        ObjectMapper mapper = new ObjectMapper();
	        returnNode = mapper.readTree(response.getEntity().getContent());

	      } catch (UnsupportedEncodingException e) {
	    	LogUtil.error(e);
	      } catch (ClientProtocolException e) {
	    	LogUtil.error(e);
	      } catch (IOException e) {
	    	LogUtil.error(e);
	      }
	        //JSON에 담겨있는 Access_token 조회
	      
	      	return returnNode.get("access_token").toString().replaceAll("\"","");
	    }
	 
	 /*
	  * 1. 메소드명: getKakaoUserInfo
	  * 2. 클래스명: KakaoService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 카카오 아이디 로그인 사용자 정보 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param accessToken
	 *   @return JsonNode
	 */
	public JsonNode getKakaoUserInfo(String accessToken) {
		 
			String RequestUrl = BeansUtil.getApplicationProperty("kakao.login.request-user-url",String.class,"");
	        HttpClient client = HttpClientBuilder.create().build();
	        HttpPost post = new HttpPost(RequestUrl);
	 
	        // AccessToken 값 POST 요청 헤더값세팅
	        post.addHeader("Authorization", "Bearer " + accessToken);
	 
	        JsonNode returnNode = null;
	 
	        try {
	        	//POST방식으로 KAKAO URL로 요청
	            HttpResponse response = client.execute(post);

	            // JSON 형태 반환값 처리
	            ObjectMapper mapper = new ObjectMapper();
	            
	            //사용자 정보 담긴 JSON 형태의 데이터
	            returnNode = mapper.readTree(response.getEntity().getContent());
	 
	        } catch (IOException e) {
	        	LogUtil.error(e);
	        } 
	        return returnNode;
	    }
	
	@SuppressWarnings({ "deprecation", "unchecked" })
	public void getPushAlterTalk() {
		
		 // 카카오 개발자 어플리케이션에 등록된 ClientID,AccessKey 요청 Reuqest URL값 조회
//		 String clientId = BeansUtil.getApplicationProperty("kakao.login.client-id",String.class,"");
//		 String RequestUrl = "https://kapi.kakao.com/v1/api/talk/friends/message/default/send";
	
		 RestTemplate rest = new RestTemplate();
		 
		 JSONArray jsonArray = new JSONArray();
		 JSONObject jsonObject = new JSONObject();
		 jsonObject.put("receiver_uuids","1325924350");
		 jsonArray.add(jsonObject);
		 
		 JSONObject jsonl = new JSONObject();
		 jsonl.put("web_url", "http://localhost:9090");
		 jsonl.put("mobile_web_url", "http://localhost:9090");
		 JSONObject jsonc = new JSONObject();
			jsonc.put("title", "알람 메세지");
			jsonc.put("description", "상세설명");
			jsonc.put("image_url", "https://postfiles.pstatic.net/MjAxODA2MjBfMTAw/MDAxNTI5NDkwODEwMDQx._OCQLH2IQgRXriYMG2bX7v0cGJh7uvKsEfF8yJqN694g.qjmOUpN6rLr7LkAw_eoqjW20ulKJ9_NaI-FnfqCVn9Ag.PNG.ihk1547/Farmlogo.png?type=w773");
			jsonc.put("link", jsonl);
			
			JSONObject jsonm = new JSONObject();
			jsonm.put("object_type", "feed");
			jsonm.put("content", jsonc);
			jsonm.put("button_title", "바로가기");
			HttpHeaders header = new HttpHeaders();
			//header.add("Authorization", "Bearer "+"FO4EE5X-h74Pvy8WqzlsxrEQBy6eZogAHNPeXQo9dVwAAAFxhzACLg");
			MultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>();
			map.add("receiver_uuids",jsonArray.toString());
			map.add("template_object", jsonm.toString());
			
			HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, header);
			String result = rest.postForObject("https://kapi.kakao.com/v2/api/talk/memo/default/send", request, String.class);

	}


	 /*
	  * 1. 메소드명: callGetSiGugun
	  * 2. 클래스명: KakaoService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public JSONObject callGetSiGugun(LoyChannelLocationReqDto param) {
		String key ="KakaoAK " +"1a9826f73511a3a2e1aa79462087bd98";
		JSONObject rtnValue = new JSONObject();
		BufferedReader br = null;
		try {
			String x = URLEncoder.encode(param.getLatitude(),"UTF-8");
			String y = URLEncoder.encode(param.getLongitude(),"UTF-8");
			/*String url = BeansUtil.getApplicationProperty("kakao.api.url") + addr;*/
			String url="https://dapi.kakao.com/v2/local/geo/coord2regioncode.json";
			String buf;
			

			
			String query = "x=" +x+ "&"+"y="+y;
			StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(url)
            			.append("?")
            			.append(query);
            URL link = new URL(stringBuffer.toString());
            HttpsURLConnection hc = (HttpsURLConnection)link.openConnection();
            hc.setRequestMethod("GET");
			//hc.setRequestProperty("User-Agent", "Java-Client");
			//hc.setRequestProperty("Host", "dapi.kakao.com");
            hc.setRequestProperty("X-Requested-With", "curl");
			hc.setRequestProperty("Authorization", key);
			br = new BufferedReader(new InputStreamReader(hc.getInputStream(),"UTF-8")); // byte 스트림 -> 문자 스트림  ->
			
			StringBuffer result = new StringBuffer();
			
			while((buf = br.readLine()) != null) {
				result.append(buf);
			}

			JSONParser jsonParser = new JSONParser();
			rtnValue = (JSONObject)jsonParser.parse(result.toString());
			JSONArray jsonArray;
			
				jsonArray = (JSONArray) rtnValue.get("documents");
				if(jsonArray.size() > 0) {
					JSONObject temObj = (JSONObject) jsonArray.get(0);
					
					if(ObjectUtil.isNotEmpty(temObj)) {
						rtnValue.put("success", true);
						rtnValue.put("result", temObj);
						/*rtnValue.put("latitude", temObj.get("y"));
						rtnValue.put("longitude", temObj.get("x"));*/
					}
				}
				
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e);
		} catch (MalformedURLException e) {
			LogUtil.error(e);
		} catch (IOException e) {
			LogUtil.error(e);
		} catch (ParseException e) {
			LogUtil.error(e);
		} finally {
			if(br != null ) {
				try {
					br.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
		}
		
//		if(!rtnValue.containsKey("success")) {
//			rtnValue.put("success", false);
//		}
		
		return rtnValue;
	}
}

