package com.icignal.systemmanagement.job.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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

/*
 * 1. 클래스명	: SystemJobMapper
 * 2. 파일명	: SystemJobMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.job.mapper
 * 4. 작성자명	:
 * 5. 작성일자	: 2020. 2. 25.
 */

/**
 * <PRE>
 * 1. 설명
 *		Batch (JOB) 관리 Mapper
 * </PRE>
 */
@Mapper
public interface SystemJobMapper {

	List<SystemJobItemResDto> selectJobList(SystemJobListReqDto paramDto);

	void insertJob(SystemJobInsertReqDto paramDto);

	SystemJobDetailResDto selectJobDetail(SystemJobDetailReqDto paramDto);

	void updateJob(SystemJobUpdateReqDto paramDto);

	void deleteJobList(SystemJobDetailReqDto paramDto);

	List<SystemExecParamItemResDto> selectExecParamList(SystemExecParamListReqDto paramDto);

	Integer checkParamSeqDup(SystemExecParamListReqDto paramDupChkReqDto);

	void insertExecParam(SystemExecParamListReqDto paramDto);

	SystemExecParamDetailResDto selectExecParamDetail(SystemExecParamListReqDto paramDto);

	void updateExecParam(SystemExecParamListReqDto paramDto);

	void deleteExecParamList(SystemExecParamListReqDto paramDto);

	List<SystemLogItemResDto> selectLogList(SystemLogListReqDto paramDto);

	List<Object> selectLogListForExcel(SystemLogListReqDto paramDto);

	List<SystemLogDtlItemResDto> selectLogDtlList(SystemLogDtlListReqDto paramDto);

	List<Object> selectLogDtlListForExcel(SystemLogDtlListReqDto paramDto);

	void insertTrgr(SystemTrgrListReqDto paramDto);

	void deleteTrgrList(SystemTrgrListReqDto trgrListDelReqDto);

	List<SystemTrgrItemResDto> selectTrgrList(SystemTrgrListReqDto paramDto);

	SystemTrgrDetailResDto selectTrgrDetail(SystemTrgrListReqDto paramDto);

	void updateTrgr(SystemTrgrListReqDto paramDto);

	void updateTrgrStatCd(SystemTrgrStartPauseReqDto paramDto);

	void insertAlrt(SystemAlrtListReqDto paramDto);

	List<SystemAlrtItemResDto> selectAlrtList(SystemAlrtListReqDto paramDto);

	SystemAlrtDetailResDto selectAlrtDetail(SystemAlrtListReqDto paramDto);

	void updateAlrt(SystemAlrtListReqDto paramDto);

	void deleteAlrtList(SystemAlrtListReqDto paramDto);

	void insertSbsqnt(SystemSbsqntListReqDto paramDto);

	List<SystemSbsqntItemResDto> selectSbsqntList(SystemSbsqntListReqDto paramDto);

	SystemSbsqntDetailResDto selectSbsqntDetail(SystemSbsqntListReqDto paramDto);

	void updateSbsqnt(SystemSbsqntListReqDto paramDto);

	void deleteSbsqntTaskList(SystemSbsqntListReqDto paramDto);

	void deleteSbsqntList(SystemSbsqntListReqDto paramDto);

	List<SystemChoiceJobItemResDto> selectChoiceJobList(SystemChoiceJobListReqDto paramDto);

	void insertTargetJob(SystemTargetJobListReqDto paramDto);

	List<SystemTargetJobItemResDto> selectTargetJobList(SystemTargetJobListReqDto paramDto);

	SystemTargetJobDetailResDto selectTargetJobDetail(SystemTargetJobListReqDto paramDto);

	void updateTargetJob(SystemTargetJobListReqDto paramDto);

	void deleteTargetJobList(SystemTargetJobListReqDto paramDto);

	List<SystemJobStepItemResDto> getJobStepList(SystemJobStepListReqDto paramDto);

	List<SystemJobStepMapperItemResDto> getJobStepMapperList(SystemJobStepMapperListReqDto paramDto);

	SystemJobStepItemResDto getJobStepDtl(SystemJobStepListReqDto paramDto);

	void addJobStep(SystemJobStepListReqDto paramDto);

	void editJobStep(SystemJobStepListReqDto paramDto);

	void removeJobStep(SystemJobStepListReqDto paramDto);

	SystemJobStepMapperItemResDto getJobStepMapperDtl(SystemJobStepMapperListReqDto paramDto);

	void addJobStepMapper(SystemJobStepMapperListReqDto paramDto);

	void editJobStepMapper(SystemJobStepMapperListReqDto paramDto);

	void removeJobStepMapper(SystemJobStepMapperListReqDto paramDto);

	List<SystemJobItemResDto> getJobLogList(SystemJobListReqDto paramDto);

	List<SystemJobItemResDto> getBatchLogList(SystemJobListReqDto paramDto);

	List<SystemJobStepCommandItemResDto> getJobStepCommandList(SystemJobStepCommandListReqDto paramDto);

	SystemJobStepCommandItemResDto getJobStepCommandDtl(SystemJobStepCommandListReqDto paramDto);

	void addJobStepCommand(SystemJobStepCommandListReqDto paramDto);

	void editJobStepCommand(SystemJobStepCommandListReqDto paramDto);

	void removeJobStepCommand(SystemJobStepCommandListReqDto paramDto);

	List<SystemBatchParameterItemResDto> selectBatchParameterList(SystemBatchParameterListReqDto paramDto);

	void addBatchParameter(SystemBatchParameterListReqDto paramDto);

	void editBatchParameter(SystemBatchParameterListReqDto paramDto);

	SystemBatchParameterItemResDto selectBatchParameterDtl(SystemBatchParameterListReqDto paramDto);

	void removeBatchParameter(SystemBatchParameterListReqDto paramDto);

	List<SystemJobStepParamItemResDto> selectJobStepParamList(SystemJobStepParamListReqDto paramDto);

	void addJobStepParam(SystemJobStepParamListReqDto paramDto);

	void editJobStepParam(SystemJobStepParamListReqDto paramDto);

	void removeJobStepParam(SystemJobStepParamListReqDto paramDto);

	SystemJobStepParamItemResDto selectJobStepParamDtl(SystemJobStepParamListReqDto paramDto);

    List<jobStepInfoExecuteParamResDto> getInfoExecuteParam(SystemJobStepParamListReqDto paramDto);
    
	jobStepInfoExecuteDtlResDto getParamInfoDtl(SystemJobStepParamListReqDto paramDto);

	void saveParamInfo(SystemJobStepParamListReqDto paramDto);

	void editParamInfo(SystemJobStepParamListReqDto paramDto);

	void deleteParamInfo(SystemJobStepParamListReqDto paramDto);

	List<SystemJobItemResDto> selectJobProcLogList(SystemJobListReqDto param);
}