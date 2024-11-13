package com.icignal.marketing.realtime.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.marketing.realtime.dto.request.MktCampaignChnlReqDto;
import com.icignal.marketing.realtime.dto.request.MktCampaignStoreReqDto;
import com.icignal.marketing.realtime.dto.request.MktRealTimeCampExecReqDto;
import com.icignal.marketing.realtime.dto.request.MktRealTimeCampaignReqDto;
import com.icignal.marketing.realtime.dto.response.MktCampaignChnlResDto;
import com.icignal.marketing.realtime.dto.response.MktCampaignStoreResDto;
import com.icignal.marketing.realtime.dto.response.MktRTIntactTypeListResDto;
import com.icignal.marketing.realtime.dto.response.MktRealTimeCampExecResDto;
import com.icignal.marketing.realtime.dto.response.MktRealTimeCampaignResDto;

@Mapper
public interface MktRealTimeCampaignMapper {
	public List<MktRealTimeCampaignResDto> selectRealTimeCampExeList(MktRealTimeCampaignReqDto reqDto);

	public List<MktRealTimeCampaignResDto> selectRTCampChnlExeList(MktRealTimeCampaignReqDto reqDto);

	public MktRealTimeCampaignResDto selectEvtCnt(MktRealTimeCampaignReqDto reqDto);

	public MktRealTimeCampaignResDto selectOfferCnt(MktRealTimeCampaignReqDto reqDto);

	public MktRealTimeCampaignResDto selectChnlCnt(MktRealTimeCampaignReqDto reqDto);

	public MktRealTimeCampaignResDto selectCampInfo(MktRealTimeCampaignReqDto reqDto);

	public List<MktRealTimeCampaignResDto> selectRTCampErrorHist(MktRealTimeCampaignReqDto reqDto);

	public List<MktRealTimeCampaignResDto> selectRTCampTargetReact(MktRealTimeCampaignReqDto reqDto);

	public List<MktRealTimeCampExecResDto> selectRealTimeCampaignExcutionList(MktRealTimeCampExecReqDto reqDto);

	public MktRealTimeCampExecResDto selectRealTimeCampaignExecutionDetail(MktRealTimeCampExecReqDto reqDto);

	public Integer selectExecutorCachePortCheck(MktRealTimeCampExecReqDto reqDto);

	public void editRealCampaigExecution(MktRealTimeCampExecReqDto reqDto);

	public void insertRealCampaigExecution(MktRealTimeCampExecReqDto reqDto);

	public void removeRealTimeCampaign(MktRealTimeCampaignReqDto param);

	public List<MktRTIntactTypeListResDto> selectETIntactTypeList(MktRealTimeCampExecReqDto reqDto);

	public void saveCampaignStore(MktCampaignStoreReqDto reqDto);

	public void editCampaignStore(MktCampaignStoreReqDto reqDto);

	public void removeCampaignStore(MktCampaignStoreReqDto reqDto);

	public List<MktCampaignStoreResDto> selectStoreTreeList(MktCampaignStoreReqDto reqDto);

	public List<MktCampaignStoreResDto> selectStoreTreeSearchList(MktCampaignStoreReqDto reqDto);

	public List<MktCampaignStoreResDto> selectStoreList(MktCampaignStoreReqDto reqDto);

	public List<MktCampaignChnlResDto> getChnlCd(MktCampaignChnlReqDto reqDto);

	public List<MktCampaignChnlResDto> getBrdCd(MktCampaignChnlReqDto reqDto);

	public List<MktCampaignChnlResDto> getSndChnlCd(MktCampaignChnlReqDto reqDto);

	public List<MktCampaignChnlResDto> getSndBrdCd(MktCampaignChnlReqDto reqDto);

	public List<MktCampaignChnlResDto> getSndStoreCd(MktCampaignChnlReqDto reqDto);

	public List<MktCampaignChnlResDto> getBrdCdByRid(MktCampaignChnlReqDto reqDto);

	public List<MktCampaignChnlResDto> getStoreCdByRid(MktCampaignChnlReqDto reqDto);

	public List<MktCampaignChnlResDto> getStoreCd(MktCampaignChnlReqDto reqDto);

	
}
