package com.icignal.marketing.batch.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.RestAPIUtil;
import com.icignal.marketing.batch.dto.request.MktBatchJobReqDto;
import com.icignal.marketing.batch.dto.response.MktBatchJobResDto;
import com.icignal.marketing.batch.dto.response.MktBatchLogResDto;
import com.icignal.marketing.batch.mapper.MktBatchMapper;


@Service
public class MktBatchService {
	@Autowired
	private MktBatchMapper mktBatchMapper;

	
	/**
	 * 배치 job 목록 조회
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public GridPagingResDto<MktBatchJobResDto> getMktBatchJobList(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);		     
		dto.setSVCAlias("t1");
		
		GridPagingResDto<MktBatchJobResDto> rtnValue = new GridPagingResHelper<MktBatchJobResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				mktBatchMapper.selectMktBatchJobList(dto));
		
		for (MktBatchJobResDto job : rtnValue.getRows()) {
			MktBatchJobReqDto req = new MktBatchJobReqDto();
			req.setJobNm(job.getJobNm());
			
			StatusResDto status = statusMktBatchJob(req);
			
			if (status.getSuccess()) {
				job.setStatus("Y");
			} else {
				job.setStatus("N");
			}
		}
		
		return rtnValue;
	}
	
	/**
	 * 배치 job 저장
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto saveMktBatchJob(MktBatchJobReqDto dto) {
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);
		
		if (ObjectUtil.isNotEmpty(dto.getRid())) {
			rtnValue = editMktBatchJob(dto);
		} else {
			rtnValue = addMktBatchJob(dto);
		}
		
		return rtnValue;
	}

	/**
	 * 배치 job 등록
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto addMktBatchJob(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);
		
		mktBatchMapper.insertMktBatchJob(dto);
	
		return rtnValue;
	}		

	/**
	 * 배치 job 수정
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto editMktBatchJob(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);
		
		mktBatchMapper.updateMktBatchJob(dto);
		
		StatusResDto status = statusMktBatchJob(dto);
		if (status.getSuccess()) {
			changeMktBatchJob(dto);
		}
	
		return rtnValue;
	}	
	
	/**
	 * 배치 job 삭제
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto removeMktBatchJob(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);
		
		mktBatchMapper.deleteMktBatchJob(dto);
		StatusResDto status = statusMktBatchJob(dto);
		if (status.getSuccess()) {
			stopMktBatchJob(dto);
		}
	
		return rtnValue;
	}
	
	/**
	 * 배치 job 실행
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto startMktBatchJob(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);

		dto.setUseYn("Y");
		mktBatchMapper.updateMktBatchJobUseYn(dto);
		
		try {
			String url = BeansUtil.getApplicationProperty("icignal.marketing.batch-api-url") + "/api/batch/start";
			rtnValue = (StatusResDto) RestAPIUtil.jsonPost(url, dto, StatusResDto.class);

			if (ObjectUtil.isEmpty(rtnValue)) {
				rtnValue = new StatusResDto(false, "Marketing batch server error..");
			}
		} catch (Exception e) {
			rtnValue = new StatusResDto(false, "Marketing batch server error..");
		}
	
		return rtnValue;
	}
	
	/**
	 * 배치 job 수동 실행
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto runMktBatchJob(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);
		
		try {
			String url = BeansUtil.getApplicationProperty("icignal.marketing.batch-api-url") + "/api/batch/run";
			rtnValue = (StatusResDto) RestAPIUtil.jsonPost(url, dto, StatusResDto.class);

			if (ObjectUtil.isEmpty(rtnValue)) {
				rtnValue = new StatusResDto(false, "Marketing batch server error..");
			}
		} catch (Exception e) {
			rtnValue = new StatusResDto(false, "Marketing batch server error..");
		}
	
		return rtnValue;
	}
	
	/**
	 * 배치 job 중지
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto stopMktBatchJob(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);
		
		dto.setUseYn("N");
		mktBatchMapper.updateMktBatchJobUseYn(dto);
		
		try {
			String url = BeansUtil.getApplicationProperty("icignal.marketing.batch-api-url") + "/api/batch/stop";
			rtnValue = (StatusResDto) RestAPIUtil.jsonPost(url, dto, StatusResDto.class);

			if (ObjectUtil.isEmpty(rtnValue)) {
				rtnValue = new StatusResDto(false, "Marketing batch server error..");
			}
		} catch (Exception e) {
			rtnValue = new StatusResDto(false, "Marketing batch server error..");
		}
	
		return rtnValue;
	}
	
	/**
	 * 배치 job 변경
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto changeMktBatchJob(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);
		
		try {
			String url = BeansUtil.getApplicationProperty("icignal.marketing.batch-api-url") + "/api/batch/change";
			rtnValue = (StatusResDto) RestAPIUtil.jsonPost(url, dto, StatusResDto.class);

			if (ObjectUtil.isEmpty(rtnValue)) {
				rtnValue = new StatusResDto(false, "Marketing batch server error..");
			}
		} catch (Exception e) {
			rtnValue = new StatusResDto(false, "Marketing batch server error..");
		}
	
		return rtnValue;
	}
	
	/**
	 * 배치 job 상태
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public StatusResDto statusMktBatchJob(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);
		StatusResDto rtnValue = new StatusResDto(true, null);
		
		try {
			String url = BeansUtil.getApplicationProperty("icignal.marketing.batch-api-url") + "/api/batch/status";
			rtnValue = (StatusResDto) RestAPIUtil.jsonPost(url, dto, StatusResDto.class);

			if (ObjectUtil.isEmpty(rtnValue)) {
				rtnValue = new StatusResDto(false, "Marketing batch server error..");
			}
		} catch (Exception e) {
			rtnValue = new StatusResDto(false, "Marketing batch server error..");
		}
	
		return rtnValue;
	}
	
	/**
	 * 배치 로그 헤더 목록 조회
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public GridPagingResDto<MktBatchLogResDto> getMktBatchLogHadList(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);		     
		dto.setSVCAlias("t1");
		
		return  new GridPagingResHelper<MktBatchLogResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				mktBatchMapper.selectMktBatchLogHadList(dto));
	}
	
	/**
	 * 배치 로그 상세 목록 조회
	 *
	 * @author dgryu
	 * @since 2020. 8. 24.
	 */
	public GridPagingResDto<MktBatchLogResDto> getMktBatchLogDtlList(MktBatchJobReqDto dto){
		LogUtil.param(MktBatchService.class, dto);		     
		dto.setSVCAlias("t1");
		
		return  new GridPagingResHelper<MktBatchLogResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				mktBatchMapper.selectMktBatchLogDtlList(dto));
	}
	
}
