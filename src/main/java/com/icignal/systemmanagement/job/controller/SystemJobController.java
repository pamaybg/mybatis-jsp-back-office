package com.icignal.systemmanagement.job.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.job.dto.request.SystemAlrtListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemBatchParameterListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemChoiceJobListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemExecParamListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemJobDetailReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemJobInsertReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemJobListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemJobStepCommandListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemJobStepListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemJobStepMapperListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemJobStepParamListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemJobUpdateReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemLogDtlListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemLogListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemSbsqntListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemTargetJobListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemTrgrListReqDto;
import com.icignal.systemmanagement.job.dto.request.SystemTrgrStartPauseReqDto;
import com.icignal.systemmanagement.job.dto.response.SystemAlrtDetailResDto;
import com.icignal.systemmanagement.job.dto.response.SystemAlrtItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemBatchParameterItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemChoiceJobItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemExecParamDetailResDto;
import com.icignal.systemmanagement.job.dto.response.SystemExecParamItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemJobDetailResDto;
import com.icignal.systemmanagement.job.dto.response.SystemJobItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemJobStepCommandItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemJobStepItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemJobStepMapperItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemJobStepParamItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemLogDtlItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemLogItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemSbsqntDetailResDto;
import com.icignal.systemmanagement.job.dto.response.SystemSbsqntItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemTargetJobDetailResDto;
import com.icignal.systemmanagement.job.dto.response.SystemTargetJobItemResDto;
import com.icignal.systemmanagement.job.dto.response.SystemTrgrDetailResDto;
import com.icignal.systemmanagement.job.dto.response.SystemTrgrItemResDto;
import com.icignal.systemmanagement.job.dto.response.jobStepInfoExecuteDtlResDto;
import com.icignal.systemmanagement.job.dto.response.jobStepInfoExecuteParamResDto;
import com.icignal.systemmanagement.job.service.SystemJobService;

/*
 * 1. 클래스명	: SystemJobController
 * 2. 파일명	: SystemJobController.java
 * 3. 패키지명	: com.icignal.systemmanagement.job.controller
 * 4. 작성자명	:
 * 5. 작성일자	: 2020. 2. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *		Batch (JOB) 관리 Controller
 * </PRE>
 */
@Controller
@RequestMapping("/system/job")
public class SystemJobController extends BaseController {

	@Autowired
	SystemJobService systemJobService;

	@Autowired
	AuthHelper authHelper;

//	@Override
//	@RequestMapping(value = "/popup/{name:.+}", method = RequestMethod.GET)
//	public String NavigatePopMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
//		LogUtil.info("NavigatePopMenu start.....");
//
//		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
//		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
//		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
//		String respUrl = requestPath + "/popup/" +  name;
//
//		String result = authHelper.checkUserInfoInclude(request, response, respUrl);
//		LogUtil.info("resUrl: " + result);
//		return result;
//	}
//
//	@Override
//	@RequestMapping(value = "/include/{name:.+}", method = RequestMethod.GET)
//	public String NavigateIncludeMenu(@PathVariable("name") String name, HttpServletRequest request, HttpServletResponse response,Model model) {
//		RequestMapping annotationClass = this.getClass().getAnnotation(RequestMapping.class);
//		Arrays.asList(annotationClass.value()).stream().forEach(System.out::println);
//		String requestPath =  Arrays.asList(annotationClass.value()).stream().findFirst().get();
//		String respUrl = requestPath + "/include/" + name;
//		return authHelper.checkUserInfoInclude(request, response, respUrl);
//
//	}

	/*
	 * 1. 메소드명: getJobList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemJobItemResDto> getJobList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));

		return systemJobService.getJobList(paramDto);
	}

	/*
	 * 1. 메소드명: addJob
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		job 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addJob(HttpServletRequest request, HttpServletResponse response,
											 @RequestBody SystemJobInsertReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addJob(paramDto);
	}

	/*
	 * 1. 메소드명: getJobDetail
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemJobDetailResDto getJobDetail(HttpServletRequest request, HttpServletResponse response,
															@RequestBody SystemJobDetailReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		authHelper.checkLoginSession(request, response);
		return systemJobService.getJobDetail(paramDto);
	}

	/*
	 * 1. 메소드명: editJob
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editJob(HttpServletRequest request, HttpServletResponse response,
											  @RequestBody SystemJobUpdateReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editJob(paramDto);
	}

	/*
	 * 1. 메소드명: removeJobList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeJobList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeJobList(HttpServletRequest request, HttpServletResponse response,
													@RequestBody SystemJobDetailReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		authHelper.checkLoginSession(request, response);
		return systemJobService.removeJobList(paramDto);
	}

	/*
	 * 1. 메소드명: getExecParamList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getExecParamList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemExecParamItemResDto> getExecParamList(HttpServletRequest request, HttpServletResponse response,
																					  @RequestBody SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getExecParamList(paramDto);
	}

	/*
	 * 1. 메소드명: addExecParam
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addExecParam.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addExecParam(HttpServletRequest request, HttpServletResponse response,
												   @RequestBody SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addExecParam(paramDto);
	}

	/*
	 * 1. 메소드명: getExecParamDetail
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getExecParamDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemExecParamDetailResDto getExecParamDetail(HttpServletRequest request,
																		HttpServletResponse response, @RequestBody SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getExecParamDetail(paramDto);
	}

	/*
	 * 1. 메소드명: editExecParam
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editExecParam.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editExecParam(HttpServletRequest request, HttpServletResponse response,
													@RequestBody SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editExecParam(paramDto);
	}

	/*
	 * 1. 메소드명: removeExecParamList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeExecParamList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeExecParamList(HttpServletRequest request, HttpServletResponse response,
														  @RequestBody SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeExecParamList(paramDto);
	}

	/*
	 * 1. 메소드명: getLogList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getLogList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemLogItemResDto> getLogList(HttpServletRequest request, HttpServletResponse response,
																		  @RequestBody SystemLogListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getLogList(paramDto);
	}

	/*
	 * 1. 메소드명: downloadLogExcel
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param startDate
	 *   @param endDate
	 *   @param jobCd
	 *   @param logTblNm
	 *   @param headerList
	 */
	@RequestMapping(value = "/downloadLogExcel.do", method = RequestMethod.GET)
	public void downloadLogExcel(HttpServletRequest request, HttpServletResponse response,
								 @RequestParam String startDate, @RequestParam String endDate, @RequestParam String jobCd,
								 @RequestParam String logTblNm, @RequestParam List<String> headerList) {
		LogUtil.param(this.getClass(), startDate);
		LogUtil.param(this.getClass(), endDate);
		LogUtil.param(this.getClass(), jobCd);
		LogUtil.param(this.getClass(), headerList);
		authHelper.checkLoginSession(request, response);
		systemJobService.downloadLogExcel(request, response, startDate, endDate, jobCd, logTblNm, headerList);
	}

	/*
	 * 1. 메소드명: getLogDtlList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getLogDtlList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemLogDtlItemResDto> getLogDtlList(HttpServletRequest request, HttpServletResponse response,
																				@RequestBody SystemLogDtlListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getLogDtlList(paramDto);
	}

	/*
	 * 1. 메소드명: downloadLogDtlExcel
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param ridJobLog
	 *   @param headerList
	 */
	@RequestMapping(value = "/downloadLogDtlExcel.do", method = RequestMethod.GET)
	public void downloadLogDtlExcel(HttpServletRequest request, HttpServletResponse response,
									@RequestParam String ridJobLog, @RequestParam List<String> headerList) {
		LogUtil.param(this.getClass(), ridJobLog);
		LogUtil.param(this.getClass(), headerList);
		authHelper.checkLoginSession(request, response);
		systemJobService.downloadLogDtlExcel(request, response, ridJobLog, headerList);
	}

	/*
	 * 1. 메소드명: addExecParam
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addTrgr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addExecParam(HttpServletRequest request, HttpServletResponse response,
												   @RequestBody SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addTrgr(paramDto);
	}

	/*
	 * 1. 메소드명: getTrgrList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getTrgrList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemTrgrItemResDto> getTrgrList(HttpServletRequest request, HttpServletResponse response,
																			@RequestBody SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getTrgrList(paramDto);
	}

	/*
	 * 1. 메소드명: getTrgrDetail
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getTrgrDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemTrgrDetailResDto getTrgrDetail(HttpServletRequest request, HttpServletResponse response,
															  @RequestBody SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getTrgrDetail(paramDto);
	}

	/*
	 * 1. 메소드명: editTrgr
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editTrgr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editTrgr(HttpServletRequest request, HttpServletResponse response,
											   @RequestBody SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editTrgr(paramDto);
	}

	/*
	 * 1. 메소드명: removeTrgrList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeTrgrList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTrgrList(HttpServletRequest request, HttpServletResponse response,
													 @RequestBody SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeTrgrList(paramDto);
	}

	/*
	 * 1. 메소드명: startPauseTrgr
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/startPauseTrgr.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto startPauseTrgr(HttpServletRequest request, HttpServletResponse response,
													 @RequestBody SystemTrgrStartPauseReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		StatusResDto resDto = null;
		if (paramDto.getStatCd().equalsIgnoreCase("NORMAL")) {
			resDto = systemJobService.startTrgr(paramDto);
		} else if (paramDto.getStatCd().equalsIgnoreCase("PAUSED")) {
			resDto = systemJobService.pauseTrgr(paramDto);
		}
		return resDto;
	}

	/*
	 * 1. 메소드명: addAlrt
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addAlrt.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addAlrt(HttpServletRequest request, HttpServletResponse response,
											  @RequestBody SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addAlrt(paramDto);
	}

	/*
	 * 1. 메소드명: getAlrtList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getAlrtList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemAlrtItemResDto> getAlrtList(HttpServletRequest request, HttpServletResponse response,
																			@RequestBody SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getAlrtList(paramDto);
	}

	/*
	 * 1. 메소드명: getAlrtDetail
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getAlrtDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemAlrtDetailResDto getAlrtDetail(HttpServletRequest request, HttpServletResponse response,
															  @RequestBody SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getAlrtDetail(paramDto);
	}

	/*
	 * 1. 메소드명: editAlrt
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editAlrt.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editAlrt(HttpServletRequest request, HttpServletResponse response,
											   @RequestBody SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editAlrt(paramDto);
	}

	/*
	 * 1. 메소드명: removeAlrtList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeAlrtList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeAlrtList(HttpServletRequest request, HttpServletResponse response,
													 @RequestBody SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeAlrtList(paramDto);
	}

	/*
	 * 1. 메소드명: addSbsqnt
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addSbsqnt.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addSbsqnt(HttpServletRequest request, HttpServletResponse response,
												@RequestBody SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addSbsqnt(paramDto);
	}

	/*
	 * 1. 메소드명: getSbsqntList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getSbsqntList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemSbsqntItemResDto> getSbsqntList(HttpServletRequest request, HttpServletResponse response,
																				@RequestBody SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getSbsqntList(paramDto);
	}

	/*
	 * 1. 메소드명: getSbsqntDetail
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getSbsqntDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemSbsqntDetailResDto getSbsqntDetail(HttpServletRequest request,
																  HttpServletResponse response, @RequestBody SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getSbsqntDetail(paramDto);
	}

	/*
	 * 1. 메소드명: editSbsqnt
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editSbsqnt.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editSbsqnt(HttpServletRequest request, HttpServletResponse response,
												 @RequestBody SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editSbsqnt(paramDto);
	}

	/*
	 * 1. 메소드명: removeSbsqntList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeSbsqntList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeSbsqntList(HttpServletRequest request, HttpServletResponse response,
													   @RequestBody SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeSbsqntList(paramDto);
	}

	/*
	 * 1. 메소드명: getChoiceJobList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getChoiceJobList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemChoiceJobItemResDto> getChoiceJobList(HttpServletRequest request, HttpServletResponse response,
																					  @RequestBody SystemChoiceJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getChoiceJobList(paramDto);
	}

	/*
	 * 1. 메소드명: addTargetJob
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addTargetJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addTargetJob(HttpServletRequest request, HttpServletResponse response,
												   @RequestBody SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addTargetJob(paramDto);
	}

	/*
	 * 1. 메소드명: getTargetJobList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getTargetJobList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemTargetJobItemResDto> getTargetJobList(HttpServletRequest request, HttpServletResponse response,
																					  @RequestBody SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getTargetJobList(paramDto);
	}

	/*
	 * 1. 메소드명: getTargetJobDetail
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getTargetJobDetail.do", method = RequestMethod.POST)
	public @ResponseBody SystemTargetJobDetailResDto getTargetJobDetail(HttpServletRequest request,
																		HttpServletResponse response, @RequestBody SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getTargetJobDetail(paramDto);
	}

	/*
	 * 1. 메소드명: editTargetJob
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editTargetJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editTargetJob(HttpServletRequest request, HttpServletResponse response,
													@RequestBody SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editTargetJob(paramDto);
	}

	/*
	 * 1. 메소드명: removeTargetJobList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeTargetJobList.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeTargetJobList(HttpServletRequest request, HttpServletResponse response,
														  @RequestBody SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeTargetJobList(paramDto);
	}

	/*
	 * 1. 메소드명: executeJob
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/executeJob.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto executeJob(HttpServletRequest request, HttpServletResponse response,
												 @RequestBody SystemJobDetailReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		authHelper.checkLoginSession(request, response);
		return systemJobService.executeJob(paramDto);
	}

	/*
	 * 1. 메소드명: getJobStepList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobStepList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemJobStepItemResDto> getJobStepList(HttpServletRequest request, HttpServletResponse response,
																				  @RequestBody SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobStepList(paramDto);
	}

	/*
	 * 1. 메소드명: getJobStepDtl
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobStepDtl.do", method = RequestMethod.POST)
	public @ResponseBody SystemJobStepItemResDto getJobStepDtl(HttpServletRequest request, HttpServletResponse response,
															   @RequestBody SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobStepDtl(paramDto);
	}

	/*
	 * 1. 메소드명: addJobStep
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addJobStep.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addJobStep(HttpServletRequest request, HttpServletResponse response,
												 @RequestBody SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addJobStep(paramDto);
	}

	/*
	 * 1. 메소드명: editJobStep
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editJobStep.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editJobStep(HttpServletRequest request, HttpServletResponse response,
												  @RequestBody SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editJobStep(paramDto);
	}

	/*
	 * 1. 메소드명: removeJobStep
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeJobStep.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeJobStep(HttpServletRequest request, HttpServletResponse response,
													@RequestBody SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeJobStep(paramDto);
	}

	/*
	 * 1. 메소드명: getJobStepMapperList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobStepMapperList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemJobStepMapperItemResDto> getJobStepMapperList(HttpServletRequest request, HttpServletResponse response,
																							  @RequestBody SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobStepMapperList(paramDto);
	}

	/*
	 * 1. 메소드명: getJobStepMapperDtl
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobStepMapperDtl.do", method = RequestMethod.POST)
	public @ResponseBody SystemJobStepMapperItemResDto getJobStepMapperDtl(HttpServletRequest request,
																		   HttpServletResponse response, @RequestBody SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobStepMapperDtl(paramDto);
	}

	/*
	 * 1. 메소드명: addJobStepMapper
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addJobStepMapper.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addJobStepMapper(HttpServletRequest request, HttpServletResponse response,
													   @RequestBody SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addJobStepMapper(paramDto);
	}

	/*
	 * 1. 메소드명: editJobStepMapper
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editJobStepMapper.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editJobStepMapper(HttpServletRequest request, HttpServletResponse response,
														@RequestBody SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editJobStepMapper(paramDto);
	}

	/*
	 * 1. 메소드명: removeJobStepMapper
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeJobStepMapper.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeJobStepMapper(HttpServletRequest request, HttpServletResponse response,
														  @RequestBody SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeJobStepMapper(paramDto);
	}

	/*
	 * 1. 메소드명: getJobLogList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobLogList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemJobItemResDto> getJobLogList(HttpServletRequest request, HttpServletResponse response,
																			 @RequestBody SystemJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobLogList(paramDto);
	}

	/*
	 * 1. 메소드명: getJobStepCommandList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명: hy.jun
	 * 4. 작성일자: 2019. 1. 29.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobStepCommandList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemJobStepCommandItemResDto> getJobStepCommandList(HttpServletRequest request,
																								HttpServletResponse response, @RequestBody SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobStepCommandList(paramDto);
	}

	/*
	 * 1. 메소드명: getJobStepCommandDtl
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명: hy.jun
	 * 4. 작성일자: 2019. 1. 29.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobStepCommandDtl.do", method = RequestMethod.POST)
	public @ResponseBody SystemJobStepCommandItemResDto getJobStepCommandDtl(HttpServletRequest request,
																			 HttpServletResponse response, @RequestBody SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobStepCommandDtl(paramDto);
	}

	/*
	 * 1. 메소드명: addJobStepCommand
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:  hy.jun
	 * 4. 작성일자: 2019. 1. 29.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addJobStepCommand.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addJobStepCommand(HttpServletRequest request, HttpServletResponse response,
														@RequestBody SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addJobStepCommand(paramDto);
	}

	/*
	 * 1. 메소드명: editJobStepCommand
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명: hy.jun
	 * 4. 작성일자: 2019. 1. 29.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editJobStepCommand.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editJobStepCommand(HttpServletRequest request, HttpServletResponse response,
														 @RequestBody SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editJobStepCommand(paramDto);
	}

	/*
	 * 1. 메소드명: removeJobStepCommand
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명: hy.jun
	 * 4. 작성일자:  2019. 1. 29.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeJobStepCommand.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeJobStepCommand(HttpServletRequest request, HttpServletResponse response,
														   @RequestBody SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeJobStepCommand(paramDto);
	}

	/*
	 * 1. 메소드명: getBatchParameterList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 09. 15.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getBatchParameterList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemBatchParameterItemResDto> getBatchParameterList(HttpServletRequest request, HttpServletResponse response,
																								@RequestBody SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getBatchParameterList(paramDto);
	}
	/*
	 * 1. 메소드명: getBatchParameterDtl
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 09. 15.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getBatchParameterDtl.do", method = RequestMethod.POST)
	public @ResponseBody SystemBatchParameterItemResDto getBatchParameterDtl(HttpServletRequest request, HttpServletResponse response,
																			 @RequestBody SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getBatchParameterDtl(paramDto);
	}

	/*
	 * 1. 메소드명: addBatchParameter
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 9. 15.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addBatchParameter.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addBatchParameter(HttpServletRequest request, HttpServletResponse response,
														@RequestBody SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addBatchParameter(paramDto);
	}

	/*
	 * 1. 메소드명: editBatchParameter
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 9. 15.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editBatchParameter.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editBatchParameter(HttpServletRequest request, HttpServletResponse response,
														 @RequestBody SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editBatchParameter(paramDto);
	}

	/*
	 * 1. 메소드명: removeBatchParameter
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeBatchParameter.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeBatchParameter(HttpServletRequest request, HttpServletResponse response,
														   @RequestBody SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeBatchParameter(paramDto);
	}

	/*
	 * 1. 메소드명: getJobStepParamList
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 09. 16.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobStepParamList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemJobStepParamItemResDto> getJobStepParamList(HttpServletRequest request, HttpServletResponse response,
																							@RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobStepParamList(paramDto);
	}
	/*
	 * 1. 메소드명: addJobStepParam
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 09. 16.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/addJobStepParam.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto addJobStepParam(HttpServletRequest request, HttpServletResponse response,
													  @RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.addJobStepParam(paramDto);
	}

	/*
	 * 1. 메소드명: editJobStepParam
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 9. 15.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/editJobStepParam.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editBatchParameter(HttpServletRequest request, HttpServletResponse response,
														 @RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editJobStepParam(paramDto);
	}

	/*
	 * 1. 메소드명: removeJobStepParam
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 2. 25.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/removeJobStepParam.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto removeJobStepParam(HttpServletRequest request, HttpServletResponse response,
														 @RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.removeJobStepParam(paramDto);
	}
	/*
	 * 1. 메소드명: getJobStepParamDtl
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 09. 15.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getJobStepParamDtl.do", method = RequestMethod.POST)
	public @ResponseBody SystemJobStepParamItemResDto getJobStepParamDtl(HttpServletRequest request, HttpServletResponse response,
																		 @RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getJobStepParamDtl(paramDto);
	}

	/*
	 * 1. 메소드명: getInfoExecuteParam
	 * 2. 클래스명: SystemJobController
	 * 3. 작성자명:
	 * 4. 작성일자: 2020. 11. 18.
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
	 *   @param paramDto
	 *   @return
	 */
	@RequestMapping(value = "/getInfoExecuteParam.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<jobStepInfoExecuteParamResDto> getInfoExecuteParam(HttpServletRequest request, HttpServletResponse response,
																							 @RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getInfoExecuteParam(paramDto);
	}

	//상세
	@RequestMapping(value = "/getParamInfoDtl.do", method = RequestMethod.POST)
	public @ResponseBody jobStepInfoExecuteDtlResDto getParamInfoDtl(HttpServletRequest request, HttpServletResponse response,
																							 @RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getParamInfoDtl(paramDto);
	}

	//저장
	@RequestMapping(value = "/saveParamInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto saveParamInfo(HttpServletRequest request, HttpServletResponse response,
																	   @RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.saveParamInfo(paramDto);
	}

	//수정
	@RequestMapping(value = "/editParamInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto editParamInfo(HttpServletRequest request, HttpServletResponse response,
													@RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.editParamInfo(paramDto);
	}

	//삭제
	@RequestMapping(value = "/deleteParamInfo.do", method = RequestMethod.POST)
	public @ResponseBody StatusResDto deleteParamInfo(HttpServletRequest request, HttpServletResponse response,
													@RequestBody SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.deleteParamInfo(paramDto);
	}
	
	 /*
	  * 1. 메소드명: getJobLogList
	  * 2. 클래스명: SystemJobController
	  * 3. 작성자명: noh.hyungrae 
	  * 4. 작성일자: 2020. 12. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		Batch관리 - 상세 이력 tab
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param paramDto
	 *   @return	
	 */
	@RequestMapping(value = "/getjobProcLogList.do", method = RequestMethod.POST)
	public @ResponseBody GridPagingResDto<SystemJobItemResDto> getjobProcLogList(HttpServletRequest request, HttpServletResponse response, @RequestBody SystemJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		paramDto.setLoginInfo(authHelper.checkLoginSession(request, response));
		return systemJobService.getjobProcLogList(paramDto);
	}
}