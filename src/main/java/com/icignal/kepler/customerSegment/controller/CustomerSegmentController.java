package com.icignal.kepler.customerSegment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.kepler.customerSegment.dto.request.CustSegMartReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegStageReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegmentRuleReqDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegMartResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegStageResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegmentRuleResDto;
import com.icignal.kepler.customerSegment.service.CustomerSegmentService;
import com.icignal.kepler.segment.controller.KprSegmentController;
import com.icignal.kepler.segment.dto.request.KprSegmentListReqDto;
import com.icignal.kepler.segment.dto.response.KprSegmentListResDto;
import com.icignal.kepler.targetGroup.targetGroup.controller.KprTargetGroupController;

/*	
 * 1. 클래스명	: CustomerSegmentController
 * 2. 파일명	: CustomerSegmentController.java
 * 3. 패키지명	: com.icignal.kepler.customerSegment.controller
 * 4. 작성자명	: sh.park
 * 5. 작성일자	: 2020. 07. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		공통
 * </PRE>
 */ 
@Controller
@RequestMapping("/kepler/customerSegment")
public class CustomerSegmentController extends BaseController{
	
	@Autowired 
	private CustomerSegmentService custSegmentService;
	 
	@Autowired 
	AuthHelper authHelper;
	/*
	 * 1. 메소드명: getCustSegMartList
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 리스트 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/getCustSegMartList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<CustSegMartResDto> getCustSegMartList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return custSegmentService.getCustSegMartList(reqDto);
	}
	/*
	 * 1. 메소드명: getCustSegMartDetail
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/getCustSegMartDetail.do", method = RequestMethod.POST)
	public @ResponseBody CustSegMartResDto getCustSegMartDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return custSegmentService.getCustSegMartDetail(reqDto);
	}
	/*
	 * 1. 메소드명: addCustSegmentMart
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세 등록
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/addCustSegmentMart.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addCustSegmentMart(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.insertCustSegmentMart(reqDto);

		return rtnValue;
	}
	/*
	 * 1. 메소드명: editCustSegmentMart
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/editCustSegmentMart.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editCustSegmentMart(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.updateCustSegmentMart(reqDto);

		return rtnValue;
	}
	/*
	 * 1. 메소드명: editCustSegmentMart
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/removeCustSegmentMart.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCustSegmentMart(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.removeCustSegmentMart(reqDto);

		return rtnValue;
	}
	/*
	 * 1. 메소드명: editCustSegmentMart
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세  로지컬 컴포넌트 팝업 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/getLogicalCompList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<CustSegMartResDto> getLogicalCompList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return custSegmentService.getLogicalCompList(reqDto);
	}
	
	/*
	 * 1. 메소드명: getCustSegList
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 09
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 리스트 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/getCustSegList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<CustSegResDto> getCustSegList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return custSegmentService.getCustSegList(reqDto);
	}
	
	/*
	 * 1. 메소드명: getCustSegDetail
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 09
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 디테일 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/getCustSegDetail.do", method = RequestMethod.POST)
	public @ResponseBody CustSegResDto getCustSegDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return custSegmentService.getCustSegDetail(reqDto);
	}
	
	/*
	 * 1. 메소드명: editCustSegmentMart
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/removeCustSegment.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCustSegment(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.removeCustSegment(reqDto);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: addCustSegment
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 09
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 등록
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/addCustSegment.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addCustSegment(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.addCustSegment(reqDto);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: editCustSegment
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 상세 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/editCustSegment.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editCustSegment(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.editCustSegment(reqDto);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: getCustSegStageList
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세분화 단계 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/getCustSegStageList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<CustSegStageResDto> getCustSegStageList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return custSegmentService.getCustSegStageList(reqDto);
	}

	/*
	 * 1. 메소드명: getCustSegStageDetail
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세분화 단계 상세 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/getCustSegStageDetail.do", method = RequestMethod.POST)
	public @ResponseBody CustSegStageResDto getCustSegStageDetail(HttpServletRequest request,
			HttpServletResponse response, @RequestBody CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		
		return custSegmentService.getCustSegStageDetail(reqDto);
	}
	
	/*
	 * 1. 메소드명: addCustSegment
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 09
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세분화 단계 등록
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/addCustSegmentStage.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addCustSegmentStage(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.addCustSegmentStage(reqDto);

		return rtnValue;
	}
	
	
	/*
	 * 1. 메소드명: editCustSegment
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 단계 상세 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/editCustSegmentStage.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editCustSegmentStage(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.editCustSegmentStage(reqDto);

		return rtnValue;
	}
	
	/*
	 * 1. 메소드명: editCustSegmentMart
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 단계 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	@RequestMapping(value = "/removeCustSegmentStage.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeCustSegmentStage(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.removeCustSegmentStage(reqDto);

		return rtnValue;
	}
	/*
	 * 1. 메소드명: addCustSegmentRule
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 룰 생성
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	
    @RequestMapping(value="/addCustSegmentRule.do", method = RequestMethod.POST)
    public @ResponseBody
    StatusResDto addCustSegmentRule(HttpServletRequest request, HttpServletResponse response, @RequestBody CustSegmentRuleReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);

    	reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
        
    	StatusResDto rtnValue = custSegmentService.addCustSegmentRule(reqDto);

        return rtnValue;
    }
    /*
	 * 1. 메소드명: getCustSegRuleList
	 * 2. 클래스명: CustomerSegmentController 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 08
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 룰 그리드 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
    @RequestMapping(value="/getCustSegRuleList.do", method = RequestMethod.POST)
    public @ResponseBody
    GridPagingResDto<CustSegmentRuleResDto> getCustSegRuleList(HttpServletRequest request, HttpServletResponse response, @RequestBody CustSegmentRuleReqDto reqDto) {
        LogUtil.param(KprTargetGroupController.class, reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        GridPagingResDto<CustSegmentRuleResDto> rtnValue = new GridPagingResDto<>();
        rtnValue = custSegmentService.getCustSegRuleList(reqDto);

        return rtnValue;
    }
      /*
   	 * 1. 메소드명: execSegMartSql
   	 * 2. 클래스명: CustomerSegmentController 
   	 * 3. 작성자명: sh.park 
   	 * 4. 작성일자: 2020. 7. 21
   	 */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *		마트 쿼리 수동 실행
   	 * 2. 사용법
   	 * 
   	 * </PRE>
   	 * 
   	 * @param request
   	 * @param response
   	 * @param reqDto
   	 * @return
   	 */	 
    @RequestMapping(value = "/execSegMartSql.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto execSegMartSql(HttpServletRequest request, HttpServletResponse response,
			@RequestBody CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto rtnValue = custSegmentService.execSegMartSql(reqDto);

		return rtnValue;
	}
    /*
   	 * 1. 메소드명: getCustRuleListBySegId
   	 * 2. 클래스명: CustomerSegmentController 
   	 * 3. 작성자명: sh.park 
   	 * 4. 작성일자: 2020. 7. 22
   	 */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *		고객 세그먼트 룰 그리드 조회(세그먼트 아이디에 따른 조회)
   	 * 2. 사용법
   	 * 
   	 * </PRE>
   	 * 
   	 * @param request
   	 * @param response
   	 * @param reqDto
   	 * @return
   	 */	 
       @RequestMapping(value="/getCustRuleListBySegId.do", method = RequestMethod.POST)
       public @ResponseBody
       GridPagingResDto<CustSegmentRuleResDto> getCustRuleListBySegId(HttpServletRequest request, HttpServletResponse response, @RequestBody CustSegmentRuleReqDto reqDto) {
           LogUtil.param(KprTargetGroupController.class, reqDto);

           reqDto.setLoginInfo(this.checkLoginSession(request, response));

           GridPagingResDto<CustSegmentRuleResDto> rtnValue = new GridPagingResDto<>();
           rtnValue = custSegmentService.getCustRuleListBySegId(reqDto);

           return rtnValue;
       }
       
       /*
      	 * 1. 메소드명: removeCustSegmentRule
      	 * 2. 클래스명: CustomerSegmentController 
      	 * 3. 작성자명: sh.park 
      	 * 4. 작성일자: 2020. 7. 23
      	 */
      	/**
      	 * <PRE>
      	 * 1. 설명
      	 *		고객 세그먼트 룰 삭제
      	 * 2. 사용법
      	 * 
      	 * </PRE>
      	 * 
      	 * @param request
      	 * @param response
      	 * @param reqDto
      	 * @return
      	 */	 
       @RequestMapping(value = "/removeCustSegmentRule.do", method = RequestMethod.POST)
       public @ResponseBody StatusResDto removeCustSegmentRule(HttpServletRequest request, HttpServletResponse response,
   		@RequestBody CustSegReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto);

   		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
   		StatusResDto rtnValue = custSegmentService.removeCustSegmentRule(reqDto);

   		return rtnValue;
   	}
       
       /*
     	 * 1. 메소드명: getCustSegmentList
     	 * 2. 클래스명: CustomerSegmentController 
     	 * 3. 작성자명: sh.park 
     	 * 4. 작성일자: 2020. 7. 28
     	 */
     	/**
     	 * <PRE>
     	 * 1. 설명
     	 *	고객 세그먼트만 조회 
     	 * 2. 사용법
     	 * 
     	 * </PRE>
     	 * 
     	 * @param request
     	 * @param response
     	 * @param reqDto
     	 * @return
     	 */	 
       @RequestMapping(value="/getCustSegmentList.do", method = RequestMethod.POST)
       public @ResponseBody
       GridPagingResDto<KprSegmentListResDto> getCustSegmentList(HttpServletRequest request, HttpServletResponse response, @RequestBody KprSegmentListReqDto slr) {
           LogUtil.param(KprSegmentController.class, slr);
           
           GridPagingResDto<KprSegmentListResDto> rtnValue = new GridPagingResDto<>();
           rtnValue = custSegmentService.getCustSegmentList(slr);
           
           return rtnValue;
       }
       
       
       /*
      	 * 1. 메소드명: getCustSegStageDetail
      	 * 2. 클래스명: CustomerSegmentController 
      	 * 3. 작성자명: sh.park 
      	 * 4. 작성일자: 2020. 7. 10
      	 */
      	/**
      	 * <PRE>
      	 * 1. 설명
      	 *		고객 세분화 단계 인덱스
      	 * 2. 사용법
      	 * 
      	 * </PRE>
      	 * 
      	 * @param request
      	 * @param response
      	 * @param reqDto
      	 * @return
      	 */	 
   	@RequestMapping(value = "/getCustSegStageIdx.do", method = RequestMethod.POST)
   	public @ResponseBody Integer getCustSegStageIdx(HttpServletRequest request,
   			HttpServletResponse response, @RequestBody CustSegStageReqDto reqDto) {
   		LogUtil.param(this.getClass(), reqDto);
   		reqDto.setLoginInfo(authHelper.checkLoginSession(request, response));
   		
   		return custSegmentService.getCustSegStageIdx(reqDto);
   	}
   	
    @RequestMapping(value="/setSegmentCond.do", method = RequestMethod.POST)
    public @ResponseBody
   CustSegmentRuleResDto setSegmentCond(HttpServletRequest request, HttpServletResponse response, @RequestBody CustSegmentRuleReqDto reqDto) {
        LogUtil.param(KprTargetGroupController.class, reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return custSegmentService.setSegmentCond(reqDto);

    }
      @RequestMapping(value="/getCustRuleNmForTxt.do", method = RequestMethod.POST)
    public @ResponseBody
   CustSegmentRuleResDto getCustRuleNmForTxt(HttpServletRequest request, HttpServletResponse response, @RequestBody CustSegmentRuleReqDto reqDto) {
        LogUtil.param(KprTargetGroupController.class, reqDto);

        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return custSegmentService.getCustRuleNmForTxt(reqDto);

    }
}
