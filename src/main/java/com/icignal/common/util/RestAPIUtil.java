package com.icignal.common.util;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;


/**
 * @name infavor.util.IFVMRestAPIUtility
 * @date 2018. 10. 31.
 * @author jh.kim
 * @description RestAPI 호출
 */
public class RestAPIUtil {

    /**
     * @programId
     * @name jsonPost
     * @date 2018. 11. 2.
     * @author jh.kim
     * @param url 호출할 API URL
     * @param param 전송 request parameter
     * @param theClass return받을 값이 Mapping 될 Object 클래스
     * @return
     * @description
     */
    public static Object jsonPost(String url, Object param, Class<?> theClass) {

        Object rtnValue = null;
        try {
            if (!theClass.isPrimitive()) {
                rtnValue = theClass.newInstance();
            }
            String JSONInput = StringUtil.getObjectToJSON2(param);
            
            LogUtil.debug("API URL = " + url);
            LogUtil.debug("JSONInput = " + JSONInput);
            
            
			String hsKey = CommonUtil.getInstance().getServletProp("Loyalty.api.hskey");
		//	String hsKeyRslt = CryptoManager.generateHMAC(JSONInput, hsKey);
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
    //        headers.add("H_KEY", hsKeyRslt);
            HttpEntity httpEntity = new HttpEntity(JSONInput, headers);

            RestTemplate restTemplate = new RestTemplate();
            String result = restTemplate.postForObject(url, httpEntity, String.class);

            LogUtil.debug("result = " + result);

            rtnValue = StringUtil.strJsontoObject(result, theClass);
        }
        catch (InstantiationException | IllegalAccessException e) {
            LogUtil.error(e);
        }
        

        return rtnValue;
    }
    
    
    /**
     * @programId
     * @name jsonLoyaltyApiPost
     * @date 2019. 6. 24.
     * @author 장태식
     * @param url 호출할 API URL
     * @param param 전송 request parameter
     * @param theClass return받을 값이 Mapping 될 Object 클래스
     * @return
     * @description  로얄티 API 서버용으로 HMAC 첨부해서 전송함
     */
    public static Object jsonLoyaltyApiPost(String url, Object param, Class<?> theClass) {

        Object rtnValue = null;
        try {
            if (!theClass.isPrimitive()) {
                rtnValue = theClass.newInstance();
            }
            String JSONInput = StringUtil.getObjectToJSON(param);
            
            LogUtil.debug("API URL = " + url);
            LogUtil.debug("JSONInput = " + JSONInput);
            
            
			String hsKey = CommonUtil.getInstance().getServletProp("Loyalty.api.hskey");
			//String hsKeyRslt = CryptoManager.generateHMAC(JSONInput, hsKey);
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
        //    headers.add("H_KEY", hsKeyRslt);
            HttpEntity httpEntity = new HttpEntity(JSONInput, headers);

            RestTemplate restTemplate = new RestTemplate();
            String result = restTemplate.postForObject(url, httpEntity, String.class);

            LogUtil.debug("result = " + result);

            rtnValue = StringUtil.strJsontoObject(result, theClass);
        }
        catch (InstantiationException | IllegalAccessException e) {
            LogUtil.error(e);
        }
        

        return rtnValue;
    }
}
