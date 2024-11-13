package com.icignal.kepler.common.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

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
import com.icignal.kepler.common.dto.request.KprAnalysisModifyCheckReqDto;
import com.icignal.kepler.common.dto.request.KprAnalysisSetupPropertyReqDto;
import com.icignal.kepler.common.dto.request.KprCommonAttributeGroupListReqDto;
import com.icignal.kepler.common.dto.request.KprCommonColumnReqDto;
import com.icignal.kepler.common.dto.request.KprCommonDateFunctionReqDto;
import com.icignal.kepler.common.dto.request.KprCommonLogicalComponentListReqDto;
import com.icignal.kepler.common.dto.request.KprNodeDetailReqDto;
import com.icignal.kepler.common.dto.request.KprNodeListReqDto;
import com.icignal.kepler.common.dto.response.KprAnalysisColumnItemResDto;
import com.icignal.kepler.common.dto.response.KprAnalysisModifyCheckResDto;
import com.icignal.kepler.common.dto.response.KprAnalysisPromptItemResDto;
import com.icignal.kepler.common.dto.response.KprCommonAttributeGroupListResDto;
import com.icignal.kepler.common.dto.response.KprCommonDateFunctionResDto;
import com.icignal.kepler.common.dto.response.KprCommonLogicalComponentListResDto;
import com.icignal.kepler.common.dto.response.KprNodeListResDto;
import com.icignal.kepler.common.service.KprCommonService;
import com.icignal.systemmanagement.channel.service.SystemChannelService;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCondListRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCondListResponseDTO;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;

/*
 * 1. 클래스명	: KPRCommonController
 * 2. 파일명	: KPRCommonController.java
 * 3. 패키지명	: com.icignal.kepler.common.controller
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2016. 06. 09.
 */
/**
 * <PRE>
 * 1. 설명
 *		공통
 * </PRE>
 */ 
@Controller
@RequestMapping("/kepler/common")
public class KprCommonController extends CommonController {

	@Autowired
	private KprCommonService kprCommonService;

//	@Autowired
//	private MKTCommonService mktCommonService;
	
	@Autowired
	private SystemCommCodeService SystemCommcodeService;
	
	@Autowired
	private SystemChannelService SystemChannelService;
	
	@Autowired
	AuthHelper authHelper;

	@Override
	@RequestMapping(value = "/{name:.+}", method = RequestMethod.GET)
	public String NavigateMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) throws NoSuchMethodException, SecurityException {
		// LogUtil.debug(this.getClass().getName() + " NavigateMenu Method start...");
		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
		
		 return Optional.ofNullable(annotationClass).map(o -> {
				String requestPath =  Arrays.asList(o.value()).stream().findFirst().get();
				String respUrl = requestPath + "/" + name +   ".tiles";
				if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfo(request, response, respUrl);
				return null;				 
			}).orElse("");
	
	}
	
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

	 /*
	  * 1. 메소드명: getCommCodeList
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: 류동균
	  * 4. 작성일자: 2016. 06. 09.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		컴코드 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param bccr
	 *   @return	
	 */
	@RequestMapping(value = "/getCommCodeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MKTCommonCodeResponseDTO> getCommCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO bccr) {
		LogUtil.param(KprCommonController.class, bccr);

		authHelper.checkLoginSession(request, response);
		GridPagingResDto<MKTCommonCodeResponseDTO> rtnValue = new GridPagingResDto<MKTCommonCodeResponseDTO>();
		rtnValue = SystemCommcodeService.getCommCodeList(bccr);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getCommCondLIst
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: 류동균
	  * 4. 작성일자: 2016. 06. 09.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통 조건 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param cclr
	 *   @table : mkt_cmn_srch (조건 목록 테이블)
	 *   @return	
	 */
	@RequestMapping(value = "/getCommCondLIst.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MKTCommonCondListResponseDTO> getCommCondLIst(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCondListRequestDTO cclr) {
		LogUtil.param(KprCommonController.class, cclr);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto<MKTCommonCondListResponseDTO> rtnValue = new GridPagingResDto<MKTCommonCondListResponseDTO>();
		rtnValue = SystemCommcodeService.getCommCondLIst(cclr);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getDateInfo
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: 류동균
	  * 4. 작성일자: 2016. 06. 09.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		현재 날자 조회
	 * 2. 사용법
	 *		새로운 메소드 만들지 않고 SystemManagement 채널쪽 쿼리 불러와서 사용합니다.
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param slir
	 *   @return	
	 */
	@RequestMapping(value = "/getDateInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getDateInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody MKTCommonCodeRequestDTO slir) {
		LogUtil.param(KprCommonController.class, slir);

		authHelper.checkLoginSession(request, response);

		return SystemChannelService.getDateInfo(slir);
	}

	 /*
	  * 1. 메소드명: getLogicalComponentTreeList
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: 류동균
	  * 4. 작성일자: 2016. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통 로지컬컴포넌트 트리 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param caglr
	 *   @return	
	 */
	@RequestMapping(value = "/getLogicalComponentTreeList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprCommonAttributeGroupListResDto> getLogicalComponentTreeList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody KprCommonAttributeGroupListReqDto caglr) {
		LogUtil.param(KprCommonController.class, caglr);
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		List<KprCommonAttributeGroupListResDto> rtnList = new ArrayList<KprCommonAttributeGroupListResDto>();
		rtnList = kprCommonService.getLogicalComponentTreeList(caglr);

		return rtnList;
	}

	 /*
	  * 1. 메소드명: getCommonLogicalComponentList
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: 류동균
	  * 4. 작성일자: 2016. 7. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공통 로지컬 컴포넌트 목록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param clclr
	 *   @table : anl.anl_lgc_comp_mst, com.employee
	 *   @return	
	 */
	@RequestMapping(value = "/getCommonLogicalComponentList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprCommonLogicalComponentListResDto> getCommonLogicalComponentList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprCommonLogicalComponentListReqDto clclr) {
		LogUtil.param(KprCommonController.class, clclr);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto<KprCommonLogicalComponentListResDto> rtnValue = new GridPagingResDto<KprCommonLogicalComponentListResDto>();
		rtnValue = kprCommonService.getCommonLogicalComponentList(clclr);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getCommonDateCodeList
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 9. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		날짜 공통 코드 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param ccr
	 *   @return	
	 */
	@RequestMapping(value = "/getCommonDateCodeList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprCommonDateFunctionResDto> getCommonDateCodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprCommonDateFunctionReqDto ccr) {
		LogUtil.param(KprCommonController.class, ccr);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return kprCommonService.getCommonDateCodeList(ccr);
	}

	 /*
	  * 1. 메소드명: getNodeList
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		폴더 및 분석 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param nlr
	 *   @return	
	 */
	@RequestMapping(value = "/getNodeList.do", method = RequestMethod.POST)
	public @ResponseBody KprNodeListResDto getNodeList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprNodeListReqDto nlr) {
		LogUtil.param(KprCommonController.class, nlr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		nlr.setEmpId(userInfo.getId());

		return kprCommonService.getNodeList(nlr);
	}

	 /*
	  * 1. 메소드명: addFolder
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		폴더 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param nlr
	 *   @return	
	 */
	@RequestMapping(value = "/addFolder.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addFolder(HttpServletRequest request, HttpServletResponse response, @RequestBody KprNodeDetailReqDto nlr) {
		LogUtil.param(KprCommonController.class, nlr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		nlr.setEmpId(userInfo.getId());

		return kprCommonService.addFolder(nlr);
	}

	 /*
	  * 1. 메소드명: editFolder
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		폴더 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param nlr
	 *   @return	
	 */
	@RequestMapping(value = "/editFolder.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editFolder(HttpServletRequest request, HttpServletResponse response, @RequestBody KprNodeDetailReqDto nlr) {
		LogUtil.param(KprCommonController.class, nlr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		nlr.setEmpId(userInfo.getId());

		return kprCommonService.editFolder(nlr);
	}

	 /*
	  * 1. 메소드명: removeFolder
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: KioLee
	  * 4. 작성일자: 2016. 7. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		폴더를 삭제( 논리삭제 )
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param nlr
	 *   @return	
	 */
	@RequestMapping(value = "/removeFolder.do", method = RequestMethod.POST)
	public @ResponseBody
	StatusResDto removeFolder(HttpServletRequest request, HttpServletResponse response, @RequestBody KprNodeDetailReqDto nlr) {
		LogUtil.param(KprCommonController.class, nlr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		nlr.setEmpId(userInfo.getId());

		return kprCommonService.removeFolder(nlr);
	}

	 /*
	  * 1. 메소드명: getAnalysisModifyCheck
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: KioLee 
	  * 4. 작성일자: 2016. 7. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		분석/대시보드 수정 가능여부 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param acr
	 *   @return	
	 */
	@RequestMapping(value = "/getAnalysisModifyCheck.do", method = RequestMethod.POST)
	public @ResponseBody KprAnalysisModifyCheckResDto getAnalysisModifyCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisModifyCheckReqDto acr) {
		LogUtil.param(KprCommonController.class, acr);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		acr.setEmpId(userInfo.getId());

		return kprCommonService.getAnalysisModifyCheck(acr);
	}

	 /*
	  * 1. 메소드명: getAnalysisSetupColumnList
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: kj.kang
	  * 4. 작성일자: 2016. 8. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		분석에서 그룹 컬럼 체크 시 해당 분석의 컬럼 영역에 있는 Dimension 리스트를 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getAnalysisSetupColumnList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprAnalysisColumnItemResDto> getAnalysisSetupColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisSetupPropertyReqDto param) {
		LogUtil.param(KprCommonController.class, param);
		if ("INSTANCE".equals(param.getInstFlag())) {
			param.setTblColumnNm("anl_rpt_column_inst");
			param.setTblRptMstNm("anl_rpt_mst_inst");
		} else {
			param.setTblColumnNm("anl_rpt_column");
			param.setTblRptMstNm("anl_rpt_mst");
		}

		return kprCommonService.getAnalysisSetupColumnList(param);
	}

	 /*
	  * 1. 메소드명: getAnalysisSetupPromptList
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: kj.kang 
	  * 4. 작성일자: 2016. 8. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		분석에서 프롬프트 설정 시 해당 분석의 프롬프트 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param param
	 *   @return	
	 */
	@RequestMapping(value = "/getAnalysisSetupPromptList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprAnalysisPromptItemResDto> getAnalysisSetupPromptList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprAnalysisSetupPropertyReqDto param) {
		LogUtil.param(KprCommonController.class, param);
		if ("INSTANCE".equals(param.getInstFlag())) {
			param.setTblPromptNm("anl_rpt_prompt_inst");
			param.setTblRptMstNm("anl_rpt_mst_inst");
		} else {
			param.setTblPromptNm("anl_rpt_prompt");
			param.setTblRptMstNm("anl_rpt_mst");
		}

		return kprCommonService.getAnalysisSetupPromptList(param);
	}
	
	 /*
	  * 1. 메소드명: getCommonColumnValueList
	  * 2. 클래스명: KPRCommonController
	  * 3. 작성자명: 
	  * 4. 작성일자: 2016. 8. 4.
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
	@RequestMapping(value = "/getCommonColumnValueList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<Object> getCommonColumnValueList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprCommonColumnReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto userInfo = authHelper.checkLoginSession(request, response);
		//userInfo.
		reqDto.setBranchCode(userInfo.getBranchCode());
		reqDto.setStationCode(userInfo.getStationCode());

		return this.kprCommonService.getCommonColumnValueList(reqDto);
	}
}