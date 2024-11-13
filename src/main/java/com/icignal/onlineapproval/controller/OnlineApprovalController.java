package com.icignal.onlineapproval.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.onlineapproval.dto.request.ApprovalAdminDetailReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalAdminListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalDetailReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalEmpListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalEmpReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalInsertReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalUpdateReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemDeleteReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemInsertReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemRejectReqDto;
import com.icignal.onlineapproval.dto.request.ApprvReqReqDto;
import com.icignal.onlineapproval.dto.request.AprvCountReqDto;
import com.icignal.onlineapproval.dto.request.AprvReportReqDto;
import com.icignal.onlineapproval.dto.request.CommonApprovalReqDto;
import com.icignal.onlineapproval.dto.response.ApprovalAdminDetailResDto;
import com.icignal.onlineapproval.dto.response.ApprovalAdminListResDto;
import com.icignal.onlineapproval.dto.response.ApprovalDetailResDto;
import com.icignal.onlineapproval.dto.response.ApprovalEmpListResDto;
import com.icignal.onlineapproval.dto.response.ApprovalEmpResDto;
import com.icignal.onlineapproval.dto.response.ApprovalListResDto;
import com.icignal.onlineapproval.dto.response.ApprvCamListResDto;
import com.icignal.onlineapproval.dto.response.ApprvReqResDto;
import com.icignal.onlineapproval.dto.response.AprvCountResDto;
import com.icignal.onlineapproval.dto.response.AprvReportCampaignResDto;
import com.icignal.onlineapproval.dto.response.AprvReportResDto;
import com.icignal.onlineapproval.service.OnlineApprovalService;



/**
 * @name : 전자 결제 승인 Controller
 * @date : 2015. 9. 21.
 * @author 박지열
 * @description : 전자 결제 승인 서비스 컨트롤러
 */
@Controller
@RequestMapping("/onlineApproval")
public class OnlineApprovalController extends BaseController {
	@Autowired
	private OnlineApprovalService onlineApprovalService;

	/**
     * @programId : MKT_MNG_P02
     * @name : getCampaignDefaultInfo
     * @date : 2015. 10. 16.
     * @author : dg.ryu
     * @table :
     * @return :
     * @description : 캠페인 기본 정보
     */
    @RequestMapping(value="/getCampaignDefaultInfo.do", method = RequestMethod.POST)
	public @ResponseBody
	AprvReportCampaignResDto getCampaignDefaultInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody AprvReportReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        LoginResDto loginInfo = this.checkLoginSession(request, response);
        mcr.setLoginInfo(loginInfo);

        return onlineApprovalService.getCampaignDefaultInfo(mcr);
    }
	
	/**
	 * @programId : MKT_APR_002
	 * @name : setApproval
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : el_approval (전자결제 승인 정보 관리 테이블)
	 * @return : StatusResDto
	 * @description : 전자결제 등록 - 신규 버튼 클릭 후 전자 결제 등록
	 */
	@RequestMapping(value = "/setApproval.do")
	public @ResponseBody
	StatusResDto setApproval(
	        HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalInsertReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
				
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getId());

		return onlineApprovalService.setApproval(mer);
	}
	
	/**
	 * @programId : MKT_APR_P02
	 * @name : setItemApproval
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_elec_aprv_item (전자결제 승인자 관리 테이블)
	 * @return : StatusResDto
	 * @description : 전자결제 등록 -전자 결제 승인자 등록
	 */
	@RequestMapping(value = "/setItemApproval.do")
	public @ResponseBody
	StatusResDto setItemApproval(HttpServletRequest request, HttpServletResponse response, @RequestBody ApproverItemInsertReqDto mir) {
		LogUtil.param(OnlineApprovalController.class, mir);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mir.setMemId(loginInfo.getId());

		return onlineApprovalService.setItemApproval(mir);
	}
	
	/**
	 * @name : setRequiredItemApproval
	 * @date : 2018. 03. 03.
	 * @author : hy.jun
	 * @table : mkt_elec_aprv_item (전자결제 승인자 관리 테이블)
	 * @return : StatusResDto
	 * @description : 전자결제 등록 -전자 결제 승인자 등록 완료 후 필수 결재 승인자 추가 (필수 결재 승인자는 공통코드로 관리.MKT_EL_APPROVAL_REQUIRED)
	 */
	@RequestMapping(value = "/setRequiredItemApproval.do")
	public @ResponseBody
	StatusResDto setRequiredItemApproval(HttpServletRequest request, HttpServletResponse response, @RequestBody ApproverItemInsertReqDto mir) {
		LogUtil.param(OnlineApprovalController.class, mir);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mir.setMemId(loginInfo.getId());
		
		return onlineApprovalService.setRequiredItemApproval(mir);
	}
	
	/**
	 * @programId : MKT_APR_002
	 * @name : getCampaign
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : el_approval (전자결제 승인 정보 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 자결제 등록 - 캠페인 검색
	 */
	@RequestMapping(value = "/getCampaign.do") 
	public @ResponseBody
	GridPagingResDto<ApprvCamListResDto> getCampaign(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprvReqReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//mer.setStrAuthDataIn(this.getSessionAuthority(request));
		//세션에 저장되어 있는 지원의 아이디를 셋팅

		return onlineApprovalService.getCampaign(mer);
	}

	/**
	 * @programId : MKT_APR_001
	 * @name : selectApproverStatus
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_elec_aprv_item (전자결제 승인 정보 관리 테이블)
	 * @return : List<MKTApprvReqResponseDTO>
	 * @description : 전자결제  승인상태 조회
	 */
	@RequestMapping(value = "/getApproverStatus.do") 
	public @ResponseBody
	List<ApprvReqResDto> getApproverStatus(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprvReqReqDto mer) {
        LogUtil.param(OnlineApprovalController.class, mer);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        //LoginResDto loginInfo = 
        this.checkLoginSession(request, response);
        
        //세션에 저장되어 있는 지원의 아이디를 셋팅
        //mer.setAccntId(loginInfo.getAccountOrgId());

		return onlineApprovalService.getApproverStatus(mer);
	}
	
	/**
	 * @programId : MKT_APR_P02
	 * @name : getApproverList
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : employee (직원 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 결제자 등록 - 결제자 조회
	 */
	@RequestMapping(value = "/getApproverList.do") 
	public @ResponseBody
	GridPagingResDto<ApprovalEmpListResDto> getApproverList(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalEmpListReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅

		return onlineApprovalService.getApproverList(mer);
	}
	
	/**
	 * @programId : MKT_APR_P02
	 * @name : getAprvList
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : mkt_elec_aprv_item (결재 승인자 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 결재 승인자 조회
	 */
	@RequestMapping(value = "/getAprvList.do")  
	public @ResponseBody
	List<ApprvReqResDto> getAprvList(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprvReqReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		response.setContentType("application/json");
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		
		return onlineApprovalService.getAprvList(mer);
	}
	
	/**
	 * @programId : MKT_APR_P02
	 * @name : getReftAprvList
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : mkt_elec_aprv_item (결재 승인자 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 결재 승인자 조회
	 */
	@RequestMapping(value = "/getReftAprvList.do") 
	public @ResponseBody
	List<ApprvReqResDto> getReftAprvList(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprvReqReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅

		return onlineApprovalService.getReftAprvList(mer);
	}
	
	/**
	 * @programId : MKT_APR_001
	 * @name : getMyElapproval
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 내가 승인 요청한 캠페인 조회
	 */
	@RequestMapping(value = "/getMyElapproval.do") 
	public @ResponseBody
	GridPagingResDto<ApprovalListResDto> getMyElapproval(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalListReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getEmpId());

		return onlineApprovalService.getMyElapproval(mer);
	}
	
	/**
	 * @programId : MKT_APR_001
	 * @name : getRefElapproval
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 내가 참조된 캠페인 목록 조회
	 */
	@RequestMapping(value = "/getRefElapproval.do") 
	public @ResponseBody
	GridPagingResDto<ApprovalListResDto> getRefElapproval(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalListReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getEmpId());

		return onlineApprovalService.getRefElapproval(mer);
	}
	
	/**
	 * @programId : MKT_APR_001
	 * @name : getMyElapproval2
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 내가 승인할 캠페인 목록 조회
	 */
	@RequestMapping(value = "/getMyElapproval2.do") 
	public @ResponseBody
	GridPagingResDto<ApprovalListResDto> getMyElapproval2(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalListReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getEmpId());

		return onlineApprovalService.getMyElapproval2(mer);
	}
	
	/**
	 * @programId : MKT_APR_002
	 * @name : getDetailAprv
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
	 * @return : MKTElapprovalDetailResponseDTO
	 * @description : 전자결재 정보 조회
	 */
	@RequestMapping(value = "/getDetailAprv.do") 
	public @ResponseBody GridPagingResDto<ApprovalDetailResDto> getDetailAprv(
	        HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalDetailReqDto mer) {
        LogUtil.param(OnlineApprovalController.class, mer);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        
        //세션에 저장되어 있는 지원의 아이디를 셋팅
        
        return onlineApprovalService.getDetailAprv(mer);
    }
	
	
	
	/**
	 * @programId : MKT_APR_002
	 * @name : getMember
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : employee (직원 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 기안자 및 기안자 부서 조회
	 */
	@RequestMapping(value = "/getMember.do") 
	public @ResponseBody
	ApprovalEmpResDto getMember(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalEmpReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		mer.setMemId(loginInfo.getId());

		return onlineApprovalService.getMember(mer);
	}

	/**
	 * @programId : MKT_APR_P02
	 * @name : removeItem
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : mkt_elec_aprv_item (결재 승인자 관리 테이블)
	 * @return : StatusResDto
	 * @description : 결재 승인자 삭제
	 */
	@RequestMapping(value = "/removeItem.do") 
	public @ResponseBody
	StatusResDto removeItem(HttpServletRequest request, HttpServletResponse response, @RequestBody ApproverItemDeleteReqDto mid) {
		LogUtil.param(OnlineApprovalController.class, mid);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		mid.setMemId(loginInfo.getId());

		return onlineApprovalService.removeItem(mid);
	}

	
	
	
	/**
	 * @programId : MKT_APR_002
	 * @name : getRefApproverCount
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : el_approval (전자결제 승인 정보 관리 테이블)
	 * @return : List<MKTElapprovalResponseDTO>
	 * @description : 결제 참조자 등록자 조회 - 결제 참조자가 5명 이상인지 조회(5명 이상 추가 불가)
	 */
	/*
	 * @RequestMapping(value = "/getRefApproverCount.do") public @ResponseBody
	 * List<MKTElapprovalResponseDTO> getRefApproverCount(HttpServletRequest
	 * request,HttpServletResponse response, @RequestBody
	 * MKTElapprovalRequestDTO mer){
	 * LogUtil.param(MKTElApporvalController.class, mer);
	 * 
	 * //로그인 여부 체크 this.checkLoginSession(request, response);
	 * 
	 * return onlineApprovalService.getRefApproverCount(mer);
	 * 
	 * }
	 */

	/**
	 * @programId : MKT_APR_002
	 * @name : getApproverCount
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : el_approval (전자결제 승인 정보 관리 테이블)
	 * @return : List<MKTElapprovalResponseDTO>
	 * @description : 결제 승인자 등록자 조회 - 결제 승인자가 5명 이상인지 조회(5명 이상 추가 불가)
	 */
	/*
	 * @RequestMapping(value = "/getApproverCount.do") public @ResponseBody
	 * List<MKTElapprovalResponseDTO> getApproverCount(HttpServletRequest
	 * request,HttpServletResponse response, @RequestBody
	 * MKTElapprovalRequestDTO mer){
	 * LogUtil.param(MKTElApporvalController.class, mer);
	 * 
	 * //로그인 여부 체크 this.checkLoginSession(request, response);
	 * 
	 * return onlineApprovalService.getApproverCount(mer); }
	 */


	
	/**
	 * @programId : MKT_APR_002
	 * @name : editElapproval
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_elec_aprv (전자결제 관리 테이블)
	 * @return : StatusResDto
	 * @description : 결제 결제 수정  - 전자 결제 선택후 선택한 정보 수정
	 */
	@RequestMapping(value = "/editElapproval.do")
	public @ResponseBody
	StatusResDto editElapproval(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalUpdateReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
										
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getId());

		return onlineApprovalService.editElapproval(mer);
	}
	
	/**
	 * @programId : MKT_APR_001
	 * @name : editReject
	 * @date : 2015. 12. 02.
	 * @author : 박지열
	 * @table : mkt_elec_aprv (전자결제 관리 테이블)
	 * @return : StatusResDto
	 * @description : 결제 결제 반려
	 */
	@RequestMapping(value = "/editReject.do")
	public @ResponseBody
	StatusResDto editReject(
	        HttpServletRequest request, HttpServletResponse response, @RequestBody ApproverItemRejectReqDto majr) {
		LogUtil.param(OnlineApprovalController.class, majr);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		majr.setLoginInfo(loginInfo);
		majr.setMemId(loginInfo.getId());
		majr.setApvrId(loginInfo.getEmpId());

		return onlineApprovalService.editReject(majr);
	}
	
	/**
	 * @programId : MKT_APR_P02
	 * @name : editAprvType
	 * @date : 2015. 12. 02.
	 * @author : 박지열
	 * @table : mkt_elec_aprv (전자결제 관리 테이블)
	 * @return : StatusResDto
	 * @description : 결제 결제 유형 수정 - 전자 결제 상신/상신 취소/작성 중 등등에 따른 유형 변경
	 */
	@RequestMapping(value = "/editAprvType.do")
	public @ResponseBody
            StatusResDto editAprvType(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalUpdateReqDto meur) {
        LogUtil.param(OnlineApprovalController.class, meur);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        
        //세션에 저장되어 있는 지원의 아이디를 셋팅
        meur.setMemId(loginInfo.getId());
        StatusResDto rtnDto = onlineApprovalService.editAprvType(meur);
        return rtnDto;
    }
	
	
	/**
	 * @programId : MKT_APR_002
	 * @name : removeElapproval
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : el_approval (전자결제 승인 정보 관리 테이블)
	 * @return : StatusResDto
	 * @description : 결제 결제 삭제
	 */
	@RequestMapping(value = "/removeElapproval.do")
	public @ResponseBody
	StatusResDto removeElapproval(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		mer.setLoginInfo(loginInfo);
		
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getId());
	
		return onlineApprovalService.removeElapproval(mer);
	}
	
	/**
	 * @programId : MKT_APR_002
	 * @name : getMyAprvCount
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : el_approval (전자결제 승인 정보 관리 테이블)
	 * @return : StatusResDto
	 * @description : 전자 결제 승인 건수 카운트
	 */
	@RequestMapping(value = "/getMyAprvCount.do")
	public @ResponseBody
	AprvCountResDto getMyAprvCount(HttpServletRequest request, HttpServletResponse response, @RequestBody AprvCountReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getEmpId());
		
	
		return onlineApprovalService.getMyAprvCount(mer);
	}
	
	/**
	 * @programId : MKT_APR_002
	 * @name : getMyAprvCount
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : el_approval (전자결제 승인 정보 관리 테이블)
	 * @return : StatusResDto
	 * @description : 전자 결제 승인 건수 카운트(내가 승인할 목록)
	 */
	@RequestMapping(value = "/getMyAgreeCount.do")
	public @ResponseBody
	AprvCountResDto getMyAgreeCount(HttpServletRequest request, HttpServletResponse response, @RequestBody AprvCountReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getEmpId());
		
	
		return onlineApprovalService.getMyAgreeCount(mer);
	}
	
	/**
	 * @programId : MKT_APR_002
	 * @name : getMyAprvCount
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : el_approval (전자결제 승인 정보 관리 테이블)
	 * @return : StatusResDto
	 * @description : 전자 결제 승인 건수 카운트(내가 참조된 목록)
	 */
	@RequestMapping(value = "/getMyRefCount.do")
	public @ResponseBody
	AprvCountResDto getMyRefCount(HttpServletRequest request, HttpServletResponse response, @RequestBody AprvCountReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		mer.setMemId(loginInfo.getEmpId());
		
		return onlineApprovalService.getMyRefCount(mer);
	}
	
	
	/**
	 * @programId : MKT_APR_P02
	 * @name : editItem
	 * @date : 2015. 11. 30.
	 * @author : 박지열
	 * @table : mkt_elec_aprv_item (결재 승인자 관리 테이블)
	 * @return : StatusResDto
	 * @description : 결재 승인자 업데이트
	 */
	@RequestMapping(value = "/editItem.do") 
	public @ResponseBody
	StatusResDto editItem(HttpServletRequest request, HttpServletResponse response, @RequestBody ApproverItemDeleteReqDto mid) {
		LogUtil.param(OnlineApprovalController.class, mid);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		mid.setMemId(loginInfo.getId());

		return onlineApprovalService.editItem(mid);
	}
	
	
	@RequestMapping(value = "/requestApproval.do") 
	public @ResponseBody
	StatusResDto requestApproval(HttpServletRequest request, HttpServletResponse response, @RequestBody CommonApprovalReqDto param) {
		LogUtil.param(OnlineApprovalController.class, param);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		param.setReqRid(loginInfo.getEmpId());

		return onlineApprovalService.requestApproval(param);
	}
	
	
	
	@RequestMapping(value = "/getApprovalAdminList.do") 
	public @ResponseBody
	GridPagingResDto<ApprovalAdminListResDto> getApprovalAdminList(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalAdminListReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);		
				
		mer.setLoginInfo(this.checkLoginSession(request, response));	

		return onlineApprovalService.getApprovalAdminList(mer);
	}
	
	
	
	
	/**
	* @programId :
	* @name : getApprovalAdminDetail
	* @date : 2017. 11. 7.
	* @author : 이성원
	* @table :
	* @return : MKTApprovalAdminDetailResponseDTO
	* @description :
	*/
	@RequestMapping(value = "/getApprovalAdminDetail.do") 
	public @ResponseBody
	ApprovalAdminDetailResDto getApprovalAdminDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalAdminDetailReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);		
				
		mer.setLoginInfo(this.checkLoginSession(request, response));	

		return onlineApprovalService.getApprovalAdminDetail(mer);
	}
	
	
	
	
	/**
	* @programId :
	* @name : saveApprovalAdminDetail
	* @date : 2017. 11. 7.
	* @author : 이성원
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	@RequestMapping(value = "/saveApprovalAdminDetail.do") 
	public @ResponseBody
	StatusResDto saveApprovalAdminDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalAdminDetailReqDto param) {
		LogUtil.param(OnlineApprovalController.class, param);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		param.setLoginInfo(this.checkLoginSession(request, response));	
						
		

		return onlineApprovalService.saveApprovalAdminDetail(param);
	}
	
	
	
	/**
	* @programId :
	* @name : editApprovalAdminDetail
	* @date : 2017. 11. 7.
	* @author : 이성원
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	@RequestMapping(value = "/editApprovalAdminDetail.do") 
	public @ResponseBody
	StatusResDto editApprovalAdminDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalAdminDetailReqDto param) {
		LogUtil.param(OnlineApprovalController.class, param);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		param.setLoginInfo(this.checkLoginSession(request, response));	

		return onlineApprovalService.editApprovalAdminDetail(param);
	}
	
	@RequestMapping(value = "/deleteApprovalAdminDetail.do") 
	public @ResponseBody
	StatusResDto deleteApprovalAdminDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalAdminDetailReqDto param) {
		LogUtil.param(OnlineApprovalController.class, param);
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		param.setLoginInfo(this.checkLoginSession(request, response));	

		return onlineApprovalService.deleteApprovalAdminDetail(param);
    }
	
    /**
     * 캠페인 결제 상신
     * 
     * @programId : 
     * @name : campaignRequestApproval
     * @date : 2017. 12. 27.
     * @author : jh.kim
     * @table : 
     * @return : StatusResDto
     * @description : 
     */
    @RequestMapping(value = "/campaignRequestApproval.do")
    public @ResponseBody StatusResDto campaignRequestApproval(
            HttpServletRequest request, HttpServletResponse response, @RequestBody CommonApprovalReqDto param) {
        LogUtil.param(OnlineApprovalController.class, param);
        
        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        param.setReqRid(loginInfo.getEmpId());
        
        return onlineApprovalService.campaignRequestApproval(param);
    }
    
    /**
     * 승인을 위한 캠페인 전체 정보 조회
     * 
     * @programId : 
     * @name : getCampaignReport
     * @date : 2018. 2. 28.
     * @author : jh.kim
     * @table : 
     * @param request
     * @param response
     * @param param
     * @return
     * @description : 
     */
    @RequestMapping(value = "/getCampaignReportInfo.do")
    public @ResponseBody AprvReportResDto getCampaignReportInfo(
            HttpServletRequest request, HttpServletResponse response, @RequestBody AprvReportReqDto param) {

        //로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
        LoginResDto loginInfo = this.checkLoginSession(request, response);
        param.setLoginInfo(loginInfo);
        
        return onlineApprovalService.getCampaignReportInfo(param);
    }

	/**
	 * @programId : MKT_APR_P02
	 * @name : getApproverList
	 * @date : 2022. 03. 03.
	 * @author : 정수지
	 * @table : employee (직원 관리 테이블)
	 * @return : GridPagingResponseDTO
	 * @description : 결제자 등록 - 결제자 조회
	 */
	@RequestMapping(value = "/getStoreManagerInfo.do")
	public @ResponseBody
	GridPagingResDto<ApprovalEmpListResDto> getStoreManagerInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody ApprovalEmpListReqDto mer) {
		LogUtil.param(OnlineApprovalController.class, mer);

		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);

		//세션에 저장되어 있는 지원의 아이디를 셋팅

		return onlineApprovalService.getStoreManagerInfo(mer);
	}
}