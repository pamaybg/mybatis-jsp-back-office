package com.icignal.mobile.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.mobile.dto.request.MktMobileCampaginReqDto;
import com.icignal.mobile.dto.response.MktCampaignApprovalReqListResDto;
import com.icignal.mobile.mapper.MobileMapper;


@Service
public class MobileService {
	@Autowired
	private MobileMapper mobileMapper;

	/**
	 * 모바일 캠페인 승인 대상 리스트 조회
	 *
	 * @author ps.lee
	 * @since 2022. 3. 1.
	 */
	public GridPagingResDto<MktCampaignApprovalReqListResDto> getCampaginApprovalReqList(MktMobileCampaginReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
        return new GridPagingResHelper<MktCampaignApprovalReqListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                mobileMapper.getCampaginApprovalReqList(reqDto),
                AnnotationType.CommCode);
	}

	public StatusResDto setCampaginApproval(MktMobileCampaginReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mobileMapper.setCampaginApproval(reqDto);
	}

	public StatusResDto setCampaginReject(MktMobileCampaginReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mobileMapper.setCampaginReject(reqDto);
	}

}
