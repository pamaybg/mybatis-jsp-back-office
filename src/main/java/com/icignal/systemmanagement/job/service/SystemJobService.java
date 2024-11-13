package com.icignal.systemmanagement.job.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateUtils;
import org.quartz.CronScheduleBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.ErrorHelper;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.exception.DataBadRequestException;
import com.icignal.core.exception.DataUnhandledException;
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
import com.icignal.systemmanagement.job.dto.request.SystemTrgrMakingReqDto;
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
import com.icignal.systemmanagement.job.mapper.SystemJobMapper;

/*
 * 1. 클래스명	: SystemJobService
 * 2. 파일명	: SystemJobService.java
 * 3. 패키지명	: com.icignal.systemmanagement.job.service
 * 4. 작성자명	:
 * 5. 작성일자	: 2020. 2. 25.
 */

/**
 * <PRE>
 * 1. 설명
 *		Batch (JOB) 관리 Service
 * </PRE>
 */
@Service("SystemJobService")
public class SystemJobService {

	@Autowired
	SystemJobMapper systemJobMapper;

	private SchedulerFactoryBean schedulerFactoryBean;

	private Scheduler scheduler;

	// 스케쥴러 객체 획득
	private void init() {
		if (scheduler == null) {
			scheduler = schedulerFactoryBean.getScheduler();
		}
	}

	public void setScheduler(Scheduler scheduler) {
		this.scheduler = scheduler;
	}

	/*
	 * 1. 메소드명: getJobList
	 * 2. 클래스명: SystemJobService
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
	 *
	 * @param paramDto
	 * @return
	 */
	public GridPagingResDto<SystemJobItemResDto> getJobList(SystemJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemJobItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectJobList(paramDto));

	}

	/*
	 * 1. 메소드명: addJob
	 * 2. 클래스명: SystemJobService
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
	 *
	 * @param paramDto
	 * @return
	 */
	public StatusResDto addJob(SystemJobInsertReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);

		paramDto.setRid(CommonUtil.newRid());
		systemJobMapper.insertJob(paramDto);
		String rid = paramDto.getRid();
		if (rid == null) {
			throw new DataUnhandledException(ErrorHelper.MSG_1001);
		}
		StatusResDto rtnDto = new StatusResDto(true, rid);
		return rtnDto;

	}

	 /*
	  * 1. 메소드명: getJobDetail
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemJobDetailResDto getJobDetail(SystemJobDetailReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return systemJobMapper.selectJobDetail(paramDto);
	}

	 /*
	  * 1. 메소드명: editJob
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editJob(SystemJobUpdateReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.updateJob(paramDto);
		rtnValue.setSuccess(true);
		if (rtnValue.getSuccess()) {
			String method = "/regJobSchedule?jobName=" + paramDto.getJobNm();
			String result = "";
			result = sendJobScheduler(method);

			String str[] = result.split("&");
			if (str[0].split("=")[1].equals("S")) {
				rtnValue.setSuccess(true);
			} else {
				rtnValue.setSuccess(false);
			}

		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeJobList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeJobList(SystemJobDetailReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.deleteJobList(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: executeJob
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto executeJob(SystemJobDetailReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		String method = "/runJob";

		String result = "";
		method += "?jobName=" + paramDto.getJobNm();
		result = sendJobScheduler(method);
		StatusResDto rtnResult = new StatusResDto();

		String str[] = result.split("&");
		if (str[0].split("=")[1].equals("S")) {
			rtnResult.setSuccess(true);
		} else {
			rtnResult.setSuccess(false);
		}

		return rtnResult;

	}

	 /*
	  * 1. 메소드명: getExecParamList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemExecParamItemResDto> getExecParamList(SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemExecParamItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectExecParamList(paramDto));
	}

	 /*
	  * 1. 메소드명: addExecParam
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto addExecParam(SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);

		// 실행인수 순서 중복 체크
		SystemExecParamListReqDto paramDupChkReqDto = new SystemExecParamListReqDto();
		paramDupChkReqDto.setRidJobMst(paramDto.getRidJobMst());
		paramDupChkReqDto.setParamSeq(paramDto.getParamSeq());
		paramDupChkReqDto.setRid("");
		Integer dupCnt = systemJobMapper.checkParamSeqDup(paramDupChkReqDto);
		if (dupCnt != 0) {
			return new StatusResDto(true, "PARAM_SEQ_DUP");
		}
		paramDto.setRid(CommonUtil.newRid());
		// 실행인수 저장
		systemJobMapper.insertExecParam(paramDto);
		String rid = paramDto.getRid();
		if (rid == null) {
			throw new DataUnhandledException(ErrorHelper.MSG_1001);
		}
		StatusResDto rtnDto = new StatusResDto(true, rid);
		return rtnDto;
	}

	 /*
	  * 1. 메소드명: getExecParamDetail
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemExecParamDetailResDto getExecParamDetail(SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return systemJobMapper.selectExecParamDetail(paramDto);
	}

	 /*
	  * 1. 메소드명: editExecParam
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editExecParam(SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		// 실행인수 순서 중복 체크
		SystemExecParamListReqDto paramDupChkReqDto = new SystemExecParamListReqDto();
		paramDupChkReqDto.setRidJobMst(paramDto.getRidJobMst());
		paramDupChkReqDto.setParamSeq(paramDto.getParamSeq());
		paramDupChkReqDto.setRid(paramDto.getRid());
		Integer dupCnt = systemJobMapper.checkParamSeqDup(paramDupChkReqDto);
		if (dupCnt != 0) {
			return new StatusResDto(true, "PARAM_SEQ_DUP");
		}
		// 실행인수 업데이트
		systemJobMapper.updateExecParam(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeExecParamList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeExecParamList(SystemExecParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.deleteExecParamList(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getLogList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemLogItemResDto> getLogList(SystemLogListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);

		// Job 상세 조회
		SystemJobDetailReqDto dtlReqDto = new SystemJobDetailReqDto();
		dtlReqDto.setRid(paramDto.getRidJobMst());

		return new GridPagingResHelper<SystemLogItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectLogList(paramDto));
	}

	 /*
	  * 1. 메소드명: downloadLogExcel
	  * 2. 클래스명: SystemJobService
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
	public void downloadLogExcel(HttpServletRequest request, HttpServletResponse response, String startDate,
			String endDate, String jobCd, String logTblNm, List<String> headerList) {
		LogUtil.param(this.getClass(), startDate);
		LogUtil.param(this.getClass(), endDate);
		LogUtil.param(this.getClass(), jobCd);
		LogUtil.param(this.getClass(), logTblNm);
		LogUtil.param(this.getClass(), headerList);

		// 임시 파일 명
		//String tempFileName = "실행이력";
		// 출력할 데이터 목록 조회
		SystemLogListReqDto paramDto = new SystemLogListReqDto();
		paramDto.setStartDate(startDate);
		paramDto.setEndDate(endDate);
		paramDto.setJobCd(jobCd);
		paramDto.setLogTblNm(logTblNm);
		//List<Object> listForExcel = systemJobMapper.selectLogListForExcel(paramDto);

	}

	 /*
	  * 1. 메소드명: getLogDtlList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemLogDtlItemResDto> getLogDtlList(SystemLogDtlListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);

		// Job 상세 조회
		SystemJobDetailReqDto dtlReqDto = new SystemJobDetailReqDto();
		dtlReqDto.setRid(paramDto.getRidJobMst());
		SystemJobDetailResDto dtlResDto = systemJobMapper.selectJobDetail(dtlReqDto);

		String connSrvrCd = dtlResDto.getConnSrvrCd();

		if (connSrvrCd.contains("NRTMS")) {
			return new GridPagingResHelper<SystemLogDtlItemResDto>().newGridPagingResDto(
					paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectLogDtlList(paramDto));
		}

		return new GridPagingResHelper<SystemLogDtlItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectLogDtlList(paramDto));
	}

	 /*
	  * 1. 메소드명: downloadLogDtlExcel
	  * 2. 클래스명: SystemJobService
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
	public void downloadLogDtlExcel(HttpServletRequest request, HttpServletResponse response, String ridJobLog,
			List<String> headerList) {
		LogUtil.param(this.getClass(), ridJobLog);
		LogUtil.param(this.getClass(), headerList);

		// 임시 파일 명
		//String tempFileName = "로그상세";
		// 출력할 데이터 목록 조회
		SystemLogDtlListReqDto paramDto = new SystemLogDtlListReqDto();
		paramDto.setRidJobLog(ridJobLog);
		//List<Object> listForExcel = systemJobMapper.selectLogDtlListForExcel(paramDto);

	}

	 /*
	  * 1. 메소드명: addTrgr
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto addTrgr(SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		init();
		String ridJobMst = paramDto.getRidJobMst();
		String rid = "";
		try {
			JobDetail jobDetail = scheduler.getJobDetail(new JobKey(ridJobMst, "LoyJob"));

			// 트리거 Insert
			systemJobMapper.insertTrgr(paramDto);
			rid = paramDto.getRid();
			if (rid == null) {
				throw new DataUnhandledException(ErrorHelper.MSG_1001);
			}
			StatusResDto rtnDto = new StatusResDto(true, rid);

			// 트리거 객체 생성
			SystemTrgrMakingReqDto trgrMakeReqDto = new SystemTrgrMakingReqDto();
			trgrMakeReqDto.setTrgrName(rid);
			trgrMakeReqDto.setCronExpr(paramDto.getCronExpr());
			trgrMakeReqDto.setDescription(paramDto.getTrgrNm());
			trgrMakeReqDto.setTriggerStartTime(paramDto.getStartDttm());
			trgrMakeReqDto.setTriggerEndTime(paramDto.getEndDttm());
			Trigger trigger = makeTrigger(trgrMakeReqDto, jobDetail);

			// Job에 트리거 등록
			scheduler.scheduleJob(trigger);

			return rtnDto;
		} catch (SchedulerException e) {
			// 트리거 삭제
			SystemTrgrListReqDto trgrListDelReqDto = new SystemTrgrListReqDto();
			List<String> rids = new ArrayList<String>();
			rids.add(rid);
			trgrListDelReqDto.setRids(rids);
			systemJobMapper.deleteTrgrList(trgrListDelReqDto);

			LogUtil.error(">>>>>> Job 조회 또는 트리거 등록 시 에러");
			LogUtil.error(e);
			throw new DataBadRequestException();
		}

	}

	 /*
	  * 1. 메소드명: makeTrigger
	  * 2. 클래스명: SystemJobService
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
	 *   @param trgrMakeReqDto
	 *   @param jobDetail
	 *   @return
	 *   @throws Exception
	 */
	private Trigger makeTrigger(SystemTrgrMakingReqDto trgrMakeReqDto, JobDetail jobDetail) {
		LogUtil.param(this.getClass(), trgrMakeReqDto);

		Trigger trigger = null;

		Date startTime = trgrMakeReqDto.getTriggerStartTime();
		Date now = new Date();
		now = DateUtils.addSeconds(now, 10);
		// 시작 시간이 과거일 경우 현재 시간으로 변경
		if (startTime != null && startTime.compareTo(now) < 0) {
			startTime = now;
		}

		// 크론 트리거 설정
		trigger = TriggerBuilder.newTrigger().withIdentity(new TriggerKey(trgrMakeReqDto.getTrgrName(), "LoyTrgr"))
				.withSchedule(CronScheduleBuilder.cronSchedule(trgrMakeReqDto.getCronExpr()))
				.withDescription(trgrMakeReqDto.getDescription()).forJob(jobDetail).startAt(startTime)
				.endAt(trgrMakeReqDto.getTriggerEndTime()).build();

		return trigger;
	}

	 /*
	  * 1. 메소드명: getTrgrList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemTrgrItemResDto> getTrgrList(SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		init();

		GridPagingResDto<SystemTrgrItemResDto> rtnDto = new GridPagingResHelper<SystemTrgrItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectTrgrList(paramDto));
		List<SystemTrgrItemResDto> temList = rtnDto.getRows();
		for (Object tempDto : temList) {
			SystemTrgrItemResDto trgrItemDto = (SystemTrgrItemResDto) tempDto;
			String rid = trgrItemDto.getRid();
			Trigger trigger;
			try {
				trigger = scheduler.getTrigger(new TriggerKey(rid, "LoyTrgr"));
			} catch (SchedulerException e) {
				LogUtil.error(">>>>>> 트리거 조회 시 에러");
				LogUtil.error(e);
				throw new DataBadRequestException();
			}
			trgrItemDto.setPreExecDttm(trigger.getPreviousFireTime());
			trgrItemDto.setNextExecDttm(trigger.getNextFireTime());
		}

		return rtnDto;
	}

	 /*
	  * 1. 메소드명: getTrgrDetail
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemTrgrDetailResDto getTrgrDetail(SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return systemJobMapper.selectTrgrDetail(paramDto);
	}

	 /*
	  * 1. 메소드명: editTrgr
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editTrgr(SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		init();
		StatusResDto rtnValue = new StatusResDto();
		try {
			// Job 마스터 로우 아이디
			String ridJobMst = paramDto.getRidJobMst();

			// Job 조회
			JobDetail jobDetail = scheduler.getJobDetail(new JobKey(ridJobMst, "LoyJob"));

			// 트리거 로우 아이디
			String rid = paramDto.getRid();

			// 트리거 객체 생성
			SystemTrgrMakingReqDto trgrMakeReqDto = new SystemTrgrMakingReqDto();
			trgrMakeReqDto.setTrgrName(rid);
			trgrMakeReqDto.setCronExpr(paramDto.getCronExpr());
			trgrMakeReqDto.setDescription(paramDto.getTrgrNm());
			trgrMakeReqDto.setTriggerStartTime(paramDto.getStartDttm());
			trgrMakeReqDto.setTriggerEndTime(paramDto.getEndDttm());
			Trigger trigger = makeTrigger(trgrMakeReqDto, jobDetail);

			// 트리거 교체
			scheduler.rescheduleJob(new TriggerKey(rid, "LoyTrgr"), trigger);

			// 트리거 업데이트
			systemJobMapper.updateTrgr(paramDto);
			rtnValue.setSuccess(true);
			return rtnValue;
		} catch (SchedulerException e) {
			LogUtil.error(">>>>>> Job 조회 또는 트리거 교체 시 에러");
			LogUtil.error(e);
			throw new DataBadRequestException();
		}
	}

	 /*
	  * 1. 메소드명: removeTrgrList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeTrgrList(SystemTrgrListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		init();

		try {
			// 해제할 트리거 셋팅
			List<TriggerKey> triggerList = new ArrayList<TriggerKey>();
			for (String rid : paramDto.getRids()) {
				triggerList.add(new TriggerKey(rid, "LoyTrgr"));
			}

			// 트리거 해제
			scheduler.unscheduleJobs(triggerList);

			// 트리거 삭제
			systemJobMapper.deleteTrgrList(paramDto);
			rtnValue.setSuccess(true);
			return rtnValue;
		} catch (SchedulerException e) {
			LogUtil.error(">>>>>> 트리거 해제 시 에러");
			LogUtil.error(e);
			throw new DataBadRequestException();
		}
	}

	 /*
	  * 1. 메소드명: startTrgr
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto startTrgr(SystemTrgrStartPauseReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		init();

		try {
			String rid = paramDto.getRid();

			// 트리거 상세 조회
			SystemTrgrListReqDto trgrDtlReqDto = new SystemTrgrListReqDto();
			trgrDtlReqDto.setRid(rid);
			SystemTrgrDetailResDto trgrDtlResDto = systemJobMapper.selectTrgrDetail(trgrDtlReqDto);

			// 트리거 상태 검사
			if (trgrDtlResDto.getStatCd().equalsIgnoreCase("NORMAL")) {
				return new StatusResDto(true, "NORMAL");
			}

			// 트리거 시작
			scheduler.resumeTrigger(new TriggerKey(rid, "LoyTrgr"));

			// 트리거 상태 업데이트
			paramDto.setStatCd("NORMAL");
			systemJobMapper.updateTrgrStatCd(paramDto);
			rtnValue.setSuccess(true);
			return rtnValue;
		} catch (SchedulerException e) {
			LogUtil.error(">>>>>> 트리거 시작 시 에러");
			LogUtil.error(e);
			throw new DataBadRequestException();
		}
	}

	 /*
	  * 1. 메소드명: pauseTrgr
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto pauseTrgr(SystemTrgrStartPauseReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		init();

		try {
			String rid = paramDto.getRid();

			// 트리거 상세 조회
			SystemTrgrListReqDto trgrDtlReqDto = new SystemTrgrListReqDto();
			trgrDtlReqDto.setRid(rid);
			SystemTrgrDetailResDto trgrDtlResDto = systemJobMapper.selectTrgrDetail(trgrDtlReqDto);

			// 트리거 상태 검사
			if (trgrDtlResDto.getStatCd().equalsIgnoreCase("PAUSED")) {
				return new StatusResDto(true, "PAUSED");
			}

			// 트리거 정지
			scheduler.pauseTrigger(new TriggerKey(rid, "LoyTrgr"));

			// 트리거 상태 업데이트
			paramDto.setStatCd("PAUSED");
			systemJobMapper.updateTrgrStatCd(paramDto);
			rtnValue.setSuccess(true);
			return rtnValue;
		} catch (SchedulerException e) {
			LogUtil.error(">>>>>> 트리거 정지 시 에러");
			LogUtil.error(e);
			throw new DataBadRequestException();
		}
	}

	 /*
	  * 1. 메소드명: addAlrt
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto addAlrt(SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		systemJobMapper.insertAlrt(paramDto);
		String rid = paramDto.getRid();
		if (rid == null) {
			throw new DataUnhandledException(ErrorHelper.MSG_1001);
		}
		StatusResDto rtnDto = new StatusResDto(true, rid);
		return rtnDto;
	}

	 /*
	  * 1. 메소드명: getAlrtList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemAlrtItemResDto> getAlrtList(SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemAlrtItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectAlrtList(paramDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getAlrtDetail
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemAlrtDetailResDto getAlrtDetail(SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		SystemAlrtDetailResDto rtnValue  = new SystemAlrtDetailResDto();
		rtnValue = systemJobMapper.selectAlrtDetail(paramDto);

		return new AnnotationHelper<SystemAlrtDetailResDto>(AnnotationType.CommCode, rtnValue).getItem();
	}

	 /*
	  * 1. 메소드명: editAlrt
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editAlrt(SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.updateAlrt(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeAlrtList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeAlrtList(SystemAlrtListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.deleteAlrtList(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: addSbsqnt
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto addSbsqnt(SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		systemJobMapper.insertSbsqnt(paramDto);
		String rid = paramDto.getRid();
		if (rid == null) {
			throw new DataUnhandledException(ErrorHelper.MSG_1001);
		}
		StatusResDto rtnDto = new StatusResDto(true, rid);
		return rtnDto;
	}

	 /*
	  * 1. 메소드명: getSbsqntList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemSbsqntItemResDto> getSbsqntList(SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemSbsqntItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectSbsqntList(paramDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getSbsqntDetail
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemSbsqntDetailResDto getSbsqntDetail(SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		SystemSbsqntDetailResDto rtnValue = new SystemSbsqntDetailResDto();
		rtnValue = systemJobMapper.selectSbsqntDetail(paramDto);
		return new AnnotationHelper<SystemSbsqntDetailResDto>(AnnotationType.CommCode, rtnValue).getItem() ;
	}

	 /*
	  * 1. 메소드명: editSbsqnt
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editSbsqnt(SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.updateSbsqnt(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeSbsqntList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeSbsqntList(SystemSbsqntListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.deleteSbsqntTaskList(paramDto);
		systemJobMapper.deleteSbsqntList(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getChoiceJobList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemChoiceJobItemResDto> getChoiceJobList(SystemChoiceJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemChoiceJobItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectChoiceJobList(paramDto));
	}

	 /*
	  * 1. 메소드명: addTargetJob
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto addTargetJob(SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		systemJobMapper.insertTargetJob(paramDto);
		String rid = paramDto.getRid();
		if (rid == null) {
			throw new DataUnhandledException(ErrorHelper.MSG_1001);
		}
		StatusResDto rtnDto = new StatusResDto(true, rid);
		return rtnDto;
	}

	 /*
	  * 1. 메소드명: getTargetJobList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemTargetJobItemResDto> getTargetJobList(SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemTargetJobItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectTargetJobList(paramDto));
	}

	 /*
	  * 1. 메소드명: getTargetJobDetail
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemTargetJobDetailResDto getTargetJobDetail(SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return systemJobMapper.selectTargetJobDetail(paramDto);
	}

	 /*
	  * 1. 메소드명: editTargetJob
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editTargetJob(SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.updateTargetJob(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTargetJobList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeTargetJobList(SystemTargetJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.deleteTargetJobList(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getJobStepList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemJobStepItemResDto> getJobStepList(SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemJobStepItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.getJobStepList(paramDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getJobStepMapperList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemJobStepMapperItemResDto> getJobStepMapperList(
			SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemJobStepMapperItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.getJobStepMapperList(paramDto));
	}

	 /*
	  * 1. 메소드명: getJobStepDtl
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemJobStepItemResDto getJobStepDtl(SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);

		SystemJobStepItemResDto rtnValue = new SystemJobStepItemResDto();
		rtnValue = systemJobMapper.getJobStepDtl(paramDto);

		return new AnnotationHelper<SystemJobStepItemResDto>(AnnotationType.CommCode, rtnValue).getItem();
	}

	 /*
	  * 1. 메소드명: addJobStep
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto addJobStep(SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		String rid = CommonUtil.newRid();
		paramDto.setRid(rid);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.addJobStep(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editJobStep
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editJobStep(SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.editJobStep(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeJobStep
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeJobStep(SystemJobStepListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.removeJobStep(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getJobStepMapperDtl
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemJobStepMapperItemResDto getJobStepMapperDtl(SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return systemJobMapper.getJobStepMapperDtl(paramDto);
	}

	 /*
	  * 1. 메소드명: addJobStepMapper
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto addJobStepMapper(SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		String rid = CommonUtil.newRid();
		paramDto.setRid(rid);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.addJobStepMapper(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editJobStepMapper
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editJobStepMapper(SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.editJobStepMapper(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeJobStepMapper
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeJobStepMapper(SystemJobStepMapperListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.removeJobStepMapper(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getJobLogList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemJobItemResDto> getJobLogList(SystemJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemJobItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.getJobLogList(paramDto));
	}

	 /*
	  * 1. 메소드명: getBatchLogList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemJobItemResDto> getBatchLogList(SystemJobListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemJobItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.getBatchLogList(paramDto));
	}

	 /*
	  * 1. 메소드명: sendJobScheduler
	  * 2. 클래스명: SystemJobService
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
	 *   @param method
	 *   @return
	 */
	public String sendJobScheduler(String method) {
		LogUtil.debug("jobScheduler 실행");
		String url = CommonUtil.getInstance().getServletProp("icignal.batch.host");
		url += "/api" + method;
		LogUtil.debug("url : " + url);
		RestTemplate restTemplate = new RestTemplate();
		String result = restTemplate.getForObject(url, String.class);
		LogUtil.debug("Scheduler 결과 : " + result);
		return result;
	}

	 /*
	  * 1. 메소드명: getJobStepCommandList
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemJobStepCommandItemResDto> getJobStepCommandList(
			SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemJobStepCommandItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.getJobStepCommandList(paramDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getJobStepCommandDtl
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public SystemJobStepCommandItemResDto getJobStepCommandDtl(SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		SystemJobStepCommandItemResDto rtnValue = new SystemJobStepCommandItemResDto();
		rtnValue = systemJobMapper.getJobStepCommandDtl(paramDto);
		return new AnnotationHelper<SystemJobStepCommandItemResDto>(AnnotationType.CommCode, rtnValue).getItem();
	}

	 /*
	  * 1. 메소드명: addJobStepCommand
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto addJobStepCommand(SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		String rid = CommonUtil.newRid();
		paramDto.setRid(rid);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.addJobStepCommand(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editJobStepCommand
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto editJobStepCommand(SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.editJobStepCommand(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeJobStepCommand
	  * 2. 클래스명: SystemJobService
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
	 *   @param paramDto
	 *   @return
	 */
	public StatusResDto removeJobStepCommand(SystemJobStepCommandListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.removeJobStepCommand(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	 /*
	  * 1. 메소드명: getBatchParameterList
	  * 2. 클래스명: SystemJobService
	  * 3. 작성자명: sy.Cha
	  * 4. 작성일자: 2020.09.15
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 * @param paramDto
	 *   @param paramDto
	 *   @return
	 */
	public GridPagingResDto<SystemBatchParameterItemResDto> getBatchParameterList(SystemBatchParameterListReqDto paramDto){
			LogUtil.param(this.getClass(), paramDto);
			return new GridPagingResHelper<SystemBatchParameterItemResDto>().newGridPagingResDto(
					paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectBatchParameterList(paramDto), AnnotationType.CommCode);
	}

	public StatusResDto addBatchParameter(SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		paramDto.setRid(CommonUtil.newRid());
		systemJobMapper.addBatchParameter(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto editBatchParameter(SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.editBatchParameter(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public SystemBatchParameterItemResDto getBatchParameterDtl(SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);

		SystemBatchParameterItemResDto rtnValue = new SystemBatchParameterItemResDto();
		rtnValue = systemJobMapper.selectBatchParameterDtl(paramDto);

		return new AnnotationHelper<SystemBatchParameterItemResDto>(AnnotationType.CommCode, rtnValue).getItem();
	}

	public StatusResDto removeBatchParameter(SystemBatchParameterListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.removeBatchParameter(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public GridPagingResDto<SystemJobStepParamItemResDto> getJobStepParamList(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		return new GridPagingResHelper<SystemJobStepParamItemResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectJobStepParamList(paramDto), AnnotationType.CommCode);
	}

	public StatusResDto addJobStepParam(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		paramDto.setRid(CommonUtil.newRid());
		systemJobMapper.addJobStepParam(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto editJobStepParam(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.editJobStepParam(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto removeJobStepParam(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.removeJobStepParam(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public SystemJobStepParamItemResDto getJobStepParamDtl(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(), paramDto);

		SystemJobStepParamItemResDto rtnValue = new SystemJobStepParamItemResDto();
		rtnValue = systemJobMapper.selectJobStepParamDtl(paramDto);

		return new AnnotationHelper<SystemJobStepParamItemResDto>(AnnotationType.CommCode, rtnValue).getItem();
	}


	public GridPagingResDto<jobStepInfoExecuteParamResDto> getInfoExecuteParam(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(),paramDto);
		return new GridPagingResHelper<jobStepInfoExecuteParamResDto>().newGridPagingResDto(
				paramDto.init(CommonUtil.getInstance().getDBType()), systemJobMapper.getInfoExecuteParam(paramDto), AnnotationType.CommCode);
	}

	public jobStepInfoExecuteDtlResDto getParamInfoDtl(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(),paramDto);
		return systemJobMapper.getParamInfoDtl(paramDto);
	}

	public StatusResDto saveParamInfo(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(),paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.saveParamInfo(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto editParamInfo(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(),paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.editParamInfo(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto deleteParamInfo(SystemJobStepParamListReqDto paramDto) {
		LogUtil.param(this.getClass(),paramDto);
		StatusResDto rtnValue = new StatusResDto();
		systemJobMapper.deleteParamInfo(paramDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getjobProcLogList
	  * 2. 클래스명: SystemJobService
	  * 3. 작성자명: noh.hyungrae 
	  * 4. 작성일자: 2020. 12. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		batch관리 - 상세 이력 tab
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param paramDto
	 *   @return	
	 */
	public GridPagingResDto<SystemJobItemResDto> getjobProcLogList(SystemJobListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<SystemJobItemResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemJobMapper.selectJobProcLogList(param));
	}
}