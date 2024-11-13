package com.icignal.kepler.logicalComponent.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.CommonController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentAttributeGroupLeftAccordionListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentAttributeGroupTreeNodeListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentCheckAttributeCalFieldReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentDetailReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentGroupColumnReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinAccordionListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinColumnMasterListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinDbServiceComboListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentSegRptUsedListReqDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentAttributeGroupLeftAccordionListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentAttributeGroupTreeNodeListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentDetailResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentGroupColumnResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinAccordionListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinColumnMasterListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinColumnMasterPopupListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinDbServiceComboListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentSegRptUsedResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentsResDto;
import com.icignal.kepler.logicalComponent.service.KprLogicalComponentService;

/*
 * 1. 클래스명	: KPRLogicalComponentController
 * 2. 파일명	: KPRLogicalComponentController.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.controller
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 29.
 */
/**
 * <PRE>
 * 1. 설명
 *		로지컬 컴포넌트 컨트롤러
 * </PRE>
 */ 
@Controller
@RequestMapping("/kepler/logicalComponent")
public class KprLogicalComponentController extends CommonController {

	@Autowired
	private KprLogicalComponentService kprLogicalComponentService;
	
	@Autowired
	AuthHelper authHelper;

//	@Override
//	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
//	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, 
//			HttpServletResponse response,Model model) {
//		LogUtil.info("NavigatePopMenu start.....");
//		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
//		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
//		String respUrl = requestPath + "/popup/" +  name;
//		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
//		return null;
//	}
//
//	@Override
//	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
//	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
//		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
//		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
//		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
//		String respUrl = requestPath + "/include/" + name;
//		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
//		return null;	
//	}

	 /*
	  * 1. 메소드명: getLogicalComponentList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 목록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table   anl.anl_lgc_comp_mst
	 *   @return	GridPagingResDto
	 */
	@RequestMapping(value = "/getLogicalComponentList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprLogicalComponentsResDto> getLogicalComponentList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		// Service Execution
		GridPagingResDto<KprLogicalComponentsResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = kprLogicalComponentService.getLogicalComponentList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getLogicalComponentDetail
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 로지컬 컴포넌트 상세조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table   anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column
	 *   @return	
	 */
	@RequestMapping(value = "/getLogicalComponentDetail.do", method = RequestMethod.POST)
	public @ResponseBody KprLogicalComponentDetailResDto getLogicalComponentDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		KprLogicalComponentDetailResDto resDto = kprLogicalComponentService.getLogicalComponentDetail(reqDto);

		LogUtil.param(this.getClass(), resDto);

		return resDto;
	}

	 /*
	  * 1. 메소드명: addLogicalComponent
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 로지컬 컴포넌트 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column
	 *   @return StatusResDto
	 */
	@RequestMapping(value = "/addLogicalComponent.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addLogicalComponent(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		// Service Execution
		StatusResDto resDto = kprLogicalComponentService.addLogicalComponent(reqDto);
		LogUtil.param(this.getClass(), resDto);

		return resDto;
	}

	 /*
	  * 1. 메소드명: addLogicalComponentSaveAs
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 로지컬 컴포넌트 다른이름으로 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel,  anl.anl_lgc_join_column, anl.anl_atrib_group,  anl_anl_atrib_group_column
	 *   @return	
	 */
	@RequestMapping(value = "/addLogicalComponentSaveAs.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addLogicalComponentSaveAs(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		// Service Execution
		StatusResDto resDto = kprLogicalComponentService.addLogicalComponentSaveAs(reqDto);
		LogUtil.param(this.getClass(), resDto);

		return resDto;
	}

	 /*
	  * 1. 메소드명: editLogicalComponent
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 로지컬 컴포넌트 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return KPRLogicalComponentResponseDTO
	 */
	@RequestMapping(value = "/editLogicalComponent.do", method = RequestMethod.POST)
	public @ResponseBody KprLogicalComponentResDto editLogicalComponent(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		// Service Execution
		KprLogicalComponentResDto resDto = kprLogicalComponentService.editLogicalComponent(reqDto);
		LogUtil.param(this.getClass(), resDto);

		return resDto;
	}

	 /*
	  * 1. 메소드명: editLogicalComponentAttributeGroupColumnName
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 8. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 로지컬 컴포넌트 어트리뷰트그룹 칼럼명 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel,  anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return KPRLogicalComponentResponseDTO
	 */
	@RequestMapping(value = "/editLogicalComponentAttributeGroupColumnName.do", method = RequestMethod.POST)
	public @ResponseBody KprLogicalComponentResDto editLogicalComponentAttributeGroupColumnName(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		// Service Execution
		KprLogicalComponentResDto resDto = kprLogicalComponentService.editLogicalComponentAttributeGroupColumnName(reqDto);
		LogUtil.param(this.getClass(), resDto);

		return resDto;
	}

	 /*
	  * 1. 메소드명: removeLogicalComponent
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 로지컬 컴포넌트 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group,  anl_anl_atrib_group_column
	 *   @return	
	 */
	@RequestMapping(value = "/removeLogicalComponent.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeLogicalComponent(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		//
		StatusResDto resDto = kprLogicalComponentService.removeLogicalComponent(reqDto);
		LogUtil.param(this.getClass(), resDto);

		return resDto;
	}

	 /*
	  * 1. 메소드명: getJoinAccordionList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 조인 설정 탭 > 왼쪽 어코디언 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table : anl.anl_lgc_table_rel, anl.anl_lgc_join_column
	 *   @return List<KPRLogicalComponentJoinAccordionListResponseDTO>
	 */
	@RequestMapping(value = "/getJoinAccordionList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprLogicalComponentJoinAccordionListResDto> getJoinAccordionList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentJoinAccordionListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprLogicalComponentJoinAccordionListResDto> rtnValue = new ArrayList<>();
		rtnValue = kprLogicalComponentService.getJoinAccordionList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);

		return rtnValue;
	}

	/**
	 * @programId : ANL_LGC_002
	 * @name : getJoinDbServiceComboList
	 * @date : 2016. 7. 13.
	 * @author : 
	 * @table : anl.anl_db_inform
	 * @return : List<KPRLogicalComponentJoinDbServiceComboListResponseDTO>
	 * @description : 
	 */
	 /*
	  * 1. 메소드명: getJoinDbServiceComboList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 조인 설정 탭 > DB 서비스 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	@RequestMapping(value = "/getJoinDbServiceComboList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprLogicalComponentJoinDbServiceComboListResDto> getJoinDbServiceComboList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentJoinDbServiceComboListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprLogicalComponentJoinDbServiceComboListResDto> rtnValue = new ArrayList<>();
		rtnValue = kprLogicalComponentService.getJoinDbServiceComboList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getJoinColumnMasterList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 조인 설정 탭 > 다이어그램 > 테이블 노드 칼럼 정보 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table : anl.anl_table_mst, anl.anl_column_mst
	 *   @return List<KPRLogicalComponentJoinColumnMasterListResponseDTO>
	 */
	@RequestMapping(value = "/getJoinColumnMasterList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprLogicalComponentJoinColumnMasterListResDto> getJoinColumnMasterList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentJoinColumnMasterListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprLogicalComponentJoinColumnMasterListResDto> rtnValue = new ArrayList<>();
		rtnValue = kprLogicalComponentService.getJoinColumnMasterList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getJoinColumnMasterPopupList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 조인 설정 탭 > 다이어그램 > 테이블 칼럼 팝업 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table : anl.anl_table_mst, anl.anl_column_mst
	 *   @return	
	 */
	@RequestMapping(value = "/getJoinColumnMasterPopupList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprLogicalComponentJoinColumnMasterPopupListResDto> getJoinColumnMasterPopupList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentJoinColumnMasterListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		GridPagingResDto<KprLogicalComponentJoinColumnMasterPopupListResDto> rtnValue = new GridPagingResDto<KprLogicalComponentJoinColumnMasterPopupListResDto>();
		rtnValue = kprLogicalComponentService.getJoinColumnMasterPopupList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAttributeGroupLeftAccordionList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 어트리뷰트 그룹 설정 탭 > 왼쪽 어코디언 트리 리스트 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table   anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return List<KPRLogicalComponentAttributeGroupLeftAccordionListResponseDTO>
	 */
	@RequestMapping(value = "/getAttributeGroupLeftAccordionList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprLogicalComponentAttributeGroupLeftAccordionListResDto> getAttributeGroupLeftAccordionList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentAttributeGroupLeftAccordionListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprLogicalComponentAttributeGroupLeftAccordionListResDto> rtnValue = new ArrayList<>();
		rtnValue = kprLogicalComponentService.getLeftAttributeGroupAccordionList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAttributeGroupTreeNodeList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 어트리뷰트 그룹 탭 > 어트리뷰트 그룹 트리 정보 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table   anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return List<KPRLogicalComponentAttributeGroupTreeNodeListResponseDTO>
	 */
	@RequestMapping(value = "/getAttributeGroupTreeNodeList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprLogicalComponentAttributeGroupTreeNodeListResDto> getAttributeGroupTreeNodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentAttributeGroupTreeNodeListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprLogicalComponentAttributeGroupTreeNodeListResDto> rtnValue = new ArrayList<>();
		rtnValue = kprLogicalComponentService.getAttributeGroupTreeNodeList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: checkAttributeCalField
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 어트리뷰트 그룹 설정 > 변환필드 신규/수정 > 저장 > "어트리뷰트 그룹
	 *     칼럼-변환 필드"을 대상 시스템 DBMS를 통해 쿼리 작동 확인
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table   Target System Table
	 *   @return	
	 */
	@RequestMapping(value = "/checkAttributeCalField.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto checkAttributeCalField(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentCheckAttributeCalFieldReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setLang(loginInfo.getLang());

		// Service Execution
		StatusResDto resDto = kprLogicalComponentService.checkAttributeCalField(reqDto);
		LogUtil.param(this.getClass(), resDto);
		return resDto;
	}

	 /*
	  * 1. 메소드명: getSegRptUsedList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 분석/세그먼트 적용 목록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @table   anl.anl_seg_mst, anl.anl_rpt_mst
	 *   @return	
	 */
	@RequestMapping(value = "/getSegRptUsedList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprLogicalComponentSegRptUsedResDto> getSegRptUsedList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentSegRptUsedListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());

		// Service Execution
		GridPagingResDto<KprLogicalComponentSegRptUsedResDto> rtnValue = new GridPagingResDto<KprLogicalComponentSegRptUsedResDto>();
		rtnValue = kprLogicalComponentService.getSegRptUsedList(reqDto);

		LogUtil.param(this.getClass(), rtnValue);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getLgcCompGrpColMstList
	  * 2. 클래스명: KPRLogicalComponentController
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 6. 29.
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
	@RequestMapping(value = "/getLgcCompGrpColMstList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprLogicalComponentGroupColumnResDto> getLgcCompGrpColMstList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprLogicalComponentGroupColumnReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		// Session Check
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());

		return this.kprLogicalComponentService.getLgcCompGrpColMstList(reqDto);
	}
}