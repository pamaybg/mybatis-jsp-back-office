/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: MktStoreReportMapper.java
 * 2. Package	: com.icignal.marketing.storeReport.mapper
 * 3. Comments	:	
 * 4. Author	: ps.lee
 * 5. DateTime	: 2022. 3. 1.
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022. 3. 1.		 | ps.lee			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.mobile.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.mobile.dto.request.MktMobileCampaginReqDto;
import com.icignal.mobile.dto.response.MktCampaignApprovalReqListResDto;

/*
 * 1. 클래스명	: MktStoreReportMapper
 * 2. 파일명	: MktStoreReportMapper.java
 * 3. 패키지명	: com.icignal.marketing.storeReport.mapper
 * 4. 작성자명	: ps.lee
 * 5. 작성일자	: 2022. 3. 1.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface MobileMapper {

	List<MktCampaignApprovalReqListResDto> getCampaginApprovalReqList(MktMobileCampaginReqDto reqDto);

	StatusResDto setCampaginApproval(MktMobileCampaginReqDto reqDto);

	StatusResDto setCampaginReject(MktMobileCampaginReqDto reqDto);

}
