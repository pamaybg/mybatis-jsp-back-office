package com.icignal.marketing.realtime.service;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.RestAPIUtil;
import com.icignal.marketing.realtime.api.dto.RealCampaignApiDTO;
import com.icignal.marketing.realtime.api.dto.RealCampaignApiDTO.Response;
import com.icignal.marketing.realtime.dto.request.MktCampaignChnlReqDto;
import com.icignal.marketing.realtime.dto.request.MktCampaignStoreReqDto;
import com.icignal.marketing.realtime.dto.request.MktRealTimeCampExecReqDto;
import com.icignal.marketing.realtime.dto.request.MktRealTimeCampaignReqDto;
import com.icignal.marketing.realtime.dto.response.MktCampaignChnlResDto;
import com.icignal.marketing.realtime.dto.response.MktCampaignStoreResDto;
import com.icignal.marketing.realtime.dto.response.MktRTIntactTypeListResDto;
import com.icignal.marketing.realtime.dto.response.MktRealTimeCampExecResDto;
import com.icignal.marketing.realtime.dto.response.MktRealTimeCampaignResDto;
import com.icignal.marketing.realtime.mapper.MktRealTimeCampaignMapper;

@Service
public class MktRealTimeCampaignService {
	
	
	@Autowired
	private MktRealTimeCampaignMapper mktRealTimeCampaignMapper;
	
	
	
	   /**
	    * @programId :
	    * @name : getRealTimeCampExeList
	    * @date : 2020. 6. 3.
	    * @author : yj.choi
	    * @table :
	    * @description : 실시간 캠페인 실행 현황
	    */
	public GridPagingResDto<MktRealTimeCampaignResDto> getRealTimeCampExeList(MktRealTimeCampaignReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("c");
		reqDto.setAuthAlias("c");
		reqDto.setInDataAuthTargetColumn("cam_plan_org_cd");
		
		return new GridPagingResHelper<MktRealTimeCampaignResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType())
				, mktRealTimeCampaignMapper.selectRealTimeCampExeList(reqDto));
				
	}
	  /**
	    * @programId :
	    * @name : getRTCampChnlExeList
	    * @date : 2020. 6. 4.
	    * @author : yj.choi
	    * @table :
	    * @description : 실시간 캠페인 채널실행 정보
	    */
	public GridPagingResDto<MktRealTimeCampaignResDto> getRTCampChnlExeList(MktRealTimeCampaignReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("t1");
		MktRealTimeCampaignResDto setValue = new MktRealTimeCampaignResDto();
		List<MktRealTimeCampaignResDto> rtnList = new ArrayList<MktRealTimeCampaignResDto>();
		
		if(!(reqDto.getCamId().equals(""))) {
		 MktRealTimeCampaignResDto rtnValue =new MktRealTimeCampaignResDto();
		 rtnValue = mktRealTimeCampaignMapper.selectEvtCnt(reqDto);
         setValue.setEventDataCnt(rtnValue.getEventDataCnt());
     
         rtnValue = mktRealTimeCampaignMapper.selectOfferCnt(reqDto);
         setValue.setEpntCnt(rtnValue.getEpntCnt());
         setValue.setRetailOfferCnt(rtnValue.getRetailOfferCnt());
         setValue.setFoodOfferCnt(rtnValue.getFoodOfferCnt());
             
         rtnValue = mktRealTimeCampaignMapper.selectChnlCnt(reqDto);
         setValue.setSmsCnt(rtnValue.getSmsCnt());
         setValue.setLmsCnt(rtnValue.getLmsCnt());
         setValue.setMmsCnt(rtnValue.getMmsCnt());
         setValue.setKakaoCnt(rtnValue.getKakaoCnt());
         setValue.setPushCnt(rtnValue.getPushCnt());
         setValue.setEmailCnt(rtnValue.getEmailCnt());
         setValue.setKkoChatBotCnt(rtnValue.getKkoChatBotCnt());

         rtnValue = mktRealTimeCampaignMapper.selectCampInfo(reqDto);
         setValue.setDispNo(rtnValue.getDispNo());
         setValue.setCamNm(rtnValue.getCamNm());
         
         setValue.setTotalCount(1);
         
         rtnList.add(setValue);
        // value.setRows(rtnList);
        // value.setTotal(1);
        // value.setRecords(1);
		
		}
		
		return new GridPagingResHelper<MktRealTimeCampaignResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType())
				, rtnList);
	}

	   /**
	    * @programId :
	    * @name : getRTCampErrorHist
	    * @date : 2020. 6. 4.
	    * @author : yj.choi
	    * @table :
	    * @description : 실시간 캠페인 오류내역조회
	    */
	public GridPagingResDto<MktRealTimeCampaignResDto> getRTCampErrorHist(MktRealTimeCampaignReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("t1");
		return new GridPagingResHelper<MktRealTimeCampaignResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType())
				, mktRealTimeCampaignMapper.selectRTCampErrorHist(reqDto));
	}
	   /**
	    * @programId :
	    * @name : getRTCampTargetReact
	    * @date : 2020. 6. 4.
	    * @author : yj.choi
	    * @table :
	    * @description : 대상자반응조회
	    */
	public GridPagingResDto<MktRealTimeCampaignResDto> getRTCampTargetReact(MktRealTimeCampaignReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("t1");
		return  new GridPagingResHelper<MktRealTimeCampaignResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType())
				, mktRealTimeCampaignMapper.selectRTCampTargetReact(reqDto));
	}
	   /**
	    * @programId :
	    * @name : getRealTimeCampaignExecutionList
	    * @date : 2020. 6. 4.
	    * @author : yj.choi
	    * @table :
	    * @description : 실시간 캠페인 실행 리스트
	    */
	public GridPagingResDto<MktRealTimeCampExecResDto> getRealTimeCampaignExecutionList(
			MktRealTimeCampExecReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("t1");
		return  new GridPagingResHelper<MktRealTimeCampExecResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType())
				, mktRealTimeCampaignMapper.selectRealTimeCampaignExcutionList(reqDto));
	}
	
	   /**
     * 실시간 캠페인 실행 관리 상세
     *
     * @programId :
     * @name : getRealTimeCampaignExecutionDetail
     * @date : 2019.09.09
     * @author : sh.park
     * @table :
     * @param request
     * @param response
     * @param param
     * @return
     * @description : 실시간 캠페인 실행 관리 상세
     */
	public MktRealTimeCampExecResDto getRealTimeCampaignExecutionDetail(MktRealTimeCampExecReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("t1");
		return mktRealTimeCampaignMapper.selectRealTimeCampaignExecutionDetail(reqDto);
	}
	
	
	public StatusResDto editRealCampaigExecution(MktRealTimeCampExecReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto checkDto =this.checkCampaignExecutionData(reqDto);
		StatusResDto resDto = new StatusResDto();
	
		if(checkDto.getSuccess()) {
			resDto.setSuccess(false);
			mktRealTimeCampaignMapper.editRealCampaigExecution(reqDto);
			resDto.setSuccess(true);
		}else {
			resDto.setSuccess(false);
			resDto.setMessage(checkDto.getMessage());
			
		}
		
		return resDto;
	}
	
	public StatusResDto addRealCampaigExecution(MktRealTimeCampExecReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto checkDto =this.checkCampaignExecutionData(reqDto);
		StatusResDto resDto = new StatusResDto();
		
		if(checkDto.getSuccess()) {
			resDto.setSuccess(false);
			
			String id = CommonUtil.newRid();
			reqDto.setRid(id);
			mktRealTimeCampaignMapper.insertRealCampaigExecution(reqDto);
			
		  if (ObjectUtil.isNotEmpty(id)) {
			  resDto.setMessage(id);
	        }
			resDto.setSuccess(true);
		}else {
			resDto.setSuccess(false);
			resDto.setMessage(checkDto.getMessage());
			
		}
		
		return resDto;
	}

    private StatusResDto checkCampaignExecutionData(MktRealTimeCampExecReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	StatusResDto resDto = new StatusResDto();
        resDto.setSuccess(true);

        String svcExeMq = reqDto.getSvcExeMq();
        if (ObjectUtil.isNotEmpty(svcExeMq) && svcExeMq.contains(".")) {
            resDto.setSuccess(false);
            resDto.setMessage("실행제어RK 값에는 [.]이 없어야합니다.");
            return resDto;
        }

        Integer cachePort = reqDto.getCachePort();
        Integer cachePortCount = mktRealTimeCampaignMapper.selectExecutorCachePortCheck(reqDto);
        if (ObjectUtil.isNotEmpty(cachePort) && (cachePort < 50000 || cachePort > 51000) || cachePortCount != 0) {
            resDto.setSuccess(false);
            resDto.setMessage("캐시 포트 값은 50000 ~ 51000 사이거나, 중복이 없어야 합니다.");
            return resDto;
        }

        return resDto;
    }
	public StatusResDto removeRealTimeCampaign(MktRealTimeCampaignReqDto param) {
	 	LogUtil.param(this.getClass(), param);
    	StatusResDto rtnVal = new StatusResDto();
    	rtnVal.setSuccess(false);
    	mktRealTimeCampaignMapper.removeRealTimeCampaign(param);
    	rtnVal.setSuccess(true);
    	
		return rtnVal;
	}
	public Response callApiCampaignExecutor(MktRealTimeCampExecReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		String apiUrl = BeansUtil.getApplicationProperty("icignal.marketing.realtime-api-url");
		apiUrl = apiUrl + "/api/v1/handleService";
		
		TimeZone time;
	        time = TimeZone.getTimeZone("Asia/Seoul");
	        SimpleDateFormat formYYYYMMDD = new SimpleDateFormat("yyyyMMdd", Locale.KOREAN);
	        SimpleDateFormat formHHMMSS = new SimpleDateFormat("HHmmss", Locale.KOREAN);
	        formYYYYMMDD.setTimeZone(time);
	        formHHMMSS.setTimeZone(time);
	        String day = formYYYYMMDD.format(new Date()); //현재 날짜
	        String timeS = formHHMMSS.format(new Date()); //현재 시각

	        RealCampaignApiDTO.Request realCampaignApi = new RealCampaignApiDTO.Request();
	        realCampaignApi.setTrkNo(UUID.randomUUID().toString());
	        realCampaignApi.setTgNo("RDRC0001");
	        realCampaignApi.setTrsDate(day);
	        realCampaignApi.setTrsTime(timeS);
	        realCampaignApi.setSvcCd(param.getProcessCd());
	        realCampaignApi.setExecCd(param.getExecCd());

	        RealCampaignApiDTO.Response res = 
	        		(RealCampaignApiDTO.Response) RestAPIUtil.jsonPost(apiUrl, realCampaignApi, RealCampaignApiDTO.Response.class);

	        return res;
	}
	public GridPagingResDto<MktRTIntactTypeListResDto> getETIntactTypeList(MktRealTimeCampExecReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("t1");
		
		return  new GridPagingResHelper<MktRTIntactTypeListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType())
				, mktRealTimeCampaignMapper.selectETIntactTypeList(reqDto));
	}
	public StatusResDto saveCampaignStore(MktCampaignStoreReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		rtnVal.setSuccess(false);
		mktRealTimeCampaignMapper.saveCampaignStore(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}
	public StatusResDto editCampaignStore(MktCampaignStoreReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		rtnVal.setSuccess(false);
		mktRealTimeCampaignMapper.editCampaignStore(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}
	public StatusResDto removeCampaignStore(MktCampaignStoreReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		rtnVal.setSuccess(false);
		mktRealTimeCampaignMapper.removeCampaignStore(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}
	public List<MktCampaignStoreResDto> getStoreTreeList(MktCampaignStoreReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.selectStoreTreeList(reqDto);
	}
	public List<MktCampaignStoreResDto> getStoreTreeSearchList(MktCampaignStoreReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.selectStoreTreeSearchList(reqDto);
	}
	public GridPagingResDto<MktCampaignStoreResDto> getStoreMappingList(MktCampaignStoreReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("mcs");
		return  new GridPagingResHelper<MktCampaignStoreResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType())
				, mktRealTimeCampaignMapper.selectStoreList(reqDto));
	}
	public List<MktCampaignChnlResDto> getChnlCd(MktCampaignChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.getChnlCd(reqDto);
	}
	public List<MktCampaignChnlResDto> getBrdCd(MktCampaignChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.getBrdCd(reqDto);
	}
	public List<MktCampaignChnlResDto> getSndChnlCd(MktCampaignChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.getSndChnlCd(reqDto);

	}
	public List<MktCampaignChnlResDto> getSndBrdCd(MktCampaignChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.getSndBrdCd(reqDto);

	}
	public List<MktCampaignChnlResDto> getSndStoreCd(MktCampaignChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.getSndStoreCd(reqDto);
	}
	public List<MktCampaignChnlResDto> getBrdCdByRid(MktCampaignChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.getBrdCdByRid(reqDto);
	}
	public List<MktCampaignChnlResDto> getStoreCdByRid(MktCampaignChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.getStoreCdByRid(reqDto);
	}
	public List<MktCampaignChnlResDto> getStoreCd(MktCampaignChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return mktRealTimeCampaignMapper.getStoreCd(reqDto);
	}
	
	



	

}
