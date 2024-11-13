package com.icignal.loyalty.promotion.offer.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.CommonUtil.DATA_STATUS;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.promotion.offer.dto.request.LoyGetOfferReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferChildOfferDtlReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferDeleteRequestDTO;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferExpDividReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferInsertReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferMstReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferProdReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferReqDto;
import com.icignal.loyalty.promotion.offer.dto.response.LOYGetOfferChnlResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LOYGetOfferProdResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferExpDividResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferMstListResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferMstResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferPntDtlResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferRelCampaignResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferUseLmtChnlResDto;
import com.icignal.loyalty.promotion.offer.dto.response.LoyOfferUseLmtProdResDto;
import com.icignal.loyalty.promotion.offer.mapper.LoyOfferMapper;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyOfferEditReqDto;








/**
 * @name : LOYRuleSetService.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : ruleSet
 */
@Service
public class LoyOfferService{

	@Autowired LoyOfferMapper loyOfferMapper;

	/**
	 * @programId : PLOY_051
	 * @name : getLoyOfferMstList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : mkt.mkt_offer_mst
	 * @return :
	 * @description : 로얄티 오퍼 마스터 목록
	 */
	public GridPagingResDto<LoyOfferMstListResDto>getLoyOfferMstList(LoyOfferMstReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("mom");
		return new GridPagingResHelper<LoyOfferMstListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyOfferMapper.selectLoyOfferMstList(param), AnnotationType.CommCode);

	}

	/**
	 * @programId : PLOY_051
	 * @name : getLoyOfferDetail
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table :
	 * @return :
	 * @description : 로얄티 오퍼 상세 조회
	 */

	public LoyOfferMstResDto getLoyOfferDetail(LoyOfferMstReqDto lomr) {
		LogUtil.param(this.getClass(), lomr);

		LoyOfferMstResDto rtnValue = new LoyOfferMstResDto();

		//오퍼 마스터 조회
		rtnValue = getLoyOfferMst(lomr);

		if (ObjectUtil.isNotEmpty(rtnValue)) {

			//분담률 목록 조회
			LoyOfferExpDividReqDto loedr = new  LoyOfferExpDividReqDto();
			loedr.setSystemColumn(lomr.getSystemColumn());
			loedr.setRidMktOfferMst(lomr.getId());

			List<LoyOfferExpDividResDto> expDividList = getLoyOfferExpDividList(loedr);
			if (ObjectUtil.isNotEmpty(expDividList)) {
				rtnValue.setExpDividList(expDividList);
			}

			//제한채널 목록 조회
			LoyGetOfferReqDto loulcr = new LoyGetOfferReqDto();
			loulcr.setSystemColumn(lomr.getSystemColumn());
			loulcr.setRidMktOfferMst(lomr.getId());

			List<LoyOfferUseLmtChnlResDto> useLmtChnlList = getLoyOfferUseLmtChnlList(loulcr);
			if (ObjectUtil.isNotEmpty(useLmtChnlList)) {
				rtnValue.setUseLmtChnlList(useLmtChnlList);
			}

			//관계캠페인 조회
			LoyGetOfferReqDto lorcr = new LoyGetOfferReqDto();
			lorcr.setSystemColumn(lomr.getSystemColumn());
			lorcr.setRidMktOfferMst(lomr.getId());

			List<LoyOfferRelCampaignResDto> relCampaignList = getLoyOfferRelCampaignList(lorcr);
			if (ObjectUtil.isNotEmpty(relCampaignList)) {
				rtnValue.setRelCampaignList(relCampaignList);
			}

			//제한모델 목록 조회
			LoyGetOfferReqDto loulpr = new LoyGetOfferReqDto();
			loulpr.setSystemColumn(lomr.getSystemColumn());
			loulpr.setRidMktOfferMst(lomr.getId());

			List<LoyOfferUseLmtProdResDto> useLmtProdList = getLoyOfferUseLmtProdList(loulpr);
			if (ObjectUtil.isNotEmpty(useLmtProdList)) {
				rtnValue.setUseLmtProdList(useLmtProdList);
			}

			//포인트 목록 조회
			LoyGetOfferReqDto lopdr = new LoyGetOfferReqDto();
			lopdr.setSystemColumn(lomr.getSystemColumn());
			lopdr.setRidMktOfferMst(lomr.getId());

			List<LoyOfferPntDtlResDto> pntDtlList = getLoyOfferPntDtlList(lopdr);
			if (ObjectUtil.isNotEmpty(pntDtlList)) {
				rtnValue.setPntDtlList(pntDtlList);
			}


		}

		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : saveLoyOffer
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table :
	 * @return :
	 * @description : 로얄티 오퍼 저장
	 */
	@Transactional
	public StatusResDto saveLoyOffer(LoyOfferMstReqDto lomr) {
		LogUtil.param(this.getClass(), lomr);

		StatusResDto rtnValue = new StatusResDto();

		/**
		 * 2019.11.29
		 * 이경남 부장님 요청으로 프로모션 등록시 오퍼 유형이 포인트의 경우 포인트 유효 기간이 없으면 저장 안되게 validation 추가
		 * sm.lee
		 */
		if("POINT".equals(lomr.getOfferTypeCd()) && ObjectUtil.isEmpty(lomr.getPntDtlList())) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("오퍼 유형이 포인트인 경우 포인트 유효기간을 등록하셔야 합니다. 포인트 관리 탭에서 등록하세요");

			return rtnValue;
		}else {
			int cnt = 0;

			for (LoyGetOfferReqDto param : lomr.getPntDtlList()) {
				if(DATA_STATUS.D.name().equals(param.getDataStatus())){
					cnt++;
				}
			}
			if(lomr.getPntDtlList().size()==cnt) {
				rtnValue.setSuccess(false);
				rtnValue.setMessage("오퍼 유형이 포인트인 경우 포인트 유효기간을 등록하셔야 합니다. 포인트 관리 탭에서 등록하세요");

				return rtnValue;
			}
		}


		String ridMktOfferMst = "";

		//오퍼 마스터 저장
		if (ObjectUtil.isEmpty(lomr.getId())) {
				lomr.setOfferNo(loyOfferMapper.createOfferNum());
				rtnValue = addLoyOfferMst(lomr);			//오퍼 정보 등록
				ridMktOfferMst = rtnValue.getMessage();
		}
		else {
		
				rtnValue = editLoyOfferMst(lomr);		//오퍼 수정
				ridMktOfferMst = lomr.getId();
				rtnValue.setMessage(ridMktOfferMst);

		}

		//분담률 저장 및 삭제
		for (LoyOfferExpDividReqDto param : lomr.getExpDividList()) {
			param.setSystemColumn(lomr.getSystemColumn());
			param.setRidMktOfferMst(ridMktOfferMst);

			// 삭제이고 RID가 존재할 경우
			if ( DATA_STATUS.D.name().equals(param.getDataStatus()) ) {
				if (!ObjectUtil.isEmpty(param.getRid())) {
					removeLoyOfferExpDivid(param);
				}
			}
			// 등록
			else if ( ObjectUtil.isEmpty(param.getRid())) {
				addLoyOfferExpDivid(param);
			}
			// 수정
			else {
				editLoyOfferExpDivid(param);
			}
		}

		//제한채널 저장
		if ( lomr.getUseLmtChnlList() != null ) {
			for ( LoyGetOfferReqDto param : lomr.getUseLmtChnlList() ) {
				param.setSystemColumn(lomr.getSystemColumn());
				param.setRidMktOfferMst(ridMktOfferMst);

				// 삭제이고 RID가 존재할 경우
				if ( DATA_STATUS.D.name().equals(param.getDataStatus()) ) {
					if (!ObjectUtil.isEmpty(param.getRid())) {
						removeLoyOfferUseLmtChnl(param);
					}
				}
				else if ( ObjectUtil.isEmpty(param.getRid()) ) {
					addLoyOfferUseLmtChnl(param);
				}
				else {
					editLoyOfferUseLmtChnl(param);
				}
			}
		}

		//제한모델 저장
		if ( lomr.getUseLmtProdList() != null ) {
			for ( LoyGetOfferReqDto param : lomr.getUseLmtProdList() ) {
				param.setSystemColumn(lomr.getSystemColumn());
				param.setRidMktOfferMst(ridMktOfferMst);

				// 삭제이고 RID가 존재할 경우
				if ( DATA_STATUS.D.name().equals(param.getDataStatus()) ) {
					if (!ObjectUtil.isEmpty(param.getRid())) {
						removeLoyOfferUseLmtProd(param);
					}
				}
				else if ( ObjectUtil.isEmpty(param.getRid()) ) {
					addLoyOfferUseLmtProd(param);
				}
				else {
					editLoyOfferUseLmtProd(param);
				}
			}
		}

		//포인트 저장
		for (LoyGetOfferReqDto param : lomr.getPntDtlList()) {
			param.setSystemColumn(lomr.getSystemColumn());
			param.setRidMktOfferMst(ridMktOfferMst);

			// 삭제이고 RID가 존재할 경우
			if ( DATA_STATUS.D.name().equals(param.getDataStatus()) ) {
				if (!ObjectUtil.isEmpty(param.getRid())) {
					removeLoyOfferPntDtl(param);
				}
			}
			// 등록
			else if ( ObjectUtil.isEmpty(param.getRid()) ) {
				addLoyOfferPntDtl(param);
			}
			// 수정
			else {
				editLoyOfferPntDtl(param);
			}
		}

		//this.commitTransaction();
		//this.endTransaction();

		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : getLoyRuleSetPack
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : mkt.mkt_offer_mst
	 * @return :
	 * @description : 로얄티 오퍼 마스터
	 */

	public LoyOfferMstResDto getLoyOfferMst(LoyOfferMstReqDto lomr) {
		LogUtil.param(this.getClass(), lomr);

		lomr.setSVCAlias("t1");
		return new AnnotationHelper<LoyOfferMstResDto>(AnnotationType.CommCode,loyOfferMapper.selectLoyOfferMst(lomr)).getItem() ;
	}

	/**
	 * @programId : PLOY_051
	 * @name : addLoyOfferMst
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : mkt.mkt_offer_mst
	 * @return :
	 * @description : 로얄티 오퍼 마스터 등록
	 */

	public StatusResDto addLoyOfferMst(LoyOfferMstReqDto lomr) {
		LogUtil.param(this.getClass(), lomr);

		StatusResDto rtnValue = new StatusResDto();

		String id =CommonUtil.newRid();
		lomr.setId(id);

		lomr.setSVCAlias("mof");

		if (loyOfferMapper.insertLoyOfferMst(lomr)>0) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);
			//승인서버 데이터 동기화
			//            iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.MKT_OFFER_MST, lomr.getId(), DATA_SYNC_TYPE.I);
		}

		return rtnValue;

	}

	/**
	 * @programId : PLOY_051
	 * @name : editLoyOfferMst
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : mkt.mkt_offer_mst
	 * @return :
	 * @description : 로얄티 오퍼 마스터 수정
	 */

	public StatusResDto editLoyOfferMst(LoyOfferMstReqDto lomr) {
		LogUtil.param(this.getClass(), lomr);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.updateLoyOfferMst(lomr);
		rtnValue.setSuccess(true);

		//승인서버 데이터 동기화
		// iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.MKT_OFFER_MST, lomr.getId(), DATA_SYNC_TYPE.U);

		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : removeLoyOfferMst
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : mkt.mkt_offer_mst
	 * @return :
	 * @description : 로얄티 오퍼 마스터 삭제
	 */

	public StatusResDto removeLoyOfferMst(LoyOfferMstReqDto lomr) {
		LogUtil.param(this.getClass(), lomr);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.deleteLoyOfferMst(lomr);
		rtnValue.setSuccess(true);
		//승인서버 데이터 동기화
		//  iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.MKT_OFFER_MST, lomr.getId(), DATA_SYNC_TYPE.U);


		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : getLoyOfferExpDividList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_exp_divid
	 * @return :
	 * @description : 로얄티 오퍼 분담률 목록
	 */

	public List<LoyOfferExpDividResDto> getLoyOfferExpDividList(LoyOfferExpDividReqDto loedr) {
		LogUtil.param(this.getClass(), loedr);
		loedr.setSVCAlias("t1");
		loedr.setSVCAlias("t1");
		return new AnnotationHelper<List<LoyOfferExpDividResDto>>(AnnotationType.CommCode,loyOfferMapper.selectLoyOfferExpDividList(loedr)).getItem();


	}

	/**
	 * @programId : PLOY_051
	 * @name : addLoyOfferExpDividList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_exp_divid
	 * @return :
	 * @description : 로얄티 오퍼 분담률 등록
	 */

	public StatusResDto addLoyOfferExpDivid(LoyOfferExpDividReqDto loedr) {
		LogUtil.param(this.getClass(), loedr);

		StatusResDto rtnValue = new StatusResDto();
		String id = CommonUtil.newRid();
		loedr.setRid(id);
		if(loyOfferMapper.insertLoyOfferExpDivid(loedr)>0){
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);

		}

		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : editLoyOfferExpDivid
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_exp_divid
	 * @return :
	 * @description : 로얄티 오퍼 분담률 수정
	 */

	public StatusResDto editLoyOfferExpDivid(LoyOfferExpDividReqDto loedr) {
		LogUtil.param(this.getClass(), loedr);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.updateLoyOfferExpDivid(loedr);
		rtnValue.setSuccess(true);
		//2. 승인서버 데이터 동기화
		// iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.LOY_OFFER_EXP_DIVID, loedr.getRid(), DATA_SYNC_TYPE.U);

		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : removeLoyOfferExpDivid
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_exp_divid
	 * @return :
	 * @description : 로얄티 오퍼 분담률 삭제
	 */

	public StatusResDto removeLoyOfferExpDivid(LoyOfferExpDividReqDto loedr) {
		LogUtil.param(this.getClass(), loedr);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.deleteLoyOfferExpDivid(loedr);
		rtnValue.setSuccess(true);

		//2. 승인서버 데이터 동기화
		// iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.LOY_OFFER_EXP_DIVID, loedr.getRid(), DATA_SYNC_TYPE.U);

		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : getLoyOfferRelCampaignList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : mkt.mkt_cam_mst, mkt.mkt_cam_offer_rel
	 * @return :
	 * @description : 로얄티 오퍼 관계 캠페인 목록
	 */

	public List<LoyOfferRelCampaignResDto> getLoyOfferRelCampaignList(LoyGetOfferReqDto lorcr) {
		LogUtil.param(this.getClass(), lorcr);
		lorcr.setSVCAlias("t1");
		return new AnnotationHelper<List<LoyOfferRelCampaignResDto>>(AnnotationType.CommCode,loyOfferMapper.selectLoyOfferRelCampaignList(lorcr)).getItem();
	}

	/**
	 * @programId : PLOY_051
	 * @name : getLoyOfferUseLmtChnlList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_use_lmt_chnl
	 * @return :
	 * @description : 로얄티 오퍼 제한채널 목록
	 */

	public List<LoyOfferUseLmtChnlResDto> getLoyOfferUseLmtChnlList(LoyGetOfferReqDto loulcr) {
		LogUtil.param(this.getClass(), loulcr);
		return new AnnotationHelper<List<LoyOfferUseLmtChnlResDto>>(AnnotationType.CommCode,(List<LoyOfferUseLmtChnlResDto>)loyOfferMapper.selectLoyOfferUseLmtChnlList(loulcr)).getItem();
	}

	/**
	 * @programId : PLOY_051
	 * @name : addLoyOfferUseLmtChnl
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_use_lmt_chnl
	 * @return :
	 * @description : 로얄티 오퍼 제한채널 등록
	 */

	public StatusResDto addLoyOfferUseLmtChnl(LoyGetOfferReqDto loulcr) {
		LogUtil.param(this.getClass(), loulcr);

		StatusResDto rtnValue = new StatusResDto();
		String id = CommonUtil.newRid();
		loulcr.setRid(id);

		if(loyOfferMapper.insertLoyOfferUseLmtChnl(loulcr)>0){
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);
		}
		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : editLoyOfferUseLmtChnlList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_use_lmt_chnl
	 * @return :
	 * @description : 로얄티 오퍼 제한채널 수정
	 */

	public StatusResDto editLoyOfferUseLmtChnl(LoyGetOfferReqDto loulcr) {
		LogUtil.param(this.getClass(), loulcr);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.updateLoyOfferUseLmtChnl(loulcr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : removeLoyOfferUseLmtChnlList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_use_lmt_chnl
	 * @return :
	 * @description : 로얄티 오퍼 제한채널 삭제
	 */

	public StatusResDto removeLoyOfferUseLmtChnl(LoyGetOfferReqDto loulcr) {
		LogUtil.param(this.getClass(), loulcr);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.deleteLoyOfferUseLmtChnl(loulcr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : getLoyOfferUseLmtProdList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_use_lmt_prod
	 * @return :
	 * @description : 로얄티 오퍼 제한모델 목록
	 */

	public List<LoyOfferUseLmtProdResDto> getLoyOfferUseLmtProdList(LoyGetOfferReqDto loulpr) {
		LogUtil.param(this.getClass(), loulpr);
		loulpr.setSVCAlias("t1");

		return new AnnotationHelper<List<LoyOfferUseLmtProdResDto>>(AnnotationType.CommCode,loyOfferMapper.selectLoyOfferUseLmtProdList(loulpr)).getItem();
	}

	/**
	 * @programId : PLOY_051
	 * @name : addLoyOfferUseLmtProdList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_use_lmt_prod
	 * @return :
	 * @description : 로얄티 오퍼 제한모델 등록
	 */

	public StatusResDto addLoyOfferUseLmtProd(LoyGetOfferReqDto loulpr) {
		LogUtil.param(this.getClass(), loulpr);

		StatusResDto rtnValue = new StatusResDto();
		String id= CommonUtil.newRid();
		loulpr.setRid(id);
		if(loyOfferMapper.insertLoyOfferUseLmtProd(loulpr)>0) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);
		}
		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : editLoyOfferUseLmtProd
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_use_lmt_prod
	 * @return :
	 * @description : 로얄티 오퍼 제한모델 수정
	 */

	public StatusResDto editLoyOfferUseLmtProd(LoyGetOfferReqDto loulpr) {
		LogUtil.param(this.getClass(), loulpr);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.updateLoyOfferUseLmtProd(loulpr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : removeLoyOfferUseLmtProd
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_use_lmt_prod
	 * @return :
	 * @description : 로얄티 오퍼 제한모델 삭제
	 */

	public StatusResDto removeLoyOfferUseLmtProd(LoyGetOfferReqDto loulpr) {
		LogUtil.param(this.getClass(), loulpr);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.deleteLoyOfferUseLmtProd(loulpr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : getLoyOfferPntDtlList
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_pnt_dtl
	 * @return :
	 * @description : 로얄티 오퍼 포인트 목록
	 */

	public List<LoyOfferPntDtlResDto> getLoyOfferPntDtlList(LoyGetOfferReqDto lopdr) {
		LogUtil.param(this.getClass(), lopdr);

		lopdr.setSVCAlias("t1");
		return new AnnotationHelper<List<LoyOfferPntDtlResDto>>(AnnotationType.CommCode,loyOfferMapper.selectLoyOfferPntDtlList(lopdr)).getItem();
	}

	/**
	 * @programId : PLOY_051
	 * @name : addLoyOfferPntDtl
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_pnt_dtl
	 * @return :
	 * @description : 로얄티 오퍼 포인트 등록
	 */

	public StatusResDto addLoyOfferPntDtl(LoyGetOfferReqDto param) {
		LogUtil.param(this.getClass(), param);

		StatusResDto rtnValue = new StatusResDto();
		String id =  CommonUtil.newRid();
		param.setRid(id);
		if(loyOfferMapper.insertLoyOfferPntDtl(param)>0) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);
		}

		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : editLoyOfferPntDtl
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_pnt_dtl
	 * @return :
	 * @description : 로얄티 오퍼 포인트 수줭
	 */

	public StatusResDto editLoyOfferPntDtl(LoyGetOfferReqDto param) {
		LogUtil.param(this.getClass(), param);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.updateLoyOfferPntDtl(param);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * @programId : PLOY_051
	 * @name : removeLoyOfferPntDtl
	 * @date : 2017. 1. 3.
	 * @author : dg.ryu
	 * @table : loy.loy_offer_pnt_dtl
	 * @return :
	 * @description : 로얄티 오퍼 포인트 삭제
	 */

	public StatusResDto removeLoyOfferPntDtl(LoyGetOfferReqDto param) {
		LogUtil.param(this.getClass(), param);

		StatusResDto rtnValue = new StatusResDto();
		loyOfferMapper.deleteLoyOfferPntDtl(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/**
	 * @programId :
	 * @name : checkActivatedCampaignUsingOffer
	 * @date : 2017. 7. 12.
	 * @author : jh.kim
	 * @table :
	 * @return :
	 * @description : 오퍼를 사용하고 있는 활성화된 마케팅 개수 확인
	 */

	public Integer checkActCamUsingOffer(LoyOfferMstReqDto lomr) {
		LogUtil.param(this.getClass(), lomr);

		return loyOfferMapper.checkActCamUsingOffer(lomr);
	}

	/**
	 * @name : getOfferChnlList
	 * @date : 2017. 7. 25.
	 * @author : jun.lee
	 * @return : LOYGetOfferChnlResponseDTO
	 * @description : 오퍼 관리 상세 내, 매장 리스트 출력
	 */

	public GridPagingResDto<LOYGetOfferChnlResDto> getOfferChnlList(LoyGetOfferReqDto param) {
		LogUtil.param(this.getClass(), param);

		return  new GridPagingResHelper<LOYGetOfferChnlResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyOfferMapper.selectOfferChnlList(param), AnnotationType.CommCode);


	}

	/**
	 * @name : insertOfferChnl
	 * @date : 2017. 7. 25.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오퍼 관리 상세 내, 매장 추가
	 */

	public StatusResDto insertOfferChnl(LoyGetOfferReqDto param) {
		LogUtil.param(this.getClass(), param);

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		int chkOverlap =  loyOfferMapper.checkOfferChnlExist(param);

		if(chkOverlap <= 0){
			param.setId(CommonUtil.newRid());
			loyOfferMapper.insertOfferChnl(param);
			rtnValue.setSuccess(true);
			rtnValue.setMessage("1");
		}else{
			rtnValue.setSuccess(true);
			rtnValue.setMessage("2");
		}

		return rtnValue;
	}

	/**
	 * @name : deleteOfferChnl
	 * @date : 2017. 7. 25.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오퍼 관리 상세 내, 매장 삭제
	 */

	public StatusResDto deleteOfferChnl(LoyGetOfferReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyOfferMapper.deleteOfferChnl(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @name : getOfferProdList
	 * @date : 2017. 7. 26.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : 오퍼 관리 상세 내, 상품 리스트 조회
	 */

	public GridPagingResDto<LOYGetOfferProdResDto> getOfferProdList(LoyGetOfferReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("motat");
		return new GridPagingResHelper<LOYGetOfferProdResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyOfferMapper.selectOfferProdList(param));




	}

	/**
	 * @name : insertOfferProd
	 * @date : 2017. 7. 26.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오퍼 관리 상세 내, 상품 추가
	 */

	public StatusResDto insertOfferProd(LoyOfferProdReqDto param) {
		LogUtil.param(this.getClass(), param);

		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);

		int chkOverlap =  loyOfferMapper.checkOfferProdExist(param);

        if(chkOverlap <= 0){
        	param.setId(CommonUtil.newRid());
        	loyOfferMapper.insertOfferProd(param);
        	rtnValue.setSuccess(true);
        	rtnValue.setMessage("1");
        }else{
        	rtnValue.setSuccess(true);
        	rtnValue.setMessage("2");
        }

		return rtnValue;
	}

	/**
	 * @name : deleteOfferProd
	 * @date : 2017. 7. 26.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 오퍼 관리 상세 내, 상품 삭제
	 */

	public StatusResDto deleteOfferProd(LoyOfferProdReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyOfferMapper.deleteOfferProd(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	

	/**
	 * @programId :
	 * @name : getCamMstInfo
	 * @date : 2019. 3. 19.
	 * @author : dw.keum
	 * @table :
	 * @return : StatusResDto
	 * @description : 캠페인 기간
	 */

	public LoyOfferMstResDto getCamMstInfo(LoyOfferMstReqDto lomr) {
		LogUtil.param(this.getClass(), lomr);

		return loyOfferMapper.getCamMstInfo(lomr);
	}



	public GridPagingResDto<LoyOfferResDto> getListOffer(LoyOfferReqDto mor) {
		LogUtil.param(this.getClass(), mor);
		mor.setSVCAlias("mof");
		
		return  new GridPagingResHelper<LoyOfferResDto>().newGridPagingResDto(
	    		 mor.init(CommonUtil.getInstance().getDBType()),
	    		 loyOfferMapper.selectListOffer(mor), AnnotationType.CommCode);
	}

	public StatusResDto setOffer(LoyOfferInsertReqDto met) {
	       LogUtil.param(this.getClass(), met);
	
	        // 0. 오퍼 마스터 등록
	        	        
	        StatusResDto rtnValue = new StatusResDto();
			rtnValue.setSuccess(false);
			
			met.setSVCAlias("mof");
			
			String  rid = CommonUtil.newRid();
			met.setId(rid);
			
			String offerNum = loyOfferMapper.createOfferNum();
			met.setOfferNo(offerNum);
			
			loyOfferMapper.insertOffer(met);		
			
			rtnValue.setMessage(rid);
			rtnValue.setSuccess(true);
	        
	        
	        LoyOfferEditReqDto metDto = new LoyOfferEditReqDto();
	        metDto.setSystemColumn(met.getSystemColumn());
	        metDto.setId(rtnValue.getMessage());
	        
//	        // 1. 사용처 등록 & 삭제
//	        metDto.setUseDeskList(met.getUseDeskList());
//	        editUseDeskList(metDto);
//	        
//	        // 2. 할인/교환상품 등록 & 수정 & 삭제
//	        metDto.setProductList(met.getProductList());
//	        editProductList(metDto);
	        
	        // 3. 등급차감 등록 & 수정 & 삭제
	        /*metDto.setGradeList(met.getGradeList());
	        editGradeList(metDto);*/
	        
	        // 4. 재원분담 등록 & 수정 & 삭제
	        metDto.setExpDividList(met.getExpDividList());
	        editExpDividList(metDto);
	        
	        // 5. 하위오퍼 등록 & 수정 & 삭제
	        metDto.setParOfferId(rtnValue.getMessage());
	        metDto.setChildOfferList(met.getChildOfferList());
	        editChildOfferList(metDto);
	        
	        rtnValue.setSuccess(true);
	        
	        return rtnValue;
	}
	
	/**
     * 재원분담 (탭) > 등록, 수정, 삭제
     * 
     * @programId : 
     * @name : editExpDividList
     * @date : 2017. 11. 23.
     * @author : jh.kim
     * @table : 
     * @return : StatusResponseDTO
     * @description : 
     */
    public StatusResDto editExpDividList(LoyOfferEditReqDto met) {
    	StatusResDto rtnDto = new StatusResDto();

        for ( LoyOfferExpDividReqDto expDividInfo : met.getExpDividList() ) {
            
            expDividInfo.setSystemColumn(met.getSystemColumn());
            expDividInfo.setRidMktOfferMst(met.getId());
            
            // 삭제이고 RID가 존재할 경우 
            if ( DATA_STATUS.D.name().equals(expDividInfo.getDataStatus()) ) {
                if (!ObjectUtil.isEmpty(expDividInfo.getRid())) {
                    rtnDto.setSuccess(false);
                    loyOfferMapper.removeExpDividList(expDividInfo);
                    rtnDto.setSuccess(true);
                }
            }
            // 등록
            else if ( ObjectUtil.isEmpty(expDividInfo.getRid())) {
            	  rtnDto.setSuccess(false);
            	  loyOfferMapper.insertExpDividList(expDividInfo);
            	  rtnDto.setSuccess(true);
            }
            // 수정 
            else {
            	  rtnDto.setSuccess(false);
                  loyOfferMapper.updateExpDividList(expDividInfo);
                  rtnDto.setSuccess(true);
            }
        }
        
        return rtnDto;
    }
    
    /**
     * 하위 오퍼 (탭) > 등록, 수정, 삭제
     * 
     * @programId : 
     * @name : editChildOfferList
     * @date : 2018. 4. 18.
     * @author : 이필수
     * @table : mkt_self_offer_rel
     * @return : StatusResponseDTO
     * @description : 
     */
    public StatusResDto editChildOfferList(LoyOfferEditReqDto met) {
    	StatusResDto rtnDto = new StatusResDto();

        for ( LoyOfferChildOfferDtlReqDto childOfferInfo : met.getChildOfferList() ) {
        	
        	childOfferInfo.setSystemColumn(met.getSystemColumn());
        	childOfferInfo.setRidMktOfferMst(met.getId());
        	childOfferInfo.setParentOfferId(met.getId());
            
            // 삭제이고 RID가 존재할 경우 
            if ( DATA_STATUS.D.name().equals(childOfferInfo.getDataStatus()) ) {
                if ( !ObjectUtil.isEmpty(childOfferInfo.getRid())) {
                	  rtnDto.setSuccess(false);
                	  loyOfferMapper.removeChildOfferList(childOfferInfo);
                	  rtnDto.setSuccess(true);
                }
            }
            // 등록
            else if (ObjectUtil.isEmpty(childOfferInfo.getRid())) {
            	  rtnDto.setSuccess(false);
                loyOfferMapper.insertChildOfferList(childOfferInfo);
                rtnDto.setSuccess(true);
            }
            // 수정 
            else {
          	    rtnDto.setSuccess(false);
               loyOfferMapper.updateChildOfferList(childOfferInfo);
               rtnDto.setSuccess(true);
            }
        }
        
        return rtnDto;
    }

	public StatusResDto removeOffer(LoyOfferDeleteRequestDTO mor) {
		StatusResDto rtnValue = new StatusResDto();	
		rtnValue.setSuccess(false);
		
		mor.setSVCAlias("mof");
		loyOfferMapper.deleteOffer(mor);
		
		rtnValue.setSuccess(true);
		
      /*  //승인서버 데이터 동기화
        iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.MKT_OFFER_MST, mor.getId(), DATA_SYNC_TYPE.U);*/
		return rtnValue;
	}
	
}