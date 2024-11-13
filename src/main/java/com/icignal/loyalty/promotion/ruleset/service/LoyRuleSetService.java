package com.icignal.loyalty.promotion.ruleset.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.DATA_STATUS;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.ExcelUtil.HeaderInfo;
import com.icignal.common.util.ExcelUtil.HeaderInfoList;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.component.Messages;
import com.icignal.core.exception.DataBadRequestException;
import com.icignal.core.exception.DataUnhandledException;
import com.icignal.loyalty.promotion.campaign.dto.request.LoyCampaignStatusCheckReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyBrdCategoryListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyChannelListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyProdCategoryListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyProdListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyPromProdListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRuleSetMstReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRuleSetReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetCondChnlListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetCondProdListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetCondTimeListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetMbrDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetMbrReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPaymentStandardListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPromProductListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPrvBnfDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPrvBnfListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetPymntPolicyListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetSdayDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetSdayReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetSpecificDayListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetTranDtlReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyRulesetTranReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.request.LoyTierListReqDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyBrdCategoryListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyChannelListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyProdCategoryListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyProdListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyPromProdListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRuleSetResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetCondChnlListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetCondProdListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetCondTimeListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetDtlResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetExcelUploadResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetMbrResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetPaymentStandardListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetPrvBnfListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetPymntPolicyListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetSdayResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetSpecificDayListResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyRulesetTranResDto;
import com.icignal.loyalty.promotion.ruleset.dto.response.LoyTierListResDto;
import com.icignal.loyalty.promotion.ruleset.mapper.LoyRuleSetMapper;
import com.opencsv.CSVReader;







/**
 * @name : LOYRuleSetService.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : ruleSet
 */
@Service
public class LoyRuleSetService {
	@Autowired private LoyRuleSetMapper rulesetMapper;
	/**
	 * @programId : PLOY_071
	 * @name : getLoyRuleSetMstList
	 * @date : 2016. 12. 13.
	 * @author : dg.ryu
	 * @table : loy.loy_ruleset_mst
	 * @return :
	 * @description : RuleSet 조회
	 */

	public LoyRuleSetResDto getRuleSet(LoyRuleSetReqDto rsr) {
		LogUtil.param(LoyRuleSetService.class, rsr);

		LoyRuleSetResDto rtnValue = new LoyRuleSetResDto();
		rtnValue.setRidMktCamMst(rsr.getRidMktCamMst());

		// 1. RuleSet 정보 조회 - loyRuleset
		LoyRulesetDtlReqDto dtlReq = new LoyRulesetDtlReqDto();
		dtlReq.setSystemColumn(rsr.getSystemColumn());
		dtlReq.setRidMktCamMst(rsr.getRidMktCamMst());

		LoyRulesetDtlResDto dtlRes = getLoyRulesetDtl(dtlReq);

		rtnValue.setRulesetDtl(dtlRes);

		if ( !ObjectUtil.isEmpty(dtlRes) ) {



			// 7. RuleSet  - 부여기준
			LoyRulesetPymntPolicyListReqDto lppr = new LoyRulesetPymntPolicyListReqDto();
			lppr.setRidMktCamMst(rsr.getRidMktCamMst());
			lppr.setSystemColumn(rsr.getSystemColumn());
			rtnValue.setRulesetPymntPolicyList(getPaymentPolicyList(lppr));
			// 8. RuleSet  - 대상상품
			LoyRulesetCondProdListReqDto lcpr = new LoyRulesetCondProdListReqDto();
			lcpr.setRulesetId(dtlRes.getRid());
			lcpr.setSystemColumn(rsr.getSystemColumn());
			rtnValue.setRulesetCondProdList(getCondProdList(lcpr));

			// 9. RuleSet  - 대상경로
			LoyRulesetCondChnlListReqDto lccr = new LoyRulesetCondChnlListReqDto();
			lccr.setRulesetId(dtlRes.getRid());
			lccr.setSystemColumn(rsr.getSystemColumn());
			rtnValue.setRulesetCondChnlList(getCondChnlList(lccr));


			// RuleSet  - 거래시간
			LoyRulesetCondTimeListReqDto lctr = new LoyRulesetCondTimeListReqDto();
			lctr.setRulesetId(dtlRes.getRid());
			lctr.setSystemColumn(rsr.getSystemColumn());
			rtnValue.setRulesetCondTimeList(getCondTimeList(lctr));

			// RuleSet  - 결제수단
			LoyRulesetPaymentStandardListReqDto lpsr = new LoyRulesetPaymentStandardListReqDto();
			lpsr.setRulesetId(dtlRes.getRid());
			lpsr.setSystemColumn(rsr.getSystemColumn());
			rtnValue.setRulesetPymntStandardList(getPaymentStandardList(lpsr));

			// RuleSet  - 특정일
			LoyRulesetSpecificDayListReqDto lsfr = new LoyRulesetSpecificDayListReqDto();
			lsfr.setRulesetId(dtlRes.getRid());
			lsfr.setSystemColumn(rsr.getSystemColumn());
			rtnValue.setRulesetSpecificDayList(getSpecificDayList(lsfr));

		}
	//	rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : saveRuleSet
	 * @date : 2016. 12. 19.
	 * @author : dg.ryu
	 * @table :
	 * @return :
	 * @description : RuleSet 저장
	 */
	@Transactional
	public StatusResDto saveRuleSet(LoyRuleSetReqDto rsr) {
		//LogUtil.param(this.getClass(), rsr);

		StatusResDto rtnValue = new StatusResDto();



		/**
		 * 0.캠페인 마스터 프로모션 관련정보 수정
		 */
		editCampaignMstPromType(rsr);

		/**
		 * 1.룰셋 정보
		 */
		LoyRulesetDtlReqDto rulesetDtl = rsr.getRulesetDtl();
		rulesetDtl.setSystemColumn(rsr.getSystemColumn());
		rulesetDtl.setRidMktCamMst(rsr.getRulesetDtl().getRidMktCamMst());

		
		
		if ( ObjectUtil.isEmpty(rsr.getRulesetDtl().getRid()) ) { //등록
			rtnValue = addLoyRuleset(rulesetDtl);
			rulesetDtl.setRid(rtnValue.getMessage());
		} else { //수정
			rtnValue = editLoyRuleset(rulesetDtl);
			rtnValue.setSuccess(true);
		}

		String rulesetId = rulesetDtl.getRid();

		/**
		 * 2.룰셋 - 대상경로
		 */
		//기존 데이터 전체 삭제
		LoyRulesetCondChnlListReqDto lrcclrRemove = new LoyRulesetCondChnlListReqDto();
		lrcclrRemove.setModifyBy(rsr.getModifyBy());
		lrcclrRemove.setRulesetId(rulesetId);
		removeLoyRulesetCondChnlList(lrcclrRemove);

		int lrcclrIdx = 1;
		int lrcclrSize = rsr.getRulesetCondChnlList().size();
		List<LoyRulesetCondChnlListReqDto> lrcclrSplitData = new ArrayList<LoyRulesetCondChnlListReqDto>();
		for ( LoyRulesetCondChnlListReqDto data : rsr.getRulesetCondChnlList()) {
			data.setSystemColumn(rsr.getSystemColumn());
			data.setRulesetId(rulesetId);
			data.setCreateBy(rsr.getCreateBy());
			data.setModifyBy(rsr.getModifyBy());
			data.setLang(rsr.getLang());

			lrcclrSplitData.add(data);

			//1000건씩 나누어서 insert
			if(lrcclrIdx % 1000 == 0 || lrcclrIdx == lrcclrSize) {
				//일괄 등록
				addLoyRulesetCondChnlList(lrcclrSplitData);
				lrcclrSplitData.clear();
			}
			lrcclrIdx++;
		}

		/**
		 * 3.룰셋 - 거래시간
		 */
		//기존 데이터 전체 삭제
		LoyRulesetCondTimeListReqDto lrctlrRemove = new LoyRulesetCondTimeListReqDto();
		lrctlrRemove.setModifyBy(rsr.getModifyBy());
		lrctlrRemove.setRulesetId(rulesetId);
		removeLoyRulesetCondTimeList(lrctlrRemove);

		int lrctlrIdx = 1;
		int lrctlrSize = rsr.getRulesetCondTimeList().size();
		List<LoyRulesetCondTimeListReqDto> lrctlrSplitData = new ArrayList<LoyRulesetCondTimeListReqDto>();
		for (LoyRulesetCondTimeListReqDto data : rsr.getRulesetCondTimeList()) {
			data.setSystemColumn(rsr.getSystemColumn());
			data.setRulesetId(rulesetId);
			data.setCreateBy(rsr.getCreateBy());
			data.setModifyBy(rsr.getModifyBy());
			data.setLang(rsr.getLang());

			lrctlrSplitData.add(data);

			//1000건씩 나누어서 insert
			if(lrctlrIdx % 1000 == 0 || lrctlrIdx == lrctlrSize) {
				//일괄 등록
				addLoyRulesetCondTimeList(lrctlrSplitData);
				lrctlrSplitData.clear();
			}
			lrctlrIdx++;
		}

		/**
		 * 4.룰셋 - 부여기준
		 */

		LoyRuleSetMstReqDto lrsmr = new LoyRuleSetMstReqDto();
		List<LoyRuleSetMstReqDto> lrsmrArr = new ArrayList<LoyRuleSetMstReqDto>();
		try {
			for(int i=0; i<rsr.getRulesetPymntPolicyList().size(); i++) {
				lrsmr = new LoyRuleSetMstReqDto();
				BeanUtils.copyProperties(lrsmr, rsr.getRulesetPymntPolicyList().get(i));
				lrsmr.setRidMktCamMst(rsr.getRidMktCamMst());
				lrsmr.setRidMktOfferMst(rsr.getRidMktOfferMst());

				boolean minAmt =  ObjectUtil.isEmpty(rsr.getRulesetPymntPolicyList().get(i).getMinAmt());
				boolean minCnt =  ObjectUtil.isEmpty(rsr.getRulesetPymntPolicyList().get(i).getMinCnt());

				if(minAmt) {
					lrsmr.setMinAmt("0");
				}
				if(minCnt) {
					lrsmr.setMinCnt("0");
				}

				lrsmrArr.add(lrsmr);
			}
		} catch (IllegalAccessException | InvocationTargetException e) {
			LogUtil.error(e);
			throw new DataUnhandledException();
		}
		removeLoyRuleSetMst(lrsmr);
		
		
		addLoyRuleSetMst(lrsmrArr);

		/**
		 * 5.룰셋 - 결제수단
		 */
		//기존 데이터 전체 삭제
		LoyRulesetPaymentStandardListReqDto lrpslrRemove = new LoyRulesetPaymentStandardListReqDto();
		lrpslrRemove.setModifyBy(rsr.getModifyBy());
		lrpslrRemove.setRulesetId(rulesetId);
		removeLoyRulesetPaymentStandardList(lrpslrRemove);

		int lrpslrIdx = 1;
		int lrpslrSize = rsr.getRulesetPymntStandardList().size();
		List<LoyRulesetPaymentStandardListReqDto> lrpslrSplitData = new ArrayList<LoyRulesetPaymentStandardListReqDto>();
		for (LoyRulesetPaymentStandardListReqDto data : rsr.getRulesetPymntStandardList()) {
			data.setSystemColumn(rsr.getSystemColumn());
			data.setRulesetId(rulesetId);
			data.setCreateBy(rsr.getCreateBy());
			data.setModifyBy(rsr.getModifyBy());
			data.setLang(rsr.getLang());

			lrpslrSplitData.add(data);

			//1000건씩 나누어서 insert
			if(lrpslrIdx % 1000 == 0 || lrpslrIdx == lrpslrSize) {
				//일괄 등록
				addLoyRulesetPaymentStandardList(lrpslrSplitData);
				lrpslrSplitData.clear();
			}
			lrpslrIdx++;
		}



		/**
		 * 6.룰셋 - 특정일
		 */
		//기존 데이터 전체 삭제
		LoyRulesetSpecificDayListReqDto lrsflrRemove = new LoyRulesetSpecificDayListReqDto();
		lrsflrRemove.setModifyBy(rsr.getModifyBy());
		lrsflrRemove.setRulesetId(rulesetId);
		removeLoyRulesetSpecificDayList(lrsflrRemove);

		int lrsflrIdx = 1;
		int lrsflrSize = rsr.getRulesetSpecificDayList().size();
		List<LoyRulesetSpecificDayListReqDto> lrsflrSplitData = new ArrayList<LoyRulesetSpecificDayListReqDto>();
		for (LoyRulesetSpecificDayListReqDto data : rsr.getRulesetSpecificDayList()) {
			data.setSystemColumn(rsr.getSystemColumn());
			data.setRulesetId(rulesetId);
			data.setCreateBy(rsr.getCreateBy());
			data.setModifyBy(rsr.getModifyBy());
			data.setLang(rsr.getLang());

			lrsflrSplitData.add(data);

			//1000건씩 나누어서 insert
			if(lrsflrIdx % 1000 == 0 || lrsflrIdx == lrsflrSize) {
				//일괄 등록
				addLoyRulesetSpecificDayList(lrsflrSplitData);
				lrsflrSplitData.clear();
			}
			lrsflrIdx++;
		}



		rulesetDtl.setRidMktCamMst(rsr.getRulesetDtl().getRidMktCamMst());
		//7. RuleSet > 조건-상품
		//지급기준에서 다른 기준에서 모델별 포인트로 넘어갔을시 대상상품,상품프로모션 삭제
		if(rsr.getRulesetCondProdList().size()==0 && !rsr.getPromSubType().equals("P011")) {
			LoyRulesetPromProductListReqDto data = new LoyRulesetPromProductListReqDto();
			data.setCamRid(rsr.getRidMktCamMst());
			data.setCreateBy(rsr.getCreateBy());
			data.setModifyBy(rsr.getModifyBy());

			//대상상품 전체삭제
			removeLoyAllRulesetCondProd(rulesetDtl);
			removeProductPromAll(data);
		}

		for ( LoyRulesetCondProdListReqDto data : rsr.getRulesetCondProdList() ) {
			data.setSystemColumn(rsr.getSystemColumn());
			data.setRulesetId(rulesetId);
			data.setRidMktCamMst(rsr.getRulesetDtl().getRidMktCamMst());
			data.setCreateBy(rsr.getCreateBy());
			data.setModifyBy(rsr.getModifyBy());

			//삭제
			if ( DATA_STATUS.D.name().equalsIgnoreCase(data.getDataStatus()) ) {
				// rid가 존재할경우
				if ( ObjectUtil.isNotEmpty(data.getRid()) ) {
					rtnValue = removeLoyRulesetCondProd(data);
					
				}
			}
			//등록
			else if ( ObjectUtil.isEmpty(data.getRid())) {
				rtnValue = addLoyRulesetCondProd(data);
			}
			//수정
			else {
				rtnValue = editLoyRulesetCondProd(data);
			}

		}

		//신규멤버십회원여부
		if(ObjectUtil.isNotEmpty(rsr.getNewMemYn())) {
			rtnValue =  getPromNewMember(rsr);
		}

		return rtnValue;


	}

	/**
	 * @programId : PLOY_071
	 * @name : addLoyRuleSetMst
	 * @date : 2016. 12. 13.
	 * @author : dg.ryu
	 * @table : loy.loy_ruleset_mst
	 * @return :
	 * @description : RuleSet 마스터 등록
	 */

	public StatusResDto addLoyRuleSetMst(List<LoyRuleSetMstReqDto> rsmr) {
		LogUtil.param(LoyRuleSetService.class, rsmr);

		StatusResDto rtnValue = new StatusResDto();
		
		
        for(int i=0; i<rsmr.size(); i++) {
        	rulesetMapper.insertLoyRuleSetMst(rsmr.get(i));
        }
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : PLOY_071
	 * @name : removeLoyRuleSetMst
	 * @date : 2016. 12. 13.
	 * @author : dg.ryu
	 * @table : loy.loy_ruleset_mst
	 * @return :
	 * @description : RuleSet 마스터 삭제
	 */

	public StatusResDto removeLoyRuleSetMst(LoyRuleSetMstReqDto rsmr) {
		LogUtil.param(LoyRuleSetService.class, rsmr);

		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.deleteLoyRulesetPaymentPolicyList(rsmr);
		rtnValue.setSuccess(true);
		//2. 승인서버 데이터 동기화
		//iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.LOY_RULESET_MST, rsmr.getRid(), DATA_SYNC_TYPE.U);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : removeLoyRuleSet
	 * @date : 2017. 7. 7.
	 * @author : jh.kim
	 * @table :
	 * @return :
	 * @description : 캠페인의 RuleSet 모두 삭제
	 */
	public StatusResDto removeLoyRuleSet(LoyRuleSetMstReqDto param) {
		LogUtil.param(LoyRuleSetService.class, param);

		StatusResDto rtnValue = new StatusResDto();



		//캠페인마스터 프로모션 관련정보 수정
		LoyRuleSetReqDto rsr = new LoyRuleSetReqDto();
		rsr.setRidMktCamMst(param.getRidMktCamMst());
		rsr.setSystemColumn(param.getSystemColumn());
		rtnValue = editCampaignMstPromType(rsr);

		// 룰셋 삭제
		LoyRulesetDtlReqDto rulesetDtlParam = new LoyRulesetDtlReqDto();
		rulesetDtlParam.setRidMktCamMst(param.getRidMktCamMst());
		rulesetDtlParam.setSystemColumn(param.getSystemColumn());

		LoyRulesetDtlResDto rulesetDtl = rulesetMapper.selectLoyRulesetDtl(rulesetDtlParam);
		if (!ObjectUtil.isEmpty(rulesetDtl)) {
			LoyRulesetDtlReqDto delparam = new LoyRulesetDtlReqDto();
			delparam.setRid(rulesetDtl.getRid());
			delparam.setSystemColumn(param.getSystemColumn());

			rtnValue.setSuccess(false);
			rulesetMapper.deleteRuleSet(delparam);
			rtnValue.setSuccess(true);
			// 혜택수량 삭제
			LoyRulesetPrvBnfListReqDto prvbnfListReq = new LoyRulesetPrvBnfListReqDto();
			prvbnfListReq.setSystemColumn(param.getSystemColumn());
			prvbnfListReq.setRulesetId(rulesetDtl.getRid());

			List<LoyRulesetPrvBnfListResDto> prvbnfList = rulesetMapper.selectRulesetPrvBnfList(prvbnfListReq);
			LoyRulesetPrvBnfDtlReqDto prvbnfDelReq = new LoyRulesetPrvBnfDtlReqDto();
			for ( LoyRulesetPrvBnfListResDto prvbnf : prvbnfList ) {
				prvbnfDelReq = new LoyRulesetPrvBnfDtlReqDto();
				prvbnfDelReq.setSystemColumn(param.getSystemColumn());
				prvbnfDelReq.setRid(prvbnf.getRid());
				rtnValue.setSuccess(false);
				rulesetMapper.removeRulesetPrvBnf(prvbnfDelReq);
				rtnValue.setSuccess(true);
			}

			// 룰셋 고객조건 삭제
			LoyRulesetMbrReqDto mbrReq = new LoyRulesetMbrReqDto();
			mbrReq.setSystemColumn(param.getSystemColumn());
			mbrReq.setRulesetId(rulesetDtl.getRid());

			LoyRulesetMbrResDto mbr = rulesetMapper.selectLoyRulesetMbr(mbrReq);
			if (!ObjectUtil.isEmpty(mbr)) {
				LoyRulesetMbrDtlReqDto mbrDelReq = new LoyRulesetMbrDtlReqDto();
				mbrDelReq.setSystemColumn(param.getSystemColumn());
				mbrDelReq.setRid(mbr.getRid());

				rulesetMapper.removeRulesetMbr(mbrDelReq);
				rtnValue.setSuccess(true);
			}

			// 룰셋 거래조건 삭제
			LoyRulesetTranReqDto tranReq = new LoyRulesetTranReqDto();
			tranReq.setSystemColumn(param.getSystemColumn());
			tranReq.setRulesetId(rulesetDtl.getRid());

			LoyRulesetTranResDto tran = rulesetMapper.selectLoyRulesetTran(tranReq);
			if (!ObjectUtil.isEmpty(tran)) {
				LoyRulesetTranDtlReqDto tranDelReq = new LoyRulesetTranDtlReqDto();
				tranDelReq.setSystemColumn(param.getSystemColumn());
				tranDelReq.setRid(tran.getRid());

				rulesetMapper.removeRulesetTran(tranDelReq);
				rtnValue.setSuccess(true);
			}

			// 룰셋 기념일 삭제
			LoyRulesetSdayReqDto sdayReq = new LoyRulesetSdayReqDto();
			sdayReq.setSystemColumn(param.getSystemColumn());
			sdayReq.setRulesetId(rulesetDtl.getRid());

			LoyRulesetSdayResDto sday = rulesetMapper.selectLoyRulesetSday(sdayReq);
			if (!ObjectUtil.isEmpty(sday)) {
				LoyRulesetSdayDtlReqDto sdayDelReq = new LoyRulesetSdayDtlReqDto();
				sdayDelReq.setSystemColumn(param.getSystemColumn());
				sdayDelReq.setRid(sday.getRid());

				rulesetMapper.removeRulesetSday(sdayDelReq);
				rtnValue.setSuccess(true);
			}

			//신규멤버십 회원 여부 삭제
			rtnValue = deletePromNewMember(rsr);
		}



		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : editCampaignMstPromType
	 * @date : 2016. 12. 19.
	 * @author : dg.ryu
	 * @table : mkt.mkt_cam_mst
	 * @return :
	 * @description : 캠페인 마스터 프로모션 유형 수정
	 */

	public StatusResDto editCampaignMstPromType(LoyRuleSetReqDto rsr) {
		LogUtil.param(LoyRuleSetService.class, rsr);

		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.updateCampaignMstPromType(rsr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * 룰셋 상세정보 조회
	 *
	 * @programId :
	 * @name : getLoyRuleSet
	 * @date : 2017. 11. 30.
	 * @author : jh.kim
	 * @description :
	 */

	public LoyRulesetDtlResDto getLoyRulesetDtl(LoyRulesetDtlReqDto param) {
		LogUtil.param(this.getClass(), param);

		return rulesetMapper.selectLoyRulesetDtl(param);
	}

	/**
	 * 룰셋 등록
	 *
	 * @programId :
	 * @name : addLoyRuleset
	 * @date : 2017. 12. 1.
	 * @author : jh.kim
	 * @description :
	 */

	public StatusResDto addLoyRuleset(LoyRulesetDtlReqDto rsmr) {
		LogUtil.param(this.getClass(), rsmr);
		//1. 등록
		StatusResDto rtnValue = new StatusResDto();
		String id =CommonUtil.newRid();
		rsmr.setRid(id);
		if (rulesetMapper.insertRuleSet(rsmr)>0) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);
		}

		return rtnValue;
	}

	/**
	 * 룰셋 수정
	 *
	 * @programId :
	 * @name : editLoyRuleset
	 * @date : 2017. 12. 1.
	 * @author : jh.kim
	 * @description :
	 */

	public StatusResDto editLoyRuleset(LoyRulesetDtlReqDto rsmr) {
		LogUtil.param(this.getClass(), rsmr);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		rulesetMapper.updateRuleSet(rsmr);
		rtnValue.setSuccess(true); 
		return rtnValue;
	}

	/**
	 * 룰셋 삭제
	 *
	 * @programId :
	 * @name : removeLoyRuleset
	 * @date : 2017. 12. 1.
	 * @author : jh.kim
	 * @description :
	 */

	public StatusResDto removeLoyRuleset(LoyRulesetDtlReqDto rsmr) {
		LogUtil.param(this.getClass(), rsmr);
		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.deleteRuleSet(rsmr);
		rtnValue.setSuccess(true); 
		return rtnValue;


	}


	/**
	 * 룰셋 > 고객조건(탭) 삭제
	 *
	 * @programId :
	 * @name : removeLoyRulesetMbr
	 * @date : 2017. 12. 1.
	 * @author : jh.kim
	 * @description :
	 */

	public StatusResDto removeLoyRulesetMbr(LoyRulesetMbrDtlReqDto rsmr) {
		LogUtil.param(this.getClass(), rsmr);

		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.removeRulesetMbr(rsmr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * 룰셋 > 지급 정책 (챕)
	 *
	 * @programId :
	 * @name : getPaymentPolicyList
	 * @date : 2018. 7. 13.
	 * @author : jk.kim
	 * @description :
	 */

	public List<LoyRulesetPymntPolicyListResDto> getPaymentPolicyList(LoyRulesetPymntPolicyListReqDto param) {
		LogUtil.param(this.getClass(), param);

		return rulesetMapper.selectPaymentPolicyList(param);
	}
	
	//
	/**
	 * 룰셋 > 조건-상품(챕)
	 *
	 * @programId :
	 * @name : getCondProdList
	 * @date : 2018. 7. 13.
	 * @author : jk.kim
	 * @description :
	 */

	public  List<LoyRulesetCondProdListResDto> getCondProdList(LoyRulesetCondProdListReqDto param) {
		LogUtil.param(this.getClass(), param);

		return rulesetMapper.selectCondProdList(param);
	}





	/**
	 * 룰셋 > 조건 상품 (챕) 등록
	 *
	 * @programId :
	 * @name : addLoyRulesetCondProd
	 * @date : 2018. 7. 13.
	 * @author : jk.kim
	 * @description :
	 */

	public StatusResDto addLoyRulesetCondProd(LoyRulesetCondProdListReqDto rslr) {
		LogUtil.param(this.getClass(), rslr);

		StatusResDto rtnValue = new StatusResDto();

		String id =CommonUtil.newRid();
		rslr.setRid(id);

		if (rulesetMapper.insertLoyRulesetCondProd(rslr)>0) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage(id);
		}

		return rtnValue;
	}

	/**
	 * 룰셋 > 조건 상품 (챕) 삭제
	 *
	 * @programId :
	 * @name : removeLoyRulesetCondProd
	 * @date : 2018. 7. 13.
	 * @author : jk.kim
	 * @description :
	 */

	public StatusResDto removeLoyRulesetCondProd(LoyRulesetCondProdListReqDto rsmr) {
		LogUtil.param(LoyRuleSetService.class, rsmr);

		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.removeLoyRulesetCondProd(rsmr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/**
	 * 룰셋 > 조건 상품 (챕) 수정
	 *
	 * @programId :
	 * @name : editLoyRulesetCondProd
	 * @date : 2018. 7. 13.
	 * @author : jk.kim
	 * @description :
	 */

	public StatusResDto editLoyRulesetCondProd(LoyRulesetCondProdListReqDto rsmr) {
		LogUtil.param(LoyRuleSetService.class, rsmr);

		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.updateLoyRulesetCondProd(rsmr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}



	/**
	 * 룰셋 > 조건-채널 (챕)
	 *
	 * @programId :
	 * @name : getCondChnlList
	 * @date : 2018. 7. 13.
	 * @author : jk.kim
	 * @description :
	 */

	public List<LoyRulesetCondChnlListResDto> getCondChnlList(LoyRulesetCondChnlListReqDto param) {
		LogUtil.param(this.getClass(), param);

		return rulesetMapper.selectCondChnlList(param);
	}


	/**
	 * @programId :
	 * @name : getCondTime
	 * @date : 2018. 10. 15.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 거래시간 조회
	 */

	public List<LoyRulesetCondTimeListResDto> getCondTimeList(LoyRulesetCondTimeListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return rulesetMapper.selectCondTime(param);
	}

	/**
	 * @programId :
	 * @name : addLoyRulesetCondChnlList
	 * @date : 2018. 10. 17.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 대상경로 등록 (list)
	 */

	public StatusResDto addLoyRulesetCondChnlList(List<LoyRulesetCondChnlListReqDto> param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.insertLoyRulesetCondChnlList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : removeLoyRulesetCondChnlList
	 * @date : 2018. 10. 17.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 대상경로 삭제 (list)
	 */

	public StatusResDto removeLoyRulesetCondChnlList(LoyRulesetCondChnlListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto(true, "");
		rulesetMapper.deleteLoyRulesetCondChnlList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : addLoyRulesetCondTimeList
	 * @date : 2018. 10. 17.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 거래시간 등록 (list)
	 */

	public StatusResDto addLoyRulesetCondTimeList(List<LoyRulesetCondTimeListReqDto> param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto(true, "");
		rulesetMapper.insertLoyRulesetCondTimeList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : removeLoyRulesetCondTimeList
	 * @date : 2018. 10. 17.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 대상경로 삭제 (list)
	 */

	public StatusResDto removeLoyRulesetCondTimeList(LoyRulesetCondTimeListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto(true, "");
		rulesetMapper.deleteLoyRulesetCondTimeList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : getPaymentStandard
	 * @date : 2018. 10. 17.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 결제수단 조회
	 */

	public List<LoyRulesetPaymentStandardListResDto> getPaymentStandardList(LoyRulesetPaymentStandardListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return rulesetMapper.selectPaymentStandardList(param);
	}


	/**
	 * @programId :
	 * @name : addLoyRulesetPaymentStandardList
	 * @date : 2018. 10. 17.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 결제수단 등록 (list)
	 */

	public StatusResDto addLoyRulesetPaymentStandardList(List<LoyRulesetPaymentStandardListReqDto> param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.insertLoyRulesetPaymentStandardList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : removeLoyRulesetPaymentStandardList
	 * @date : 2018. 10. 17.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 결제수단 삭제 (list)
	 */

	public StatusResDto removeLoyRulesetPaymentStandardList(LoyRulesetPaymentStandardListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.deleteLoyRulesetPaymentStandardList(param);

		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/**
	 * @programId :
	 * @name : removeLoyRulesetSpecificDayList
	 * @date : 2019. 03. 07.
	 * @author : mj.pyo
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 특정일 삭제 (list)
	 */

	public StatusResDto removeLoyRulesetSpecificDayList(LoyRulesetSpecificDayListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.deleteLoyRulesetSpecificDayList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : addLoyRulesetSpecificDayList
	 * @date : 2019. 03. 07.
	 * @author : mj.pyo
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 특정일 등록 (list)
	 */

	public StatusResDto addLoyRulesetSpecificDayList(List<LoyRulesetSpecificDayListReqDto> param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rulesetMapper.insertLoyRulesetSpecificDayList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	/**
	 * @programId :
	 * @name : getSpecificDayList
	 * @date : 2019. 03. 07.
	 * @author : mj.pyo
	 * @table :
	 * @return : 
	 * @description : 룰셋 - 특정일 조회
	 */

	public List<LoyRulesetSpecificDayListResDto> getSpecificDayList(LoyRulesetSpecificDayListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return rulesetMapper.selectSpecificDayList(param);
	}

	
	/**
	 * @programId :
	 * @name : removeProductPromAll
	 * @date : 2019.04.11
	 * @author : dw.keum
	 * @description : 프로모션 상품 목록 전체 삭제(화면 )
	 */

	public StatusResDto removeProductPromAll(LoyRulesetPromProductListReqDto rsmr) {
		LogUtil.param(LoyRuleSetService.class, rsmr);

		StatusResDto rtnValue = new StatusResDto();

		rulesetMapper.removeProductPromAll(rsmr);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : removeLoyAllRulesetCondProd
	 * @date : 2019.04.11
	 * @author : dw.keum
	 * @description : 프로모션 대상상품 전체 삭제
	 */

	public StatusResDto removeLoyAllRulesetCondProd(LoyRulesetDtlReqDto rsmr) {
		LogUtil.param(LoyRuleSetService.class, rsmr);

		StatusResDto rtnValue = new StatusResDto();

		rulesetMapper.removeLoyAllRulesetCondProd(rsmr);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * @programId : 
	 * @name : getPromNewMember
	 * @date : 2019. 04. 08.
	 * @author : dw.keum
	 * @table : 
	 * @return : 
	 * @description : 프로모션 신규멤버십회원 여부 UPDATE OR DELETE
	 */

	public StatusResDto getPromNewMember(LoyRuleSetReqDto param) {
		LogUtil.param(LoyRuleSetService.class, param);
		StatusResDto rtnValue = new StatusResDto();

		rulesetMapper.updatePromNewMember(param);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId : 
	 * @name : deletePromNewMember
	 * @date : 2019. 04. 08.
	 * @author : dw.keum
	 * @table : 
	 * @return : 
	 * @description : 프로모션 신규멤버십회원 여부 DELETE
	 */

	public StatusResDto deletePromNewMember(LoyRuleSetReqDto param) {
		LogUtil.param(LoyRuleSetService.class, param);
		StatusResDto rtnValue = new StatusResDto();

		rulesetMapper.deletePromNewMember(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto selectValidPromProd(LoyCampaignStatusCheckReqDto rsmr) {
		LogUtil.param(LoyRuleSetService.class, rsmr);
		StatusResDto rtnValue = new StatusResDto();
			int check;
			check = rulesetMapper.selectValidPromProd(rsmr);
			
	        if(0 > check) {
	        	rtnValue.setSuccess(true);
	        }else {
	        	rtnValue.setSuccess(false);
	        }
			
	        return rtnValue;
	}

	public GridPagingResDto<LoyTierListResDto> getTierList(LoyTierListReqDto param) {
		param.setSVCAlias("t1");
		
		return  new GridPagingResHelper<LoyTierListResDto>().newGridPagingResDto(
	    		 param.init(CommonUtil.getInstance().getDBType()),
	    		 rulesetMapper.selectTierList(param));

	}

	public GridPagingResDto<LoyProdListResDto> getLoyProdList(LoyProdListReqDto param) {
		param.setSVCAlias("t1");
		
		return new GridPagingResHelper<LoyProdListResDto>().newGridPagingResDto(
	    		 param.init(CommonUtil.getInstance().getDBType()),
	    		 rulesetMapper.selectLoyProdList(param));

	}

	public GridPagingResDto<LoyProdCategoryListResDto> getLoyProdCategoryList(
			LoyProdCategoryListReqDto param) {
		param.setSVCAlias("t1");
		
		
		return new GridPagingResHelper<LoyProdCategoryListResDto>().newGridPagingResDto(
	    		 param.init(CommonUtil.getInstance().getDBType()),
	    		 rulesetMapper.selectLoyProdCategoryList(param));
	}

	public GridPagingResDto<LoyBrdCategoryListResDto> getLoyBrdCategoryList(
			LoyBrdCategoryListReqDto param) {
		param.setSVCAlias("t1");
		
		return new GridPagingResHelper<LoyBrdCategoryListResDto>().newGridPagingResDto(
	    		 param.init(CommonUtil.getInstance().getDBType()),
	    		 rulesetMapper.selectLoyBrdCategoryList(param));
	}

	public GridPagingResDto<LoyChannelListResDto> getLoyChannelList(LoyChannelListReqDto param) {
		param.setSVCAlias("t1");
		return new GridPagingResHelper<LoyChannelListResDto>().newGridPagingResDto(
	    		 param.init(CommonUtil.getInstance().getDBType()),
	    		 rulesetMapper.selectLoyChannelList(param));
	}

	/**
	* @programId :
	* @name : createDownloadChannelTemplate
	* @date : 2018. 10. 8.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 엑셀 템플릿 생성 (채널 전체목록 기본세팅)
	*/
	public String createDownloadChannelTemplate(HttpServletRequest request, LoginResDto param) {
		
		String FILE_EXTENSION = ".xlsx";
		XSSFWorkbook wb = null;
		FileOutputStream fileOut = null;
		
		String excelFileDownPath = request.getSession().getServletContext().getRealPath("/") + CommonUtil.getInstance().getChannelExcelFileDownPath().replaceAll("/", Matcher.quoteReplacement(File.separator));
		String excelFileDownName = CommonUtil.getInstance().getChannelExcelFileDownName();
		String fileServerLocation = excelFileDownPath + excelFileDownName + FILE_EXTENSION;
		
		LogUtil.info("엑셀 템플릿 경로 : " + excelFileDownPath);
		
		//1.엑셀 템플릿 수정일시 조회
		File channelTemplateFile = new File(excelFileDownPath, excelFileDownName + FILE_EXTENSION);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREAN);
		String lastModifyDateChannelTemplate = sdf.format(channelTemplateFile.lastModified()); 
		
		LogUtil.info("엑셀 템플릿 수정일시 : " + lastModifyDateChannelTemplate);

		//2.채널정보 최근수정일시 조회
		String lastModifyDateChannel = rulesetMapper.selectLastModiyDateChannel();
		
		try {
			//3.엑셀 템플릿이 존재하지 않거나 최근 채널정보 수정된 적이 있는 경우 
			//엑셀 템플릿을 생성/수정한다. (=전체채널목록 갱신)
			if(DateUtil.datetimeCompare(lastModifyDateChannelTemplate, lastModifyDateChannel, "yyyy-MM-dd HH:mm:ss") < 1 || !channelTemplateFile.exists()) {
				//4.전체채널목록 조회
				List<HashMap<String, Object>> channelList = rulesetMapper.selectAllChannelList();
				
				wb = new XSSFWorkbook();
				Sheet sheet = wb.createSheet("Channel List");
				
				//5.엑셀 헤더정보 세팅
				HeaderInfoList headers = new HeaderInfoList();
				HeaderInfo headerChnlCd = new HeaderInfo();
				headerChnlCd.setVariableName("CHNLNO");
				headerChnlCd.setDisplayName(Messages.getMessage("L00128", param.getLang()));
				headerChnlCd.setIndex(0);
				
				HeaderInfo headerChnlNm = new HeaderInfo();
				headerChnlNm.setVariableName("CHNLNM");
				headerChnlNm.setDisplayName(Messages.getMessage("L00129", param.getLang()));
				headerChnlNm.setIndex(1);
				
				headers.add(headerChnlCd);
				headers.add(headerChnlNm);
				
				int cellIdx = 0;
				Row rowHeader = sheet.createRow(0);
				for(HeaderInfo header : headers) {
					rowHeader.createCell(cellIdx).setCellValue(header.getDisplayName());
					cellIdx++;
				}
				
				//6.엑셀 셀 입력
				int rowNum = 1;
				for(HashMap<String,Object> channel : channelList) {
					Row row = sheet.createRow(rowNum);
		            row.createCell(0).setCellValue(channel.get("CHNLNO").toString());
		            row.createCell(1).setCellValue(channel.get("CHNLNM").toString());
		            rowNum++;
				}
				
				for(int i = 0; i < headers.size(); i++) {
		            sheet.autoSizeColumn(i);
		        }

		        //7.서버 내 파일 생성
				try {
					fileOut = new FileOutputStream(fileServerLocation);
				} catch (FileNotFoundException e) {
						File fileDir = new File(excelFileDownPath);
						if(!fileDir.isDirectory()) {
							fileDir.mkdirs();
						}
						
						File file = new File(fileServerLocation);
						file.createNewFile();
						fileOut = new FileOutputStream(file);
				}
		        wb.write(fileOut);
		        fileOut.flush();
		        fileOut.close();
			}
		} catch (ParseException | IOException e) {
			LogUtil.error(e);
			throw new DataUnhandledException("");
		} catch (NullPointerException e) {
			LogUtil.error(e);
			//채널 존재하지 않는 경우
			throw new DataUnhandledException("채널이 존재하지 않습니다.");
		} finally {
			try {
				if(fileOut != null) { fileOut.flush(); fileOut.close(); }
				if(wb      != null) { wb.close(); }
			} catch (IOException e) {
				LogUtil.error(e);
				throw new DataUnhandledException("");
			}
		}
		
		return fileServerLocation;
	}

	public void exportExcel(String fileName, HttpServletRequest request, HttpServletResponse response) throws IOException {
		BufferedInputStream fin = null;
    	BufferedOutputStream outs = null;

		try{
			File file = new File(fileName); // 저장된 위치에서 뽑아옴.
	        if(file.isFile()) {
	
	        	fin = new BufferedInputStream(new FileInputStream(file));
	        	outs = new BufferedOutputStream(response.getOutputStream());
	
	            int filelength = (int) file.length();
	
	            if(filelength > 0){
	                byte[] bytestream = new byte[filelength];
	
	                int read = 0;
	                
	                //response.setContentType("application/x-msdownload");
	                response.setContentType("application/octet-stream");
	                
	                String userAgent = request.getHeader("User-Agent");
	                boolean isIE =  userAgent.indexOf("MSIE") > -1 ||  userAgent.indexOf("Trident") > -1;
	
	                String fileNm = fileName;
	                
	                if (isIE){
	                	fileNm = new String (fileName.getBytes("x-windows-949"),"ISO-8859-1");
	                }else{
	                	fileNm = new String (fileName.getBytes("UTF-8"),"ISO-8859-1");
	                }
	                
	                response.setHeader("Content-Disposition", "attachment; filename=\"" 
	                + fileNm.substring(fileNm.lastIndexOf(File.separator)+1, fileNm.length()) + "\"");
	                response.setContentLength(filelength);
	                response.setHeader("Content-Length", String.valueOf(filelength));
	                response.setHeader("Content-Transfer-Encoding", "binary;");
	                response.setHeader("Pragma", "no-cache;");
	                response.setHeader("Expires", "0");
	              
	                read = fin.read(bytestream);
	
	                while (read != -1) {
	                    outs.write(bytestream, 0, read);
	
	                    read = fin.read(bytestream);
	                }
	
	                outs.flush();
	            } else {
	                throw new DataUnhandledException("There are no file.");
	            }
	        } else {
	            throw new DataUnhandledException("There are no file.");
	        }
		} catch (Exception e) {
			throw e;
		} finally {
			if (fin != null)
				fin.close();
            if(outs != null)
                outs.close();
        }  
		
	}
	/**
	* @programId :
	* @name : excelUploadChannelTemplate
	* @date : 2018. 10. 12.
	* @author : hy.jun
	* @table :
	* @return : 
	 * @throws IOException 
	* @description :
	*/
	@SuppressWarnings({ "resource", "rawtypes" })
	public LoyRulesetExcelUploadResDto excelUploadChannelTemplate(MultipartFile file, LoginResDto loginInfo) throws IOException {
	LoyRulesetExcelUploadResDto rtnValue = new LoyRulesetExcelUploadResDto();
		
		//업로드파일에서 읽어온 채널 목록
		List<HashMap<String,String>> channelList = new ArrayList<HashMap<String,String>>();
		
        // 파일 확장자 초기화
        String fileName = "";
        String fileType = "";
		
        // 파일 확장자 검사
        try {
			fileName = URLDecoder.decode(file.getOriginalFilename(), "utf-8");
			fileType = fileName.substring(fileName.lastIndexOf('.') + 1, fileName.lastIndexOf('.') + 4);
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e);
			throw new DataBadRequestException("xls, xlsx, csv 형식의 파일만 가능합니다.");
		}

        // 파일 확장자가 올바른가?
        if (!fileType.equalsIgnoreCase("xls") && !fileType.equalsIgnoreCase("xlsx") && !fileType.equalsIgnoreCase("csv")) {
            throw new DataBadRequestException(Messages.getMessage("M00703", loginInfo.getLang()));
        }
        // 파일의 용량이 10MB 이하인가?
        else if (file.getSize() > 10485760) {
            throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
        }
        
        //xlsx 파일 읽기
        if(fileType.equalsIgnoreCase("xls") || fileType.equalsIgnoreCase("xlsx")) {
            XSSFWorkbook wb = null;

            try {
				wb = new XSSFWorkbook(file.getInputStream());
				XSSFSheet sheet = wb.getSheetAt(0);
				
				int firstRowNum = sheet.getFirstRowNum();
				int lastRowNum = sheet.getLastRowNum();

				//템플릿 형식 체크
				//-> 첫번째 행이 '채널코드,채널명' 이 맞는가?
				Row firstRow = sheet.getRow(firstRowNum);
				String firstCellValue = firstRow.getCell(0).getStringCellValue();
				String secondCellValue = firstRow.getCell(1).getStringCellValue();
				
				if(ObjectUtil.isEmpty(firstCellValue) || !firstCellValue.equals(Messages.getMessage("L00128", loginInfo.getLang()))) {
//					throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
					throw new DataBadRequestException("유효한 템플릿 형식이 아닙니다.");
				}
				if(ObjectUtil.isEmpty(secondCellValue) || !secondCellValue.equals(Messages.getMessage("L00129", loginInfo.getLang()))) {
//					throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
					throw new DataBadRequestException("유효한 템플릿 형식이 아닙니다.");
				}
				
				DataFormatter formatter = new DataFormatter();
				//엑셀 데이터 읽기
				for (int i = firstRowNum+1; i <= lastRowNum; i++) {
					HashMap<String,String> channel = new HashMap<String,String>();
					
                    XSSFRow row = sheet.getRow(i);
                    Iterator cells = row.cellIterator();
                    
                    while (cells.hasNext()) {
                    	XSSFCell cell = (XSSFCell) cells.next();
                    	
                    	int cellIdx = cell.getColumnIndex();
                    	String cellValue = formatter.formatCellValue(row.getCell(cellIdx));
                    	//개행문자 & 공백 제거
                		cellValue = StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,"")).replaceAll(" ", "");
                    	
                    	if(cellIdx == 0) {
                    		channel.put("chnlNo", cellValue);
                    	} else if(cellIdx == 1) {
                    		channel.put("chnlNm", cellValue);
                    	}
                    	
                    }
                    
                    channelList.add(channel);
                    
				}
			} catch (IOException e) {
				LogUtil.error(e);
				throw new DataUnhandledException(Messages.getMessage("M02506", loginInfo.getLang()));
			}finally {
				wb.close();
			}
        } 
        //csv 파일 읽기
        else if(fileType.equalsIgnoreCase("csv")) {
            CSVReader reader = null;
            try {
				reader = new CSVReader(new InputStreamReader(file.getInputStream(), "EUC-KR"));
                String[] nextLine;

				//템플릿 형식 체크
				//-> 첫번째 행이 '채널코드,채널명' 이 맞는가?
                nextLine = reader.readNext();
                if(nextLine == null || nextLine.length != 2 
                		|| !nextLine[0].equals(Messages.getMessage("L00128", loginInfo.getLang())) 
                		|| !nextLine[0].equals(Messages.getMessage("L00129", loginInfo.getLang()))) {
//                	throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
					throw new DataBadRequestException("유효한 템플릿 형식이 아닙니다.");
                }
                
                //csv 데이터 읽기
                while ((nextLine = reader.readNext()) != null) {
                	HashMap<String,String> channel = new HashMap<String,String>();

                    for (int i = 0; i < nextLine.length; i++) {
                    	if(i == 0) {
                    		channel.put("chnlNo", nextLine[i]);
                    	} else if(i == 1) {
                    		channel.put("chnlNm", nextLine[i]);
                    	}
                    }
                    
                    channelList.add(channel);
                }
                
            } catch (UnsupportedEncodingException e) {
            	LogUtil.error(e);
				throw new DataUnhandledException();
			} catch (IOException e) {
				LogUtil.error(e);
				throw new DataUnhandledException();
			}finally {
				reader.close();
			}
            
        }
        
        rtnValue.setChannelList(channelList);
        rtnValue.setAllUploadCnt(channelList.size());
        rtnValue.setSuccess(true);
        
        
		return rtnValue;
	}

	public GridPagingResDto<LoyTierListResDto> getAllTierList(LoyTierListReqDto param) {
		return new GridPagingResHelper<LoyTierListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		 rulesetMapper.selectAllTierList(param));
	}

	public GridPagingResDto<LoyPromProdListResDto> getPromProdListNew(LoyPromProdListReqDto param) {
		return  new GridPagingResHelper<LoyPromProdListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		 rulesetMapper.selectPromProdList(param));
	}

	public GridPagingResDto<LoyPromProdListResDto> getPromProductPopList(LoyPromProdListReqDto param) {
		LogUtil.param(this.getClass(), param);
		String promValid = param.getEtcCod() + param.getEtcSname() + param.getGdsNum() + param.getGdsNam();
		boolean valid = ObjectUtil.isNotEmpty(promValid);
		GridPagingResDto<LoyPromProdListResDto> rtnValue = new GridPagingResDto<>();
		if(valid) {
			rtnValue = new GridPagingResHelper<LoyPromProdListResDto>().newGridPagingResDto(
					param.init(CommonUtil.getInstance().getDBType()),
		    		 rulesetMapper.selectPromProdPopList(param));
		}else {
			rtnValue.setSuccess(false);
		}
        
        return rtnValue;
	}

	public StatusResDto setPromProduct(LoyRuleSetReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
        rulesetMapper.insertPromProduct(param);
		rtnValue.setSuccess(true);
        return rtnValue;
	}

	public StatusResDto getProductPromValid(LoyRuleSetReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		int check;
		
		for(LoyRulesetPromProductListReqDto promProd : param.getRulesetPromProductList()) {
			promProd.setCamRid(param.getRidMktCamMst());
			promProd.setCreateBy(param.getCreateBy());
			promProd.setModifyBy(param.getModifyBy());
			check = rulesetMapper.selectProductPromValid(promProd);
			if(check > 0 ) {
				rtnValue.setSuccess(true);
				rtnValue.setMessage("대상상품 리스트에 중복된 상품이 있습니다.");
				return rtnValue;
			}
		}
		
        return rtnValue;
	}

	public StatusResDto removeProductPromValid(LoyRuleSetReqDto rsmr) {
		StatusResDto rtnValue = new StatusResDto();
	        
	        for(LoyRulesetPromProductListReqDto removeProd : rsmr.getRulesetPromProductList()) {
	        	removeProd.setCreateBy(rsmr.getCreateBy());
	        	removeProd.setModifyBy(rsmr.getModifyBy());
	        	
	        	rtnValue.setSuccess(false);
	        	rulesetMapper.removeProductPromValid(removeProd);
	        	
	        	rtnValue.setSuccess(true);
	        }
	        
	        return rtnValue;
	}
}