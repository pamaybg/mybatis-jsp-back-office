package com.icignal.loyalty.operationpolicymgt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
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
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.operationpolicymgt.dto.request.OperationPolicyDetailReqDto;
import com.icignal.loyalty.operationpolicymgt.dto.request.OperationPolicyReqDto;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyDetailResDto;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyResDto;
import com.icignal.loyalty.operationpolicymgt.service.OperationPolicyMgtService;
import com.icignal.loyalty.product.dto.response.LoyPgmListResDto;

@Controller
@RequestMapping("/loyalty/operationpolicymgt") 		// BaseController를 상속해서 컨트롤러를 만들어야, icignal 시스템 식 url 호출을 할 수 있음
public class OperationPolicyMgtController extends BaseController { 
	
	@Autowired
	private OperationPolicyMgtService operationPolicyMgtService;
	
		
	@RequestMapping(value="/getOperationPolicyList.do", method=RequestMethod.POST)
	@ResponseBody
	public GridPagingResDto<OperationPolicyResDto> getOperationPolicyList(@RequestBody OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);

		return operationPolicyMgtService.getOperationPolicyList(opDto);
	} 
	
	
	//getOperationPolicyDetailList1
	@RequestMapping(value="/getOperationPolicyDetail1.do", method=RequestMethod.POST)
	@ResponseBody
	public GridPagingResDto<OperationPolicyDetailResDto> getOperationPolicyDetailList1(@RequestBody OperationPolicyDetailReqDto opdDto) {
		LogUtil.param(this.getClass(), opdDto);

		return operationPolicyMgtService.getOperationPolicyDetail1(opdDto);
	}
	@RequestMapping(value="/getOperationPolicyDetail2.do", method=RequestMethod.POST)
	@ResponseBody
	public GridPagingResDto<OperationPolicyDetailResDto> getOperationPolicyDetailList2(@RequestBody OperationPolicyDetailReqDto opdDto) {
		LogUtil.param(this.getClass(), opdDto);

		return operationPolicyMgtService.getOperationPolicyDetail2(opdDto);
	}
	
	
	@RequestMapping(value="/addOperationPolicy.do", method=RequestMethod.POST)
	public @ResponseBody StatusResDto addOperationPolicy(HttpServletRequest request, HttpServletResponse response, @RequestBody OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// 로그인 사용자의 정보 초기화
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		opDto.setLoginInfo(loginInfo);
		
		return operationPolicyMgtService.addOperationPolicy(opDto);
	}

	@RequestMapping(value="/updateOperationPolicy.do", method=RequestMethod.POST) 
	public @ResponseBody StatusResDto updateOperationPolicy(HttpServletRequest request, HttpServletResponse response, @RequestBody OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// 로그인 사용자의 정보 초기화
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		opDto.setLoginInfo(loginInfo);
		
		return operationPolicyMgtService.updateOperationPolicy(opDto);
	}
	
	@RequestMapping(value="/getOperationPolicyPop.do", method=RequestMethod.POST)
	@ResponseBody
	public OperationPolicyResDto getOperationPolicyPop(@RequestBody OperationPolicyReqDto opDto) { 
		LogUtil.param(this.getClass(), opDto);
			
		OperationPolicyResDto rtnValue = new OperationPolicyResDto();
		rtnValue = operationPolicyMgtService.getOperationPolicyPop(opDto);
				
		return rtnValue;
	} 
	
	
	@RequestMapping(value="/deleteOperationPolicy.do", method=RequestMethod.POST) 
	public @ResponseBody StatusResDto deleteOperationPolicy(HttpServletRequest request, HttpServletResponse response, @RequestBody OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		
		return operationPolicyMgtService.deleteOperationPolicy(opDto);
	}
	
	@RequestMapping(value="/getOprDtlHist.do", method=RequestMethod.POST)
	@ResponseBody
	public GridPagingResDto<OperationPolicyDetailResDto> getOprDtlHist(@RequestBody OperationPolicyDetailReqDto opdDto) {
		LogUtil.param(this.getClass(), opdDto);

		return operationPolicyMgtService.getOprDtlHist(opdDto);
	}
      
	
      /**
   	 *
   	 * @programId : 
   	 * @name : addOperationPolicyDetail
   	 * @date : 2020. 12. 28.
   	 * @author : jb.kim
   	 * @table : LOY.LOY_OPR_PLCY_DTL
   	 * @return : StatusResDto
   	 * @description : '정책속성값' 데이터 / '세부사항' 데이터 insert + 히스토리 기록
   	 */
  	@RequestMapping(value="/addOperationPolicyDetail.do", method=RequestMethod.POST)
  	public @ResponseBody StatusResDto addOperationPolicyDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody OperationPolicyDetailReqDto opDto) {
  		LogUtil.param(this.getClass(), opDto);
  		// 로그인 사용자의 정보 초기화
  		LoginResDto loginInfo = this.checkLoginSession(request, response);
  		opDto.setLoginInfo(loginInfo);
  		
  		return operationPolicyMgtService.addOperationPolicyDetail(opDto); // insert 및 history 기록 을 수행한 결과를 리턴
  	}
	
  	
  	 /**
  	 *
  	 * @programId : 
  	 * @name : getOprPlcyDetailBeforeUpdate
  	 * @date : 2020. 12. 29.
  	 * @author : jb.kim
  	 * @table : LOY.LOY_OPR_PLCY_DTL
  	 * @return : OperationPolicyDetailResDto
  	 * @description : 정책속성값 항목 수정 클릭 시 기존데이터 불러와 화면에 뿌리는 메소드 
  	 */
	@RequestMapping(value="/getOprPlcyDetailBeforeUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public OperationPolicyDetailResDto getOprPlcyDetailBeforeUpdate(@RequestBody OperationPolicyDetailReqDto opdDto) {
		LogUtil.param(this.getClass(), opdDto);

		return operationPolicyMgtService.getOprPlcyDetailBeforeUpdate(opdDto);
	}
  	
	
	@RequestMapping(value="/updateOperationPolicyDetail.do", method=RequestMethod.POST) 
	public @ResponseBody StatusResDto updateOperationPolicyDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// 로그인 사용자의 정보 초기화
		LoginResDto loginInfo = this.checkLoginSession(request, response);
		opDto.setLoginInfo(loginInfo);
		
		return operationPolicyMgtService.updateOperationPolicyDetail(opDto);
	}
	
	// 정책속성값 항목 삭제 / 또는 세부속성 항목 삭제(논리삭졔) 컨트롤러
	@RequestMapping(value="/deleteOperationPolicyDetail.do", method=RequestMethod.POST) 
	public @ResponseBody StatusResDto deleteOperationPolicyDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		
		return operationPolicyMgtService.deleteOperationPolicyDetail(opDto);
	}
	
	/**
 	 * @programId : 
 	 * @name : checkAttrCdSingleValYnForInsert
 	 * @date : 2021. 01. 06.
 	 * @author : jb.kim
 	 * @table : LOY.LOY_OPR_PLCY_DTL
 	 * @return : rtnValue
 	 * @description : 운영정책관리 - 정책속성값그리드/세부사항그리드 에서 '신규' 저장 시, 넣어주려는 데이터가 단일값 속성 규칙에 위배될지 미리 체크한다.
 	 */
	@RequestMapping(value="/checkAttrCdSingleValYnForInsert.do", method=RequestMethod.POST) 
	public @ResponseBody StatusResDto checkAttrCdSingleValYnForInsert(HttpServletRequest request, HttpServletResponse response, @RequestBody OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		
		StatusResDto rtnValue = operationPolicyMgtService.checkAttrCdSingleValYnForInsert(opDto);		
		return rtnValue;
	}
		
	/**
	 * @programId : 
	 * @name : checkAttrCdSingleValYnForUpdate
	 * @date : 2021. 01. 06.
	 * @author : jb.kim
	 * @table : LOY.LOY_OPR_PLCY_DTL
	 * @return : rtnValue
	 * @description : 운영정책관리 - 정책속성값그리드/세부사항그리드 에서  '수정' 시행 시, 넣어주려는 데이터가 단일값 속성 규칙에 위배될지 미리 체크한다.
	 */
	
	@RequestMapping(value="/checkAttrCdSingleValYnForUpdate.do", method=RequestMethod.POST) 
	public @ResponseBody StatusResDto checkAttrCdSingleValYnForUpdate(HttpServletRequest request, HttpServletResponse response, @RequestBody OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		StatusResDto rtnValue = operationPolicyMgtService.checkAttrCdSingleValYnForUpdate(opDto);
		
		return rtnValue;
	}
	
	
	
}
