package com.icignal.systemmanagement.intact.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.intact.dto.request.SystemIntactCheckReqDto;
import com.icignal.systemmanagement.intact.dto.request.SystemIntactDetailReqDto;
import com.icignal.systemmanagement.intact.dto.request.SystemIntactListReqDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactCheckResDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactDetailResDto;
import com.icignal.systemmanagement.intact.dto.response.SystemIntactListResDto;

/*
 * 1. 클래스명	: SystemIntactMapper
 * 2. 파일명	: SystemIntactMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.intact.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 3.
 */
/**
 * <PRE>
 * 1. 설명
 *		인터렉션 유형 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemIntactMapper {

	List<SystemIntactListResDto> selectLoyIntactList(SystemIntactListReqDto param);

	SystemIntactDetailResDto selectLoyIntactItem(SystemIntactDetailReqDto param);

	SystemIntactCheckResDto checkCampaignsUsingIntect(SystemIntactCheckReqDto param);

	SystemIntactCheckResDto checkDuplicationIntactType(SystemIntactCheckReqDto param);

	void insertIntactItem(SystemIntactDetailReqDto param);

	void updateIntactItem(SystemIntactDetailReqDto param);

	void deleteIntactItem(SystemIntactDetailReqDto param);

}
