package com.icignal.core.component;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
/*
 * 1. 클래스명	: IFVMImageUrlViewS3Utility
 * 2. 파일명	: IFVMImageUrlViewS3Utility.java
 * 3. 패키지명	: com.icignal.core.component
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *  (구) IFVMImageUrlViewS3Utility 
 * </PRE>
 */ 
@Component
public class ImageUrlViewS3 extends AbstractView {
	
    protected final Logger log = LoggerFactory.getLogger(this.getClass());
    

	@Override
	protected void renderMergedOutputModel(Map model,	HttpServletRequest req, HttpServletResponse res) throws Exception {
		String imagePath = (String) model.get("imagePath");
		
		res.setContentType("image/jpg");
		
		imagePath = HTMLTagFilterRequestWrapper.decodeXSS(imagePath);
		imagePath = imagePath.replace("/", "");
        
        //확장자 뒤의 ?에서부터 문자 제거
        int pos = imagePath.lastIndexOf( '.' );
        int pos2 = imagePath.lastIndexOf( '?' );
        if (pos < pos2) {
        	imagePath = imagePath.substring(0, pos2);
        }
        
        //캐릭터셋 별로 변환해서 버킷 내 이미지 존재하는지 체크한다. (한글 깨짐 문제)
        String [] charSet = {"utf-8","euc-kr","ksc5601","iso-8859-1","x-windows-949"};
        boolean setFlag = false;
        
        
        
        for (int i=0; i<charSet.length; i++) {
            for (int j=0; j<charSet.length; j++) {
                    String imagePathConverted = new String(imagePath.getBytes(charSet[i]), charSet[j]);
                    String IMAGE_SERVER_URL = CommonUtil.getInstance().getImageServerUrl() + "/";
                    LogUtil.info("IMAGE_SERVER_URL:" + IMAGE_SERVER_URL);
                    
                    
                    URL url = new URL(IMAGE_SERVER_URL + URLEncoder.encode(imagePathConverted, "UTF-8"));
                    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                    connection.setRequestMethod("GET");
                    connection.connect();

                    int code = connection.getResponseCode();
                    connection.disconnect();
                    
                    if(code == 200) {
                		try {
                			write(res, IOUtils.toByteArray(url.openStream()));
                		} catch (IOException e) {
                			LogUtil.error(e);
                		}
                		
                		setFlag = true;
                		break;
                    }
            }
            
            if (setFlag) break;
        }
        
        //파일명 일치하는 이미지 없는 경우 기본이미지 노출
        if(!setFlag) {
		    String defaultFilePath = getServletContext().getRealPath("/resources/images/marketing/content/photo_def.jpg");
    		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(defaultFilePath));
        	try {
    		int length = bis.available();
    		byte[] bytes = new byte[length];
    		bis.read(bytes);    		
    		write(res, bytes);
        	} catch (IOException e) {
        		LogUtil.error(e);
        	} finally {
        		bis.close();
        	}
        }
	}

	/**
	 * 응답 OutputStream에 파일 내용 쓰기
	 * @throws IOException 
	 */
	private void write(HttpServletResponse res, byte[] bytes) throws IOException {
		OutputStream output = res.getOutputStream();
		try {
			output.write(bytes);
			output.flush();
		} catch (IOException e) {
			LogUtil.error(e);
		} finally {
			output.close();
		}
	}


}
