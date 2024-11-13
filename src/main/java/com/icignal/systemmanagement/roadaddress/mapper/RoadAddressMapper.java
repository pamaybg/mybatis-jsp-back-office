package com.icignal.systemmanagement.roadaddress.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.roadaddress.dto.request.RoadAddressReqDto;
import com.icignal.systemmanagement.roadaddress.dto.response.RoadAddressResDto;

/*
 * 1. 클래스명	: RoadAddressMapper
 * 2. 파일명	: RoadAddressMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.roadaddress.mapper
 * 4. 작성자명	: jb.kim
 * 5. 작성일자	: 2020. 12. 04.
 */
/**
 * <PRE>
 * 1. 설명
 *	: 시스템운영 - 도로명 주소 관리 Mapper
 * </PRE>
 */

@Mapper
public interface RoadAddressMapper {

	public List<RoadAddressResDto> getRoadAddressList(RoadAddressReqDto param);
	
	
	
	
	
	
}
