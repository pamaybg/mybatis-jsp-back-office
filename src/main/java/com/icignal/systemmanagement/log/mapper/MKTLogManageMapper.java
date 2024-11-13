package com.icignal.systemmanagement.log.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.log.dto.request.MKTLogManageListReqDto;
import com.icignal.systemmanagement.log.dto.response.MKTLogManageListResDto;

/*
 * 1. 클래스명	: MKTLogManageMapper
 * 2. 파일명	: MKTLogManageMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.log.mapper
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 마켓팅 로그 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface MKTLogManageMapper {

	List<MKTLogManageListResDto> getLogList(MKTLogManageListReqDto param);

}
