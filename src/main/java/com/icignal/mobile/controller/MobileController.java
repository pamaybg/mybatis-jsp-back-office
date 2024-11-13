package com.icignal.mobile.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.mobile.dto.request.MktMobileCampaginReqDto;
import com.icignal.mobile.dto.response.MktCampaignApprovalReqListResDto;
import com.icignal.mobile.service.MobileService;
import com.icignal.onlineapproval.dto.request.ApprovalUpdateReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemRejectReqDto;
import com.icignal.onlineapproval.service.OnlineApprovalService;

@Controller
@RequestMapping("/mobile")
@CrossOrigin(originPatterns = "*", allowedHeaders = "*")
public class MobileController extends BaseController{
	
	@Autowired
	private MobileService mobileService;
	
	@Autowired
	private OnlineApprovalService onlineApprovalService;
	
	/**
	 * 모바일 캠페인 승인 대상 리스트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	@RequestMapping(value="/getCampaginApprovalReqList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktCampaignApprovalReqListResDto> getCampaginApprovalReqList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktMobileCampaginReqDto reqDto) {
		LogUtil.param(MobileController.class,reqDto);	
		
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
						
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		reqDto.setMemId(loginInfo.getEmpId());
		//테스트용
		//reqDto.setMemId("792ED781B353418CB6D5B73D131A3D28");
		
		return mobileService.getCampaginApprovalReqList(reqDto);
	}
	
	/**
	 * 모바일 캠페인 승인
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	@RequestMapping(value="/setCampaginApproval.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCampaginApproval(HttpServletRequest request, HttpServletResponse response, @RequestBody MktMobileCampaginReqDto reqDto) {
		LogUtil.param(MobileController.class,reqDto);	
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		ApproverItemRejectReqDto editRejectReqDto = new ApproverItemRejectReqDto();
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		editRejectReqDto.setLoginInfo(loginInfo);
		editRejectReqDto.setMemId(loginInfo.getId());
		editRejectReqDto.setApvrId(loginInfo.getEmpId());
		editRejectReqDto.setId(reqDto.getElecAprvId());
		editRejectReqDto.setSeq(reqDto.getSeq());
		editRejectReqDto.setAprvType("01");
		editRejectReqDto.setApprovalTypeCd(reqDto.getApvrTypeCd());
		editRejectReqDto.setRecordRid(reqDto.getRecordRid());
		editRejectReqDto.setItemId(reqDto.getItemId());
		//승인
		editRejectReqDto.setStatusCode("014");
		editRejectReqDto.setElecAprvStatusCd("090");
		editRejectReqDto.setElecAprvTitle(reqDto.getCamNm());
		
		StatusResDto resDto = onlineApprovalService.editReject(editRejectReqDto);
		
		//최종 결제 시 서비스 호풀
		if (reqDto.getApvrTypeCd().equals("9")) {
			ApprovalUpdateReqDto approvalUpdateReqDto = new ApprovalUpdateReqDto(); 
			approvalUpdateReqDto.setElecAprvStatusCd(editRejectReqDto.getElecAprvStatusCd());
			approvalUpdateReqDto.setId(editRejectReqDto.getId());
			approvalUpdateReqDto.setAprvType(editRejectReqDto.getApprovalTypeCd());
			approvalUpdateReqDto.setRecordRid(editRejectReqDto.getRecordRid());
			
			resDto = onlineApprovalService.editAprvType(approvalUpdateReqDto);
		}
			
		return resDto;
	}
	
	/**
	 * 모바일 캠페인 반려
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	@RequestMapping(value="/setCampaginReject.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto setCampaginReject(HttpServletRequest request, HttpServletResponse response, @RequestBody MktMobileCampaginReqDto reqDto) {
		LogUtil.param(MobileController.class,reqDto);	
		//로그인 여부 체크 - 세션에서 유저 정보를 조회 하여 없을 경우 권한없음 에러 리턴
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		ApproverItemRejectReqDto editRejectReqDto = new ApproverItemRejectReqDto();
		//세션에 저장되어 있는 지원의 아이디를 셋팅
		editRejectReqDto.setLoginInfo(loginInfo);
		editRejectReqDto.setMemId(loginInfo.getId());
		editRejectReqDto.setApvrId(loginInfo.getEmpId());
		editRejectReqDto.setId(reqDto.getElecAprvId());
		editRejectReqDto.setSeq(reqDto.getSeq());
		editRejectReqDto.setAprvType("01");
		editRejectReqDto.setApprovalTypeCd(reqDto.getApvrTypeCd());
		editRejectReqDto.setRecordRid(reqDto.getRecordRid());	
		editRejectReqDto.setItemId(reqDto.getItemId());
		//반려
		editRejectReqDto.setStatusCode("021");
		editRejectReqDto.setElecAprvStatusCd("020");
		editRejectReqDto.setRejectRsn(reqDto.getRejectDesc());
		editRejectReqDto.setElecAprvTitle(reqDto.getCamNm());

		StatusResDto resDto = onlineApprovalService.editReject(editRejectReqDto);
		
		//최종 결제 시 서비스 호풀
		if (reqDto.getApvrTypeCd().equals("9")) {
			ApprovalUpdateReqDto approvalUpdateReqDto = new ApprovalUpdateReqDto(); 
			approvalUpdateReqDto.setElecAprvStatusCd(editRejectReqDto.getElecAprvStatusCd());
			approvalUpdateReqDto.setId(editRejectReqDto.getId());
			approvalUpdateReqDto.setAprvType(editRejectReqDto.getApprovalTypeCd());
			approvalUpdateReqDto.setRecordRid(editRejectReqDto.getRecordRid());
			
			resDto = onlineApprovalService.editAprvType(approvalUpdateReqDto);
		}		
		return resDto;
	}	
	
}