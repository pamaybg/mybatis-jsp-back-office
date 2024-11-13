package com.icignal.marketing.batch.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.marketing.batch.dto.request.MktBatchJobReqDto;
import com.icignal.marketing.batch.dto.response.MktBatchJobResDto;
import com.icignal.marketing.batch.dto.response.MktBatchLogResDto;

@Mapper
public interface MktBatchMapper {

	public List<MktBatchJobResDto> selectMktBatchJobList(MktBatchJobReqDto dto);

	public void insertMktBatchJob(MktBatchJobReqDto dto);

	public void updateMktBatchJob(MktBatchJobReqDto dto);

	public void deleteMktBatchJob(MktBatchJobReqDto dto);

	public List<MktBatchLogResDto> selectMktBatchLogHadList(MktBatchJobReqDto dto);

	public List<MktBatchLogResDto> selectMktBatchLogDtlList(MktBatchJobReqDto dto);
	
	public void updateMktBatchJobUseYn(MktBatchJobReqDto dto);
}
