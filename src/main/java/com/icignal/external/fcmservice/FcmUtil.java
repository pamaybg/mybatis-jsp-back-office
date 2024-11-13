/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: FcmUtil.java
 * 2. Package	: com.icignal.external.fcmservice
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 11. 16. 오전 10:48:57
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 11. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.external.fcmservice;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.AndroidConfig;
import com.google.firebase.messaging.AndroidNotification;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;

/*
 * 1. 클래스명	: FcmUtil
 * 2. 파일명	: FcmUtil.java
 * 3. 패키지명	: com.icignal.external.fcmservice
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 11. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Component
public class FcmUtil {
	public void send_FCM(String tokenId, String title, String content) {
        try {    
            //본인의 json 파일 경로 입력
           String FIREBASE_CONFIG_PATH = "icignal-fcm-firebase-adminsdk-5okhu-ef033ee317.json";
            
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(new ClassPathResource(FIREBASE_CONFIG_PATH).getInputStream()))
                    .setDatabaseUrl("https://icignal-fcm.firebaseio.com")
                    .build();
            
            //Firebase 처음 호출시에만 initializing 처리
            if(FirebaseApp.getApps().isEmpty()) { 
                FirebaseApp.initializeApp(options);
            }
            
            //String registrationToken = 안드로이드 토큰 입력;
            String registrationToken = "cUvofBxAxu0:APA91bGq0mGFGtSULSTZDS8jhHdpHDEBsUtxPeo_zz6d_tHPOs3klFadoEjkXwhBjTzokE_dnhUwBot-arLOCERO9TzlEMEwKCDSazg7zxD7Jvls5cNkhvsXUxgyp6ln_hAqXwGzToxQ";
                                        
            //message 작성
            Message msg = Message.builder()
                    .setAndroidConfig(AndroidConfig.builder()
                        .setTtl(3600 * 1000) // 1 hour in milliseconds
                        .setPriority(AndroidConfig.Priority.NORMAL)
                        .setNotification(AndroidNotification.builder()
                            .setTitle(title)
                            .setBody(content)
                            .setIcon("stock_ticker_update")
                            .setColor("#f45342")
                            .build())
                        .build())
                    .setToken(registrationToken)
                    .build();

            //메세지를 FirebaseMessaging 에 보내기
            String response = FirebaseMessaging.getInstance().send(msg);
            //결과 출력
            System.out.println("Successfully sent message: " + response);
                 
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
