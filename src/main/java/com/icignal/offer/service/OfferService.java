package com.icignal.offer.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.CommonCodeReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.channel.dto.request.LoyChnlMasterReqDto;
import com.icignal.loyalty.channel.dto.response.LoyChannelListPageResDto;
import com.icignal.loyalty.channel.dto.response.LoyProgramListResDto;
import com.icignal.offer.dto.request.CouponDtlReqDto;
import com.icignal.offer.dto.request.CouponGuideListReqDto;
import com.icignal.offer.dto.request.CouponGuideReqDto;
import com.icignal.offer.dto.request.CouponReqDto;
import com.icignal.offer.dto.request.OfferCouponPoolReqDto;
import com.icignal.offer.dto.request.OfferCpnPoolListCondReqDto;
import com.icignal.offer.dto.request.OfferGroupReqDto;
import com.icignal.offer.dto.request.OfferJoinChnlItemReqDto;
import com.icignal.offer.dto.request.OfferJoinChnlReqDto;
import com.icignal.offer.dto.request.OfferJoinPgmReqDto;
import com.icignal.offer.dto.request.OfferJoinProdReqDto;
import com.icignal.offer.dto.request.OfferReqDto;
import com.icignal.offer.dto.response.CouponDtlResDto;
import com.icignal.offer.dto.response.CouponGuideResDto;
import com.icignal.offer.dto.response.CouponHistResDto;
import com.icignal.offer.dto.response.CouponResDto;
import com.icignal.offer.dto.response.OfferCouponPoolResDto;
import com.icignal.offer.dto.response.OfferCpnPoolListCondResDto;
import com.icignal.offer.dto.response.OfferGroupResDto;
import com.icignal.offer.dto.response.OfferJoinChnlResDto;
import com.icignal.offer.dto.response.OfferJoinPgmResDto;
import com.icignal.offer.dto.response.OfferJoinProdResDto;
import com.icignal.offer.dto.response.OfferResDto;
import com.icignal.offer.mapper.OfferMapper;
import com.icignal.systemmanagement.commcode.dto.response.ICNCommonCodeResponseDTO;

@Service
public class OfferService {
	@Autowired
	AddBatchService addBatchService;
	@Autowired
	OfferMapper offerMapper;
	
	public GridPagingResDto<OfferResDto> getOfferList(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<OfferResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerMapper.selectOfferList(reqDto), AnnotationType.CommCode);
	}
	
	public OfferResDto getOfferDetail(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return offerMapper.selectOfferDetail(reqDto);
	}
	
	public StatusResDto updateOffer(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();

		CouponDtlReqDto couponDto = new CouponDtlReqDto();
		couponDto.setCreateBy(reqDto.getCreateBy());
		couponDto.setModifyBy(reqDto.getModifyBy());
		couponDto.setUseExpirType(reqDto.getUseExpirType());
		couponDto.setUseExpirDayCnt(reqDto.getUseExpirDayCnt());
		couponDto.setUseFixStartDate(reqDto.getUseFixStartDate());
		couponDto.setUseFixEndDate(reqDto.getUseFixEndDate());
		couponDto.setUseMinPurAmt(reqDto.getUseMinPurAmt());
		couponDto.setUseMaxDcAmt(reqDto.getUseMaxDcAmt());
		couponDto.setCpndescText(reqDto.getCpndescText());
		couponDto.setRidOfr(reqDto.getRid());
		couponDto.setRidOfr(reqDto.getRid());


		offerMapper.updateCoupon(couponDto);

		reqDto.setOfrValAmt(reqDto.getOfrValAmt().replaceAll(",", ""));
		offerMapper.updateOffer(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto insertOffer(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

        reqDto.setRid(CommonUtil.newRid());
		
        StatusResDto rtnValue = new StatusResDto();
		reqDto.setOfrValAmt(reqDto.getOfrValAmt().replaceAll(",", ""));

		List<LoyProgramListResDto> ofrSelectLoyPgmListData = offerMapper.ofrSelectLoyPgmListNew();
        
        for(LoyProgramListResDto loyProgramData : ofrSelectLoyPgmListData) {
            OfferJoinPgmReqDto existDataCheckReqData = new OfferJoinPgmReqDto();
            existDataCheckReqData.setRid(CommonUtil.newRid());
            existDataCheckReqData.setModifyBy(reqDto.getModifyBy());
            existDataCheckReqData.setCreateBy(reqDto.getCreateBy());
        	existDataCheckReqData.setRidOfr(reqDto.getRid());
        	existDataCheckReqData.setRidPgm(loyProgramData.getRid());
        	
    		int ofrPgmRelCnt =  offerMapper.chekOfrPgmRel(existDataCheckReqData);
    		if(ofrPgmRelCnt == 0) {
    			offerMapper.insertOfferJoinPgm(existDataCheckReqData);
    		} else {
    			continue;
    		}
        }

		offerMapper.insertOffer(reqDto);

		CouponDtlReqDto couponDto = new CouponDtlReqDto();
		couponDto.setCreateBy(reqDto.getCreateBy());
		couponDto.setModifyBy(reqDto.getModifyBy());
		couponDto.setUseExpirType(reqDto.getUseExpirType());
		couponDto.setUseExpirDayCnt(reqDto.getUseExpirDayCnt());
		couponDto.setUseFixStartDate(reqDto.getUseFixStartDate());
		couponDto.setUseFixEndDate(reqDto.getUseFixEndDate());
		/*couponDto.setUseMinPurAmt(reqDto.getUseMinPurAmt());
		couponDto.setUseMaxDcAmt(reqDto.getUseMaxDcAmt());*/
		couponDto.setCpndescText(reqDto.getCpndescText());
		couponDto.setRidOfr(reqDto.getRid());

		offerMapper.insertCoupon(couponDto);

        rtnValue.setSuccess(true);
        rtnValue.setMessage(reqDto.getRid());
        return rtnValue;
	}
	
	public StatusResDto deleteOffer(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		
		offerMapper.updateOfferDel(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	public CouponDtlResDto getCouponDetail(CouponDtlReqDto slr) {
			LogUtil.param(this.getClass(), slr);
		
		return offerMapper.selectCouponDetail(slr);
	}

	public StatusResDto updateCoupon(CouponDtlReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.updateCoupon(slr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto insertCoupon(CouponDtlReqDto slr) {
		LogUtil.param(this.getClass(), slr);

		StatusResDto rtnValue = new StatusResDto();
		        
		offerMapper.insertCoupon(slr);
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	public CouponResDto getCouponExtAttr(CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		
		return offerMapper.selectCouponExtAttr(slr);
	}

	public GridPagingResDto<CouponHistResDto> getCpnStatusList(CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		
		return new GridPagingResHelper<CouponHistResDto>().newGridPagingResDto(
		slr.init(CommonUtil.getInstance().getDBType()),
	     offerMapper.selectCpnStatusList(slr), AnnotationType.CommCode);
	}

	public GridPagingResDto<OfferJoinPgmResDto> getOfferJoinPgmList(OfferJoinPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<OfferJoinPgmResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerMapper.selectOfferJoinPgmList(reqDto), AnnotationType.CommCode);
	}
	
	public StatusResDto insertOfferJoinPgm(OfferJoinPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();

		int ofrPgmRelCnt =  offerMapper.chekOfrPgmRel(reqDto);
		
		if(ofrPgmRelCnt > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("동일한 프로그램이 존재합니다.");
		}else {
			reqDto.setRid(CommonUtil.newRid());
	        offerMapper.insertOfferJoinPgm(reqDto);
	        rtnValue.setSuccess(true);
		}
        
        return rtnValue;
	}
	
	public StatusResDto deleteOfferJoinPgm(OfferJoinPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.updateOfferJoinPgmDel(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	public StatusResDto editCoupGuide(CouponGuideReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.editCoupGuide(slr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto insertCpnAttr(CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
        StatusResDto rtnValue = new StatusResDto();
        offerMapper.insertCpnAttr(slr);
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto updateCpnAttr(CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.updateCpnAttr(slr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	public CouponResDto getCouponChk(CouponReqDto slr) {
			LogUtil.param(this.getClass(), slr);
			CouponResDto rtnValue = offerMapper.selectCouponChk(slr);
		
		return rtnValue;
		
	}

	public StatusResDto addCouponGuide(CouponGuideReqDto slr) {
			LogUtil.param(this.getClass(), slr);
			 Map<String, String> couponGuideMap = new HashMap<String, String>();
			 couponGuideMap.put("1",slr.getLine1Msg());
			 couponGuideMap.put("2",slr.getLine2Msg());
			 couponGuideMap.put("3",slr.getLine3Msg());
			 couponGuideMap.put("4",slr.getLine4Msg());
			 couponGuideMap.put("5",slr.getLine5Msg());
			 couponGuideMap.put("6",slr.getLine6Msg());
			 couponGuideMap.put("7",slr.getLine7Msg());
			 couponGuideMap.put("8",slr.getLine8Msg());
			 couponGuideMap.put("9",slr.getLine9Msg());
			 couponGuideMap.put("10",slr.getLine10Msg());
			 
			 List<String> keyList = new ArrayList<>(couponGuideMap.keySet());
			 List<String> valueList = new ArrayList<>(couponGuideMap.values());
			 
			 
			 CouponGuideListReqDto reqDto = new CouponGuideListReqDto();
			 List<CouponGuideListReqDto> guideList= new ArrayList<CouponGuideListReqDto>(); 
			
			 for(int i=0; i<keyList.size();i++) {
				 reqDto 	=new CouponGuideListReqDto();
				 reqDto.setCreateBy(slr.getCreateBy());
				 reqDto.setRidCpn(slr.getRidCpn());
				 reqDto.setRidOfr(slr.getRidOfr());
				 reqDto.setLineNo(keyList.get(i));
				 reqDto.setMsgText(valueList.get(i));
				 guideList.add(reqDto);
				 reqDto.setCpnGuideList(guideList);	
			 }
			 
				offerMapper.insertCouponGuide(reqDto);
		    
		     
		StatusResDto rtnValue = new StatusResDto();
   

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	public CouponGuideResDto getCouponGuide(CouponReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		CouponGuideResDto rtnValue= new CouponGuideResDto();
		List<CouponGuideResDto> guideList = offerMapper.selectCouponGuide(slr);
		rtnValue.setMsgInfo(guideList);
		return rtnValue;
	}

	public StatusResDto updateCouponGuide(CouponGuideReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		 Map<String, String> couponGuideMap = new HashMap<String, String>();
		 couponGuideMap.put("1",slr.getLine1Msg());
		 couponGuideMap.put("2",slr.getLine2Msg());
		 couponGuideMap.put("3",slr.getLine3Msg());
		 couponGuideMap.put("4",slr.getLine4Msg());
		 couponGuideMap.put("5",slr.getLine5Msg());
		 couponGuideMap.put("6",slr.getLine6Msg());
		 couponGuideMap.put("7",slr.getLine7Msg());
		 couponGuideMap.put("8",slr.getLine8Msg());
		 couponGuideMap.put("9",slr.getLine9Msg());
		 couponGuideMap.put("10",slr.getLine10Msg());
		 
		 List<String> keyList = new ArrayList<>(couponGuideMap.keySet());
		 List<String> valueList = new ArrayList<>(couponGuideMap.values());
		 
		 CouponGuideListReqDto reqDto = new CouponGuideListReqDto();
		 List<CouponGuideListReqDto> guideList= new ArrayList<CouponGuideListReqDto>(); 
		
		 for(int i=0; i<keyList.size();i++) {
			 reqDto 	=new CouponGuideListReqDto();
			 reqDto.setModifyBy(slr.getModifyBy());
			 reqDto.setMsgText(valueList.get(i));
			 reqDto.setRidOfr(slr.getRidOfr());
			 reqDto.setLineNo(keyList.get(i));
			 guideList.add(reqDto);
			 reqDto.setCpnGuideList(guideList);
		 }		 
			offerMapper.updateCouponGuide(reqDto);		 
	    
	     
		 StatusResDto rtnValue = new StatusResDto();
		 rtnValue.setSuccess(true);
		 return rtnValue;
	}
	public GridPagingResDto<OfferJoinChnlResDto> getOfferJoinChnlList(OfferJoinChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<OfferJoinChnlResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerMapper.selectOfferJoinChnlList(reqDto), AnnotationType.CommCode);
	}
	
	//사용 가능 채널 insert
	public StatusResDto insertOfferJoinChnl(OfferJoinChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        reqDto.setRid(CommonUtil.newRid());
        StatusResDto rtnValue = new StatusResDto();
        offerMapper.insertOfferJoinChnl(reqDto);
        
        reqDto.setChnlLimitYn("Y");
        offerMapper.updateOfferChnlLimitYCheck(reqDto);
        String offYn = offerMapper.OfflineYCheck(reqDto);
        reqDto.setOffYn(offYn);
        offerMapper.updateOfferOfflineYCheck(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	//사용가능채널 삭제
	public StatusResDto deleteOfferJoinChnl(OfferJoinChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.updateOfferJoinChnlDel(reqDto);
		
		Integer cnt= offerMapper.selectChkCnt(reqDto);
		
		if(cnt==0) {
			 reqDto.setChnlLimitYn("N");
			 offerMapper.updateOfferChnlLimitYCheck(reqDto);
		     String offYn = offerMapper.OfflineYCheck(reqDto);
		     reqDto.setOffYn(offYn);
			 offerMapper.updateOfferOfflineYCheck(reqDto);
		}
		
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	//사용가능채널 전체 삭제
	public StatusResDto deleteOfferJoinAllChnl(OfferJoinChnlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.updateOfferJoinAllChnlDel(reqDto);
		
		reqDto.setChnlLimitYn("N");
		offerMapper.updateOfferChnlLimitYCheck(reqDto);
        String offYn = offerMapper.OfflineYCheck(reqDto);
        reqDto.setOffYn(offYn);
		offerMapper.updateOfferOfflineYCheck(reqDto);
        
		rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/**
     * @programId :
     * @name : addOfferJoinChnlItem
     * @date : 2020. 06. 13.
     * @author : jw.yu
     * @table :
     * @description : 오퍼 사용가능 채널 아이템 등록
     */
    public StatusResDto addOfferJoinChnlItem(OfferJoinChnlItemReqDto reqDto) {
    	LogUtil.param(this.getClass(), "");
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        if (ObjectUtil.isNotEmpty(reqDto.getItemList())) {
        
	        // 타겟그룹 아이템 등록
	        StringBuffer sql = new StringBuffer();
	        sql.append(" insert into LOY.LOY_OFR_CHNL")
	        .append(" (")
	        .append(" RID, ")
	        .append(" CREATE_BY, ")
	        .append(" MODIFY_BY, ")
	        .append(" RID_OFR, ")
	        .append(" RID_CHNL_M, ")
	        .append(" REL_TYPE_CD ")
	        .append(" ) values ( ")
	        .append(" com.getNewID('') ")
	        .append(" , ? ")
	        .append(" , ? ")
	        .append(" , ? ")
	        .append(" , ? ")
	        .append(" , NULL ")
	        .append(" ) ");
        	
	    	List<Map<Integer, Object>> params = new ArrayList<Map<Integer, Object>>();
	    	int itemSeq = 1;
	    	int cntUpload = reqDto.getItemList().size();
	    	int uploadCnt =0;
	    	OfferJoinChnlReqDto chnlLimitCheckReqDto = new OfferJoinChnlReqDto();
	        for (OfferJoinChnlItemReqDto item : reqDto.getItemList()) {
	        	LoyChnlMasterReqDto chnlNo = new LoyChnlMasterReqDto();
	        	chnlNo.setChnlNo(item.getChnlId());
	        	LoyChannelListPageResDto chnlData = offerMapper.selectOfrChnlListPage(chnlNo);
	        	chnlData.setRidOfr(reqDto.getTargetOfferId());
	        	chnlData.setRidChnl(chnlData.getRid());	        	
	      	    Integer cnt = offerMapper.selectChnlDupChk(chnlData);
	      	 
		    	int sIdx = 1;
		    	if(cnt<=0) {
		    		Map<Integer, Object> param = new HashMap<Integer, Object>();
		    		param.put(sIdx++, reqDto.getCreateBy());
		    		param.put(sIdx++, reqDto.getModifyBy());
		    		param.put(sIdx++, reqDto.getTargetOfferId());
		    		param.put(sIdx++, chnlData.getRid());
		    		params.add(param);
		    		uploadCnt++;
		    	}
		    	
	        	chnlLimitCheckReqDto.setRidOfr(chnlData.getRidOfr());
	        	chnlLimitCheckReqDto.setModifyBy(reqDto.getModifyBy());
	        	chnlLimitCheckReqDto.setChnlLimitYn("Y");
		        offerMapper.updateOfferChnlLimitYCheck(chnlLimitCheckReqDto);
		    }
	        int duplCnt = cntUpload - uploadCnt;
	        addBatchService.addBatch(sql.toString(), params);
	        
	        String offYn = offerMapper.OfflineYCheck(chnlLimitCheckReqDto);
	        chnlLimitCheckReqDto.setOffYn(offYn);
	        offerMapper.updateOfferOfflineYCheck(chnlLimitCheckReqDto);
	        
	        rtnValue.setSuccess(true);
            rtnValue.setMessage("총 : "+cntUpload+"건, 정상입력 : "+uploadCnt+", 중복제외 : "+duplCnt+"건");      
        }

        return rtnValue;
    }
    
    public GridPagingResDto<OfferJoinProdResDto> getOfferJoinProdList(OfferJoinProdReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<OfferJoinProdResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerMapper.selectOfferJoinProdList(reqDto), AnnotationType.CommCode);
	}
    
    public GridPagingResDto<OfferJoinProdResDto> selectOfferJoinProdNotUsedList(OfferJoinProdReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<OfferJoinProdResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerMapper.selectOfferJoinProdNotUsedList(reqDto), AnnotationType.CommCode);
	}
	//사용 가능 상품 
	public StatusResDto insertOfferJoinProd(OfferJoinProdReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        reqDto.setRid(CommonUtil.newRid());
        StatusResDto rtnValue = new StatusResDto();
        
        //사용 가능 : PU -> PN 에서 조회 하기 위함   
        //사용 불가능 : PN -> PU에서 조회하기 위함
        if("PU".equals(reqDto.getProdUseType())){
        	reqDto.setProdUseTypeDup("PU");
        }else if("PN".equals(reqDto.getProdUseType())) {
        	reqDto.setProdUseTypeDup("PN");
        }
        //사용 가능 상품 -> 사용 불가능한 상품에 등록됐는지 확인 
        //OR 사용 불가능 상품 -> 사용불가능한 상품에 등록됐는지 확인 하기위한 상품 RID 리스트
        ArrayList<String> dupProd= offerMapper.selectOfferProdRidList(reqDto);  

        //포함되어있는지 확인     
        if(dupProd.contains(reqDto.getRidProdM())) {
        	 rtnValue.setSuccess(true);
        	 rtnValue.setMessage("dupProd");
        	 return rtnValue;
        }
        
        offerMapper.insertOfferJoinProd(reqDto);
        
        reqDto.setProdLimitYn("Y");
        offerMapper.updateOfferProdLimitYCheck(reqDto);
       
        rtnValue.setMessage("저장되었습니다.");
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto deleteOfferJoinProd(OfferJoinProdReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.updateOfferJoinProdDel(reqDto);

		Integer cnt= offerMapper.selectChkProdCnt(reqDto);
		
		if(cnt==0) {
		 reqDto.setProdLimitYn("N");
		 offerMapper.updateOfferProdLimitYCheck(reqDto);
		}
       
		rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto deleteOfferJoinAllProd(OfferJoinProdReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.updateOfferJoinAllProdDel(reqDto);
		
   	    reqDto.setProdLimitYn("N");
		offerMapper.updateOfferProdLimitYCheck(reqDto);

		 rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public StatusResDto deleteOfferJoinNotAllProd(OfferJoinProdReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		offerMapper.updateOfferJoinNotAllProdDel(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	public GridPagingResDto<OfferGroupResDto> getOfferGroupList(OfferGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<OfferGroupResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerMapper.selectOfferGroupList(reqDto), AnnotationType.CommCode);
	}

	public GridPagingResDto<OfferCouponPoolResDto> getOfferCouponPoolList(OfferCouponPoolReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<OfferCouponPoolResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerMapper.selectOfferCouponPoolList(reqDto), AnnotationType.CommCode);
	}
	
	public OfferCpnPoolListCondResDto getOfferCpnPoolListCond(OfferCpnPoolListCondReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return offerMapper.selectOfferCpnPoolListCond(reqDto);
	}

	 /*
	  * 1. 메소드명: modifyOfferJoinPgm
	  * 2. 클래스명: OfferService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼&쿠폰 -프로그램 리스트 상세 수정 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyOfferJoinPgm(OfferJoinPgmReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		offerMapper.updateOfferJoinPgm(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: initOfrCouponDetail
	  * 2. 클래스명: OfferService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto initOfrCouponDetail(CouponDtlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		offerMapper.initOfrCouponDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: iniOfrCouponGuide
	  * 2. 클래스명: OfferService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼&쿠폰 상세 이용안내 초기화
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto initOfrCouponGuide(CouponGuideListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		offerMapper.initOfrCouponGuide(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
     * @programId :
     * @name : addOfferJoinProdItem
     * @date : 2021. 02. 19.
     * @author : 2sh.park
     * @table :
     * @description : 오퍼 상품 엑셀 업로드(사용 가능 / 사용 불가능)
     */
	public StatusResDto addOfferJoinProdItem(OfferJoinChnlItemReqDto reqDto) {
		LogUtil.param(this.getClass(), "");
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        if (ObjectUtil.isNotEmpty(reqDto.getItemList())) {
        
	        StringBuffer sql = new StringBuffer();
	        sql.append("insert into LOY.LOY_OFR_PROD")
	        .append(" (")
	        .append(" RID, ")
	        .append(" CREATE_BY, ")
	        .append(" MODIFY_BY, ")
	        .append(" RID_OFR, ")
	        .append(" RID_PROD_M, ")
	        .append(" PROD_USE_TYPE ")
	        .append(" ) values ( ")
	        .append(" com.getNewID('') ")
	        .append(" , ? ")
	        .append(" , ? ")
	        .append(" , ? ")
	        .append(" , ? ")
	        .append(" , ? ")
	        .append(" ) ");
        	
	    	List<Map<Integer, Object>> params = new ArrayList<Map<Integer, Object>>();
	    	int itemSeq = 1;
	    	int cntUpload = reqDto.getItemList().size();
	    	int uploadCnt =0; 
	    	
	        for (OfferJoinChnlItemReqDto item : reqDto.getItemList()) {
	        	LoyChnlMasterReqDto ProdM = new LoyChnlMasterReqDto();
	        	ProdM.setRidProdM(item.getRidProdM());
	        	LoyChannelListPageResDto ProdData = offerMapper.selectOfrProdListPage(ProdM);
	        	
	        	Integer prodcnt = offerMapper.selectIsProdData(ProdData);

	        	if(prodcnt == 0){
	    	        rtnValue.setSuccess(true);
	    	        rtnValue.setMessage("올바르지 않은 자재 코드가 포함되어있습니다.");	
	    	        return rtnValue;
	        	}
	        	
	        	ProdData.setRidOfr(reqDto.getTargetOfferId());
	        	ProdData.setProdUseType(reqDto.getProdUseType());
	        	Integer cnt = offerMapper.selectProdDupChk(ProdData);
	        	int sIdx = 1;
	        	if(cnt<=0) {
				Map<Integer, Object> param = new HashMap<Integer, Object>();
					param.put(sIdx++, reqDto.getCreateBy());
					param.put(sIdx++, reqDto.getModifyBy());
					param.put(sIdx++, reqDto.getTargetOfferId());
					param.put(sIdx++, ProdData.getProdRid());
					param.put(sIdx++, reqDto.getProdUseType());
					params.add(param);
					uploadCnt++;
	        	}
	        	OfferJoinProdReqDto prodLimitCheckReqDto = new OfferJoinProdReqDto();
	        	prodLimitCheckReqDto.setRidOfr(ProdData.getRidOfr());
	        	prodLimitCheckReqDto.setModifyBy(reqDto.getModifyBy());
	        	prodLimitCheckReqDto.setProdLimitYn("Y");
		        offerMapper.updateOfferProdLimitYCheck(prodLimitCheckReqDto);
	        }
	        
	        int duplCnt = cntUpload - uploadCnt;
	        addBatchService.addBatch(sql.toString(), params);
	        
	        
	        rtnValue.setSuccess(true);
	        rtnValue.setMessage("총 : "+cntUpload+"건, 정상입력 : "+uploadCnt+", 중복제외 : "+duplCnt+"건");	       
        }
        
        
        

        return rtnValue;
	}

	 /*
	  * 1. 메소드명: getOfrCpnCnt
	  * 2. 클래스명: OfferService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public int getOfrCpnCnt(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return offerMapper.selectOfrCpnCnt(reqDto);
	}

	 /*
	  * 1. 메소드명: updateOfrStatCdStop
	  * 2. 클래스명: OfferService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto updateOfrStatCdStop(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		        
		offerMapper.updateOfrStatCdStop(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	 /*
	  * 1. 메소드명: updateOfrStatCdStart
	  * 2. 클래스명: OfferService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto updateOfrStatCdStart(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		        
		offerMapper.updateOfrStatCdStart(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	 /*
	  * 1. 메소드명: getOfferPointCommCodeList
	  * 2. 클래스명: OfferService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public GridPagingResDto<ICNCommonCodeResponseDTO> getOfferPointCommCodeList(CommonCodeReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		bccr.setSVCAlias("");
		return new GridPagingResHelper<ICNCommonCodeResponseDTO>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				offerMapper.selectOfferPointCommCodeList(bccr));
	}
	
	public GridPagingResDto<OfferResDto> getOfferPointList(OfferReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<OfferResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 offerMapper.selectOfferPointList(reqDto), AnnotationType.CommCode);
	}

	
}
