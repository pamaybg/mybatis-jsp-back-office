package com.icignal.loyalty.product.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.product.dto.request.LoyEditCategoryListReqDto;
import com.icignal.loyalty.product.dto.request.LoyEditProdListReqDto;
import com.icignal.loyalty.product.dto.request.LoyGetCategoryListReqDto;
import com.icignal.loyalty.product.dto.request.LoyGetProdListReqDto;
import com.icignal.loyalty.product.dto.request.LoyProdSpecReqDto;
import com.icignal.loyalty.product.dto.request.LoyProductByBrdDto;
import com.icignal.loyalty.product.dto.request.LoyProductDtlTabInfoReqDto;
import com.icignal.loyalty.product.dto.request.LoyProductInsertReqDto;
import com.icignal.loyalty.product.dto.request.LoyProductListReqDto;
import com.icignal.loyalty.product.dto.request.LoyProductSearchHelpReqDto;
import com.icignal.loyalty.product.dto.request.LoySetCategoryListReqDto;
import com.icignal.loyalty.product.dto.request.LoySetProdListReqDto;
import com.icignal.loyalty.product.dto.response.LoyCategoryListResDto;
import com.icignal.loyalty.product.dto.response.LoyGetCategoryListResDto;
import com.icignal.loyalty.product.dto.response.LoyGetProdListResDto;
import com.icignal.loyalty.product.dto.response.LoyGetProdPosResDto;
import com.icignal.loyalty.product.dto.response.LoyGetProdSpecListResDto;
import com.icignal.loyalty.product.dto.response.LoyProdListResDto;
import com.icignal.loyalty.product.dto.response.LoyProductDtlTabInfoResDto;
import com.icignal.loyalty.product.dto.response.LoyProductListResDto;
import com.icignal.loyalty.product.dto.response.LoyProductSearchHelpResDto;
import com.icignal.loyalty.product.service.LoyProductService;

/*
 * 1. 클래스명	: LoyProductController
 * 2. 파일명	: LoyProductController.java
 * 3. 패키지명	: com.icignal.loyalty.product.controller
 * 4. 작성자명	: wjlee 
 * 5. 작성일자	: 2016. 12. 9. 
 */
/**
 * <PRE>
 * 1. 설명
 *		카테고리, 브렌드, 상품 Controller
 * </PRE>
 */
@Controller
@RequestMapping("/loyalty/membership/product")
public class LoyProductController extends BaseController {

	@Autowired
	private LoyProductService loyProductService;
	
	@Autowired
	AuthHelper authHelper;
	
	@Override
	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		LogUtil.debug("NavigatePopMenu start.....");
	
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/popup/" +  name + ".modal-tiles";

    	if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
		return null;
	}
	
	@Override
	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
		String respUrl = requestPath + "/include/" + name;
		return authHelper.checkUserInfo(request, response, respUrl);
		
	}

	 /*
	  * 1. 메소드명: getCategoryListPop
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 카테고리 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : POP_908
	 *   @table : loy_prod_category
	 *   @param slr
	 *   @return	
	 */
	@RequestMapping(value = "/getCategoryListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyCategoryListResDto> getCategoryListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCommonReqDto slr) {
		LogUtil.param(LoyProductController.class, slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyProductService.getCategoryListPop(slr);
	}

	 /*
	  * 1. 메소드명: getProdListPop
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		 상품 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : POP_908
	 *   @table : loy_prod
	 *   @param slr
	 *   @return	
	 */
	@RequestMapping(value = "/getProdListPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProdListResDto> getProdListPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCommonReqDto slr) {
		LogUtil.param(LoyProductController.class, slr);
		slr.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProdListPop(slr);
	}

	 /*
	  * 1. 메소드명: getProdList
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_022
	 *   @table : loy_prod, loy_brd_category, loy_channel
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getProdList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyGetProdListResDto> getProdList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return  loyProductService.getProdList(reqDto);
	}

	 /*
	  * 1. 메소드명: getProdDtl
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 상세조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_023
	 *   @table : loy_prod, loy_brd_category, loy_channel
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getProdDtl.do", method = RequestMethod.POST)
	public @ResponseBody LoyGetProdListResDto getProdDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProdDtl(reqDto);
	}

	 /*
	  * 1. 메소드명: setProdDtl
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_023
	 *   @table : loy_prod
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/setProdDtl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setProdDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySetProdListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.setProdDtl(reqDto);
	}

	 /*
	  * 1. 메소드명: editProdDtl
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2020. 2. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_023
	 *   @table : loy_prod
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/editProdDtl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editProdDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEditProdListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.editProdDtl(reqDto);
	}

	 /*
	  * 1. 메소드명: getProdChk
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품명 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_023
	 *   @table : loy_prod
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getProdChk.do", method = RequestMethod.POST)
	public @ResponseBody LoyGetProdListResDto getProdChk(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProdChk(reqDto);
	}

	 /*
	  * 1. 메소드명: getCategoryList
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_024
	 *   @table : loy_prod_category
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getCategoryList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyGetCategoryListResDto> getCategoryList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getCategoryList(reqDto);
	}

	 /*
	  * 1. 메소드명: getCategoryDtl
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리 상세조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_025
	 *   @table : loy_prod_category
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getCategoryDtl.do", method = RequestMethod.POST)
	public @ResponseBody LoyGetCategoryListResDto getCategoryDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getCategoryDtl(reqDto);
	}

	 /*
	  * 1. 메소드명: setCategoryDtl
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리 상세저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_025
	 *   @table : loy_prod_category
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/setCategoryDtl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCategoryDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoySetCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.setCategoryDtl(reqDto);
	}

	 /*
	  * 1. 메소드명: editCategoryDtl
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리 상세수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_025
	 *   @table : loy_prod_category
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/editCategoryDtl.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editCategoryDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyEditCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.editCategoryDtl(reqDto);
	}

	 /*
	  * 1. 메소드명: getCategoryChk
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리명 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @programId : PLOY_025
	 *   @table : loy_prod_category
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getCategoryChk.do", method = RequestMethod.POST)
	public @ResponseBody LoyGetCategoryListResDto getCategoryChk(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getCategoryChk(reqDto);
	}

	 /*
	  * 1. 메소드명: getProdSpecList
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: ps.lee
	  * 4. 작성일자: 2018. 5. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 스펙 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getProdSpecList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyGetProdSpecListResDto> getProdSpecList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyProductService.getProdSpecList(reqDto);
	}

	 /*
	  * 1. 메소드명: saveProdSpec
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: ps.lee
	  * 4. 작성일자: 2018. 5. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 스펙 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/saveProdSpec.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveProdSpec(HttpServletRequest request, HttpServletResponse response,	@RequestBody LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.saveProdSpec(reqDto);
	}

	 /*
	  * 1. 메소드명: deleteProdSpec
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: ps.lee 
	  * 4. 작성일자: 2018. 5. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 스펙 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/deleteProdSpec.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteProdSpec(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setEmpId(loginInfo.getId());
		

		return loyProductService.deleteProdSpec(reqDto);
	}

	 /*
	  * 1. 메소드명: deleteProd
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: dw.keum 
	  * 4. 작성일자: 2019. 6. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/deleteProd.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteProd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductController.class, reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.deleteProd(reqDto);
	}

	 /*
	  * 1. 메소드명: setProdMultiDtl
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: dw.keum
	  * 4. 작성일자: 2019. 6. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		upload
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param model
	 *   @param response
	 *   @return
	 *   @throws IOException	
	 */
//	@RequestMapping(value = "/setProdMultiDtl.do", method = RequestMethod.POST)
//	public @ResponseBody ResponseEntity setProdMultiDtl(MultipartHttpServletRequest request, ModelMap model,
//			HttpServletResponse response) throws IOException {
//		// authHelper.checkLoginSession(request.getSession(true));
//
//		BatchRgstExcelFileUtil excelUpld = new BatchRgstExcelFileUtil();
//		List<LoySetProdListReqDto> batchUpload = new ArrayList<LoySetProdListReqDto>();
//		StatusResDto rtnValue = new StatusResDto();
//		// LoginResDto loginInfo = authHelper.checkLoginSession(request, response); 사용 안함
//		LoySetProdListReqDto br = new LoySetProdListReqDto();
//		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
//
//		String[] rs = mptRequest.getParameterValues("param");
//		String ns = new String(rs[0].getBytes("iso-8859-1"), "utf-8");
//		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
//		JSONObject obj = (JSONObject) json.get("data");
//		String ridChnl = (String) obj.get("ridChnl");
//		String ridProdCat = (String) obj.get("ridProdCat");
//		// String ridBrdCat = (String) obj.get("ridBrdCat");
//		String prodType = (String) obj.get("prodType");
//
//		String rid = CommonUtil.newRid();
//
//		try {
//			batchUpload = excelUpld.excelUploadProd(request, false, rid);
//		} catch (Exception e) {
//			LogUtil.error(e);
//		}
//		if (batchUpload.size() > 0) {
//			if (batchUpload.get(0).getUploadValidCheck() != null) {
//				if (batchUpload.get(0).getUploadValidCheck().equals("EXT")) {
//					rtnValue.setSuccess(false);
//					rtnValue.setMessage("Excel File (xlsx, xls)만 가능 합니다.");
//
//				} else if (batchUpload.get(0).getUploadValidCheck().equals("SIZE")) {
//					rtnValue.setSuccess(false);
//					rtnValue.setMessage("파일 용량은 12메가를 초과할 수 없습니다.");
//				} else if (batchUpload.get(0).getUploadValidCheck().equals("NOTUPLD")) {
//					rtnValue.setSuccess(false);
//					rtnValue.setMessage("업로드 할 데이터가 없습니다.");
//				}
//			} else {
//				br.setArray(batchUpload);
//				br.setRid(rid);
//				br.setRidChnl(ridChnl);
//				br.setRidProdCat(ridProdCat);
//				// br.setRidBrdCat(ridBrdCat);
//				br.setProdType(prodType);
//				br.setLoginInfo(loginInfo);
//
//				rtnValue = loyProductService.insertProdList(br);
//				rtnValue.setMessage("저장되었습니다.");
//			}
//		} else {
//			rtnValue.setSuccess(false);
//			rtnValue.setMessage(Messages.getMessage("L01685", loginInfo.getLang()));
//		}
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("data", rtnValue);
//		String jsonData = "";
//		try {
//			jsonData = new ObjectMapper().writeValueAsString(map);
//		} catch (JsonProcessingException e) {
//			LogUtil.error(e);
//		}
//		HttpHeaders responseHeaders = new HttpHeaders();
//		responseHeaders.add("Content-Type", "text/plain; charset=utf-8");
//		return new ResponseEntity(jsonData, responseHeaders, HttpStatus.CREATED);
//	}

	 /*
	  * 1. 메소드명: getProdSearchHelp
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: 이성원
	  * 4. 작성일자: 2017. 10. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getProdSearchHelp.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProductSearchHelpResDto> getProdSearchHelp(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductSearchHelpReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProdSearchHelp(param);
	}

	 /*
	  * 1. 메소드명: getProductList
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getProductList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProductListResDto> getProductList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductListReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProductList(param);
	}

	 /*
	  * 1. 메소드명: insertProductDetail
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 상세 정보 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/insertProductDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertProductDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductInsertReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return  loyProductService.insertProductDetail(param);
	}

	 /*
	  * 1. 메소드명: getProductDetail
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 상세 정보 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getProductDetail.do", method = RequestMethod.POST)
	public @ResponseBody LoyProductListResDto getProductDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductListReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProductDetail(param);
	}

	 /*
	  * 1. 메소드명: getProductPriceList
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getProductPriceList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProductDtlTabInfoResDto> getProductPriceList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProductPriceList(param);
	}

	 /*
	  * 1. 메소드명: insertProductPrice
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 정보 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/insertProductPrice.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertProductPrice(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.insertProductPrice(param);
	}

	 /*
	  * 1. 메소드명: deleteProductPrice
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 삭제 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/deleteProductPrice.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteProductPrice(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.deleteProductPrice(param);

	}

	 /*
	  * 1. 메소드명: getProductCodeList
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품코드 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getProductCodeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProductDtlTabInfoResDto> getProductCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProductCodeList(param);
	}

	 /*
	  * 1. 메소드명: insertProductCodeDetail
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 정보 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/insertProductCodeDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto insertProductCodeDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.insertProductCodeDetail(param);
	}

	 /*
	  * 1. 메소드명: deleteProductCode
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/deleteProductCode.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteProductCode(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.deleteProductCode(param);
	}

	 /*
	  * 1. 메소드명: updateProductDetail
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/updateProductDetail.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateProductDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductInsertReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.updateProductDetail(param);
	}

	 /*
	  * 1. 메소드명: updateProdStatusCd
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 상태 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/updateProdStatusCd.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateProdStatusCd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductInsertReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.updateProdStatusCd(param);
	}

	 /*
	  * 1. 메소드명: getProductPriceDtl
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getProductPriceDtl.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProductDtlTabInfoResDto> getProductPriceDtl(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProductPriceDtl(param);
	}

	 /*
	  * 1. 메소드명: updateProductPrice
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 정보 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/updateProductPrice.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateProductPrice(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.updateProductPrice(param);
	}

	 /*
	  * 1. 메소드명: getProductCodeDetail
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getProductCodeDetail.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<LoyProductDtlTabInfoResDto> getProductCodeDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));

		return loyProductService.getProductCodeDetail(param);
	}

	 /*
	  * 1. 메소드명: updateProductCode
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 정보 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/updateProductCode.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto updateProductCode(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.updateProductCode(param);
	}

	 /*
	  * 1. 메소드명: getProductByBrd
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: kimTaeUk 
	  * 4. 작성일자: 2018. 07. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 정보 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getProductByBrd.do", method = RequestMethod.POST)
	public @ResponseBody List<LoyProductByBrdDto> getProductByBrd(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProductByBrdDto param) {
		LogUtil.param(LoyProductController.class, param);
		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return loyProductService.getProductByBrd(param);
	}
	
	 /*
	  * 1. 메소드명: removeCategory
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 카테고리 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/removeCategory.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCategory(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCommonReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());

		return loyProductService.removeCategory(param);
	}
	
	 /*
	  * 1. 메소드명: removeProduct
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/removeProduct.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeProduct(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyCommonReqDto param) {
		LogUtil.param(LoyProductController.class, param);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		param.setEmpId(loginInfo.getId());
		
		return loyProductService.removeProduct(param);
	}
	
	 /*
	  * 1. 메소드명: categoryChnlExecDown
	  * 2. 클래스명: LoyProductController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 11. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 다운로드 프로그램
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	  //카테고리 리스트 엑셀 다운로드
		@RequestMapping(value = "/getCategoryListExport.do", method = RequestMethod.POST)
		public  String categoryChnlExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetCategoryListReqDto reqDto, ModelMap model) {
			
			LogUtil.param(this.getClass(), reqDto);
			reqDto.setLoginInfo(this.checkLoginSession(request, response));
			
			GridPagingResDto<LoyGetCategoryListResDto> data = loyProductService.getCategoryList(reqDto);

			
			model.addAttribute("result", data);
			model.addAttribute("excelHeader", reqDto.getExcelHeader());
			model.addAttribute("fileName", "Category_List");

			return "ExcelView";
		}
		 /*
		  * 1. 메소드명: prodChnlExecDown
		  * 2. 클래스명: LoyProductController
		  * 3. 작성자명: LEE GYEONG YOUNG
		  * 4. 작성일자: 2020. 11. 12.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		엑셀 다운로드 프로그램
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param request
		 *   @param response
		 *   @param reqDto
		 *   @return	
		 */
		  //상품 리스트 엑셀 다운로드
			@RequestMapping(value = "/getProdListExport.do", method = RequestMethod.POST)
			public  String prodChnlExecDown(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto, ModelMap model) {
				
				LogUtil.param(this.getClass(), reqDto);
				reqDto.setLoginInfo(this.checkLoginSession(request, response));
				
				GridPagingResDto<LoyGetProdListResDto> data = loyProductService.getProdList(reqDto);

				
				model.addAttribute("result", data);
				model.addAttribute("excelHeader", reqDto.getExcelHeader());
				model.addAttribute("fileName", "Product_List");

				return "ExcelView";
			}		
			
			 /*
			  * 1. 메소드명: getProdPosList
			  * 2. 클래스명: LoyProductController
			  * 3. 작성자명: LEE GYEONG YOUNG 
			  * 4. 작성일자: 2020. 11. 19.
			  */
			/**
			 * <PRE>
			 * 1. 설명
			 *		POS 상품 목록 조회
			 * 2. 사용법
			 *		
			 * </PRE>
			 *   @param request
			 *   @param response
			 *   @programId : PLOY_022
			 *   @table : loy_prod, loy_brd_category, loy_channel
			 *   @param reqDto
			 *   @return	
			 */
			@RequestMapping(value = "/getProdPosList.do", method = RequestMethod.POST)
			public @ResponseBody GridPagingResDto<LoyGetProdPosResDto> getProdPosList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyProdSpecReqDto reqDto) {
				LogUtil.param(LoyProductController.class, reqDto);
				reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
				
				return  loyProductService.getProdPosList(reqDto);
			}
			
			 /*
			  * 1. 메소드명: getProdList
			  * 2. 클래스명: LoyProductController
			  * 3. 작성자명: 이원준 
			  * 4. 작성일자: 2016. 12. 9.
			  */
			/**
			 * <PRE>
			 * 1. 설명
			 *		상품 목록 조회
			 * 2. 사용법
			 *		
			 * </PRE>
			 *   @param request
			 *   @param response
			 *   @programId : PLOY_022
			 *   @table : loy_prod, loy_brd_category, loy_channel
			 *   @param reqDto
			 *   @return	
			 */
			@RequestMapping(value = "/getTProdList.do", method = RequestMethod.POST)
			public @ResponseBody GridPagingResDto<LoyGetProdListResDto> getTProdList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto) {
				LogUtil.param(LoyProductController.class, reqDto);
				reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
				
				return  loyProductService.getTProdList(reqDto);
			}
			
			 /*
			  * 1. 메소드명: prodChnlExecDown
			  * 2. 클래스명: LoyProductController
			  * 3. 작성자명: LEE GYEONG YOUNG
			  * 4. 작성일자: 2020. 11. 12.
			  */
			/**
			 * <PRE>
			 * 1. 설명
			 *		엑셀 다운로드 프로그램
			 * 2. 사용법
			 *		
			 * </PRE>
			 *   @param request
			 *   @param response
			 *   @param reqDto
			 *   @return	
			 */
			  //상품 리스트 엑셀 다운로드
				@RequestMapping(value = "/getTProdListExport.do", method = RequestMethod.POST)
				public  String getTProdListExport(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto, ModelMap model) {
					
					LogUtil.param(this.getClass(), reqDto);
					reqDto.setLoginInfo(this.checkLoginSession(request, response));
					
					GridPagingResDto<LoyGetProdListResDto> data = loyProductService.getTProdList(reqDto);

					
					model.addAttribute("result", data);
					model.addAttribute("excelHeader", reqDto.getExcelHeader());
					model.addAttribute("fileName", "Product_List");

					return "ExcelView";
				}		
				
				@RequestMapping(value = "/getTProdListYnPop.do", method = RequestMethod.POST)
				public @ResponseBody LoyGetProdListResDto getTProdListYnPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto) {
					LogUtil.param(LoyProductController.class, reqDto);
					reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
					
					return  loyProductService.getTProdListYnPop(reqDto);
				}
				
				@RequestMapping(value = "/saveTProdListYnPop.do", method = RequestMethod.POST)
				public @ResponseBody StatusResDto saveTProdListYnPop(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto) {
					LogUtil.param(LoyProductController.class, reqDto);
					reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

					return loyProductService.saveTProdListYnPop(reqDto);
				}
				
				@RequestMapping(value = "/getAllowUseProdList.do", method = RequestMethod.POST)
				public @ResponseBody GridPagingResDto<LoyGetProdListResDto> getAllowUseProdList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto) {
					LogUtil.param(LoyProductController.class, reqDto);
					reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
					
					return  loyProductService.getAllowUseProdList(reqDto);
				}
				@RequestMapping(value = "/getAllowNotUseProdList.do", method = RequestMethod.POST)
				public @ResponseBody GridPagingResDto<LoyGetProdListResDto> getAllowNotUseProdList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyGetProdListReqDto reqDto) {
					LogUtil.param(LoyProductController.class, reqDto);
					reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
					
					return  loyProductService.getAllowNotUseProdList(reqDto);
				}
}
