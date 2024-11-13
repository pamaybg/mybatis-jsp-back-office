package com.icignal.systemmanagement.banner.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.banner.dto.request.SystemBannerInsertReqDto;
import com.icignal.systemmanagement.banner.dto.request.SystemBannerReqDto;
import com.icignal.systemmanagement.banner.dto.response.SystemBannerDetailResDto;
import com.icignal.systemmanagement.banner.dto.response.SystemBannerListResDto;

/*
 * 1. 클래스명	: SystemBannerMapper
 * 2. 파일명	: SystemBannerMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.banner.mapper
 * 4. 작성자명	: mjpyo
 * 5. 작성일자	: 2017. 3. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 배너 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemBannerMapper {

	List<SystemBannerListResDto> getBannerList(SystemBannerReqDto reqDTO);

	void updateBanner(SystemBannerInsertReqDto reqDTO);

	void insertBanner(SystemBannerInsertReqDto reqDTO);
	
	String getBannerId(SystemBannerReqDto reqDTO);

	SystemBannerDetailResDto getBannerDetail(SystemBannerReqDto reqDTO);

	void increaseBannerCount(SystemBannerReqDto reqDTO);

	void updateBannerMaster(SystemBannerInsertReqDto reqDTO);

	void insertBannerMaster(SystemBannerInsertReqDto reqDTO);

	SystemBannerDetailResDto getBannerMasterDetail(SystemBannerReqDto reqDTO);



}
