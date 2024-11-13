package com.icignal.systemmanagement.unstruc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.unstruc.dto.request.SystemUnstrucDetailReqDto;
import com.icignal.systemmanagement.unstruc.dto.request.SystemUnstrucListReqDto;
import com.icignal.systemmanagement.unstruc.dto.response.SystemUnstrucDetailResDto;
import com.icignal.systemmanagement.unstruc.dto.response.SystemUnstrucListResDto;

/*
 * 1. 클래스명	: SystemUnstrucMapper
 * 2. 파일명	: SystemUnstrucMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.unstruc.mapper
 * 4. 작성자명	:
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		이벤트 함수 유형 관리형 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemUnstrucMapper {

	List<SystemUnstrucListResDto> selectLoyUnstrucList(SystemUnstrucListReqDto param);

	SystemUnstrucDetailResDto selectLoyUnstrucItem(SystemUnstrucDetailReqDto param);

	SystemUnstrucDetailResDto selectUsingByCampaignChk(SystemUnstrucDetailReqDto param);

	SystemUnstrucDetailResDto selectUnstrucChk(SystemUnstrucDetailReqDto param);

	void insertUnstrucItem(SystemUnstrucDetailReqDto param);

	void updateUnstrucItem(SystemUnstrucDetailReqDto param);

	void deleteUnstrucItem(SystemUnstrucDetailReqDto param);


}
