package com.icignal.kepler.operation.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.operation.dto.request.KprCardListReqDto;
import com.icignal.kepler.operation.dto.request.KprComboListReqDto;
import com.icignal.kepler.operation.dto.request.KprCustListReqDto;
import com.icignal.kepler.operation.dto.request.KprDatabaseUseSchemaReqDto;
import com.icignal.kepler.operation.dto.request.KprDbRegistReqDto;
import com.icignal.kepler.operation.dto.request.KprDelDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprDelIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprDelIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprDelSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprDelTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprDelTableReqDto;
import com.icignal.kepler.operation.dto.request.KprDrillDownGroupReqDto;
import com.icignal.kepler.operation.dto.request.KprEditDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxAdvanceReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprEditSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprEditSubjectDbReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableAdvanceReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableColConvertReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableListReqDto;
import com.icignal.kepler.operation.dto.request.KprExcelUpLoadReqDto;
import com.icignal.kepler.operation.dto.request.KprGetIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetTableColListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetTableReqDto;
import com.icignal.kepler.operation.dto.request.KprGetUploadErrorReqDto;
import com.icignal.kepler.operation.dto.request.KprOperationListReqDto;
import com.icignal.kepler.operation.dto.request.KprProdListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesDtlListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesMileageListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesPayListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprSetIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetSubjectAreaMappingReqDto;
import com.icignal.kepler.operation.dto.request.KprSetSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprSetTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprSetTableListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetUploadErrorReqDto;
import com.icignal.kepler.operation.dto.request.KprSetUploadResultReqDto;
import com.icignal.kepler.operation.dto.request.KprStoreListReqDto;
import com.icignal.kepler.operation.dto.request.KprSubjectAreaListReqDto;
import com.icignal.kepler.operation.dto.request.KprTableColImportReqDto;
import com.icignal.kepler.operation.dto.request.KprTableColInfoReqDto;
import com.icignal.kepler.operation.dto.request.KprTableImportTreeReqDto;
import com.icignal.kepler.operation.dto.request.KprTableMstListReqDto;
import com.icignal.kepler.operation.dto.response.KprDatabaseUseSchemaResDto;
import com.icignal.kepler.operation.dto.response.KprDbRegistResDto;
import com.icignal.kepler.operation.dto.response.KprDrillDownGroupResDto;
import com.icignal.kepler.operation.dto.response.KprExcelUploadResDto;
import com.icignal.kepler.operation.dto.response.KprExcelUploadResultResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxColListResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxColListsResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxListResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableColListResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableColListsResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableResDto;
import com.icignal.kepler.operation.dto.response.KprOperationListResDto;
import com.icignal.kepler.operation.dto.response.KprSubjectAreaListResDto;
import com.icignal.kepler.operation.dto.response.KprSubjectAreaTreesResDto;
import com.icignal.kepler.operation.dto.response.KprTableColImportResDto;
import com.icignal.kepler.operation.dto.response.KprTableColInfoResDto;
import com.icignal.kepler.operation.dto.response.KprTableImportTreeOracleResDto;
import com.icignal.kepler.operation.dto.response.KprTableImportTreesResDto;
import com.icignal.kepler.operation.dto.response.KprTableMstListResDto;
import com.icignal.kepler.operation.dto.response.KprTableResDto;
import com.icignal.kepler.operation.service.KprDrillDownGroupService;
import com.icignal.kepler.operation.service.KprOperationService;
import com.opencsv.CSVReader;

/*
 * 1. 클래스명	: SystemOperationController
 * 2. 파일명	: SystemOperationController.java
 * 3. 패키지명	: com.icignal.systemmanagement.kepler.operation.controller
 * 4. 작성자명	: 이원준
 * 5. 작성일자	: 2016. 7. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *		운영관리 controller
 * </PRE>
 */ 
@Controller
@RequestMapping("/kepler/operation")
public class KprOperationController extends BaseController {
	
	@Autowired
	public KprOperationService systemOperationService;
	
	@Autowired
	public KprDrillDownGroupService KPRDrillDownGroupService;

	@Autowired
	AuthHelper authHelper;
	
//	@Override
//	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
//	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, 
//			HttpServletResponse response,Model model) {
//		LogUtil.info("NavigatePopMenu start.....");
//		
//		
//		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
//		//Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
//		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
//		String respUrl = requestPath + "/popup/" +  name;
//		
//		//checkProgramAuth(respUrl, request ,response , model);
//		
//		if( checkProgramAuth(respUrl, request ,response , model) ) return authHelper.checkUserInfoInclude(request, response, respUrl);
//		return null;
//	}

	/**
	 * @programId : ANL_DB_001
	 * @name : getDbIformList
	 * @date : 2016. 7. 05.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리
	 */
	@RequestMapping(value = "/getDbInformList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprOperationListResDto> getDbInformList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprOperationListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto<KprOperationListResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = systemOperationService.getDbInformList(dir);

		return rtnValue;
	}

	/**
	 * @programId : ANL_DB_P01
	 * @name : getDbRegist
	 * @date : 2016. 7. 05.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리
	 */
	@RequestMapping(value = "/getDbRegist.do", method = RequestMethod.POST)
	public @ResponseBody KprDbRegistResDto getDbRegist(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDbRegistReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getDbRegist(dir);
	}

	/**
	 * 
	 * @programId : ANL_DB_P01
	 * @name : getDbChkRegist
	 * @date : 2016. 7. 22.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : 서비스명 중복체크
	 */
	@RequestMapping(value = "/getDbChkRegist.do", method = RequestMethod.POST)
	public @ResponseBody KprDbRegistResDto getDbChkRegist(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDbRegistReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getDbChkRegist(dir);
	}

	/**
	 * 
	 * @programId : ANL_DB_P01
	 * @name : getIpPortChk
	 * @date : 2016. 9. 7.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : IP / PORT 중복체크
	 */
	@RequestMapping(value = "/getIpPortChk.do", method = RequestMethod.POST)
	public @ResponseBody KprDbRegistResDto getIpPortChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDbRegistReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getIpPortChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_DB_001
	 * @name : dbInformDelChk
	 * @date : 2016. 7. 25.
	 * @author : 이원준
	 * @table : anl.anl_db_inform, anl.anl_subject_db_rel, anl.anl_table_mst
	 * @return :
	 * @description : 삭제 여부 체크
	 */
	@RequestMapping(value = "/dbInformDelChk.do", method = RequestMethod.POST)
	public @ResponseBody KprDbRegistResDto dbInformDelChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDbRegistReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.dbInformDelChk(dir);
	}

	/**
	 * @programId : ANL_DB_001
	 * @name : setDbRegist
	 * @date : 2016. 07. 15
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리 등록
	 */
	@RequestMapping(value = "/setDbRegist.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setDbRegist(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetDbInformReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setCreateBy(loginInfo.getId());
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.setDbRegist(dir);
	}

	/**
	 * @programId : ANL_DB_001
	 * @name : editDbRegist
	 * @date : 2016. 07. 15
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : DB정보관리 수정
	 */
	@RequestMapping(value = "/editDbRegist.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editDbRegist(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditDbInformReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.editDbRegist(dir);
	}

	/**
	 * @programId : ANL_DB_001
	 * @name : removeDbInform
	 * @date : 2016. 07. 15
	 * @author : 이원준
	 * @table : anl.anl_db_inform 
	 * @return :
	 * @description : DB정보관리 삭제
	 */
	@RequestMapping(value = "/removeDbInform.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeDbInform(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDelDbInformReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.removeDbInform(dir);
	}

	/**
	 * @programId : ANL_SBJ_001
	 * @name : getSubjectAreaList
	 * @date : 2016. 7. 18.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역관리 조회
	 */
	@RequestMapping(value = "/getSubjectAreaList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getSubjectAreaList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getSubjectAreaList(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_SBJ_001
	 * @name : getSubjectAreaChkRegist
	 * @date : 2016. 7. 25.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역명 중복체크
	 */
	@RequestMapping(value = "/getSubjectAreaChkRegist.do", method = RequestMethod.POST)
	public @ResponseBody KprSubjectAreaListResDto getSubjectAreaChkRegist(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getSubjectAreaChkRegist(sb);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_001
	 * @name : subjectAreaDelChk
	 * @date : 2016. 7. 25.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 삭제여부 조회
	 */
	@RequestMapping(value = "/subjectAreaDelChk.do", method = RequestMethod.POST)
	public @ResponseBody KprSubjectAreaListResDto subjectAreaDelChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.subjectAreaDelChk(sb);
	}

	/**
	 * @programId : ANL_SBJ_P01
	 * @name : getSubjectArea
	 * @date : 2016. 7. 05.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 생성 조회
	 */
	@RequestMapping(value = "/getSubjectArea.do", method = RequestMethod.POST)
	public @ResponseBody KprSubjectAreaListResDto getSubjectArea(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getSubjectArea(sb);
	}

	/**
	 * @programId : ANL_SBJ_P01
	 * @name : setSubjectArea
	 * @date : 2016. 07. 15
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 등록
	 */
	@RequestMapping(value = "/setSubjectArea.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setSubjectArea(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSubjectAreaReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		sb.setCreateBy(loginInfo.getId());
		sb.setModifyBy(loginInfo.getId());

		return systemOperationService.setSubjectArea(sb);
	}

	/**
	 * @programId : ANL_SBJ_P01
	 * @name : editSubjectArea
	 * @date : 2016. 07. 15
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 수정
	 */
	@RequestMapping(value = "/editSubjectArea.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editSubjectArea(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditSubjectAreaReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		sb.setModifyBy(loginInfo.getId());

		return systemOperationService.editSubjectArea(sb);
	}

	/**
	 * @programId : ANL_SBJ_001
	 * @name : removeSubjectArea
	 * @date : 2016. 07. 15
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 삭제
	 */
	@RequestMapping(value = "/removeSubjectArea.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeSubjectArea(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDelSubjectAreaReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		sb.setModifyBy(loginInfo.getId());

		return systemOperationService.removeSubjectArea(sb);
	}

	/**
	 * @programId : ANL_SBJ_002
	 * @name : getSubjectAreaMapping
	 * @date : 2016. 07. 19
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_db_rel
	 * @return :
	 * @description : 주제영역 조회
	 */
	@RequestMapping(value = "/getSubjectAreaMapping.do", method = RequestMethod.POST)
	public @ResponseBody List<KprSubjectAreaTreesResDto> getSubjectAreaMapping(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprSubjectAreaTreesResDto> rtnValue = new ArrayList<>();
		rtnValue = systemOperationService.getSubjectAreaMapping(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_SBJ_001
	 * @name : subjectDBDelChk
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_db_rel, anl.anl_table_mst
	 * @return :
	 * @description : 주제영역 삭제 체크
	 */
	@RequestMapping(value = "/subjectDBDelChk.do", method = RequestMethod.POST)
	public @ResponseBody KprSubjectAreaListResDto subjectDBDelChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.subjectDBDelChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_002
	 * @name : removeSubjectDb
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : anl.anl_subject_db_rel
	 * @return :
	 * @description : 서비스/주제영역 맵핑 삭제
	 */
	@RequestMapping(value = "/removeSubjectDb.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeSubjectDb(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDelSubjectAreaReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		sb.setModifyBy(loginInfo.getId());

		return systemOperationService.removeSubjectDb(sb);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : editSubjectDb
	 * @date : 2016. 8. 5.
	 * @author : 이원준
	 * @table : anl.anl_subject_db_rel
	 * @return :
	 * @description : 맵핑 주제영역 순서 변경
	 */
	@RequestMapping(value = "/editSubjectDb.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editSubjectDb(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditSubjectDbReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		sb.setModifyBy(loginInfo.getId());

		return systemOperationService.editSubjectDb(sb);
	}

	/**
	 * @programId : ANL_SBJ_P02
	 * @name : getSubjectAreaPop
	 * @date : 2016. 07. 19
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_db_rel
	 * @return : GridPagingResDto
	 * @description : 주제영역 조회
	 */
	@RequestMapping(value = "/getSubjectAreaPop.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprSubjectAreaListResDto> getSubjectAreaPop(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getSubjectAreaPop(sb);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : getMapping
	 * @date : 2016. 8. 17.
	 * @author : 이원준
	 * @table : anl.anl_subject_db_rel
	 * @return :
	 * @description : 주제영역 맵핑 여부확인
	 */
	@RequestMapping(value = "/getMapping.do", method = RequestMethod.POST)
	public @ResponseBody KprSubjectAreaListResDto getMapping(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getMapping(dir);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : setMapping
	 * @date : 2016. 7. 19.
	 * @author : 이원준
	 * @table : anl.anl_subject_db_rel
	 * @return :
	 * @description : 주제영역 맵핑
	 */
	@RequestMapping(value = "/setMapping.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setMapping(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSubjectAreaMappingReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		sb.setCreateBy(loginInfo.getId());
		sb.setModifyBy(loginInfo.getId());

		return systemOperationService.setMapping(sb);
	}

	/**
	 * 
	 * @programId : ANL_SBJ_P02
	 * @name : editMapping
	 * @date : 2016. 7. 19.
	 * @author : 이원준
	 * @table : anl.anl_subject_db_rel
	 * @return :
	 * @description : 주제영역 맵핑
	 */
	@RequestMapping(value = "/editMapping.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editMapping(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetSubjectAreaMappingReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		sb.setCreateBy(loginInfo.getId());
		sb.setModifyBy(loginInfo.getId());

		return systemOperationService.editMapping(sb);
	}

	/**
	 * 
	 * @programId : ANL_TBL_001
	 * @name : getTableMstList
	 * @date : 2016. 7. 20.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블관리 조회
	 */
	@RequestMapping(value = "/getTableMstList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprTableMstListResDto> getTableMstList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableMstListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto<KprTableMstListResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = systemOperationService.getTableMstList(dir);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getDbServiceComboList
	 * @date : 2016. 7. 27.
	 * @author : 이원준
	 * @table : anl.anl_db_inform
	 * @return :
	 * @description : 서비스명 조회
	 */
	@RequestMapping(value = "/getDbServiceComboList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getDbServiceComboList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprComboListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		authHelper.checkLoginSession(request, response);
		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getDbServiceComboList(reqDto);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getSubjectAreaComboList
	 * @date : 2016. 7. 26.
	 * @author : 이원준
	 * @table : anl.anl_subject_area
	 * @return :
	 * @description : 주제영역 조회
	 */
	@RequestMapping(value = "/getSubjectAreaComboList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getSubjectAreaComboList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprComboListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		authHelper.checkLoginSession(request, response);
		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getSubjectAreaComboList(reqDto);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getTableList
	 * @date : 2016. 7. 26.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 조회
	 */
	@RequestMapping(value = "/getTableList.do", method = RequestMethod.POST)
	public @ResponseBody KprGetTableResDto getTableList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getTableList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : tablrIdReturn
	 * @date : 2016. 7. 29.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블아이디 조회
	 */
	@RequestMapping(value = "/tableIdReturn.do", method = RequestMethod.POST)
	public @ResponseBody KprTableMstListResDto tableIdReturn(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableMstListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.tableIdReturn(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : tableNmChk
	 * @date : 2016. 7. 29.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블명 중복 체크
	 */
	@RequestMapping(value = "/tableNmChk.do", method = RequestMethod.POST)
	public @ResponseBody KprTableMstListResDto tableNmChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableMstListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.tableNmChk(dir);
	}

	/**
	 * 
	 * @programId :ANL_TBL_002
	 * @name : getTableLgcChk
	 * @date : 2016. 9. 6.
	 * @author : 이원준
	 * @table : anl.anl_table_mst, anl.anl_column_mst, anl.anl_lgc_join_column
	 * @return :
	 * @description : L.C사용유무 체크
	 */
	@RequestMapping(value = "/getTableLgcChk.do", method = RequestMethod.POST)
	public @ResponseBody KprTableMstListResDto getTableLgcChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableMstListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getTableLgcChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : tableAddColDelChk
	 * @date : 2016. 7. 29.
	 * @author : 이원준
	 * @table : anl.anl_lgc_join_column, anl.anl_column_mst
	 * @return :
	 * @description : 테이블 컬럼 삭제체크
	 */
	@RequestMapping(value = "/tableAddColDelChk.do", method = RequestMethod.POST)
	public @ResponseBody KprGetTableColListResDto tableAddColDelChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.tableAddColDelChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : setTableList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 저장
	 */
	@RequestMapping(value = "/setTableList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setTableList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTableListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setCreateBy(loginInfo.getId());
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.setTableList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : editTableList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 수정
	 */
	@RequestMapping(value = "/editTableList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editTableList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditTableListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.editTableList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getTableColList
	 * @date : 2016. 7. 26.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 테이블 컬럼정보 조회
	 */
	@RequestMapping(value = "/getTableColList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<KprGetTableColListResDto> getTableColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto<KprGetTableColListResDto> rtnValue = new GridPagingResDto<>();
		rtnValue = systemOperationService.getTableColList(dir);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getTableColList
	 * @date : 2016. 7. 26.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 테이블 컬럼정보 조회
	 */
	@RequestMapping(value = "/getTableAddColList.do", method = RequestMethod.POST)
	public @ResponseBody KprGetTableColListResDto getTableAddColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getTableAddColList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P02
	 * @name : getTblColNmChk
	 * @date : 2016. 8. 3.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼명 중복 체크
	 */
	@RequestMapping(value = "/getTblColNmChk.do", method = RequestMethod.POST)
	public @ResponseBody KprGetTableColListResDto getTblColNmChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getTblColNmChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P02
	 * @name : setTableAddColList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼정보 등록
	 */
	@RequestMapping(value = "/setTableAddColList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setTableAddColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTableAddColReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setCreateBy(loginInfo.getId());
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.setTableAddColList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P02
	 * @name : editTableAddColList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼정보 수정
	 */
	@RequestMapping(value = "/editTableAddColList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editTableAddColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditTableAddColReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.editTableAddColList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : removeTableAddColList
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼정보 삭제
	 */
	@RequestMapping(value = "/removeTableAddColList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTableAddColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDelTableAddColReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.removeTableAddColList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P01
	 * @name : getTableAdvance
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 고급설정 조회
	 */
	@RequestMapping(value = "/getTableAdvance.do", method = RequestMethod.POST)
	public @ResponseBody KprGetTableResDto getTableAdvance(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getTableAdvance(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P01
	 * @name : editTableAdvance
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 고급설정 등록
	 */
	@RequestMapping(value = "/editTableAdvance.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editTableAdvance(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditTableAdvanceReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.editTableAdvance(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_002
	 * @name : getDbType
	 * @date : 2016. 7. 28.
	 * @author : 이원준
	 * @table : anl.anl_db_inform, anl.anl_table_mst
	 * @return :
	 * @description : DB 유형 조회
	 */
	@RequestMapping(value = "/getDbType.do", method = RequestMethod.POST)
	public @ResponseBody KprDbRegistResDto getDbType(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDbRegistReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getDbType(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P02
	 * @name : getTableAddColSeq
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 컬럼 순서
	 */
	@RequestMapping(value = "/getTableAddColSeq.do", method = RequestMethod.POST)
	public @ResponseBody KprGetTableColListResDto getTableAddColSeq(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getTableAddColSeq(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_003
	 * @name : getIdxList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 목록 조회
	 */
	@RequestMapping(value = "/getIdxList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getIdxList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetIdxListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getIdxList(dir);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P03
	 * @name : getIdxInform
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 목록조회
	 */
	@RequestMapping(value = "/getIdxInform.do", method = RequestMethod.POST)
	public @ResponseBody KprGetIdxListResDto getIdxInform(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetIdxListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getIdxInform(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P03
	 * @name : getIdxNmChk
	 * @date : 2016. 8. 2.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스명 중복 체크
	 */
	@RequestMapping(value = "/getIdxNmChk.do", method = RequestMethod.POST)
	public @ResponseBody KprGetIdxListResDto getIdxNmChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetIdxListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getIdxNmChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P03
	 * @name : setIdxList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 등록
	 */
	@RequestMapping(value = "/setIdxList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setIdxList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetIdxListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setCreateBy(loginInfo.getId());
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.setIdxList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P03
	 * @name : editIdxList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 수정
	 */
	@RequestMapping(value = "/editIdxList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editIdxList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditIdxListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.editIdxList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_003
	 * @name : removeIdxList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 삭제
	 */
	@RequestMapping(value = "/removeIdxList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeIdxList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDelIdxListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.removeIdxList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_003
	 * @name : getIdxColList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 인덱스 컬럼 목록 조회
	 */
	@RequestMapping(value = "/getIdxColList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getIdxColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetIdxColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getIdxColList(dir);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P04
	 * @name : getIdxColInform
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 인덱스 정보 조회
	 */
	@RequestMapping(value = "/getIdxColInform.do", method = RequestMethod.POST)
	public @ResponseBody KprGetIdxColListResDto getIdxColInform(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetIdxColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getIdxColInform(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P04
	 * @name : getIdxColNmChk
	 * @date : 2016. 8. 2.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 컬럼명 중복체크
	 */
	@RequestMapping(value = "/getIdxColNmChk.do", method = RequestMethod.POST)
	public @ResponseBody KprGetIdxColListResDto getIdxColNmChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetIdxColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getIdxColNmChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P04
	 * @name : setIdxColList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 컬럼정보 등록
	 */
	@RequestMapping(value = "/setIdxColList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setIdxColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetIdxColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setCreateBy(loginInfo.getId());
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.setIdxColList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P04
	 * @name : editIdxColList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 컬럼정보 수정
	 */
	@RequestMapping(value = "/editIdxColList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editIdxColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditIdxColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.editIdxColList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_003
	 * @name : removeIdxColList
	 * @date : 2016. 8. 1.
	 * @author : 이원준
	 * @table : anl.anl_index_column
	 * @return :
	 * @description : 컬럼정보 삭제
	 */
	@RequestMapping(value = "/removeIdxColList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeIdxColList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDelIdxColListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.removeIdxColList(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P05
	 * @name : getIdxAdvance
	 * @date : 2016. 8. 2.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 고급설정 조회
	 */
	@RequestMapping(value = "/getIdxAdvance.do", method = RequestMethod.POST)
	public @ResponseBody KprGetIdxListResDto getIdxAdvance(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetIdxListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getIdxAdvance(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P05
	 * @name : editIdxAdvance
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : anl.anl_index_mst
	 * @return :
	 * @description : 인덱스 고급설정 저장
	 */
	@RequestMapping(value = "/editIdxAdvance.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editIdxAdvance(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditIdxAdvanceReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.editIdxAdvance(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P07
	 * @name : getCreatTblCol
	 * @date : 2016. 8. 3.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 테이블 생성
	 */
	@RequestMapping(value = "/getCreatTblCol.do", method = RequestMethod.POST)
	public @ResponseBody List<KprGetTableColListsResDto> getCreatTblCol(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableColListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprGetTableColListsResDto> rtnValue = new ArrayList<>();
		rtnValue = systemOperationService.getCreatTblCol(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P07
	 * @name : getCreatIdxCol
	 * @date : 2016. 8. 3.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 테이블 컬럼정보 조회
	 */
	@RequestMapping(value = "/getCreatIdxCol.do", method = RequestMethod.POST)
	public @ResponseBody List<KprGetIdxColListsResDto> getCreatIdxCol(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetIdxColListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprGetIdxColListsResDto> rtnValue = new ArrayList<>();
		rtnValue = systemOperationService.getCreatIdxCol(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getSourceTreeMySqlData
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : information_schema.tables, information_schema.columns
	 * @return :
	 * @description : 스키마 하위 테이블 조회
	 */
	@RequestMapping(value = "/getSourceTreeMySqlData.do", method = RequestMethod.POST)
	public @ResponseBody List<KprTableImportTreesResDto> getSourceTreeMySqlData(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableImportTreeReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		// Service Execution
		List<KprTableImportTreesResDto> rtnValue = new ArrayList<>();

		rtnValue = systemOperationService.getSourceTreeMySqlData(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getSourceTreeOracleData
	 * @date : 2016. 8. 4.
	 * @author : 이원준
	 * @table : information_schema.tables, information_schema.columns
	 * @return :
	 * @description : 스키마 하위 테이블 조회
	 */
	@RequestMapping(value = "/getSourceTreeOracleData.do", method = RequestMethod.POST)
	public @ResponseBody List<KprTableImportTreeOracleResDto> getSourceTreeOracleData(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableImportTreeReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		// Service Execution
		List<KprTableImportTreeOracleResDto> rtnValue = new ArrayList<>();

		rtnValue = systemOperationService.getSourceTreeOracleData(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getSourceTreeData
	 * @date : 2017. 12. 13.
	 * @author : 이기오
	 * @table : information_schema.tables, information_schema.columns
	 * @return :
	 * @description : 스키마 하위 테이블 조회
	 */
	@RequestMapping(value = "/getSourceTreeData.do", method = RequestMethod.POST)
	public @ResponseBody List<KprTableImportTreesResDto> getSourceTreeData(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableImportTreeReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		// Service Execution
		List<KprTableImportTreesResDto> rtnValue = new ArrayList<>();

		rtnValue = systemOperationService.getSourceTreeData(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : targetTreeData
	 * @date : 2016. 8. 5.
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_rel
	 * @return :
	 * @description : Target 주제영역 조회
	 */
	@RequestMapping(value = "/getTargetTreeData.do", method = RequestMethod.POST)
	public @ResponseBody List<KprTableImportTreesResDto> getTargetTreeData(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableImportTreeReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// Service Execution
		List<KprTableImportTreesResDto> rtnValue = new ArrayList<>();
		rtnValue = systemOperationService.getTargetTreeData(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getTableColImport
	 * @date : 2016. 8. 8.
	 * @author : 이원준
	 * @table : information_schema.columns
	 * @return :
	 * @description : 테이블 컬럼정보 조회
	 */
	@RequestMapping(value = "/getTableColImport.do", method = RequestMethod.POST)
	public @ResponseBody List<KprTableColImportResDto> getTableColImport(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableColImportReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		// Service Execution
		List<KprTableColImportResDto> rtnValue = new ArrayList<>();
		rtnValue = systemOperationService.getTableColImport(sb);

		return rtnValue;
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : setTableImport
	 * @date : 2016. 8. 8.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 불러오기
	 */
	@RequestMapping(value = "/setTableImport.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setTableImport(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTableListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setCreateBy(loginInfo.getId());
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.setTableImport(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : setTableColImport
	 * @date : 2016. 8. 9.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 테이블 컬럼정보 불러오기
	 */
	@RequestMapping(value = "/setTableColImport.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setTableColImport(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTableAddColReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setCreateBy(loginInfo.getId());
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.setTableColImport(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P07
	 * @name : setTableCreat
	 * @date : 2016. 8. 5.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 테이블생성 외부쿼리 호출
	 */
	@RequestMapping(value = "/setTableCreat.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setTableCreat(HttpServletRequest request, HttpServletResponse response, @RequestBody KprOperationListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.setTableCreat(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : tableLgcChk
	 * @date : 2016. 8. 12.
	 * @author : 이원준
	 * @table : anl.anl_table_mst, anl.anl_lgc_comp_table_rel
	 * @return :
	 * @description : 테이블 불어오기 사용여부 체크
	 */
	@RequestMapping(value = "/tableLgcChk.do", method = RequestMethod.POST)
	public @ResponseBody KprTableMstListResDto tableLgcChk(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableMstListReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.tableLgcChk(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : removeTableColumn
	 * @date : 2016. 8. 12.
	 * @author : 이원준
	 * @table : anl.anl_column_mst
	 * @return :
	 * @description : 테이블 불러오기 컬럼 삭제
	 */
	@RequestMapping(value = "/removeTableColumn.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTableColumn(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDelTableReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.removeTableColumn(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : removeTable
	 * @date : 2016. 8. 12.
	 * @author : 이원준
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 불러오기 테이블 삭제
	 */
	@RequestMapping(value = "/removeTable.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTable(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDelTableReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		dir.setModifyBy(loginInfo.getId());

		return systemOperationService.removeTable(dir);
	}

	/**
	 * 
	 * @programId : ANL_TBL_P06
	 * @name : getSubjectAreaNmRtn
	 * @date : 2016. 8. 19.
	 * @author : 이원준
	 * @table : anl.anl_subject_area, anl.anl_subject_db_rel
	 * @return :
	 * @description : 주제영역명 return
	 */
	@RequestMapping(value = "/getSubjectAreaNmRtn.do", method = RequestMethod.POST)
	public @ResponseBody KprSubjectAreaListResDto getSubjectAreaNmRtn(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSubjectAreaListReqDto sb) {
		LogUtil.param(KprOperationController.class, sb);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		return systemOperationService.getSubjectAreaNmRtn(sb);
	}

	/**
	 * 
	 * @programId :
	 * @name : getAccountNm
	 * @date : 2016. 9. 28.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description :어카운트명 조회
	 */
	@RequestMapping(value = "/getAccountNm.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getAccountNm(HttpServletRequest request, HttpServletResponse response, @RequestBody KprComboListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		authHelper.checkLoginSession(request, response);
		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getAccountNm(reqDto);

		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : getMappingColInfo
	 * @date : 2016. 10. 4.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 테이블 목록 컬럼 정보 조회
	 */
	@RequestMapping(value = "/getMappingColInfo.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getMappingColInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody KprTableColInfoReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getMappingColInfo(dir);

		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : getExcelHaedList
	 * @date : 2016. 10. 5.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 엑셀파일 head값 추출
	 */
	@RequestMapping(value = "/getExcelHaedList.do", method = RequestMethod.POST)
	public @ResponseBody KprTableColInfoResDto getExcelHaedList(@RequestParam("file") MultipartFile file, @RequestParam("appServiceId") String appServiceId, @RequestParam("country") String country, @RequestParam("lang") String lang,
			HttpServletRequest request, HttpServletResponse response) {

		KprTableColInfoResDto rtnValue = new KprTableColInfoResDto();

		String fileType = "";
		List<String> headerNm = new ArrayList<String>();
		
		if(file != null && file.getSize() > 0 && file.getSize() < 10240000) {
			XSSFWorkbook wb = null;
			CSVReader reader = null;
			try {
				// 파일 확장자 검사	    
				String fileName = new String(file.getOriginalFilename().getBytes("8859_1"), "utf-8");
				fileType = fileName.substring(fileName.lastIndexOf('.') + 1, fileName.lastIndexOf('.') + 4);
				
				// 엑셀 파일 읽기
				if (fileType.equals("xls") || fileType.equals("xlsx")) {
					// 엑셀 객체 생성
					// 엑셀 파일을 받아서 엑셀 객체로 생성
					wb = new XSSFWorkbook(file.getInputStream());

					// 엑셀 파일의 첫번째 시트 저장
					XSSFSheet sheet = wb.getSheetAt(0);
					// 첫번재 시트의 로우수 만큼 포문을 돌려서 로우의 값을 받음
					int i = sheet.getFirstRowNum();
					
					XSSFRow row = sheet.getRow(i);
					int j = row.getLastCellNum();
					while (j > 0) {
						XSSFCell cell = row.getCell(j - 1);
						String vellValue = "";
						if (cell != null) {
							switch (cell.getCellType()) {
								case FORMULA:
									vellValue = cell.getCellFormula();
									break;
								case NUMERIC:
									vellValue = Integer.toString((int) cell.getNumericCellValue());
									break;
								case STRING:
									vellValue = cell.getStringCellValue();
									break;
								case BLANK:
									vellValue = Boolean.toString(cell.getBooleanCellValue());
									break;
								case ERROR:
									vellValue = Integer.toString(cell.getErrorCellValue());
									break;
								default :
									break;
							}
						}
						headerNm.add(0, vellValue);
						j--;
					}
					headerNm.add(0, "");
				}
				// csv 파일 일기
				else if (fileType.equals("csv")) {
						// reader = new CSVReader(new
						// InputStreamReader(file.getInputStream()));
						reader = new CSVReader(new BufferedReader(new InputStreamReader(file.getInputStream(), "MS949")), ',');
						String[] nextLine;
						nextLine = reader.readNext();
						if (nextLine != null) {
							for (int j = nextLine.length - 1; j >= 0; j--) {
								headerNm.add(0, nextLine[j]);
							}
							headerNm.add(0, "");
						}						
				} else {
					// 파일 형식 맞지않음
					LogUtil.error("파일 형식 맞지않음..");
				}
				rtnValue.setHeaderNm(headerNm);
			
			}catch (IOException e) {
				LogUtil.error("엑셀파일 읽기 오류",e);
			}finally{
				try {
					reader.close();
				} catch (IOException e) {
					LogUtil.error(e.getMessage(),e);
				}
				try {
					wb.close();
				} catch (IOException e) {
					LogUtil.error(e.getMessage(),e);
				}
			}
		}
		
		return rtnValue;
		
	   
	}

	/****************************************************/
	/** 엑셀업로드 변수선언 **/
	int successCnt;
	int failCnt;
	List<String> errorMessages = new ArrayList<String>();

	/****************************************************/
	/**
	 * 
	 * @programId :
	 * @name : setExcelUpload
	 * @date : 2016. 10. 20.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 엑셀 업로드 임시테이블 저장 / 오류내역 저장
	 */
	@RequestMapping(value = "/setExcelUpload.do", method = RequestMethod.POST)
	public @ResponseBody KprExcelUploadResDto setExcelUpload(@RequestParam("file") MultipartFile file, @RequestParam("importType") String importType, @RequestParam("appServiceId") String appServiceId, @RequestParam("country") String country,
			@RequestParam("lang") String lang, @RequestParam("tableId") String tableId, @RequestParam("fileNm") String fileNm, @RequestParam("excelColList") String excelColList, HttpServletRequest request, HttpServletResponse response) {

		KprExcelUploadResDto rtnValue = new KprExcelUploadResDto();
		KprExcelUpLoadReqDto eul = new KprExcelUpLoadReqDto();

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		// 세션에 저장되어 있는 지원의 아이디를 셋팅
		eul.setCreateBy(loginInfo.getId());
		eul.setModifyBy(loginInfo.getId());

		// 파일 확장자 초기화
		String fileType = "";
		List<String> fvIds = new ArrayList<String>();
		int totCnt = 0;
		successCnt = 0;
		failCnt = 0;
		errorMessages.clear();
		Boolean javaFlag = false;

		// 임시테이블 삭제
		if (tableId.equals("T_O_CUST")) {
			systemOperationService.delTmpCustList(eul);
		} else if (tableId.equals("T_O_STORE")) {
			systemOperationService.delTmpStoreList(eul);
		} else if (tableId.equals("T_O_SALES")) {
			systemOperationService.delTmpSalesList(eul);
		} else if (tableId.equals("T_O_SALES_DTL")) {
			systemOperationService.delTmpSalesDtlList(eul);
		} else if (tableId.equals("T_O_SALES_PAY")) {
			systemOperationService.delTmpSalesPayList(eul);
		} else if (tableId.equals("T_O_CARD")) {
			systemOperationService.delTmpCardList(eul);
		} else if (tableId.equals("T_O_SALES_MILEAGE")) {
			systemOperationService.delTmpSalesMileageList(eul);
		} else if (tableId.equals("T_O_PROD")) {
			systemOperationService.delTmpProdList(eul);
		}

		// 파일 확장자 검사
		try {
			String fileName = new String(file.getOriginalFilename().getBytes("8859_1"), "utf-8");
			fileType = fileName.substring(fileName.lastIndexOf('.') + 1, fileName.lastIndexOf('.') + 4);
		} catch (IOException e) {
			// 파일 형식 오류
			LogUtil.error(e);
		}
		long startTime = System.currentTimeMillis();
		// 엑셀 파일 읽기
		if (fileType.equals("xls") || fileType.equals("xlsx")) {

			// 엑셀 객체 생성
			XSSFWorkbook wb = null;
			try {
				// 엑셀 파일을 받아서 엑셀 객체로 생성
				wb = new XSSFWorkbook(file.getInputStream());

				// 엑셀 파일의 첫번째 시트 저장
				XSSFSheet sheet = wb.getSheetAt(0);
				totCnt = sheet.getLastRowNum();

				// 첫번재 시트의 로우수 만큼 포문을 돌려서 로우의 값을 받음
				for (int i = sheet.getFirstRowNum(); i <= sheet.getLastRowNum(); i++) {
					XSSFRow row = sheet.getRow(i);
					KprCustListReqDto clr = new KprCustListReqDto();
					KprStoreListReqDto slr = new KprStoreListReqDto();
					KprSalesListReqDto salr = new KprSalesListReqDto();
					KprSalesDtlListReqDto sdlr = new KprSalesDtlListReqDto();
					KprSalesPayListReqDto splr = new KprSalesPayListReqDto();
					KprCardListReqDto calr = new KprCardListReqDto();
					KprSalesMileageListReqDto smlr = new KprSalesMileageListReqDto();
					KprProdListReqDto plr = new KprProdListReqDto();

					javaFlag = true;

					// 맵핑정보 List
					String data = excelColList;
					JSONArray jsonArr = new JSONArray(data);
					if (i != 0) {
						for (int k = 0; k < jsonArr.length(); k++) {
							JSONObject jsonObj = jsonArr.getJSONObject(k);

							int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
							int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;

							XSSFCell cell = row.getCell(b);
							String vellValue = "";
							// 문자 숫자 구분해서 읽어야함
							if (cell != null && !"".equals(cell)) {
								switch (cell.getCellType()) {
									case FORMULA:
										vellValue = cell.getCellFormula();
										break;
									case NUMERIC:
										vellValue = Integer.toString((int) cell.getNumericCellValue());
										break;
									case STRING:
										vellValue = cell.getStringCellValue();
										break;
									case BLANK:
										vellValue = cell.getStringCellValue();
										break;
									case ERROR:
										vellValue = Integer.toString(cell.getErrorCellValue());
										break;
									default :
										break;
								}
							}

							if (tableId.equals("T_O_CUST")) { // 회원
								if (a == 1) {
									clr.setId(vellValue);
									fvIds.add(vellValue);
								} else if (a == 2) {
									clr.setMbrId(vellValue);
								} else if (a == 3) {
									clr.setMbrNm(vellValue);
								} else if (a == 4) {
									clr.setMbrYn(vellValue);
								} else if (a == 5) {
									clr.setAge(vellValue);
								} else if (a == 6) {
									clr.setGndrCd(vellValue);
								} else if (a == 7) {
									clr.setAccntId(vellValue);
								} else if (a == 8) {
									clr.setBirthDt(vellValue);
								} else if (a == 9) {
									clr.setZipcd(vellValue);
								} else if (a == 10) {
									clr.setAddr1(vellValue);
								} else if (a == 11) {
									clr.setAddr2(vellValue);
								} else if (a == 12) {
									clr.setFstJoinDt(vellValue);
								} else if (a == 13) {
									clr.setFstJoinStoreId(vellValue);
								} else if (a == 14) {
									clr.setRfmGrdCd(vellValue);
								} else if (a == 15) {
									clr.setDmRecvYn(vellValue);
								} else if (a == 16) {
									clr.setSmsRecvYn(vellValue);
								} else if (a == 17) {
									clr.setTmRecvYn(vellValue);
								} else if (a == 18) {
									clr.setEmailRecvYn(vellValue);
								} else if (a == 19) {
									clr.setHpNum(vellValue);
								} else if (a == 20) {
									clr.setEmail(vellValue);
								} else if (a == 21) {
									clr.setInformMdfDt(vellValue);
								} else if (a == 22) {
									clr.setWithdrawDt(vellValue);
								} else if (a == 23) {
									clr.setEmpYn(vellValue);
								} else if (a == 24) {
									clr.setFstPurDt(vellValue);
								} else if (a == 25) {
									clr.setEmailPublicYn(vellValue);
								} else if (a == 26) {
									clr.setAlarmFavSiteYn(vellValue);
								} else if (a == 27) {
									clr.setAlarmMySiteYn(vellValue);
								} else if (a == 28) {
									clr.setAlarmJoinSiteYn(vellValue);
								} else if (a == 29) {
									clr.setAlarmPostReplyYn(vellValue);
								} else if (a == 30) {
									clr.setAlarmSiteNoticeYn(vellValue);
								} else if (a == 31) {
									clr.setMbrSts(vellValue);
								} else if (a == 32) {
									clr.setMbrValue(vellValue);
								} else if (a == 33) {
									clr.setMbrLc(vellValue);
								} else if (a == 34) {
									clr.setMbrGrd(vellValue);
								} else if (a == 35) {
									clr.setMbrGrwType(vellValue);
								} else if (a == 36) {
									clr.setMbrStsChgDt(vellValue);
								} else if (a == 37) {
									if (isStringInteger(vellValue)) {
										clr.setMileage(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 38) {
									clr.setLstPurDt(vellValue);
								}
							} else if (tableId.equals("T_O_STORE")) { // 매장
								if (a == 1) {
									slr.setId(vellValue);
									fvIds.add(vellValue);
								} else if (a == 2) {
									slr.setBrand(vellValue);
								} else if (a == 3) {
									slr.setStoreNm(vellValue);
								} else if (a == 4) {
									slr.setStoreType(vellValue);
								} else if (a == 5) {
									slr.setTelNo(vellValue);
								} else if (a == 6) {
									slr.setDeptId(vellValue);
								} else if (a == 7) {
									slr.setParAccntId(vellValue);
								} else if (a == 8) {
									slr.setOrgId(vellValue);
								}
							} else if (tableId.equals("T_O_SALES")) { // 매출
								if (a == 1) {
									salr.setId(vellValue);
									fvIds.add(vellValue);
								} else if (a == 2) {
									salr.setStoreId(vellValue);
								} else if (a == 3) {
									salr.setSalesDt(vellValue);
								} else if (a == 4) {
									salr.setSalesType(vellValue);
								} else if (a == 5) {
									if (isStringInteger(vellValue)) {
										salr.setQty(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 6) {
									if (isStringInteger(vellValue)) {
										salr.setTotSalesAmt(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 7) {
									if (isStringInteger(vellValue)) {
										salr.setRealSalesAmt(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 8) {
									if (isStringInteger(vellValue)) {
										salr.setTotDcAmt(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 9) {
									salr.setSalesEmpId(vellValue);
								} else if (a == 10) {
									salr.setCpnNo(vellValue);
								} else if (a == 11) {
									salr.setMbrId(vellValue);
								} else if (a == 12) {
									salr.setOfferNo(vellValue);
								}
							} else if (tableId.equals("T_O_SALES_DTL")) { // 매출상세
								if (a == 1) {
									sdlr.setId(vellValue);
									fvIds.add(vellValue);
								} else if (a == 2) {
									sdlr.setSalesId(vellValue);
								} else if (a == 3) {
									sdlr.setSalesDt(vellValue);
								} else if (a == 4) {
									sdlr.setProdId(vellValue);
								} else if (a == 5) {
									if (isStringInteger(vellValue)) {
										sdlr.setQty(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 6) {
									if (isStringInteger(vellValue)) {
										sdlr.setPrc(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 7) {
									if (isStringInteger(vellValue)) {
										sdlr.setAmt(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								}
							} else if (tableId.equals("T_O_SALES_PAY")) { // 매출결제
								if (a == 1) {
									splr.setId(vellValue);
									fvIds.add(vellValue);
								} else if (a == 2) {
									splr.setSalesId(vellValue);
								} else if (a == 3) {
									splr.setPayType(vellValue);
								} else if (a == 4) {
									if (isStringInteger(vellValue)) {
										splr.setPayAmt(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 5) {
									if (isStringInteger(vellValue)) {
										splr.setDcAmt(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								}
							} else if (tableId.equals("T_O_CARD")) { // 멤버쉽카드
								if (a == 1) {
									calr.setId(vellValue);
									fvIds.add(vellValue);
								} else if (a == 2) {
									calr.setUseYn(vellValue);
								} else if (a == 3) {
									calr.setIssueDt(vellValue);
								} else if (a == 4) {
									calr.setCardNo(vellValue);
								} else if (a == 5) {
									calr.setBarcodeNo(vellValue);
								} else if (a == 6) {
									calr.setQrCd(vellValue);
								} else if (a == 7) {
									calr.setMbrId(vellValue);
								}
							} else if (tableId.equals("T_O_SALES_MILEAGE")) { // 매출마일리지
								if (a == 1) {
									smlr.setId(vellValue);
									fvIds.add(vellValue);
								} else if (a == 2) {
									smlr.setSalesId(vellValue);
								} else if (a == 3) {
									smlr.setMileType(vellValue);
								} else if (a == 4) {
									if (isStringInteger(vellValue)) {
										smlr.setMileAmt(Integer.parseInt(vellValue));
									} else {
										javaFlag = false;
									}
								} else if (a == 5) {
									smlr.setCardId(vellValue);
								}
							} else if (tableId.equals("T_O_PROD")) { // 상품
								if (a == 1) {
									plr.setId(vellValue);
									fvIds.add(vellValue);
								} else if (a == 2) {
									plr.setPrdCd(vellValue);
								} else if (a == 3) {
									plr.setPrdNm(vellValue);
								} else if (a == 4) {
									plr.setBrand(vellValue);
								} else if (a == 5) {
									plr.setPrdLar(vellValue);
								} else if (a == 6) {
									plr.setPrdMid(vellValue);
								} else if (a == 7) {
									plr.setPrdSml(vellValue);
								}
							}
						}

						if (tableId.equals("T_O_CUST")) {
							if (javaFlag) {
								KprExcelUploadResDto setCustExcelUpload = systemOperationService.setCustExcelUpload(clr);
								if (setCustExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setCustExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_STORE")) {
							if (javaFlag) {
								KprExcelUploadResDto setStoreExcelUpload = systemOperationService.setStoreExcelUpload(slr);
								if (setStoreExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setStoreExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_SALES")) {
							if (javaFlag) {
								KprExcelUploadResDto setSalesExcelUpload = systemOperationService.setSalesExcelUpload(salr);
								if (setSalesExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setSalesExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_SALES_DTL")) {
							if (javaFlag) {
								KprExcelUploadResDto setSalesDtlExcelUpload = systemOperationService.setSalesDtlExcelUpload(sdlr);
								if (setSalesDtlExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setSalesDtlExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_SALES_PAY")) {
							if (javaFlag) {
								KprExcelUploadResDto setSalesPayExcelUpload = systemOperationService.setSalesPayExcelUpload(splr);
								if (setSalesPayExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setSalesPayExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_CARD")) {
							if (javaFlag) {
								KprExcelUploadResDto setCardExcelUpload = systemOperationService.setCardExcelUpload(calr);
								if (setCardExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setCardExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_SALES_MILEAGE")) {
							if (javaFlag) {
								KprExcelUploadResDto setSalesMileageExcelUpload = systemOperationService.setSalesMileageExcelUpload(smlr);
								if (setSalesMileageExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setSalesMileageExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_PROD") && javaFlag) {
							KprExcelUploadResDto setProdExcelUpload = systemOperationService.setProdExcelUpload(plr);
							if (setProdExcelUpload.getSuccess()) {
								successCnt++;
							} else {
								failCnt++;
								errorMessages.add(setProdExcelUpload.getErrorMessage());
							}
						}
					}
				}

			} catch (IOException | JSONException e) {
				// 엑셀 형식 오류
				LogUtil.error(e);
			}finally {
				try {
					wb.close();
				} catch (IOException e) {
					LogUtil.error(e.getMessage());
				}
			}
		}
		// csv 파일 일기
		else if (fileType.equals("csv")) {
			CSVReader reader = null;
			try {
				reader = new CSVReader(new InputStreamReader(file.getInputStream()));
				String[] nextLine;
				int i = 0;

				while ((nextLine = reader.readNext()) != null) {
					KprCustListReqDto clr = new KprCustListReqDto();
					KprStoreListReqDto slr = new KprStoreListReqDto();
					KprSalesListReqDto salr = new KprSalesListReqDto();
					KprSalesDtlListReqDto sdlr = new KprSalesDtlListReqDto();
					KprSalesPayListReqDto splr = new KprSalesPayListReqDto();
					KprCardListReqDto calr = new KprCardListReqDto();
					KprSalesMileageListReqDto smlr = new KprSalesMileageListReqDto();
					KprProdListReqDto plr = new KprProdListReqDto();

					javaFlag = true;

					// 맵핑정보 List
					String data = excelColList;
					JSONArray jsonArr = new JSONArray(data);
					if (i != 0) {
						if (tableId.equals("T_O_CUST")) { // 회원
							for (int k = 0; k < jsonArr.length(); k++) {
								JSONObject jsonObj = jsonArr.getJSONObject(k);
								int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
								int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;
								if (a == 1) {
									clr.setId(nextLine[b]);
									fvIds.add(nextLine[b]);
								} else if (a == 2) {
									clr.setMbrId(nextLine[b]);
								} else if (a == 3) {
									clr.setMbrNm(nextLine[b]);
								} else if (a == 4) {
									clr.setMbrYn(nextLine[b]);
								} else if (a == 5) {
									clr.setAge(nextLine[b]);
								} else if (a == 6) {
									clr.setGndrCd(nextLine[b]);
								} else if (a == 7) {
									clr.setBirthDt(nextLine[b]);
								} else if (a == 8) {
									clr.setZipcd(nextLine[b]);
								} else if (a == 9) {
									clr.setAddr1(nextLine[b]);
								} else if (a == 10) {
									clr.setAddr2(nextLine[b]);
								} else if (a == 11) {
									clr.setFstJoinDt(nextLine[b]);
								} else if (a == 12) {
									clr.setFstJoinStoreId(nextLine[b]);
								} else if (a == 13) {
									clr.setRfmGrdCd(nextLine[b]);
								} else if (a == 14) {
									clr.setDmRecvYn(nextLine[b]);
								} else if (a == 15) {
									clr.setSmsRecvYn(nextLine[b]);
								} else if (a == 16) {
									clr.setTmRecvYn(nextLine[b]);
								} else if (a == 17) {
									clr.setEmailRecvYn(nextLine[b]);
								} else if (a == 18) {
									clr.setHpNum(nextLine[b]);
								} else if (a == 19) {
									clr.setEmail(nextLine[b]);
								} else if (a == 20) {
									clr.setInformMdfDt(nextLine[b]);
								} else if (a == 21) {
									clr.setWithdrawDt(nextLine[b]);
								} else if (a == 22) {
									clr.setEmpYn(nextLine[b]);
								} else if (a == 23) {
									clr.setFstPurDt(nextLine[b]);
								} else if (a == 24) {
									clr.setEmailPublicYn(nextLine[b]);
								} else if (a == 25) {
									clr.setAlarmFavSiteYn(nextLine[b]);
								} else if (a == 26) {
									clr.setAlarmMySiteYn(nextLine[b]);
								} else if (a == 27) {
									clr.setAlarmJoinSiteYn(nextLine[b]);
								} else if (a == 28) {
									clr.setAlarmPostReplyYn(nextLine[b]);
								} else if (a == 29) {
									clr.setAlarmSiteNoticeYn(nextLine[b]);
								} else if (a == 30) {
									clr.setMbrSts(nextLine[b]);
								} else if (a == 31) {
									clr.setMbrValue(nextLine[b]);
								} else if (a == 32) {
									clr.setMbrLc(nextLine[b]);
								} else if (a == 33) {
									clr.setMbrGrd(nextLine[b]);
								} else if (a == 34) {
									clr.setMbrGrwType(nextLine[b]);
								} else if (a == 35) {
									clr.setMbrStsChgDt(nextLine[b]);
								} else if (a == 36) {
									if (isStringInteger(nextLine[b])) {
										clr.setMileage(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 37) {
									clr.setLstPurDt(nextLine[b]);
								}
							}
							if (javaFlag) {
								KprExcelUploadResDto setCustExcelUpload = systemOperationService.setCustExcelUpload(clr);
								if (setCustExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setCustExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_STORE")) { // 매장
							for (int k = 0; k < jsonArr.length(); k++) {
								JSONObject jsonObj = jsonArr.getJSONObject(k);
								int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
								int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;
								if (a == 1) {
									slr.setId(nextLine[b]);
									fvIds.add(nextLine[b]);
								} else if (a == 2) {
									slr.setBrand(nextLine[b]);
								} else if (a == 3) {
									slr.setStoreNm(nextLine[b]);
								} else if (a == 4) {
									slr.setStoreType(nextLine[b]);
								} else if (a == 5) {
									slr.setTelNo(nextLine[b]);
								} else if (a == 6) {
									slr.setDeptId(nextLine[b]);
								} else if (a == 7) {
									slr.setParAccntId(nextLine[b]);
								} else if (a == 8) {
									slr.setOrgId(nextLine[b]);
								}
							}
							if (javaFlag) {
								KprExcelUploadResDto setStoreExcelUpload = systemOperationService.setStoreExcelUpload(slr);
								if (setStoreExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setStoreExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_SALES")) { // 매출
							for (int k = 0; k < jsonArr.length(); k++) {
								JSONObject jsonObj = jsonArr.getJSONObject(k);
								int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
								int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;
								if (a == 1) {
									salr.setId(nextLine[b]);
									fvIds.add(nextLine[b]);
								} else if (a == 2) {
									salr.setStoreId(nextLine[b]);
								} else if (a == 3) {
									salr.setSalesDt(nextLine[b]);
								} else if (a == 4) {
									salr.setSalesType(nextLine[b]);
								} else if (a == 5) {
									if (isStringInteger(nextLine[b])) {
										salr.setQty(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 6) {
									if (isStringInteger(nextLine[b])) {
										salr.setTotSalesAmt(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 7) {
									if (isStringInteger(nextLine[b])) {
										salr.setRealSalesAmt(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 8) {
									if (isStringInteger(nextLine[b])) {
										salr.setTotDcAmt(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 9) {
									salr.setSalesEmpId(nextLine[b]);
								} else if (a == 10) {
									salr.setCpnNo(nextLine[b]);
								} else if (a == 11) {
									salr.setMbrId(nextLine[b]);
								} else if (a == 12) {
									salr.setOfferNo(nextLine[b]);
								}
							}
							if (javaFlag) {
								KprExcelUploadResDto setSalesExcelUpload = systemOperationService.setSalesExcelUpload(salr);
								if (setSalesExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setSalesExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_SALES_DTL")) { // 매출상세
							for (int k = 0; k < jsonArr.length(); k++) {
								JSONObject jsonObj = jsonArr.getJSONObject(k);
								int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
								int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;
								if (a == 1) {
									sdlr.setId(nextLine[b]);
									fvIds.add(nextLine[b]);
								} else if (a == 2) {
									sdlr.setSalesId(nextLine[b]);
								} else if (a == 3) {
									sdlr.setSalesDt(nextLine[b]);
								} else if (a == 4) {
									sdlr.setProdId(nextLine[b]);
								} else if (a == 5) {
									if (isStringInteger(nextLine[b])) {
										sdlr.setQty(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 6) {
									if (isStringInteger(nextLine[b])) {
										sdlr.setPrc(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 7) {
									if (isStringInteger(nextLine[b])) {
										sdlr.setAmt(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								}
							}
							if (javaFlag) {
								KprExcelUploadResDto setSalesDtlExcelUpload = systemOperationService.setSalesDtlExcelUpload(sdlr);
								if (setSalesDtlExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setSalesDtlExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_SALES_PAY")) { // 매출경제
							for (int k = 0; k < jsonArr.length(); k++) {
								JSONObject jsonObj = jsonArr.getJSONObject(k);
								int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
								int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;
								if (a == 1) {
									splr.setId(nextLine[b]);
									fvIds.add(nextLine[b]);
								} else if (a == 2) {
									splr.setSalesId(nextLine[b]);
								} else if (a == 3) {
									splr.setPayType(nextLine[b]);
								} else if (a == 4) {
									if (isStringInteger(nextLine[b])) {
										splr.setPayAmt(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 5) {
									if (isStringInteger(nextLine[b])) {
										splr.setDcAmt(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								}
							}
							if (javaFlag) {
								KprExcelUploadResDto setSalesPayExcelUpload = systemOperationService.setSalesPayExcelUpload(splr);
								if (setSalesPayExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setSalesPayExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_CARD")) { // 맴버쉽카드
							for (int k = 0; k < jsonArr.length(); k++) {
								JSONObject jsonObj = jsonArr.getJSONObject(k);
								int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
								int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;
								if (a == 1) {
									calr.setId(nextLine[b]);
									fvIds.add(nextLine[b]);
								} else if (a == 2) {
									calr.setUseYn(nextLine[b]);
								} else if (a == 3) {
									calr.setIssueDt(nextLine[b]);
								} else if (a == 4) {
									calr.setCardNo(nextLine[b]);
								} else if (a == 5) {
									calr.setBarcodeNo(nextLine[b]);
								} else if (a == 6) {
									calr.setQrCd(nextLine[b]);
								} else if (a == 7) {
									calr.setMbrId(nextLine[b]);
								}
							}
							if (javaFlag) {
								KprExcelUploadResDto setCardExcelUpload = systemOperationService.setCardExcelUpload(calr);
								if (setCardExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setCardExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_SALES_MILEAGE")) { // 매출마일리지
							for (int k = 0; k < jsonArr.length(); k++) {
								JSONObject jsonObj = jsonArr.getJSONObject(k);
								int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
								int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;
								if (a == 1) {
									smlr.setId(nextLine[b]);
									fvIds.add(nextLine[b]);
								} else if (a == 2) {
									smlr.setSalesId(nextLine[b]);
								} else if (a == 3) {
									smlr.setMileType(nextLine[b]);
								} else if (a == 4) {
									if (isStringInteger(nextLine[b])) {
										smlr.setMileAmt(Integer.parseInt(nextLine[b]));
									} else {
										javaFlag = false;
									}
								} else if (a == 5) {
									smlr.setCardId(nextLine[b]);
								}
							}
							if (javaFlag) {
								KprExcelUploadResDto setSalesMileageExcelUpload = systemOperationService.setSalesMileageExcelUpload(smlr);
								if (setSalesMileageExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setSalesMileageExcelUpload.getErrorMessage());
								}
							}
						} else if (tableId.equals("T_O_PROD")) { // 상품
							for (int k = 0; k < jsonArr.length(); k++) {
								JSONObject jsonObj = jsonArr.getJSONObject(k);
								int a = Integer.parseInt(jsonObj.getString("colId")) + 1;
								int b = Integer.parseInt(jsonObj.getString("excelColId")) - 1;
								if (a == 1) {
									plr.setId(nextLine[b]);
									fvIds.add(nextLine[b]);
								} else if (a == 2) {
									plr.setPrdCd(nextLine[b]);
								} else if (a == 3) {
									plr.setPrdNm(nextLine[b]);
								} else if (a == 4) {
									plr.setBrand(nextLine[b]);
								} else if (a == 5) {
									plr.setPrdLar(nextLine[b]);
								} else if (a == 6) {
									plr.setPrdMid(nextLine[b]);
								} else if (a == 7) {
									plr.setPrdSml(nextLine[b]);
								}
							}
							if (javaFlag) {
								KprExcelUploadResDto setProdExcelUpload = systemOperationService.setProdExcelUpload(plr);
								if (setProdExcelUpload.getSuccess()) {
									successCnt++;
								} else {
									failCnt++;
									errorMessages.add(setProdExcelUpload.getErrorMessage());
								}
							}
						}
					}
					i++;
				}
				totCnt = i - 1;

			} catch (IOException | JSONException e) {
				// scv 파일 에러
				LogUtil.error(e);
			} finally {
				try {
					reader.close();
				} catch (IOException e) {
					LogUtil.error(e.getMessage(),e);
				}
			}
		}
		long endTime = System.currentTimeMillis();

		rtnValue.setFvId(fvIds);

		// Calendar c = Calendar.getInstance();
		String yyyymmdd = DateUtil.getToday("YYYYMMDD"); // String.valueOf(c.get(Calendar.YEAR))+String.valueOf(c.get(Calendar.MONTH)+1)+String.valueOf(c.get(Calendar.DATE));
		Float uploadTime = (endTime - startTime) / 1000.0f;
		String upTime = String.format("%.2f", uploadTime);

		// 업로드 결과 데이터 저장
		KprSetUploadResultReqDto urr = new KprSetUploadResultReqDto();
		urr.setAllCnt(totCnt);
		urr.setOkCnt(successCnt);
		urr.setNoCnt(failCnt);
		urr.setFileNm(fileNm);
		urr.setCreateBy(loginInfo.getId());
		urr.setUploadTime(upTime);
		urr.setUploadStartTime(yyyymmdd + formatTime(startTime));
		urr.setUploadEndTime(yyyymmdd + formatTime(endTime));
		urr.setTableType("TEMP");
		urr.setTblNm(tableId);

		KprExcelUploadResultResDto setUploadResult = systemOperationService.setUploadResult(urr);
		rtnValue.setId(setUploadResult.getMessage());

		// 업로드 Error 내역 저장
		for (int k = 0; k < errorMessages.size(); k++) {
			KprSetUploadErrorReqDto uer = new KprSetUploadErrorReqDto();
			KprGetUploadErrorReqDto guer = new KprGetUploadErrorReqDto();
			String errorMsg = errorMessages.get(k);

			uer.setId(setUploadResult.getMessage());
			guer.setId(setUploadResult.getMessage());

			Integer seq = systemOperationService.getUploadErrorSeq(guer);
			if (seq != null) {
				uer.setSeqIndex(seq);
				uer.setTblNm(tableId);
				uer.setErrorDesc(errorMsg);

				systemOperationService.setUploadError(uer);
			}
		}

		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : setReExcelUpload
	 * @date : 2016. 10. 20.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description :엑셀업로드 임시테이블에서 Main테이블로 저장
	 */
	@RequestMapping(value = "/setReExcelUpload.do", method = RequestMethod.POST)
	public @ResponseBody KprExcelUploadResDto setReExcelUpload(HttpServletRequest request, HttpServletResponse response, @RequestBody KprExcelUpLoadReqDto eur) {
		LogUtil.param(KprOperationController.class, eur);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		eur.setCreateBy(loginInfo.getId());
		eur.setModifyBy(loginInfo.getId());

		return systemOperationService.setReExcelUpload(eur);
	}

	/**
	 * 
	 * @programId :
	 * @name : getExcelUpResultList
	 * @date : 2016. 10. 20.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 업로드 결과 조회 ID기준
	 */
	@RequestMapping(value = "/getExcelUpResultList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getExcelUpResultList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprExcelUpLoadReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getExcelUpResultList(dir);

		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : getExcelUpResult
	 * @date : 2016. 10. 20.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 업로드 결과 조회 ACCNT_ID 기준
	 */
	@RequestMapping(value = "/getExcelUpResult.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getExcelUpResult(HttpServletRequest request, HttpServletResponse response, @RequestBody KprExcelUpLoadReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getExcelUpResult(dir);

		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : getUploadErrorList
	 * @date : 2016. 10. 20.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description :업로드 오류내역 조회
	 */
	@RequestMapping(value = "/getUploadErrorList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto getUploadErrorList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprExcelUpLoadReqDto dir) {
		LogUtil.param(KprOperationController.class, dir);

		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);

		GridPagingResDto rtnValue = new GridPagingResDto();
		rtnValue = systemOperationService.getUploadErrorList(dir);

		return rtnValue;
	}

	/**
	 * 
	 * @programId :
	 * @name : formatTime
	 * @date : 2016. 10. 20.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description : 날짜포맷설정
	 */
	public String formatTime(long lTime) {
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(lTime);
		return String.format("%02d%02d%02d", c.get(Calendar.HOUR_OF_DAY), c.get(Calendar.MINUTE), c.get(Calendar.SECOND));
	}

	/**
	 * 
	 * @programId :
	 * @name : isStringInteger
	 * @date : 2016. 10. 26.
	 * @author : 이원준
	 * @table :
	 * @return :
	 * @description :숫자형식 체크
	 */
	public Boolean isStringInteger(String str) {
		try {
			Integer.parseInt(str);
			return true;
		} catch (NumberFormatException e) {
			LogUtil.error(e);
			failCnt++;
			errorMessages.add("JAVA Error : " + e.getMessage());

			return false;
		}
	}

	/**
	 * @programId :
	 * @name : getTableColListByType
	 * @date : 2017. 7. 25.
	 * @author : jh.kim
	 * @table :
	 * @return : List<KprGetTableColListResDto>
	 * @description : 테이블의 타입별 컬럼 목록 조회
	 */
	@RequestMapping(value = "/getTableColListByType.do", method = RequestMethod.POST)
	public @ResponseBody List<KprGetTableColListResDto> getTableColListByType(HttpServletRequest request, HttpServletResponse response, @RequestBody KprGetTableColListReqDto param) {
		LogUtil.param(KprOperationController.class, param);

		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		List<KprGetTableColListResDto> rtnList = systemOperationService.getTableColListByType(param);

		return rtnList;
	}

	/**
	 * @programId :
	 * @name : editTableColConvert
	 * @date : 2017. 7. 26.
	 * @author : jh.kim
	 * @table :
	 * @return : KPReditTableColConvertResponseDTO
	 * @description : 테이블의 컬럼의 col type cd 값을 일괄 변환한다.
	 */
	@RequestMapping(value = "/editTableColsType.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editTableColsType(HttpServletRequest request, HttpServletResponse response, @RequestBody KprEditTableColConvertReqDto param) {
		LogUtil.param(KprOperationController.class, param);

		param.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnDto = systemOperationService.editTableColsType(param);

		return rtnDto;
	}
	
	/**
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getMetaServiceList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprDrillDownGroupResDto> getMetaServiceList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return KPRDrillDownGroupService.getMetaServiceList(reqDto);
	}
	
	/**
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getMetaTableColumnList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprDrillDownGroupResDto> getMetaTableColumnList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return KPRDrillDownGroupService.getMetaTableColumnList(reqDto);
	}
	
	/**
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/getDrillDownGroupList.do", method = RequestMethod.POST)
	public @ResponseBody List<KprDrillDownGroupResDto> getDrillDownGroupList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return KPRDrillDownGroupService.getDrillDownGroupList(reqDto);
	}
	
	/**
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/addDrillDownGroup.do", method = RequestMethod.POST)
	public @ResponseBody List<KprDrillDownGroupResDto> addDrillDownGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return KPRDrillDownGroupService.addDrillDownGroup(reqDto);
	}
	
	/**
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/editDrillDownGroup.do", method = RequestMethod.POST)
	public @ResponseBody List<KprDrillDownGroupResDto> editDrillDownGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return KPRDrillDownGroupService.editDrillDownGroup(reqDto);
	}
	
	/**
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */
	@RequestMapping(value = "/removeDrillDownGroup.do", method = RequestMethod.POST)
	public @ResponseBody List<KprDrillDownGroupResDto> removeDrillDownGroup(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDrillDownGroupReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return KPRDrillDownGroupService.removeDrillDownGroup(reqDto);
	}
	
	/**
	 * @programId : ANL_TBL_P06
	 * @name : setTableImport
	 * @date : 2017. 12. 20.
	 * @author : 이기오
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 테이블 정보 불러오기
	 */
	@RequestMapping(value = "/saveTableImport.do", method = RequestMethod.POST)
	public @ResponseBody KprTableResDto saveTableImport(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSetTableListReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		return systemOperationService.saveTableImport(reqDto);
	}

	/**
	 * @programId : 
	 * @name : getDatabaseUseSchema
	 * @date : 2017. 12. 20.
	 * @author : 이기오
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 대상 데이터베이스 스키마 리스트 조회
	 */
	@RequestMapping(value = "/getDatabaseUseSchema.do", method = RequestMethod.POST)
	public @ResponseBody KprDatabaseUseSchemaResDto getDatabaseUseSchema(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDatabaseUseSchemaReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		return systemOperationService.getDatabaseUseSchema(reqDto);
	}
	
	/**
	 * @programId : 
	 * @name : getDatabaseUseSchema
	 * @date : 2017. 12. 20.
	 * @author : 이기오
	 * @table : anl.anl_table_mst
	 * @return :
	 * @description : 대상 데이터베이스 스키마 리스트 조회
	 */
	@RequestMapping(value = "/saveDatabaseUseSchemaList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveDatabaseUseSchemaList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprDatabaseUseSchemaReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		return systemOperationService.saveDatabaseUseSchemaList(reqDto);
	}
	
	/**
	 * @programId : 
	 * @name : getDatabaseConCheck
	 * @date : 2020. 03. 27.
	 * @author : yj.choi
	 * @table : 
	 * @return :
	 * @description : 데이터베이스 연결확인
	 */
	@RequestMapping(value = "/getDatabaseConCheck.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto getDBConCheck(HttpServletRequest request, HttpServletResponse response, @RequestBody KprOperationListReqDto reqDto) {
		LogUtil.param(KprOperationController.class, reqDto);

		// 로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = authHelper.checkLoginSession(request, response);
		reqDto.setCreateBy(loginInfo.getId());
		reqDto.setModifyBy(loginInfo.getId());

		return systemOperationService.getDBConCheck(reqDto);
	}
	
}