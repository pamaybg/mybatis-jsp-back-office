package com.icignal.marketing.batch.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.marketing.batch.dto.request.MktBatchJobReqDto;
import com.icignal.marketing.batch.dto.response.MktBatchJobResDto;
import com.icignal.marketing.batch.dto.response.MktBatchLogResDto;
import com.icignal.marketing.batch.service.MktBatchService;



@Controller
@RequestMapping("/marketing/batch")
public class MktBatchController extends BaseController{
	
	@Autowired
	private MktBatchService mktBatchService;
	
	/**
	 * 배치 job 목록 조회
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	@RequestMapping(value="/getMktBatchJobList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktBatchJobResDto> getMktBatchJobList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchController.class,dto);	
		
		dto.setLoginInfo(this.checkLoginSession(request, response));
		
		return mktBatchService.getMktBatchJobList(dto);
	}
	
	/**
	 * 배치 job 저장
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	@RequestMapping(value="/saveMktBatchJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveMktBatchJob(HttpServletRequest request, HttpServletResponse response, @RequestBody MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchController.class,dto);	
		
		dto.setLoginInfo(this.checkLoginSession(request, response));
		
		return mktBatchService.saveMktBatchJob(dto);
	}		

	/**
	 * 배치 job 삭제
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	@RequestMapping(value="/removeMktBatchJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeMktBatchJob(HttpServletRequest request, HttpServletResponse response, @RequestBody MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchController.class,dto);	

		dto.setLoginInfo(this.checkLoginSession(request, response));
		
		return mktBatchService.removeMktBatchJob(dto);
	}
	
	/**
	 * 배치 job 실행
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	@RequestMapping(value="/startMktBatchJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto startMktBatchJob(HttpServletRequest request, HttpServletResponse response, @RequestBody MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchController.class,dto);	

		dto.setLoginInfo(this.checkLoginSession(request, response));
		
		return mktBatchService.startMktBatchJob(dto);
	}
	
	/**
	 * 배치 job 수동 실행
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	@RequestMapping(value="/runMktBatchJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto runMktBatchJob(HttpServletRequest request, HttpServletResponse response, @RequestBody MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchController.class,dto);	

		dto.setLoginInfo(this.checkLoginSession(request, response));
		
		return mktBatchService.runMktBatchJob(dto);
	}
	
	/**
	 * 배치 job 중지
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	@RequestMapping(value="/stopMktBatchJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto stopMktBatchJob(HttpServletRequest request, HttpServletResponse response, @RequestBody MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchController.class,dto);	

		dto.setLoginInfo(this.checkLoginSession(request, response));
		
		return mktBatchService.stopMktBatchJob(dto);
	}
	
	/**
	 * 배치 job 로그 헤더 목록 조회
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	@RequestMapping(value="/getMktBatchLogHadList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktBatchLogResDto> getMktBatchLogHadList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchController.class,dto);	
		
		dto.setLoginInfo(this.checkLoginSession(request, response));
		
		return mktBatchService.getMktBatchLogHadList(dto);
	}
	
	/**
	 * 배치 job 로그 상세 목록 조회
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	@RequestMapping(value="/getMktBatchLogDtlList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<MktBatchLogResDto> getMktBatchLogDtlList(HttpServletRequest request, HttpServletResponse response, @RequestBody MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchController.class,dto);	
		
		dto.setLoginInfo(this.checkLoginSession(request, response));
		
		return mktBatchService.getMktBatchLogDtlList(dto);
	}	
	
}