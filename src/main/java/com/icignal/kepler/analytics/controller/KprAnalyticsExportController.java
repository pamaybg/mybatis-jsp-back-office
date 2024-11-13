package com.icignal.kepler.analytics.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.common.base.controller.CommonController;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.analytics.dto.request.KprAnalyticsExportReqDto;
import com.icignal.kepler.analytics.dto.response.KprAnalyticsExportResDto;
import com.icignal.kepler.analytics.service.KprAnalyticsExportService;


/*
 * 1. 클래스명	: KPRAnalyticsExportController
 * 2. 파일명	: KPRAnalyticsExportController.java
 * 3. 패키지명	: com.icignal.kepler.analytics.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Controller
@RequestMapping(value = "/kepler/analytics")
public class KprAnalyticsExportController extends CommonController {

	@Autowired
	private KprAnalyticsExportService kprAnalyticsExportService;

	 /*
	  * 1. 메소드명: getAnalyticsExportData
	  * 2. 클래스명: KPRAnalyticsExportController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param req
	 *   @param res
	 *   @param aer
	 *   @return
	 *   @throws Exception	
	 */
	@RequestMapping(value = "/getAnalyticsExportData.do", method = RequestMethod.POST)
	@ResponseBody
	public KprAnalyticsExportResDto getAnalyticsExportData(HttpServletRequest req, HttpServletResponse res, @RequestBody KprAnalyticsExportReqDto aer) throws Exception {
		LogUtil.param(KprAnalyticsExportController.class, aer);

		// 파일을 ByteArray 로 변경 후 BASE64 형태로 변환을 한다.
		// 그 후 생성된 파일을 삭제하고, 리턴할 객체에 담아 처리한다.
		// 이렇게 하는 이유는 서버에 파일이 계속 남아있기 때문.
		String fileFullPath = kprAnalyticsExportService.getAnalyticsExportData(req, res, aer);
		File exportFile = new File(fileFullPath);
		byte[] fileByteArray = FileUtils.readFileToByteArray(exportFile);
		String fileStream = new String(Base64.encodeBase64(fileByteArray), "UTF-8");
		exportFile.delete();

		// 리턴 객체 설정
		KprAnalyticsExportResDto resDto = new KprAnalyticsExportResDto();
		resDto.setSuccess(true);
		resDto.setFileName(exportFile.getName());
		resDto.setFileDataStream(fileStream);
		return resDto;
	}
}