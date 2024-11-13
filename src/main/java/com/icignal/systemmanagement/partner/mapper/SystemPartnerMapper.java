package com.icignal.systemmanagement.partner.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.partner.dto.request.SystemPartnerDetailReqDto;
import com.icignal.systemmanagement.partner.dto.request.SystemPartnerInsertReqDto;
import com.icignal.systemmanagement.partner.dto.request.SystemPartnerListReqDto;
import com.icignal.systemmanagement.partner.dto.response.SystemPartnerDetailResDto;
import com.icignal.systemmanagement.partner.dto.response.SystemPartnerListResDto;

/*
 * 1. 클래스명	: SystemPartnerMaper
 * 2. 파일명	: SystemPartnerMaper.java
 * 3. 패키지명	: com.icignal.systemmanagement.partner.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 제휴 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemPartnerMapper {

	List<SystemPartnerListResDto> getPartnerList(SystemPartnerListReqDto reqDTO);

	void insertPartner(SystemPartnerInsertReqDto reqDTO);

	SystemPartnerDetailResDto getPartnerDetail(SystemPartnerDetailReqDto reqDTO);

	void updatePartnerMaster(SystemPartnerInsertReqDto reqDTO);

	void insertPartnerMaster(SystemPartnerInsertReqDto reqDTO);

	SystemPartnerDetailResDto getPartnerMasterDetail(SystemPartnerDetailReqDto reqDTO);

}
