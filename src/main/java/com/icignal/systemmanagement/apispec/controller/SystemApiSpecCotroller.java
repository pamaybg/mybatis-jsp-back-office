package com.icignal.systemmanagement.apispec.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.exception.RequiredFieldException;
import com.icignal.loyalty.channel.dto.response.LoyChannelListPageResDto;
import com.icignal.systemmanagement.apispec.dto.request.SystemApiParamDetailReqDto;
import com.icignal.systemmanagement.apispec.dto.request.SystemApiSpecFileListReqDto;
import com.icignal.systemmanagement.apispec.dto.request.SystemApiSpecInsertReqDto;
import com.icignal.systemmanagement.apispec.dto.request.SystemApiSpecListReqDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiParamResDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiSendLogListResDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiSpecDetailResDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiSpecFileListResDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiSpecListResDto;
import com.icignal.systemmanagement.apispec.service.SystemApiSpecService;

/*
 * 1. 클래스명	: SystemApiSpecCotroller
 * 2. 파일명	: SystemApiSpecCotroller.java
 * 3. 패키지명	: com.icignal.systemmanagement.apispec.controller
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *		API 정의서 Controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/system/apiSpec")
public class SystemApiSpecCotroller extends BaseController {

	@Autowired
	private SystemApiSpecService systemApiSpecService;
	
	@Autowired
	AuthHelper authHelper;
	
	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name + ".modal-tiles";
	
		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;	
	}

	/**
	 * @programId :
	 * @name : getApiSpecList
	 * @date : 2019. 11. 12.
	 * @author : yj.choi
	 * @table :
	 * @return : GridPagingResDto
	 * @description : api정의서 리스트
	 */
	@RequestMapping(value = "/getApiSpecList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemApiSpecListResDto> getApiSpecList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemApiSpecService.getApiSpecList(param);
	}

	/**
	 * @programId :
	 * @name : insertApiSpec
	 * @date : 2019. 11. 13.
	 * @author : yj.choi
	 * @table :
	 * @return : StatusResDto
	 * @description : api정의서 신규
	 */
	@RequestMapping(value = "/insertApiSpec.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertApiSpec(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemApiSpecInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));

		HttpSession session = request.getSession(true);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue = systemApiSpecService.insertApiSpec(reqDTO, session);

		return rtnValue;

	}

	/**
	 * @programId :
	 * @name : deleteApiSpec
	 * @date : 2019. 11. 13.
	 * @author : yj.choi
	 * @table :
	 * @return : StatusResDto
	 * @description : api정의서 삭제
	 */
	@RequestMapping(value = "/deleteApiSpec.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteApiSpec(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemApiSpecService.deleteApiSpec(param);
	}

	/**
	 * @programId :
	 * @name : updateApiSpec
	 * @date : 2019. 11. 13.
	 * @author : yj.choi
	 * @table :
	 * @return : StatusResDto
	 * @description : api정의서 수정
	 */
	@RequestMapping(value = "/updateApiSpec.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateApiSpec(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemApiSpecService.updateApiSpec(param);
	}

	/**
	 * @programId :
	 * @name : apiSpecDetail
	 * @date : 2019. 11. 13.
	 * @author : yj.choi
	 * @table :
	 * @return : StatusResDto
	 * @description : api정의서 상세
	 */
	@RequestMapping(value = "/apiSpecDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemApiSpecDetailResDto apiSpecDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemApiSpecService.apiSpecDetail(param);
	}

	/**
	 * @programId :
	 * @name : apiSpecFileList
	 * @date : 2019. 11. 14.
	 * @author : yj.choi
	 * @table :
	 * @return :
	 * @description : api정의서 파일리스트
	 */

	@RequestMapping(value = "/apiSpecFileList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemApiSpecFileListResDto> apiSpecFileList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody SystemApiSpecFileListReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemApiSpecService.apiSpecFileList(param);
	}

	/**
	 * @programId :
	 * @name : apiSpecUpload
	 * @date : 2019. 11. 14.
	 * @author : yj.choi
	 * @table :
	 * @return :
	 * @description : api 정의서 업로드
	 */

	@RequestMapping(value = "/apiSpecUpload.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto apiSpecUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemApiSpecFileListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setLoginInfo(authHelper.checkLoginSession(request, response));
		HttpSession session = request.getSession(true);

		return systemApiSpecService.apiSpecUpload(reqDTO, session);

	}

	/**
	 * @programId :
	 * @name : fileRemove
	 * @date : 2019. 11. 14.
	 * @author : yj.choi
	 * @table :
	 * @return : StatusResDto
	 * @description : api정의서 삭제
	 */
	@RequestMapping(value = "/fileRemove.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto fileRemove(HttpServletRequest request, HttpServletResponse response,
			@RequestBody SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);

		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemApiSpecService.fileRemove(param);
	}

	/**
	 * @programId :
	 * @name : fileRemove
	 * @date : 2019. 11. 15.
	 * @author : yj.choi
	 * @table :
	 * @return :
	 * @description : api 정의서 다운로드
	 */

	@RequestMapping(value = "/fileDown.do")
	public void imgDownload(HttpServletResponse response, HttpServletRequest request)
			throws IOException, RequiredFieldException, FileNotFoundException, UnsupportedEncodingException {
		// 세션 확인
		authHelper.checkUserInfo(request, response);

		if (StringUtil.isEmptyAll(request.getParameter("fileName"), request.getParameter("fileUrl"))) {
			String msg = "파일명 및 URL이 존재하지 않습니다.";
			LogUtil.error(msg);

			throw new RequiredFieldException(msg);
		}

		String fileName = request.getParameter("fileName");
		String fileUrl = request.getParameter("fileUrl");
		LogUtil.info(fileName);

		fileName = URLDecoder.decode(fileName, "UTF-8");
		fileUrl = URLDecoder.decode(fileUrl, "UTF-8");

		fileName = SecurityUtil.chkPath(fileName.trim());
		fileUrl = SecurityUtil.chkPath(fileUrl.trim());

		if (!(fileUrl.toLowerCase().indexOf("http://") == 0
				|| fileUrl.toLowerCase().indexOf("https://") == 0)) {
			String msg = "URL이 올바르지 못합니다.";
			LogUtil.error(msg);

			throw new RequiredFieldException(msg);
		}

		// MIME Type 을 application/octet-stream 타입으로 변경
		// 무조건 팝업(다운로드창)이 뜨게 된다.
		response.setContentType("application/download; UTF-8");
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");

		String header = request.getHeader("User-Agent");

		if (header.contains("MSIE") || header.contains("Trident")) {
			fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");
		} else {
			fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		}

		OutputStream os = null;
		InputStream in = null;
		URL url = null;
		URLConnection uc = null;
		String type = null;

		try {
			url = new URL(fileUrl);
			uc = url.openConnection();
			type = uc.getContentType();

			os = response.getOutputStream();
			in = url.openStream();

			if (in != null) {
				int n = 0;
				byte[] b = new byte[1024];

				while ((n = in.read(b)) != -1) {
					os.write(b, 0, n);
				}
			}
		} catch (IOException io) {
			throw io;
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e2) {
					LogUtil.error(e2);
					in = null;
				}
			}

			if (os != null) {
				try {
					os.close();
				} catch (IOException e3) {
					LogUtil.error(e3);
					os = null;
				}
			}
		}

	}
	
	 /*
	  * 1. 메소드명: getApiSendLogList
	  * 2. 클래스명: SystemApiSpecCotroller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api명세서 - api 전송로그 리스트 탭
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value ="/getApiSendLogList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemApiSendLogListResDto> getApiSendLogList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		
		return systemApiSpecService.getApiSendLogList(reqDto);
	}
	
//	@RequestMapping(value = "/apiSpecExcelDown.do", method = RequestMethod.POST)
//	public @ResponseBody String apiSpecExcelDown(HttpServletRequest request, HttpServletResponse response,@RequestBody SystemApiSpecListReqDto reqDto, ModelMap model) {
//		LogUtil.param(this.getClass(), reqDto);
//		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
//		HttpSession session = request.getSession(true);
//		//내부페이지 url
//		String programPath = (String) session.getAttribute("URL_INCLUDE");
//		if("".equals(programPath)) programPath = (String) session.getAttribute("URL");
//
//		ProgramCache proResDto = null;
//		String objCode = reqDto.getObjCode();
//		commonService.getExcelMetaData(session, programPath, proResDto, objCode, model);
//		
//		GridPagingResDto<SystemProgListResDto> data = systemApiSpecService.getApiSpecExcelDown(reqDto);
//
//		model.addAttribute("result", data);
//		
//		return "ExcelView";
//	}
	
	 /*
	  * 1. 메소드명: getApiChnlList
	  * 2. 클래스명: SystemApiSpecCotroller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 명세서 - 상세 채널리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value ="/getApiChnlList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyChannelListPageResDto> getApiChnlList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return systemApiSpecService.getApiChnlList(reqDto);
	}
	
	 /*
	  * 1. 메소드명: apiSpecJoinChnl
	  * 2. 클래스명: SystemApiSpecCotroller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 명세서 상세 채널 등록 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/apiSpecJoinChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto apiSpecJoinChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemApiSpecService.apiSpecJoinChnl(reqDto);
	}
	
	 /*
	  * 1. 메소드명: removeApiChnl
	  * 2. 클래스명: SystemApiSpecCotroller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 명세서 상세 채널 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/removeApiChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeApiChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemApiSpecService.removeApiChnl(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getApiSpecNo
	  * 2. 클래스명: SystemApiSpecCotroller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api 번호 채번
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/getApiSpecNo.do", method = RequestMethod.POST)
	public @ResponseBody SystemApiSpecListResDto getApiSpecNo(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return systemApiSpecService.getApiSpecNo(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getApiSpecListPop
	  * 2. 클래스명: SystemApiSpecCotroller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getApiSpecListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemApiSpecListResDto> getApiSpecListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemApiSpecService.getApiSpecListPop(param);
	}
	
	 /*
	  * 1. 메소드명: copyApiChnl
	  * 2. 클래스명: SystemApiSpecCotroller
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 상세 채널 복사
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value="/copyApiChnl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto copyApiChnl(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemApiSpecService.copyApiChnl(reqDto);
	}
	
	@RequestMapping(value ="/getApiParamList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemApiParamResDto> getapiParamList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return systemApiSpecService.getApiParamList(reqDto);
	}
	
	@RequestMapping(value ="/getApiParamResList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemApiParamResDto> getApiParamResList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return systemApiSpecService.getApiParamResList(reqDto);
	}
	
	@RequestMapping(value ="/getParamReqDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemApiParamResDto getParamReqDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return systemApiSpecService.getParamReqDetail(reqDto);
	}
	
	@RequestMapping(value ="/getParamResDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemApiParamResDto getParamResDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return systemApiSpecService.getParamResDetail(reqDto);
	}
	
	@RequestMapping(value="/saveApiParamReq.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveApiParamReq(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiParamDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemApiSpecService.saveApiParamReq(reqDto);
	}
	
	@RequestMapping(value="/editApiParamReq.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editApiParamReq(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiParamDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemApiSpecService.editApiParamReq(reqDto);
	}
	
	@RequestMapping(value="/removeApiParam.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeApiParam(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiParamDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemApiSpecService.removeApiParam(reqDto);
	}
	
	@RequestMapping(value ="/getParParamList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemApiParamResDto> getParParamList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemApiSpecListReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		return systemApiSpecService.getParParamList(reqDto);
	}
	
}
