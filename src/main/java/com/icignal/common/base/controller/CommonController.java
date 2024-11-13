package com.icignal.common.base.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.regex.Matcher;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icignal.common.helper.ErrorHelper;
import com.icignal.core.exception.DataFailException;
import com.nhncorp.lucy.security.xss.XssPreventer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.dto.request.EncryptReqDto;
import com.icignal.common.base.dto.request.FileReqDto;
import com.icignal.common.base.dto.request.GridExcelExportReqDto;
import com.icignal.common.base.dto.request.ImageFileUploadReqDto;
import com.icignal.common.base.dto.request.ImageManageContentReqDto;
import com.icignal.common.base.dto.request.ImageManageOptionReqDto;
import com.icignal.common.base.dto.response.FileUploadResDto;
import com.icignal.common.base.dto.response.ImageCondResDto;
import com.icignal.common.base.dto.response.ImageManageOptionResDto;
import com.icignal.common.base.dto.response.ImageSyncFileUploadResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.dto.response.TempUploadResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.session.SessionUtility;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CookieUtil;
import com.icignal.common.util.EncryptUtil;
import com.icignal.common.util.ExcelUtil;
import com.icignal.common.util.JavaScriptStringUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.component.ImageUrlView;
import com.icignal.core.component.ImageUrlViewS3;
import com.icignal.core.exception.FileNameErrorException;

/**
 * @name : infavor.base.controller
 * @date : 2016. 6. 27.
 * @author : dg.ryu
 * @description : 기본 Controller
 */

@Controller
@RequestMapping("/common")
public class CommonController extends BaseController {
	
	@Autowired 
	private AuthHelper authHelper;
	
	@Autowired 
	private CommonService commonService;

	@Resource
	private ImageUrlViewS3 imageUrlViewS3;

	@Resource
	private ImageUrlView imageUrlView;

	@RequestMapping("/spaController")
	public String checkAuthority (HttpServletRequest request, HttpServletResponse response, Model model) {
		String rtnValue = null;
		HttpSession session = request.getSession(true);
		String url = (String) request.getAttribute("mktUri");
		rtnValue = authHelper.checkUserInfoInclude(request, response, url + ".spa-tiles");
		ProgramCache proResDto = new ProgramCache();
		String userRId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		boolean checkAuth = BeansUtil.getApplicationProperty("icignal.auth.program-check", Boolean.class , false);
		if(checkAuth) {
			
//		LoginResDto resDto = new LoginResDto();
//		resDto = this.checkLoginSession(request, response);
		proResDto = authCommonService.getProgramAuth(userRId,url);
		if("base/login/goLogin".equals(rtnValue) == false) {
			try {
				//로그인 페이지 이동 시 접근권한 체크 X
				if(ObjectUtil.isNotEmpty(url) == true && url.equals("/login") == false) {
					//접근 권한 체크
						
					//프로그램 접근 권한 체크
					proResDto = authCommonService.getProgramAuth(userRId,url);
					
					//프로그램 접근 조회 결과 권한이 없으면 메시지 출력
					if(!proResDto.getSuccess()) {
						JavaScriptStringUtil.setPrintWriter(response);
						return null;
					}
					
				}
			} catch (IOException e) {
				LogUtil.error(e);
			}

		}
		}
		model.addAttribute("pgmObject",proResDto.getObjectCache());
		model.addAttribute("pgmChild",proResDto.getProgramChild());
		return rtnValue;
	}
	//위에 로직과 연관되있음
//	private void setPrintWriter(HttpServletResponse response, String alertMsg) throws IOException {
//		response.setContentType("text/html; charset=UTF-8");
//		PrintWriter printwriter;
//		printwriter = response.getWriter();
//		printwriter.print("<script>alert('"+ alertMsg +"');history.go(-1); </script>");
//		printwriter.flush();
//		printwriter.close();
//	}
	
	/**
	 * @name : common
	 * @date : 2013. 6. 24.
	 * @author : 류동균
	 * @description : 공통 페이지 호출
	 */
	@RequestMapping(value = "/uploadImage/{name:.+}")
	public String MKTAconBaseController(@PathVariable("name") String name) {
		return "MKTAcon/common/" + name;
	}

	 /*
	  * 1. 메소드명: logout
	  * 2. 클래스명: BaseController
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그아웃을  처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @return	
	 */
	@RequestMapping(value = "/logout.do", method = RequestMethod.POST) 
	public @ResponseBody StatusResDto logout(HttpServletRequest request, HttpServletResponse response) { 
		LogUtil.debug("BaseController : logout");
		StatusResDto rtnValue = new StatusResDto();
		HttpSession session = request.getSession(true); // 세션값을 가져옴
		//세션풀 제거
		SessionUtility.removeSession(session);		
		CookieUtil.removeCookie(request, response);
		rtnValue.setSuccess(true); // 세션의 success를 true 로 설정
		return rtnValue;
	}


	/**
	 * @name : tempUpload
	 * @date : 2014. 11. 10.
	 * @author : 장용
	 * @description : 임시 이미지 업로드 (원본) 이미지 등록 시 임시 파일을 저장 - 비콘 매니저 라이트 공통 이미지 업로드
	 */
	@RequestMapping(value = "/fileupload/tempUploadOrg.do", method = RequestMethod.POST)
	public @ResponseBody List<TempUploadResDto> tempUpload( 
			@RequestParam("file") MultipartFile file, HttpServletRequest request) { 
		HttpSession session = request.getSession(true);
		return commonService.tempUpload(request.getSession().getServletContext().getRealPath("/"), session.getId(), file);
	}

	/**
	 * @name : tempUpload
	 * @date : 2014. 11. 10.
	 * @author : 장용
	 * @description : 임시 이미지 업로드 - 이미지 경로에 해당 이미지 경로를 저장 - 비콘 매니저 라이트 공통 이미지 업로드
	 */
	@RequestMapping(value = "/fileupload/tempUpload.do", method = RequestMethod.POST, headers = "content-type=multipart/*") // admin/categoryMangement.jsp
	public @ResponseBody List<TempUploadResDto> tempUpload(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(true); 
		List<TempUploadResDto> list = commonService.tempUpload(request.getSession().getServletContext().getRealPath("/"), session.getId(), file); // 이미지
		return list;
	}
	
	/**
	* @programId :
	* @name : tempUploadS3
	* @date : 2018. 11. 7.
	* @author : hy.jun
	* @table :
	* @return : List<TempUploadResponseDTO>
	* @description :
	*/
	@RequestMapping(value = "/fileupload/tempUploadS3.do", method = RequestMethod.POST, headers = "content-type=multipart/*") // admin/categoryMangement.jsp
	public @ResponseBody List<TempUploadResDto> tempUploadS3(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(true); // 세션 객체가 없으면 new 생성 반환,
		List<TempUploadResDto> list = commonService.tempUploadS3(request.getSession().getServletContext().getRealPath("/"), session.getId(), file); // 이미지
		return list;
	}
	
	/**
	 * @name : tempUploadIE
	 * @date : 2014. 11. 10.
	 * @author : 장용
	 * @description : 임시 이미지 업로드 IE - 비콘 매니저 라이트 공통 이미지 업로드 추가 임시 이미지폴더에 저장된 이미지
	 *              경로를 가지고와서 json 으로 파싱한 후 리턴
	 */
	@RequestMapping(value = "/fileupload/tempUploadIE.do", method = RequestMethod.POST, headers = "content-type=multipart/*", produces = "text/plain")
	// multipart 입력폼 생성 - 파일전송 타입 - 모든 파입, Produces : 출력하고자 하는 데이터 포맷 text/plain
	// 미디어 유형, accept 헤더를 참고
	public ModelAndView tempUploadIE(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		// @RequestParam 업로드 파일 데이터 전송 방식
		HttpSession session = request.getSession(true);
		List<TempUploadResDto> results = commonService.tempUpload(request.getSession().getServletContext().getRealPath("/"), session.getId(), file);
		String convertJSON = StringUtil.getJSONtoObject(results).trim().replace("\r\n", "").replace(" ", "").replace("\n", ""); // 경로값을
		return new ModelAndView("MKTAcon/common/uploadResult", "ImageInfo", convertJSON);
	}
	
	/**
	* @programId :
	* @name : tempUploadIES3
	* @date : 2018. 11. 7.
	* @author : hy.jun
	* @table :
	* @return : ModelAndView
	* @description :
	*/
	@RequestMapping(value = "/fileupload/tempUploadIES3.do", method = RequestMethod.POST, headers = "content-type=multipart/*", produces = "text/plain")
	// multipart 입력폼 생성 - 파일전송 타입 - 모든 파입, Produces : 출력하고자 하는 데이터 포맷 text/plain
	// 미디어 유형, accept 헤더를 참고
	public ModelAndView tempUploadIES3(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(true);		
		List<TempUploadResDto> results = commonService.tempUploadS3(request.getSession().getServletContext().getRealPath("/"), session.getId(), file);		
		String convertJSON = StringUtil.getJSONtoObject(results).trim().replace("\r\n", "").replace(" ", "").replace("\n", ""); // 경로값을
		return new ModelAndView("MKTAcon/common/uploadResult", "ImageInfo", convertJSON); 	
	}
	
	/**
	 * @name : encryptAes
	 * @date : 2013. 6. 24.
	 * @author : 류동균
	 * @description : AES 암호화
	 */
	// Advanced Encryption Standard(AES)는 128, 192, 256비트인 키를 사용하는 대칭 블록 암호화 방식이다
	// 바이너리나 압축파일과 같은 8비트 이진 데이터를 문자코드에 영향을 받지않는 공통 ascii 문자들로만 이루어진 문자열로 바꾸는
	// 인코딩 방식 보안  문제로  인해 파일을 주고 받을 때 스트림 방식이  아닌 base64로 인코딩하여 스트링 형식으로 변환함
	@RequestMapping(value = "/getEncryptAES.do", method = RequestMethod.POST) 
	public @ResponseBody StatusResDto encryptAes(@RequestBody EncryptReqDto er) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		String result = EncryptUtil.AES_Encode(er.getEncryptStr());
		if (result.length() > 0) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(result.trim());
		}
		return rtnValue;
	}
	
//	/**
//	 * @name : getImage
//	 * @date : 2016. 4. 28.
//	 * @author : "류동균"
//	 * @throws Exception
//	 * @description : 이미지 뷰
//	 */
//	@RequestMapping("/imgView.do")
//	public ImageUrlView getImage(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request) throws Exception {
//		String imagePath = request.getParameter("imagePath");
//		modelMap.put("imagePath", imagePath);
//		return imageUrlView;
//	}

	@RequestMapping("/imageView.do")
	public ImageUrlView getImage(HttpServletResponse response, HttpServletRequest request, ModelMap map,
								 @RequestParam(value = "imagePath", required = false) String imagePath,
								 @RequestParam(value = "imageName") String imageName) throws Exception {
		this.checkLoginSession(request, response);
		String imagePathXss = XssPreventer.unescape(imagePath);
		String imageNameXss = XssPreventer.unescape(imageName);

		if(!imageName.toLowerCase().contains(".png") && !imageName.toLowerCase().contains(".jpeg") && !imageName.toLowerCase().contains(".jpg") && !imageName.toLowerCase().contains(".bmp") && !imageName.toLowerCase().contains(".gif")){
			throw new DataFailException("알 수 없는 데이터 유형 입니다.");
		}

		map.put("imagePath", imagePathXss);
		map.put("imageName", imageNameXss);



		return imageUrlView;
	}


	/**
	* @programId :
	* @name : getImage
	* @date : 2018. 11. 7.
	* @author : hy.jun
	* @table :
	* @return : IFVMImageUrlViewUtility
	* @description : 이미지 뷰
	*/
	@RequestMapping("/imgViewS3.do")
	public ImageUrlViewS3 getImageS3(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request) throws Exception {
		this.checkLoginSession(request, response);
		String imagePath = request.getParameter("imagePath");
		modelMap.put("imagePath", imagePath);
		return imageUrlViewS3;
	}

	/**
	 * @name : fileDownload
	 * @date : 2016. 10. 4.
	 * @author : 류동균
	 * @description : 파일 다운로드
	 */
	@RequestMapping(value = "/fileDownload.do")
	public void fileDownload(HttpServletResponse response, HttpServletRequest request) throws IOException, FileNameErrorException, FileNotFoundException,  UnsupportedEncodingException {
		// 세션 확인
		authHelper.checkUserInfo(request, response);
		if(StringUtil.isEmptyAll(request.getParameter("fileName"), request.getParameter("filePath"))) {
			String msg = "파일명 및 파일경로가 존재하지 않습니다.";
			LogUtil.error(msg);
			throw new FileNameErrorException(msg);
		}
		String fileName = new String(request.getParameter("fileName").getBytes("8859_1"), "UTF-8");
        String filePath = new String(request.getParameter("filePath").getBytes("8859_1"), "UTF-8");
        fileName = SecurityUtil.chkPath(fileName);
		filePath = SecurityUtil.chkPath(filePath);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		File orgFile = new File(realPath + File.separator + filePath);
		LogUtil.info(realPath + File.separator + filePath);
		if(orgFile != null && orgFile.exists() && orgFile.isFile()){
			// MIME Type 을 application/octet-stream 타입으로 변경
			// 무조건 팝업(다운로드창)이 뜨게 된다.
			response.setContentType("application/octet-stream");
			// 브라우저는 ISO-8859-1을 인식하기 때문에
			// UTF-8 -> ISO-8859-1로 디코딩, 인코딩 한다.
			fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
			// 파일명 지정
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			OutputStream os = null;
			FileInputStream fis = null; 
			try{
				os = response.getOutputStream();
				fis = new FileInputStream(orgFile.getAbsolutePath());
				if(fis != null ) {
					int n = 0;
					byte[] b = new byte[1024];
					while ((n = fis.read(b)) != -1) {
						os.write(b, 0, n);
					}
				}
			} catch (IOException io) {
				throw io;
			}finally {
			        if(fis != null ) {
						fis.close();
					}
			        
					if(os != null ) {
						os.close();
					}				
			}
		}else {
			throw new FileNotFoundException();
		}
	}

	@RequestMapping(value = "/boardFileDownload.do")
	public void boardFileDownload(HttpServletResponse response, HttpServletRequest request) throws IOException, FileNameErrorException, FileNotFoundException,  UnsupportedEncodingException	{
		if(StringUtil.isEmptyAll(request.getParameter("fileName"), request.getParameter("filePath"))) {
			String msg = "파일명 및 파일경로가 존재하지 않습니다.";
			LogUtil.error(msg);
			throw new FileNameErrorException(msg);
		}
		String fileName = new String(request.getParameter("fileName").getBytes("8859_1"), "UTF-8");
        String filePath = new String(request.getParameter("filePath").getBytes("8859_1"), "UTF-8");	
        fileName = SecurityUtil.chkPath(fileName);
		filePath = SecurityUtil.chkPath(filePath);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		File orgFile = new File(realPath + File.separator + filePath);
		LogUtil.info(realPath + File.separator + filePath);
		if( orgFile != null && orgFile.exists() && orgFile.isFile()){
			// MIME Type 을 application/octet-stream 타입으로 변경
			// 무조건 팝업(다운로드창)이 뜨게 된다.
			response.setContentType("application/octet-stream");
			// 브라우저는 ISO-8859-1을 인식하기 때문에
			// UTF-8 -> ISO-8859-1로 디코딩, 인코딩 한다.			
			fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
			// 파일명 지정
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			OutputStream os = null;
			FileInputStream fis  = null;
			try {
				os = response.getOutputStream();        
				fis = new FileInputStream(orgFile.getAbsolutePath());
				if(fis != null) {
					int n = 0;
					byte[] b = new byte[1024];
					while ((n = fis.read(b)) != -1) {
						os.write(b, 0, n);
					}
				}
			} catch (IOException ioe) {
				throw ioe;
			}finally {
				if(fis != null ) {
					fis.close();
				}
				if(os != null ) {
					os.close();
				}					
			}
		}else {
			throw new FileNotFoundException();
		}
	}

	/**
	 * @name : getRowID
	 * @date : 2016. 11. 3.
	 * @author : dg.ryu
	 * @table : com.getRowID()
	 * @return : String
	 * @description : rowId 추출
	 */
	@RequestMapping(value = "/getRowID.do")
	public @ResponseBody String getRowID() {
         return CommonUtil.newRid();
	}

	/**
	 * @name : executeExcelDownload
	 * @date : 2017. 03. 30.
	 * @author : 이기오
	 * @return :
	 * @description : 엑셀 다운로드
	 *  -- 생성된 엑셀 파일을 넘겨주면 처리 가능.
	 *  -- 기존 엑셀다운로드는 서버에 파일을 남김으로 서버 리소스 낭비가 있어서 해당 방식으로 처리함.
	 */
	public void executeExcelDownload(HttpServletRequest request, HttpServletResponse response, File file) {
		FileInputStream fis = null;
		String fileName = null;
		if(file != null) {
			try {
				fileName = URLEncoder.encode(file.getName(), "UTF-8").replaceAll("\\+", "%20");
			} catch (UnsupportedEncodingException e1) {
	             LogUtil.error(e1);
			}
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			response.setContentType("application/vnd.ms-excel");
			try {
					fis = new FileInputStream(file);
					if(fis != null) {
						ExcelUtil.copyStream(fis, response.getOutputStream());
					}
			} catch (IOException e) {
	           LogUtil.error(e);
			} finally {
				if (fis != null) {
						try {
							fis.close();
						} catch (IOException e) {
							LogUtil.error(e.getMessage(), e);
						}
				}
				if (file.isFile()) {
					file.delete();
				}
			}
		}
	}
	
	/**
	 * @name : gridExcelExport
	 * @date : 2017. 6. 21.
	 * @author : "dg.ryu"
	 * @return : StatusResDto
	 * @description : 그리드 엑셀 다운로드
	 */
	@RequestMapping(value = "/gridExcelExport.do", method = RequestMethod.POST )
	public @ResponseBody  StatusResDto gridExcelExport(HttpServletRequest request, HttpServletResponse response, @RequestBody GridExcelExportReqDto reqDto) {
	 	LogUtil.param(this.getClass(), reqDto);  
	 	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
	 	reqDto.setRequest(request);
	 	reqDto.setResponse(response);
	 	StatusResDto rtnValue = new StatusResDto();
	 	rtnValue = commonService.gridExcelExport(reqDto);
	 	return rtnValue;
	}
	
	/**
	 * @programId : 
	 * @name : fileUpload
	 * @date : 2017. 6. 28.
	 * @author : "dg.ryu"
	 * @table : 
	 * @return : MKTFileUploadResponseDTO
	 * @description : 파일 업로드
	 */
	@RequestMapping(value = "/fileupload/fileUpload.do", method = RequestMethod.POST, headers = "content-type=multipart/*")
	public @ResponseBody FileUploadResDto fileUpload(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(true); // 세션 객체가 없으면 new 생성 반환,
		//파일 업로드
		FileUploadResDto rtnVlue = commonService.fileUpload(request.getSession().getServletContext().getRealPath("/"), session.getId(), file);
		return rtnVlue;
	}
	
	/**
	 * @programId : 
	 * @name : addFile
	 * @date : 2017. 6. 29.
	 * @author : "dg.ryu"
	 * @table : com.com_file
	 * @return : StatusResDto
	 * @description : 파일 등록
	 */
	@RequestMapping(value = "/fileupload/addFile.do")
	public @ResponseBody StatusResDto addFile(HttpServletRequest request, HttpServletResponse response, @RequestBody FileReqDto param) {
		LogUtil.param(this.getClass(), param);  
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return commonService.addFile(param);
	}

	/**
	 * @name : deleteFile
	 * @date : 2017. 7. 4.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 파일 삭제
	 */
	@RequestMapping(value = "/fileupload/deleteFile.do")
	public @ResponseBody StatusResDto deleteFile(HttpServletRequest request, HttpServletResponse response, @RequestBody FileReqDto param) {
		LogUtil.param(this.getClass(), param);  
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		return commonService.deleteFile(param);
	}

	/**
	* @programId :
	* @name : insertSearchLog
	* @date : 2017. 10. 24.
	* @author : 이성원
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	
	public void insertSearchLog(Object param) {
		LogUtil.param(this.getClass(), param);
	}
	
	/**
	* @programId :
	* @name : fileEncrypt
	* @date : 2019. 1. 31.
	* @author : hy.jun
	* @table :
	* @return : String
	* @description : byte 암호화된 파일 암호화 API 
	*/
	@RequestMapping(value = "/fileEncrypt.do")
	public void fileEncrypt(@RequestParam("src") String srcPath, @RequestParam("tgt") String tgtPath) {
		//인가된 경로 체크
		boolean isAvailable = false;
		String path = "/app/UploadFile";
		String[] paths = path.split(",");
		for(String p : paths) {
			if(srcPath.startsWith(p)) {
				isAvailable = true;
				break;
			}
		}
		if(isAvailable) {
			File files = new File(srcPath);
			if(files != null && files.isDirectory()) {
				for(File file : files.listFiles()) {
					//src 경로와 target 경로가 동일할 경우 복호화 시 src 파일을 엎어치게 되므로 에러문구 리턴한다.
					if(srcPath.equals(tgtPath)) {
						LogUtil.info("원본파일과 복호화파일은 동일하게 지정할 수 없습니다.");
					} else {
						//파일 복호화
						SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), new File(srcPath + File.separator + file.getName()), new File(tgtPath + File.separator + file.getName()));
					}
				}
				LogUtil.info("암호화 완료되었습니다. 대상파일 갯수 : "+ files.listFiles().length + " 복호화파일 경로 : " + tgtPath);
			} else if(new File(srcPath).exists()) {
				//src 경로와 target 경로가 동일할 경우 복호화 시 src 파일을 엎어치게 되므로 에러문구 리턴한다.
				if(srcPath.equals(tgtPath)) {
					LogUtil.error("원본파일과 암호화파일은 동일하게 지정할 수 없습니다.");
				} else {
					//파일 복호화
					SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), new File(srcPath), new File(tgtPath));
					LogUtil.info("암호화 완료되었습니다. " + tgtPath);
				}
			} else {
				LogUtil.error("원본파일이 존재하지 않습니다.");
			}
		} else {
			LogUtil.error("인가되지 않은 경로입니다.");
		}
	}
	
	/**
	* @programId :
	* @name : fileDecrypt
	* @date : 2019. 1. 31.
	* @author : hy.jun
	* @table :
	* @return : String
	* @description : byte 암호화된 파일 복호화 API 
	*/
	@RequestMapping(value = "/fileDecrypt.do")
	public void fileDecrypt(@RequestParam("src") String srcPath, @RequestParam("tgt") String tgtPath) {
		//인가된 경로 체크
		boolean isAvailable = false;
		String path = "/app/UploadFile";
		String[] paths = path.split(",");
		for(String p : paths) {
			if(srcPath.startsWith(p)) {
				isAvailable = true;
				break;
			}
		}
		if(isAvailable) {
			//src 경로와 target 경로가 동일할 경우 복호화 시 src 파일을 엎어치게 되므로 에러문구 리턴한다.
			if(srcPath.equals(tgtPath)) {
				LogUtil.info("원본파일과 복호화파일은 동일하게 지정할 수 없습니다.");
			} else {
				if(!new File(srcPath).exists()) {
					LogUtil.info("원본파일이 존재하지 않습니다.");
				} else {
					//파일 복호화
					SecurityUtil.createCryptoFile(Cipher.DECRYPT_MODE, BeansUtil.getFileCryptorKey(), new File(srcPath), new File(tgtPath));
					LogUtil.info("복호화 완료되었습니다. ");
				}
			}
		} else {
			LogUtil.info("인가되지 않은 경로입니다.");
		}
	}
	
	/**
	* @programId :
	* @name : getEncrypt
	* @date : 2019. 7. 18.
	* @author : dg.ryu
	* @table :
	* @return : String
	* @description : 암호화 
	*/
	@RequestMapping(value = "/getEncrypt.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getEncrypt(HttpServletRequest request, HttpServletResponse response, @RequestBody EncryptReqDto er) {
		authHelper.checkLoginSession(request, response);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(true);
		String encryptStr = "";
		encryptStr = SecurityUtil.encodeDbAES256(BeansUtil.getDbEncryptDataKey(), er.getEncryptStr());

		
		rtnValue.setMessage(encryptStr);

		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : excelSampleDown
	* @date : 2019. 7. 29.
	* @author : dg.ryu
	* @table :
	* @return : 
	* @description : 엑셀 샘플 다운로드 
	*/
	@RequestMapping(value = "/excelSampleDown.do")
	public void excelSampleDown(HttpServletResponse response, HttpServletRequest request) {
    	this.checkLoginSession(request, response);
    	OutputStream os = null;
		FileInputStream fis = null;
    	String fileName = request.getParameter("fileName");
    	String filePath = null;
    	String offerType = request.getParameter("offerType");
    	if(ObjectUtil.isNotEmpty(offerType)) {	
    		if(offerType.equals("STMP")){
    			fileName="stamp_sample_data.xls";
    		}else if(offerType.equals("PNT")){
    			fileName="point_sample_data.xls";
    		}else if(offerType.equals("CARD")){
    			fileName="card_sample_data.xls";
    		}else if(offerType.equals("TARGET_MEMBER")){
    			fileName="point_upload_member_sample_data.xlsx";
    		}else if(offerType.equals("100")){
    			fileName="point_upload_event_sample_data.xls";
    		}else if(offerType.equals("TARGET_EMP")){
    			fileName="point_upload_cust_sample_data.xls";
    		}else if(offerType.equals("TARGET_MEMBER_CI")){
    			fileName="point_upload_cust(CI)_sample_data.xls";
    		}else if(offerType.equals("PROD")) {
    			fileName="prod_list_sample_data.xls";
    		}else if(offerType.equals("EVENT_WINNER")) {
    			fileName="event_winner_sample_data.xls";
    		}else if(offerType.equals("PROD_ENTRY")){
    			fileName="send_success_sample_data.xls";
    		}else if(offerType.equals("UPLOAD_FAMILY")){
    			fileName="family_upload_sample.xlsx";
    		}else if(offerType.equals("UPLOAD_GENERAL")){
    			fileName="general_upload_sample.xlsx";
    		}
    	}
    	try {
			String fileRootPath = BeansUtil.getApplicationProperty("icignal.context.resource.file-sample-path").replaceAll("/", Matcher.quoteReplacement(File.separator));
			fileName = SecurityUtil.chkPath(fileName);
			filePath = fileRootPath + fileName;
			String realPath = request.getSession().getServletContext().getRealPath("/").replaceAll("/", Matcher.quoteReplacement(File.separator));
			File orgFile = new File(realPath  + filePath);
	         if(orgFile.exists()) {
				//fileName = SecurityUtil.chkPath(fileName);
				//ContentType 설정
				String mime = request.getSession().getServletContext().getMimeType(fileName);
				if (ObjectUtil.isEmpty(mime)) {
					mime = "application/octet-stream;charset=euc-kr";
				} else {
					mime = "application/octet-stream";
				}
				response.setContentType(mime);
				//헤더 설정
				String userAgent = request.getHeader("User-Agent");
				if (userAgent.indexOf("MSIE 5.5") > -1) { // MS IE 5.5 이하
					response.setHeader("Content-Disposition", "filename="+ URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+","\\ ") + ";");
				} else if (userAgent.indexOf("MSIE") > -1) { // MS IE (보통은 6.x 이상 가정)
					response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ") + ";");
				} else if (userAgent.indexOf("Trident") > -1) { //MS IE 11
					response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "\\ ") + ";");
				} else { // 모질라나 오페라
					response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("UTF-8"), "latin1").replaceAll("\\+", "\\ ") + ";");
				}
				//파일 출력
				fis = new FileInputStream(orgFile.getAbsolutePath());
				if(fis != null) {
					os = response.getOutputStream();
					int n = 0;
					byte[] b = new byte[1024];
					while ((n = fis.read(b)) != -1) {
						os.write(b, 0, n);
					}
				}
	         } else {
	        	 throw new FileNotFoundException();
	         }
		} catch (UnsupportedEncodingException e) {
			     LogUtil.error(e);
		} catch(IOException io){
			LogUtil.error(io);
		}finally {
				if(fis != null )
					try {
						fis.close();
					} catch (IOException e) {
						LogUtil.error(e.getMessage(),e);
					}
				
			try {
				if(os != null)	os.close();
			}catch (IOException io){LogUtil.error(io);  os = null;}
		}
    }
	
	/**
	 * @programId : MKT_CHL_P03
	 * @name : getNewImgUpType
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<ImageManageOptionResponseDTO>
	 * @description : 해당 채널에 관련된 이미지 업로드 타입 반환.
	 */
	@RequestMapping(value = "/getNewImgUpType.do", method = RequestMethod.POST)
	public @ResponseBody
	List<ImageManageOptionResDto> getNewImgUpType(HttpServletRequest request, HttpServletResponse response, @RequestBody ImageManageOptionReqDto mcr) {
	   LogUtil.param(this.getClass(), mcr);
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = this.checkLoginSession(request, response);
	   return commonService.getNewImgUpType(mcr);
	}
	
	/**
	 * @programId : MKT_CHL_P03
	 * @name : getImageUpType
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<ImageCondResponseDTO>
	 * @description : 해당 채널에 관련된 이미지 업로드 타입 반환.
	 */
	@RequestMapping(value = "/getImageUpType.do", method = RequestMethod.POST)
	public @ResponseBody
	List<ImageCondResDto> getImageUpType(HttpServletRequest request, HttpServletResponse response, @RequestBody ImageManageContentReqDto mcr) {
	   LogUtil.param(this.getClass(), mcr);
	   //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
	   LoginResDto loginInfo = this.checkLoginSession(request, response);
	   //세션에 저장되어 있는 지원의 아이디를 셋팅
	   mcr.setUserId(loginInfo.getEmpEmail());
	   return commonService.getImageUpType(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : getFileList
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : ImageSyncFileUploadResponseDTO
	 * @description : 콘텐츠 파일 리스트 조회
	 */
	@RequestMapping(value = "/getFile.do", method = RequestMethod.POST)
	public @ResponseBody
	ImageSyncFileUploadResDto getFileList(HttpServletRequest request, HttpServletResponse response, @RequestBody ImageFileUploadReqDto mfr) {
		LogUtil.param(this.getClass(), mfr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		ImageSyncFileUploadResDto rtnValue = new ImageSyncFileUploadResDto();
		rtnValue.setFiles(commonService.getFileList(mfr));
		rtnValue.setDetail("");
		return rtnValue;
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : removeImage
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResDto
	 * @description : 콘텐츠 이미지 파일 삭제
	 */
	@RequestMapping(value = "/removeImage.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeImage(@RequestBody ImageFileUploadReqDto mfr, HttpServletRequest request, HttpServletResponse response) {
		LogUtil.param(this.getClass(), mfr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mfr.setMemId(loginInfo.getId());
		return commonService.removeImage(mfr,realPath);	
	}
	
	/**
	 * @programId : MKT_CTE_003
	 * @name : eidtDescFile
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResDto
	 * @description : 이미지 파일 설명 업데이트
	 */
	@RequestMapping(value="/eidtDescFile.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto eidtDescFile(HttpServletRequest request, HttpServletResponse response, @RequestBody ImageFileUploadReqDto mcr) {
		LogUtil.param(this.getClass(), mcr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mcr.setMemId(loginInfo.getId());
		return commonService.eidtDescFile(mcr);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : uploadImage
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResDto
	 * @description : 콘텐츠 이미지 파일 업로드
	 */
	@RequestMapping(value = "/uploadImage.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto uploadImage(@RequestParam("FileUpload") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		HttpSession session = request.getSession(true);
		String sessionId = session.getId();
		return commonService.addImage(loginInfo.getId(), request.getSession().getServletContext().getRealPath("/"), sessionId, file);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : getFileList
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : ImageSyncFileUploadResponseDTO
	 * @description : 콘텐츠 파일 리스트 조회
	 */
	@RequestMapping(value = "/getFileS3.do", method = RequestMethod.POST)
	public @ResponseBody
	ImageSyncFileUploadResDto getFileListS3(HttpServletRequest request, HttpServletResponse response, @RequestBody ImageFileUploadReqDto mfr) {
		LogUtil.param(this.getClass(), mfr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		ImageSyncFileUploadResDto rtnValue = new ImageSyncFileUploadResDto();
		rtnValue.setFiles(commonService.getFileListS3(mfr));
		rtnValue.setDetail("");
		return rtnValue;
	}

	/**
	 * @programId : MKT_CTE_002
	 * @name : getFileList
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : ImageSyncFileUploadResponseDTO
	 * @description : 콘텐츠 파일 리스트 조회
	 */
	@RequestMapping(value = "/getFileFTP.do", method = RequestMethod.POST)
	public @ResponseBody
	ImageSyncFileUploadResDto getFileListFTP(HttpServletRequest request, HttpServletResponse response, @RequestBody ImageFileUploadReqDto mfr) {
		LogUtil.param(this.getClass(), mfr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		ImageSyncFileUploadResDto rtnValue = new ImageSyncFileUploadResDto();
		rtnValue.setFiles(commonService.getFileListFTP(mfr));
		rtnValue.setDetail("");
		return rtnValue;
	}
	/**
	 * @programId : MKT_CTE_002
	 * @name : removeImage
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 콘텐츠 이미지 파일 삭제
	 */
	@RequestMapping(value = "/removeImageS3.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeImageS3(@RequestBody ImageFileUploadReqDto mfr, HttpServletRequest request, HttpServletResponse response) {
		LogUtil.param(this.getClass(), mfr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mfr.setMemId(loginInfo.getId());
		return commonService.removeImageS3(mfr,realPath);	
	}

	/**
	 * @programId : MKT_CTE_002
	 * @name : removeImageFTP
	 * @date : 2022.02.15
	 * @author : 윤법공
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 콘텐츠 이미지 파일 삭제
	 */
	@RequestMapping(value = "/removeImageFTP.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeImageFTP(@RequestBody ImageFileUploadReqDto mfr, HttpServletRequest request, HttpServletResponse response) {
		LogUtil.param(this.getClass(), mfr);
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mfr.setMemId(loginInfo.getId());
		return commonService.removeImageFTP(mfr,realPath);
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : uploadImage
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 콘텐츠 이미지 파일 업로드
	 */
	@RequestMapping(value = "/uploadImageS3.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto uploadImageS3(HttpServletRequest request, HttpServletResponse response, @RequestParam("FileUpload") MultipartFile fileUpload, @RequestParam("imageType") String imageType) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		HttpSession session = request.getSession(true);
		String sessionId = session.getId();
		return commonService.addImageS3(loginInfo.getId(), request.getSession().getServletContext().getRealPath("/"), sessionId, fileUpload, imageType);
	}

	/**
	 * @programId : MKT_CTE_002
	 * @name : uploadImage
	 * @date : 2022.02.15
	 * @author : 윤법공
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : FTP 콘텐츠 이미지 파일 업로드
	 */
	@RequestMapping(value = "/uploadImageFTP.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto uploadImageFTP(HttpServletRequest request, HttpServletResponse response, @RequestParam("FileUpload") MultipartFile fileUpload, @RequestParam("imageType") String imageType) {
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		HttpSession session = request.getSession(true);
		String sessionId = session.getId();
		return commonService.addImageFTP(loginInfo.getId(), request.getSession().getServletContext().getRealPath("/"), sessionId, fileUpload, imageType);
	}
	
	
}