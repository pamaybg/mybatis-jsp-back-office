package com.icignal.marketing.fatigue.service;

import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.loyalty.membership.dto.response.LoyMbrGroupAddInfoResDto;
import com.icignal.marketing.fatigue.dto.response.MktFatigueChnlItemResDto;
import org.apache.ibatis.annotations.Case;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.marketing.fatigue.dto.request.MktDeleteFatigueReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueDetailReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueModifyReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueReqDto;
import com.icignal.marketing.fatigue.dto.request.MktFatigueSetReqDto;
import com.icignal.marketing.fatigue.dto.response.MktFatigueDetailResDto;
import com.icignal.marketing.fatigue.dto.response.MktFatigueResDto;
import com.icignal.marketing.fatigue.mapper.MktFatigueMapper;


/**
	@file MKTFatigueService.java
	@date 2015. 11. 30.
	@author 안형욱
*/
@Service
public class MktFatigueService {
	@Autowired
	private MktFatigueMapper mktFatigueMapper;

	
	/**
	 * @name : getFatigueList
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return : MKTFatigueResponseDTO
	 * @description : 피로도 목록 조회
	 */
	public GridPagingResDto<MktFatigueResDto> getFatigueList(MktFatigueReqDto dto){
		LogUtil.param(MktFatigueService.class, dto);		     
		dto.setSVCAlias("mfm");
		return new GridPagingResHelper<MktFatigueResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				mktFatigueMapper.getFatigueList(dto));
	}
	
	/**
	 * @name : getFatigueDetail
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return : MKTFatigueDetailResponseDTO
	 * @description : 피로도 세부사항 조회 
	 */
	public MktFatigueDetailResDto getFatigueDetail(MktFatigueDetailReqDto dto){
		LogUtil.param(MktFatigueService.class, dto);

		MktFatigueDetailResDto rtnValue = mktFatigueMapper.getFatigueDetail(dto);

		String[] splitChnlList = null;

		if(StringUtil.isNotEmpty(rtnValue.getChnlList())){
			splitChnlList = rtnValue.getChnlList().split(",");
		}

		for(String chnlData : splitChnlList){
			if(chnlData.equals("SMS")) {
				rtnValue.setSmsFlag(true);
			} else if(chnlData.equals("LMS")){
				rtnValue.setLmsFlag(true);
			} else if(chnlData.equals("MMS")){
				rtnValue.setMmsFlag(true);
			} else if(chnlData.equals("PUSH")){
				rtnValue.setPushFlag(true);
			} else if(chnlData.equals("EMAIL")){
				rtnValue.setEmailFlag(true);
			} else if(chnlData.equals("KAKAOFR")){
				rtnValue.setKakaoFrFlag(true);
			}
		}

		return rtnValue;
	}
	
	/**
	 * @name : insertFatigue
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return : StatusResDto
	 * @description : 피로도 추가
	 */
	public StatusResDto insertFatigue(MktFatigueSetReqDto dto){
		LogUtil.param(MktFatigueService.class, dto);
		dto.setSVCAlias("");
		String rid = CommonUtil.newRid();
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		dto.setId(rid);
		//피로도 체크 - 어카운트 별 채널별 1개씩만 등록 가능
		mktFatigueMapper.insertFatigue(dto);

		MktFatigueReqDto fatiItem = new MktFatigueReqDto();

		String [] splitChnl = dto.getChnlCheckedList().split(",");

		for (String chnlData : splitChnl) {
			fatiItem.setChnlTypeCd(chnlData);
			fatiItem.setChnlTypeCd(chnlData);
			fatiItem.setRidFati(rid);
			fatiItem.setCreateBy(dto.getCreateBy());
			mktFatigueMapper.insertFatiItem(fatiItem);
		}

		rtnValue.setMessage(rid);
		rtnValue.setSuccess(true);

		return rtnValue;
	}		

	/**
	 * @name : updateFatigue
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return : StatusResDto
	 * @description : 피로도 수정
	 */
	
	public StatusResDto updateFatigue(MktFatigueModifyReqDto dto){
		LogUtil.param(MktFatigueService.class, dto);	
		
		StatusResDto rtnValue = new StatusResDto();
		
		//피로도 체크 - 어카운트 별 채널별 1개씩만 등록 가능
		MktFatigueSetReqDto requestData = new MktFatigueSetReqDto();
		
		requestData.setLang(dto.getLang());
		requestData.setChnlTypeCd(dto.getChnlTypeCd());
		requestData.setId(dto.getId());
		
		rtnValue.setSuccess(false);
		mktFatigueMapper.updateFatigue(dto);

		MktFatigueReqDto chnlItemId = new MktFatigueReqDto();
		chnlItemId.setId(dto.getId());
		mktFatigueMapper.deleteFatigueChnlItem(chnlItemId);

		MktFatigueReqDto fatiItem = new MktFatigueReqDto();

		String [] splitChnl = dto.getChnlCheckedList().split(",");

		for (String chnlData : splitChnl) {
			fatiItem.setChnlTypeCd(chnlData);
			fatiItem.setRidFati(dto.getId());
			fatiItem.setCreateBy(dto.getCreateBy());
			mktFatigueMapper.insertFatiItem(fatiItem);
		}

		rtnValue.setSuccess(true);


		
		return rtnValue;
		
	}	
	
	/**
	 * @name : deleteFatigue
	 * @date : 2015. 11. 30.
	 * @author : 안형욱
	 * @return : StatusResDto
	 * @description : 피로도 삭제
	 */
	
	
	public StatusResDto deleteFatigue(MktDeleteFatigueReqDto dto){
		LogUtil.param(MktFatigueService.class, dto);		 
		dto.setSVCAlias("");
		StatusResDto rtnVal = new StatusResDto();
		rtnVal.setSuccess(false);
		mktFatigueMapper.deleteFatigue(dto);
		MktFatigueReqDto chnlItemId = new MktFatigueReqDto();
		chnlItemId.setId(dto.getId());
		mktFatigueMapper.deleteFatigueChnlItem(chnlItemId);
		rtnVal.setSuccess(true);
		return rtnVal;
	}	
	
	
	/**
	 * @name : fatigueCheck
	 * @date : 2016. 03. 30.
	 * @author : 장용
	 * @return : StatusResopnseDTO
	 * @description : 피로도 체크
	 */
	public StatusResDto fatigueCheck(MktFatigueSetReqDto dto){
		
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		
		dto.setSVCAlias("mfm");
		int cnt = mktFatigueMapper.selectFatigueCheck(dto);
		
		if(cnt > 0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage("1");
		}
		else{
			rtnValue.setSuccess(true);
			rtnValue.setMessage("0");
		}
		
		return rtnValue;
		
	}


	/**
	 * @name : applyFatigue
	 * @date : 2022. 01. 24.
	 * @author : 윤법공
	 * @return : StatusResDto
	 * @description : 피로도 상태 변경(미적용->적용)
	 */

	public StatusResDto applyFatigue(MktFatigueModifyReqDto dto){
		LogUtil.param(MktFatigueService.class, dto);

		StatusResDto rtnValue = new StatusResDto();
		// 피로도 미적용일 경우 적용으로 변경
		rtnValue.setSuccess(editFatigueState(CommonUtil.FATIGUE_STATE_TYPE.S.name(), dto));

		return rtnValue;
	}


	/**
	 * @name : unApplyFatigue
	 * @date : 2022. 01. 24.
	 * @author : 윤법공
	 * @return : StatusResDto
	 * @description : 피로도 상태 변경(적용->미적용)
	 */

	public StatusResDto unApplyFatigue(MktFatigueModifyReqDto dto){
		LogUtil.param(MktFatigueService.class, dto);

		StatusResDto rtnValue = new StatusResDto();
		// 피로도 적용일 경우 미적용으로 변경
		rtnValue.setSuccess(editFatigueState(CommonUtil.FATIGUE_STATE_TYPE.A.name(), dto));

		return rtnValue;
	}

	/**
	 * @name : getFatigueChnlItemList
	 * @date : 2022. 01. 24.
	 * @author : hr.noh
	 * @return : GridPagingResDto<MktFatigueResDto>
	 * @description : 피로도 상세 채널 아이템 리스트
	 */
	public GridPagingResDto<MktFatigueResDto> getFatigueChnlItemList(MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueService.class, dto);
		return new GridPagingResHelper<MktFatigueResDto>().newGridPagingResDto(
				dto.init(CommonUtil.getInstance().getDBType()),
				mktFatigueMapper.selectFatigueChnlItemList(dto), AnnotationHelper.AnnotationType.CommCode);
	}

	/**
	 * @name : getFatigueItemDetail
	 * @date : 2022. 01. 24.
	 * @author : hr.noh
	 * @return : MktFatigueChnlItemResDto
	 * @description : 피로도 채널 아이템 상세팝업
	 */
    public MktFatigueChnlItemResDto getFatigueItemDetail(MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueService.class, dto);

		MktFatigueChnlItemResDto rtnValue = new MktFatigueChnlItemResDto();
		rtnValue.setSuccess(false);
		rtnValue = mktFatigueMapper.selectFatigueItemDetail(dto);
		rtnValue.setSuccess(true);

		return rtnValue;
    }

	/**
	 * @name : addFatiItem
	 * @date : 2022. 01. 25.
	 * @author : hr.noh
	 * @return : StatusResDto
	 * @description : 피로도 채널 아이템 insert
	 */
	public StatusResDto addFatiItem(MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueService.class, dto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		mktFatigueMapper.insertFatiItem(dto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @name : editFatiItem
	 * @date : 2022. 01. 25.
	 * @author : hr.noh
	 * @return : StatusResDto
	 * @description : 피로도 채널 아이템 update
	 */
	public StatusResDto editFatiItem(MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueService.class, dto);
		StatusResDto rtnValue = new StatusResDto();
		mktFatigueMapper.updateFatiItem(dto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @name : editFatigueState
	 * @date : 2022. 01. 24.
	 * @author : bg.yoon
	 * @return : Boolean
	 * @description : 피로도 상태, 관련 아이템 상태 변경
	 */
	public boolean editFatigueState(String fatiState, MktFatigueModifyReqDto dto){

		MktFatigueDetailReqDto req = new MktFatigueDetailReqDto();
		req.setId(dto.getId());
		MktFatigueDetailResDto fatiInfo = mktFatigueMapper.getFatigueDetail(req);
		
		if (fatiState.equals(fatiInfo.getFatiState())) {
			//피로도 상태 적용
			try{
				dto.setFatiState(CommonUtil.FATIGUE_STATE_TYPE.find(fatiState).name());
				mktFatigueMapper.updateFatigueState(dto);
				mktFatigueMapper.updateFatigueChnlItemOfMfm(dto);
				return true;
			}
			catch (Exception e){
				return false;
			}
		}
		else{
			return false;
		}
	}

	/**
	 * @name : removeFatigueChnlItem
	 * @date : 2022. 01. 25.
	 * @author : hr.noh
	 * @return : StatusResDto
	 * @description : 피로도 채널 아이템 delete
	 */
	public StatusResDto removeFatigueChnlItem(MktFatigueReqDto dto) {
		LogUtil.param(MktFatigueService.class, dto);
		StatusResDto rtnValue = new StatusResDto();
		mktFatigueMapper.deleteFatigueChnlItem(dto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
}
