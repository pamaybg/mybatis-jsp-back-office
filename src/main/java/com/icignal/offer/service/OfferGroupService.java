package com.icignal.offer.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.offer.dto.request.ChildOfferReqDto;
import com.icignal.offer.dto.request.OfferGroupReqDto;
import com.icignal.offer.dto.response.ChildOfferResDto;
import com.icignal.offer.dto.response.OfferGroupResDto;
import com.icignal.offer.mapper.OfferGroupMapper;

@Service
public class OfferGroupService {

	@Autowired
	OfferGroupMapper offerGroupMapper;
	
	public GridPagingResDto<OfferGroupResDto> getOfferGroupList(OfferGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<OfferGroupResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerGroupMapper.selectOfferGroupList(reqDto), AnnotationType.CommCode);
	}
	
	public OfferGroupResDto getOfferGroupDetail(OfferGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return offerGroupMapper.selectOfferGroupDetail(reqDto);
	}
	
	public StatusResDto updateOfferGroup(OfferGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		        
		offerGroupMapper.updateOfferGroup(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto insertOfferGroup(OfferGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

        reqDto.setRid(CommonUtil.newRid());
		
        StatusResDto rtnValue = new StatusResDto();
        offerGroupMapper.insertOfferGroup(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto deleteOfferGroup(OfferGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		
		offerGroupMapper.updateOfferGroupDel(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public GridPagingResDto<ChildOfferResDto> getChildOfferList(ChildOfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<ChildOfferResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerGroupMapper.selectChildOfferList(reqDto), AnnotationType.CommCode);
	}
	
	public ChildOfferResDto getChildOfferDetail(ChildOfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return offerGroupMapper.selectChildOfferDetail(reqDto);
	}
	
	public StatusResDto updateChildOffer(ChildOfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		        
		offerGroupMapper.updateChildOffer(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto insertChildOffer(ChildOfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

        reqDto.setRid(CommonUtil.newRid());
		
        StatusResDto rtnValue = new StatusResDto();
        offerGroupMapper.insertChildOffer(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto deleteChildOffer(ChildOfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		
		offerGroupMapper.updateChildOfferDel(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
}
