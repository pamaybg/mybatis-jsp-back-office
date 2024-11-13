package com.icignal.loyalty.membership.service;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;

import com.icignal.kepler.operation.dto.response.KprOperationListResDto;
import com.icignal.loyalty.membership.dto.response.*;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.LoyCampaignExecListResDto;
import com.icignal.common.base.dto.response.LoyChnlListResDto;
import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonViewService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.PNT_TXN_TYPE;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.benefit.point.dto.request.LoyMbrPtnTxnHistReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyPointAcrlRequestDTO;
import com.icignal.loyalty.benefit.point.dto.request.LoyPointRdmRequestDTO;
import com.icignal.loyalty.benefit.point.dto.response.LoyMbrPtnTxnHistListResDto;
import com.icignal.loyalty.channel.service.LoyChannelService;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustBranchReqDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBranchResDto;
import com.icignal.loyalty.family.dto.request.LoyFamilyListReqDto;
import com.icignal.loyalty.family.dto.response.LoyFamilyCallbackResDto;
import com.icignal.loyalty.loyprogram.dto.request.LoyCustItemConfReqDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyCustItemConfListResDto;
import com.icignal.loyalty.membership.dto.request.LoyDormancyActiveReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDormancyPredUserReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDormancyReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDropMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDropReasonReqDto;
import com.icignal.loyalty.membership.dto.request.LoyDupMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyEmpSearchHelpReqDto;
import com.icignal.loyalty.membership.dto.request.LoyExecutivesViewReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrCampHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrCarHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChangeHistListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChgHistAddReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChgHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChnlHistContentsReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChnlHistListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChnlRelReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrDetailInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrDivListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrEditPntUsePwReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrFamilyListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupAddInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupCardListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupCardReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupClubReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrGroupReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrIntDetailReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrIntactPurReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrItemReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrMemberCardListResDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrMgtInfoReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPasswordReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPntYnReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointAcrlReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointAuthReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointDropReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrPointLimitReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrProcReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrProdCustListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrRecomHistoryReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrRenameReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrSearchHelpReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrStnPntTxnDetailListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrStnPntTxnListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTierBenefitHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTiersDetailReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrTmAgrHistReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrUploadItemReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrVocListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyNegativeAccReqDto;
import com.icignal.loyalty.membership.dto.request.LoyNewCustAddReqDto;
import com.icignal.loyalty.membership.dto.request.LoyPontBalanceB2cReqDto;
import com.icignal.loyalty.membership.dto.request.LoySimpleMbrRegProcReqDto;
import com.icignal.loyalty.membership.dto.request.LoyTierApprovalReqDto;
import com.icignal.loyalty.membership.dto.request.LoyTransPointListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyVocPntTxnReqDto;
import com.icignal.loyalty.membership.mapper.LoyMbrMapper;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardListReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.request.LoyMbrCardReqDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardListResDto;
import com.icignal.loyalty.membershipcard.cardmember.dto.response.LoyMbrCardResDto;
import com.icignal.loyalty.terms.memberterm.dto.request.LoyMbrTermsHistListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsRcvChnlListResDto;
import com.icignal.loyalty.tiers.membertier.dto.request.LoyMbrTierReqDto;
import com.icignal.loyalty.tiers.membertier.dto.response.LoyMbrTierHistResDto;
import com.icignal.onlineapproval.service.OnlineApprovalService;

@Service
public class LoyMbrService {

	@Autowired LoyMbrMapper loyMbrMapper;

	@Autowired LoggingHelper loggingHelper;

	@Autowired
	StandardPBEStringEncryptor encrypor;

	@Autowired
	public CommonViewService commonViewService;

	@Autowired
	public LoyChannelService loyChannelService;

	@Autowired
	CommonViewService commonVierService;
	
	@Autowired
	public OnlineApprovalService onlineApprovalService;


	 /*
	  * 1. 메소드명: getMbrList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDtor
	 *   @return
	 *   @throws Exception
	 */

	public  GridPagingResDto<LoyMbrResDto> getMbrList(LoyMbrReqDto reqDto) throws Exception {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrList(reqDto), AnnotationType.ALL
				);
	}


	 /*
	  * 1. 메소드명: getMbrDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return LoyMbrItemResDto
	 *   @throws Exception
	 */

	public LoyMbrItemResDto getMbrDetail(LoyMbrItemReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoyMbrItemResDto rtnValue = new LoyMbrItemResDto();
        // 값 체크
        if (ObjectUtil.isEmpty(reqDto.getRid()) && ObjectUtil.isEmpty(reqDto.getRidCust()) && ObjectUtil.isEmpty(reqDto.getMbrNo())) {
            rtnValue.setSuccess(false);
            rtnValue.setMessage("조회조건이 충분하지 않습니다.");
        }
        else {
            //회원정보 조회
        	rtnValue = loyMbrMapper.selectMbrDetail(reqDto);

        	LoyPontBalanceB2cReqDto lpbbr = new LoyPontBalanceB2cReqDto();
            lpbbr.setRid(reqDto.getRid());

            selectPontBalanceB2c(lpbbr);
            rtnValue.setAvlPoint(lpbbr.getP_UsePnt()); //가용포인트
            rtnValue.setExtncPamPoint(lpbbr.getP_Expr1MonthPnt()); //소멸예정포인트
            rtnValue.setPreAcrlPoint(lpbbr.getP_PreAcrlPnt()); //적립예정포인트
            rtnValue.setTotalPoint(lpbbr.getP_UsePnt()+lpbbr.getP_PreAcrlPnt());
        	}

	  	return   new AnnotationHelper<LoyMbrItemResDto>(AnnotationType.ALL, rtnValue).getItem();
	}


	 /*
	  * 1. 메소드명: selectPontBalanceB2c
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 보유포인트, 가용포인트, 적입예정, 익월 소멸예정 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param lpbbr
	 *   @return
	 */
	public LoyPontBalanceB2cReqDto selectPontBalanceB2c(LoyPontBalanceB2cReqDto lpbbr) {
        LogUtil.param(this.getClass(), lpbbr);

       return  loyMbrMapper.selectPontBalanceB2c(lpbbr);
    }

	 /*
	  * 1. 메소드명: getMbrPurHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyMbrIntactPurResDto> getMbrPurHistList(LoyMbrIntactPurReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	    reqDto.setSVCAlias("a");
	    return new GridPagingResHelper<LoyMbrIntactPurResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrIntactPurList(reqDto),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getMbrCampHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyMbrCampHistResDto> getMbrCampHistList(LoyMbrCampHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	    reqDto.setSVCAlias("a");

	    return new GridPagingResHelper<LoyMbrCampHistResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrCampHistList(reqDto),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getMbrChnlRelList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyMbrChnlRelResDto> getMbrChnlRelList(LoyMbrChnlRelReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	    reqDto.setSVCAlias("a");

	    return new GridPagingResHelper<LoyMbrChnlRelResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrChnlRelList(reqDto),AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: editMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param req
	 *   @return
	 */
	public StatusResDto editMbr(LoyMbrReqDto req) {
		LogUtil.param(this.getClass(), req);
		StatusResDto rtnVal = new StatusResDto();
		loyMbrMapper.updateMbr(req);
		rtnVal.setSuccess(true);
		return rtnVal;
	}

	 /*
	  * 1. 메소드명: getMbrPwdDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public LoyMbrPasswordResDto getMbrPwdDetail(LoyMbrPasswordReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
		 return loyMbrMapper.selectMbrPwdDetail(reqDto);
	}


	 /*
	  * 1. 메소드명: editMbrPwd
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	/*public StatusResDto editMbrPwd(LoyMbrPasswordReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();

		mbrPwdUnLock(reqDto.getRid());
		try {
			// 비밀번호 암호화
			//reqDto.setPntUsePw(cryptService.getShaEncryptMd(reqDto.getPntUsePw()));
			reqDto.setPntUsePw(SecurityUtil.encodeSHA256(reqDto.getPntUsePw()));
		} catch (Exception e) {
			LogUtil.error(e);
		}

		rtnValue = loyMbrMapper.editMbrPwd(reqDto);
		if (rtnValue.getSuccess()) {
			*//**
			 * 이경남 부장으로 요청으로 비밀번호 변경이력 ****로 하드코딩 2019.04.23 jk.kim
			 *//*
			LoyMbrChgHistAddReqDto chgHist = new LoyMbrChgHistAddReqDto();
			chgHist.setCreateBy(reqDto.getCreateBy());
			chgHist.setChgTbl("LOY_MBR");
			chgHist.setChgCol("WEB_PWD");
			chgHist.setMbrNo(reqDto.getMbrNo());
			chgHist.setBchngEnYn("Y");
			chgHist.setBchngData("**** ");
			chgHist.setAchngEnYn("Y");
			chgHist.setAchngData("****");
			chgHist.setChgPstn("CRM");
			chgHist.setRmark(reqDto.getRmark());

			iLOYMbrDAO.callAddMbrCngHist(chgHist);
		}

		return rtnValue;
	}*/

	 /*
	  * 1. 메소드명: mbrPwdUnLock
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param rid
	 */
	public StatusResDto mbrPwdUnLock(String rid) {
		LogUtil.param(this.getClass(), rid);
		StatusResDto rtnValue = new StatusResDto();
		if (mbrPwdLockCheck(rid).getSuccess()) {
			loyMbrMapper.mbrPwdUnLock(rid);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: mbrPwdLockCheck
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param rid
	 *   @return
	 */
	public StatusResDto mbrPwdLockCheck(String rid) {
		LogUtil.param(this.getClass(), rid);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		Integer lockCheck = loyMbrMapper.mbrPwdLockCheck(rid);
		if(lockCheck>0){
			rtnValue.setSuccess(true);
		}
		 return rtnValue;
	}

	 /*
	  * 1. 메소드명: getDropMbrList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyDropMbrResDto> getDropMbrList(LoyDropMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	     reqDto.setSVCAlias("a");

	     return new GridPagingResHelper<LoyDropMbrResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectDropMbrList(reqDto),AnnotationType.ALL);
	}


	 /*
	  * 1. 메소드명: clearMaskDrop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public LoyDropMbrResDto clearMaskDrop(LoyDropMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
	    LoyDropMbrResDto res =      loyMbrMapper.clearMaskDrop(reqDto);
	    return new AnnotationHelper<LoyDropMbrResDto>(AnnotationType.PersonalData, res).getItem();
	}

	 /*
	  * 1. 메소드명: getMbrstatus
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param req
	 *   @return
	 */
	public LoyMbrResDto getMbrstatus(LoyMbrReqDto req) {
		LogUtil.param(this.getClass(), req);
		req.setSVCAlias("lm");
		return loyMbrMapper.selectMbrstatus(req);
	}

	 /*
	  * 1. 메소드명: getMbrSearchHelp
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyMbrSearchHelpResDto> getMbrSearchHelp(LoyMbrSearchHelpReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");

		return new GridPagingResHelper<LoyMbrSearchHelpResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrSearchHelp(reqDto),AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getMbrRecomHistoryList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 회원상세 추천인 이력 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return GridPagingResDto<LoyMbrRecomHistoryResDto>
	 */
	public GridPagingResDto<LoyMbrRecomHistoryResDto> getMbrRecomHistoryList(LoyMbrRecomHistoryReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("fr");

		return new GridPagingResHelper<LoyMbrRecomHistoryResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrRecomHistoryList(param)
	    		 ,AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: clearMaskRecomm
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public LoyMbrRecomHistoryResDto clearMaskRecomm(LoyMbrRecomHistoryReqDto reqDto){
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
	    reqDto.setSVCAlias("");
	    return loyMbrMapper.clearMaskRecomm(reqDto);
	}

	 /*
	  * 1. 메소드명: dropMbrCancel
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public StatusResDto dropMbrCancel(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
	    loyMbrMapper.deleteMbrDrop(reqDto);
	    rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getMbrChangeHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyMbrChangeHistListResDto> getMbrChangeHistList(LoyMbrChangeHistListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		
		String ridPgm = loyMbrMapper.selectRidPgm(reqDto);
		reqDto.setRidPgm(ridPgm);
		
		GridPagingResDto<LoyMbrChangeHistListResDto> resDto = new GridPagingResDto<LoyMbrChangeHistListResDto>();
		resDto = new GridPagingResHelper<LoyMbrChangeHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrChangeHistList(reqDto));
		
		GridPagingResDto<LoyCustItemConfListResDto> rtnValue = new GridPagingResDto<LoyCustItemConfListResDto>();
		rtnValue =  new GridPagingResHelper<LoyCustItemConfListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectCustItemConfList(reqDto));

		 
		
		String dataKey = BeansUtil.getDbEncryptDataKey();
		
 		int idx=0;
    		for(LoyMbrChangeHistListResDto mbrChgList: resDto.getRows()) {
			
   			for(LoyCustItemConfListResDto list : rtnValue.getRows()) {
				if(list.getFieldNm().equals(mbrChgList.getChgCol())) {
					
  					if("Y".equals(list.getEncodeYn().trim())) {
						if(resDto.getRows().get(idx).getAchngData() != null && resDto.getRows().get(idx).getAchngData().trim().length() != 0) {
						    if(StringUtil.isNotEmpty(resDto.getRows().get(idx).getAchngData())) {

								String achngData = SecurityUtil.decodeDbAES256(resDto.getRows().get(idx).getAchngData());
								
								if(achngData != null || achngData.trim().length() != 0 ) {
									resDto.getRows().get(idx).setAchngData(achngData);
								}
						   }
							
						}
						if(resDto.getRows().get(idx).getBchngData() != null && resDto.getRows().get(idx).getBchngData().trim().length() != 0) {
						    if(StringUtil.isNotEmpty(resDto.getRows().get(idx).getBchngData())) {
								String bchngData = SecurityUtil.decodeDbAES256(resDto.getRows().get(idx).getBchngData());
								
								if(bchngData != null || bchngData.trim().length() != 0 ) {
									resDto.getRows().get(idx).setBchngData(bchngData);
								}
						    }
						}
						if(list.getFieldDesc() != null && list.getFieldDesc().trim().length() != 0) {
 							resDto.getRows().get(idx).setChgColNm(list.getFieldDesc());
						}
					} 
					
 					else if(list.getGrpCdNm()!=null) {
						resDto.getRows().get(idx).setChgColNm(list.getFieldDesc());
						mbrChgList.setGrpCode(list.getGrpCdNm());
						resDto.getRows().get(idx).setAchngData(loyMbrMapper.selectAchngMarkName(mbrChgList));
						resDto.getRows().get(idx).setBchngData(loyMbrMapper.selectBchngMarkName(mbrChgList));
					}
					
					else {
  						resDto.getRows().get(idx).setChgColNm(list.getFieldDesc());
					}
					
				}
				
				
			}
			idx++;
		}
			
		return resDto;
		
		
	}

	/*
	  * 1. 메소드명: getMbrDetailInfo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 20.
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
	public LoyMbrDetailInfoResDto getMbrDetailInfo(LoyMbrDetailInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");


		LoyMbrDetailInfoResDto res = loyMbrMapper.selectMbrDetailInfo(reqDto);
		return new AnnotationHelper<LoyMbrDetailInfoResDto>(AnnotationType.ALL, res).getItem();
	}

	 /*
	  * 1. 메소드명: getPointDropList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyMbrPointDropResDto> getPointDropList(LoyMbrPointDropReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lm");

		return new GridPagingResHelper<LoyMbrPointDropResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrPointDrop(reqDto),AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: clearMaskMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public LoyMbrResDto clearMaskMbr(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
	    reqDto.setSVCAlias("a");
	    LoyMbrResDto res =      loyMbrMapper.clearMaskMbr(reqDto);
	    return new AnnotationHelper<LoyMbrResDto>(AnnotationType.PersonalData, res).getItem();
	}

	 /*
	  * 1. 메소드명: getDormancyList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyDormancyResDto> getDormancyList(LoyDormancyReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
		 reqDto.setSVCAlias("lm");

		 return new GridPagingResHelper<LoyDormancyResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectDormancyList(reqDto),AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: selectCustNm
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public LoyDormancyResDto selectCustNm(LoyDormancyReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "DOR_MBR_INFO");

		LoyDormancyResDto res =  loyMbrMapper.selectCustNm(reqDto);
		return new AnnotationHelper<LoyDormancyResDto>(AnnotationType.PersonalData, res).getItem();
	}

	 /*
	  * 1. 메소드명: activeDorMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public LoyDormancyActiveResDto activeDorMbr(LoyDormancyActiveReqDto reqDto) {
		LoyDormancyActiveResDto rtnVal = new LoyDormancyActiveResDto();
		loyMbrMapper.activeDorMbr(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}

	 /*
	  * 1. 메소드명: getDormancyPredUser
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public GridPagingResDto<LoyDormancyPredResDto> getDormancyPredUser(LoyDormancyPredUserReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("re");

		return new GridPagingResHelper<LoyDormancyPredResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectPreDormancyList(reqDto),AnnotationType.ALL);
	}


	 /*
	  * 1. 메소드명: getMbrGroupList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 18.
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
	public GridPagingResDto<LoyMbrGroupResDto> getMbrGroupList(LoyMbrGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	     reqDto.setSVCAlias("a");
	     return new GridPagingResHelper<LoyMbrGroupResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrGroupList(reqDto),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getMbrGroupDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 18.
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
	public LoyMbrGroupResDto getMbrGroupDetail(LoyMbrGroupReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
	     reqDto.setSVCAlias("a");
	     return loyMbrMapper.selectMbrGroup(reqDto);
	}

	 /*
	  * 1. 메소드명: addMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 2. 21.
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
	public StatusResDto addMbr(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return null;
	}

	 /*
	  * 1. 메소드명: getEmpSearchHelp
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 18.
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
	public GridPagingResDto<LoyEmpSearchHelpResDto> getEmpSearchHelp(LoyEmpSearchHelpReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return new GridPagingResHelper<LoyEmpSearchHelpResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectEmpSearchHelp(reqDto));
	}


	public GridPagingResDto<LoyMbrRenameResDto> getMbrRenameReqList(LoyMbrRenameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return new GridPagingResHelper<LoyMbrRenameResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrRenameReqList(reqDto));
	}


	 /*
	  * 1. 메소드명: getMbrRenameReqDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public LoyMbrRenameResDto getMbrRenameReqDetail(LoyMbrRenameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	     reqDto.setSVCAlias("a");
	     return loyMbrMapper.selectMbrRenameReqDetail(reqDto);
	}


	 /*
	  * 1. 메소드명: saveMbrRenameReqDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public StatusResDto saveMbrRenameReqDetail(LoyMbrRenameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		reqDto.setSVCAlias("lcm");
		// 즁복체크
		List<HashMap<String, String>> renameUserList = loyMbrMapper.selectMbrRename(reqDto);

		if (renameUserList != null && renameUserList.size() > 0) {
			rtnVal.setSuccess(false);
			rtnVal.setMessage(Messages.getMessage("L01788", reqDto.getLang()));
		} else {
			reqDto.setRid(CommonUtil.newRid());
			loyMbrMapper.insertMbrRenameReqDetail(reqDto);
			rtnVal.setSuccess(true);
			rtnVal.setMessage(reqDto.getRid());
		}
		return rtnVal;
	}


	 /*
	  * 1. 메소드명: editMbrRenameReqDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public StatusResDto editMbrRenameReqDetail(LoyMbrRenameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		// 즁복체크
		reqDto.setSVCAlias("lcm");
		List<HashMap<String, String>> renameUserList = loyMbrMapper.selectMbrRename(reqDto);

		if (renameUserList != null && renameUserList.size() > 0) {
			rtnVal.setSuccess(false);
			rtnVal.setMessage(Messages.getMessage("L01788", reqDto.getLang()));
		} else {
			reqDto.setRid(CommonUtil.newRid());
			loyMbrMapper.updateMbrRenameReqDetail(reqDto);
			rtnVal.setSuccess(true);
			rtnVal.setMessage(reqDto.getRid());
		}
		return rtnVal;
	}


	public List getChargeYM(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lpt");
		return loyMbrMapper.selectChargeYm(reqDto);
	}


	public GridPagingResDto<LoyMbrChargeResDto> getChargeList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lpt");
		return new GridPagingResHelper<LoyMbrChargeResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectChargeList(reqDto));
	}


	public GridPagingResDto<LoyMbrVocListResDto> getMbrVocList(LoyMbrVocListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return new GridPagingResHelper<LoyMbrVocListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrVocList(reqDto), AnnotationType.ALL);
	}
	
	public LoyMbrVocListResDto getMbrVocListDesc(LoyMbrVocListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		
		return loyMbrMapper.selectMbrVocListDesc(reqDto);
	}

	 /*
	  * 1. 메소드명: getChargeInfo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public GridPagingResDto<LoyMbrChargeResDto> getChargeInfo(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lpt");
		return new GridPagingResHelper<LoyMbrChargeResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectChargeInfo(reqDto));
	}

	 /*
	  * 1. 메소드명: getMbrStnPntTxnList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public GridPagingResDto<LoyMbrStnPntTxnListResDto> getMbrStnPntTxnList(LoyMbrStnPntTxnListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return new GridPagingResHelper<LoyMbrStnPntTxnListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrStnPntTxnList(reqDto));
	}



	 /*
	  * 1. 메소드명: getMbrCarHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public GridPagingResDto<LoyMbrCarHistResDto> getMbrCarHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lci");
		return new GridPagingResHelper<LoyMbrCarHistResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrCarHistList(reqDto));
	}

	 /*
	  * 1. 메소드명: editMbrGroupDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public StatusResDto editMbrGroupDetail(LoyMbrGroupReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnDto = new StatusResDto();
		loyMbrMapper.updateMbrGroupeDetail(reqDto);
		return rtnDto;
	}


	 /*
	  * 1. 메소드명: getMbrSegHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	/*public GridPagingResDto<> getMbrSegHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		GridPagingResDto<> rtnValue = new GridPagingResDto<>();
		StringBuilder sqlQuery = new StringBuilder();
		//접속DB정보 설정
		MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
		StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
		encrypor.setPassword("9pwc3dke");


		String classNmae =   encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.driverClassName"));
	    String url = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.url"));
	    String username = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.username"));
 	    String password = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.password"));
	    String condType = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.condDbType"));


		dbInfo.setDriverClassName(classNmae);
	    dbInfo.setUrl(url);
		dbInfo.setUserName(username);
		dbInfo.setPassword(password);
		dbInfo.setConDbType(condType);

		sqlQuery.append(" select t1.yyyymm AS yyyymm  ");
    	sqlQuery.append(" 	, t2.mem_seg_nm AS memSegClassNm  ");
    	sqlQuery.append(" 	, t1.member_num memberNum    ");
    	sqlQuery.append(" 	  from mart.f_segment as t1 ");
    	sqlQuery.append(" 	   inner join mart.d_mem_segment as t2 on t1.mem_seg_cd = t2.mem_seg_cd  ");
    	sqlQuery.append(" WHERE t1.member_num = '" + reqDto.getMbrNo() + "' ");
    	   if (ObjectUtil.isNotEmpty(dbInfo) && ObjectUtil.isNotEmpty(sqlQuery)) {
               //쿼리 실행
               rtnValue = iMKTCallQueryDAO.callSelectForGridList("getMbrSegHistList", sqlQuery.toString(), new ArrayList<String>(), dbInfo, reqDto);
           }
		return rtnValue;
	}*/


	 /*
	  * 1. 메소드명: getEMbrTierHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public GridPagingResDto<LoyMbrTierHistResDto> getEMbrTierHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lth");
		return new GridPagingResHelper<LoyMbrTierHistResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectEMbrTierHistList(reqDto));
	}

	 /*
	  * 1. 메소드명: getMbrPointLimitInfo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public LoyMbrPointLimitResDto getMbrPointLimitInfo(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return loyMbrMapper.selectMbrPointLimitInfo(reqDto);
	}

	 /*
	  * 1. 메소드명: getMbrStnPntTxnDetailList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public GridPagingResDto<LoyMbrStnPntTxnDetailListReqDto> getMbrStnPntTxnDetailList(LoyMbrStnPntTxnDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return new GridPagingResHelper<LoyMbrStnPntTxnDetailListReqDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrStnPntTxnDetailList(reqDto));
	}

	 /*
	  * 1. 메소드명: insertMbrCarHist
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public StatusResDto addMbrCarHist(LoyMbrCarHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnDto = new StatusResDto();
		loyMbrMapper.insertMbrCarHist(reqDto);
		rtnDto.setSuccess(true);
		return rtnDto;
	}


	public GridPagingResDto getMbrBlackList(LoyMbrReqDto reqDto) {
		// 
		return null;
	}


	 /*
	  * 1. 메소드명: getMbrPointLimitList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public GridPagingResDto<LoyMbrPointLimitListResDto> getMbrPointLimitList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lmch");
		return new GridPagingResHelper<LoyMbrPointLimitListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrPointLimiList(reqDto));
	}


	 /*
	  * 1. 메소드명: getMbrClubList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public GridPagingResDto<LoyMbrClupListResDto> getMbrClubList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lcm");
		return new GridPagingResHelper<LoyMbrClupListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrClubList(reqDto));
	}

	 /*
	  * 1. 메소드명: getMbrGroupCardList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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
	public GridPagingResDto<LoyMbrGroupCardListResDto> getMbrGroupCardList(LoyMbrGroupCardListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return new GridPagingResHelper<LoyMbrGroupCardListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrGroupCardList(reqDto));
	}

	public LoyMbrCardResDto getMbrOrangeCardDetail(LoyMbrCardReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return loyMbrMapper.selectMbrOrangeCardDetail(reqDto);
	}



/*	public StatusResDto addMbrBlackHist(LoyMbrBlackListRequestDTO reqDto) {
		// 
		return null;
	}


	public StatusResDto updateMbrBlackHist(LoyMbrBlackListRequestDTO reqDto) {
		// 
		return null;
	}*/


	public StatusResDto setMbrPointLimit(LoyMbrPointLimitReqDto reqDto) {
		StatusResDto rtnVal = new StatusResDto();
		// member point limit 변경
		loyMbrMapper.updateMbrPointLimit(reqDto);
		rtnVal.setSuccess(true);
		if (rtnVal.getSuccess()) {
			// 변경 이력 남기기
			LoyMbrChgHistReqDto chgHistDto = new LoyMbrChgHistReqDto();
			chgHistDto.setCreateBy(reqDto.getCreateBy());
			chgHistDto.setModifyBy(reqDto.getModifyBy());
			//chgHistDto.setAccountId(reqDto.getAccountId());
			chgHistDto.setChgCol("LIMIT_AMT");
			chgHistDto.setBchngData(reqDto.getBchngData());
			chgHistDto.setAchngData(reqDto.getAchngData());
			chgHistDto.setRidMbr(reqDto.getRidMbr());
			chgHistDto.setMbrNo(reqDto.getMbrNo());
			chgHistDto.setChgPstn("CRM");
			loyMbrMapper.insertMbrChgHist(chgHistDto);
			rtnVal.setSuccess(true);
		}
		return rtnVal;
	}

	public LoyMbrSignInfoResDto getMbrSignInfo(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return loyMbrMapper.selectMbrSignInfo(reqDto);
	}


	public GridPagingResDto<LoyMbrChnlHistListResDto> getMbrChnlHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	     reqDto.setSVCAlias("vah");

	     Integer cnt = loyMbrMapper.selectMbrChnlHistListCnt(reqDto);
	     GridPagingResDto<LoyMbrChnlHistListResDto> rtnList = new GridPagingResHelper<LoyMbrChnlHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrChnlHistList(reqDto));

		    if(rtnList.getRows().size()>0){
		    	rtnList.setRecords(cnt);
		    	rtnList.setTotal(cnt);

		    }else{
		    	rtnList.setTotal(0);
		    	rtnList.setRecords(0);
		    }
		    return rtnList;
	}


	public GridPagingResDto getMbrInsurHistList(LoyMbrReqDto reqDto) {
		// 
		return null;
	}


	public GridPagingResDto<LoyMbrChnlHistListResDto> getMbrChnlHistSubList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("vah");
		return new GridPagingResHelper<LoyMbrChnlHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrChnlHistSubList(reqDto));
	}

	public GridPagingResDto<LoyMbrGroupClubListResDto> getMbrGroupUserList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lcm");
		return new GridPagingResHelper<LoyMbrGroupClubListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrGroupUserList(reqDto));
	}


	public GridPagingResDto<LoyMbrGroupPointTxnHistListResDto> getMbrGroupPointTxnHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lpt");
		return new GridPagingResHelper<LoyMbrGroupPointTxnHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrGroupPointTxnHistList(reqDto));
	}


	public GridPagingResDto<LoyMbrGroupCngListResDto> getMbrGroupChnList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lch");
		return new GridPagingResHelper<LoyMbrGroupCngListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrGroupCngList(reqDto));
	}


	public String getChargeSum(LoyMbrReqDto reqDto) {
		// 
		return null;
	}


	public StatusResDto getMbrPwChgDate(LoyMbrReqDto reqDto) {
		// 
		return null;
	}


	 /*
	  * 1. 메소드명: editMbrDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	public StatusResDto editMbrsDetail(LoyMbrItemReqDto reqDto) {
		StatusResDto rtnVal = new StatusResDto();
		LogUtil.param(this.getClass(), reqDto);

		LoyMbrChgHistAddReqDto cRepDto = new LoyMbrChgHistAddReqDto();
		cRepDto.setMbrNo(reqDto.getMbrNo());
		cRepDto.setCreateBy(reqDto.getCreateBy());
		cRepDto.setModifyBy(reqDto.getModifyBy());
		cRepDto.setChgPstn("CRM");
		cRepDto.setBchngEnYn("N");
		cRepDto.setAchngEnYn("N");
		LoyMbrItemResDto srcDto = new LoyMbrItemResDto();

		srcDto = getMbrDetail(reqDto);

		/**
		 * 2019.03.18 hy.jun 식별유형 02 (간편가입) 인 경우 핸드폰번호 변경 시 식별값 중복체크 후 식별값도 같이 변경해준다.
		 */
		if (srcDto.getIdentiTypeCd().equals(CommonUtil.IDENTI_TYPE.PHONE.cd())
				&& !srcDto.getHhpNo().equals(reqDto.getHhpNo())) {

			LoyMbrItemReqDto dupReqDto = new LoyMbrItemReqDto();
			try {
				dupReqDto.setLoyProgramId(reqDto.getLoyProgramId());
				dupReqDto.setRid(reqDto.getRid());
				String dataKey = BeansUtil.getDbEncryptDataKey();
				SecurityUtil.encodeDbAES256(dataKey, "홍길동");
				dupReqDto.setIdentiVal(SecurityUtil.encodeDbAES256(dataKey,reqDto.getHhpNo()));
			} catch (Exception e) {
				rtnVal.setMessage("2"); // 회원정보 변경 중 에러가 발생하였습니다. 관리자에게 문의해주세요. [에러 사유 : 암호화 실패]
				return rtnVal;
			}

			Integer cnt = this.checkDupIdentiVal(dupReqDto);
			if (cnt < 1) {
				reqDto.setIdentiVal(dupReqDto.getIdentiVal());
			} else {
				rtnVal.setMessage("1"); // 회원정보 변경 중 에러가 발생하였습니다. 관리자에게 문의해주세요. [에러 사유 : 식별값 중복]
				return rtnVal;
			}

		}

		// 주소 변경여부 체크
		String addr1Zip = srcDto.getAddr1Zip() == null ? "" : srcDto.getAddr1Zip();
		String addr1Dflt = srcDto.getAddr1Dflt() == null ? "" : srcDto.getAddr1Dflt();
		String addr1Dtl = srcDto.getAddr1Dtl() == null ? "" : srcDto.getAddr1Dtl();

		if (!addr1Zip.equals(StringUtil.convertNull(reqDto.getAddr1Zip(), ""))
				|| !addr1Dflt.equals(StringUtil.convertNull(reqDto.getAddr1Dflt(), ""))
				|| !addr1Dtl.equals(StringUtil.convertNull(reqDto.getAddr1Dtl(), ""))) {
			reqDto.setOwnhomeAdrChgDt(DateUtil.getToday("yyyy-MM-dd HH:mm:ss").toString());
		}

		// 휴대폰번호 뒷자리 추출
		if (reqDto.getHhpNo() != null) {
			String hhpNoTail = reqDto.getHhpNo().substring(reqDto.getHhpNo().length() - 4, reqDto.getHhpNo().length());
			reqDto.setHhpNoTail(hhpNoTail);
		}

		// 변경이력 등록
		rtnVal = compareMbrValueProc(srcDto, reqDto, cRepDto);

		// 수정
		if (rtnVal.getSuccess()) {
			loyMbrMapper.updateMbrDetail(reqDto);
			loyMbrMapper.updateCustDetail(reqDto);
		}

		return rtnVal;
	}




	public StatusResDto editMbrDetailInfo(LoyMbrDetailInfoReqDto reqDto) {
		StatusResDto rtnVal = new StatusResDto();
		LogUtil.param(this.getClass(), reqDto);

		LoyMbrChgHistAddReqDto cRepDto = new LoyMbrChgHistAddReqDto();
		cRepDto.setMbrNo(reqDto.getMbrNo());
		cRepDto.setCreateBy(reqDto.getCreateBy());
		cRepDto.setModifyBy(reqDto.getModifyBy());
		cRepDto.setBchngEnYn("Y");
		cRepDto.setAchngEnYn("N");
		cRepDto.setChgPstn("CRM");

		// 현재 저장된 데이터 조회
		LoyMbrDetailInfoResDto srcDto = new LoyMbrDetailInfoResDto();
		srcDto = this.getMbrDetailInfo(reqDto);

		if (ObjectUtil.isNotEmpty(srcDto.getAnivDt())) {
			String anivDt = srcDto.getAnivDt().replaceAll("-", "");
			srcDto.setAnivDt(anivDt.substring(4, 8));
		}

		rtnVal = compareMbrValueProc(srcDto, reqDto, cRepDto);

		if (rtnVal.getSuccess()) {

			// 회원정보 수정
			loyMbrMapper.updateLoyMbrInfo(reqDto);
			loyMbrMapper.updateLoyCustInfo(reqDto);
		}

		return rtnVal;
	}


	public GridPagingResDto<LoyMbrTmAgrHistListResDto> getMbrTmAtrHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lct");
		return new GridPagingResHelper<LoyMbrTmAgrHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrTmAgrHistList(reqDto),AnnotationType.ALL);
	}



	/*public StatusResDto compareMbrValue(Object srcDto, Object tgtDto, LoyMbrChgHistReqDto cRepDto) {
		// 
		return null;
	}*/


	public LoyMbrProcResDto dropMbrProc(LoyMbrProcReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrProcResDto rtnVal = new LoyMbrProcResDto();
		/* rtnVal = iLOYWebServiceService.dropMbr(reqDto); */
		rtnVal.setSuccess(true);

		if (rtnVal.getSuccess()) {
			loyMbrMapper.dropMbrProc(reqDto);
			if (reqDto.getpResultFlg().equals("S")) {
				rtnVal.setSuccess(true);
			} else {
				rtnVal.setSuccess(false);
				rtnVal.setMessage(reqDto.getpRsltMsg().toString());
			}
		}
		return rtnVal;
	}



	public LoyMbrProcResDto joinMbrProc(LoyMbrProcReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSbscChnlCd("E1");
		LoyMbrProcResDto rtnVal = new LoyMbrProcResDto();

		rtnVal = this.joinMbrProcs(reqDto);

		if (!reqDto.getpRslt().equals("S")) {
			rtnVal.setSuccess(false);
			rtnVal.setMessage(reqDto.getpRsltMsg());
		} else {
			rtnVal.setSuccess(true);
			rtnVal.setMessage(reqDto.getpRsltMsg());
			rtnVal.setpMbrRid(reqDto.getpMbrRid());
			rtnVal.setpMbrNo(reqDto.getpMbrNo());

		}
		return rtnVal;
	}

	 /*
	  * 1. 메소드명: addMbrGroupCard
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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
	public StatusResDto addMbrGroupCard(LoyMbrGroupCardReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnDto = new StatusResDto();
		loyMbrMapper.insertMbrGroupCard(reqDto);
		rtnDto.setSuccess(true);
		return rtnDto;
	}

	 /*
	  * 1. 메소드명: updateMbrCarHist
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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
	public StatusResDto updateMbrCarHist(LoyMbrCarHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnDto = new StatusResDto();
		loyMbrMapper.updateMbrCarHist(reqDto);
		rtnDto.setSuccess(true);
		return rtnDto;
	}


	public StatusResDto compareMbrValue(Object srcDto, Object tgtDto, LoyMbrChgHistReqDto cRepDto,
			boolean isOne, String fieldName) {
		// 
		return null;
	}


	public String tableColName(String colNm) {
		// 
		return null;
	}


	public LoyMbrProcResDto reqCertiCode(LoyMbrProcReqDto reqDto) {
		// 
		return null;
	}


	public LoyMbrProcResDto checkCertiCode(LoyMbrProcReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoyMbrProcResDto certiVal = new LoyMbrProcResDto();

		try{
			certiVal = commonViewService.checkCertiCode(reqDto);
		}catch(ParseException e) {
			LogUtil.error(e);
		}

		if (certiVal.getSuccess()) {
			HashMap<String, Object> iRtnVal = certiVal.getRtnVal();
			reqDto.setIdentiVal(iRtnVal.get("CIInfo").toString());
			reqDto.setName(iRtnVal.get("Name").toString());
			reqDto.setIdentiTypeCd("30");
			reqDto.setHhpNo(iRtnVal.get("Mobile").toString());
			reqDto.setBirthDay(iRtnVal.get("BirthDay").toString());
			reqDto.setPhCertiYn("Y");
			reqDto.setLunarGbnCd("20");
			reqDto.setDiNo(iRtnVal.get("MemberCheckInfo").toString());
			certiVal = joinMbrProc(reqDto);
			if (certiVal.getSuccess()) {
				if (reqDto.getCardNo() != null) {
					if (!reqDto.getCardNo().equals("")) {
						certiVal.getpMbrRid();
						LoySimpleMbrRegProcReqDto regCardParam = new LoySimpleMbrRegProcReqDto();
						regCardParam.setMbrRid(certiVal.getpMbrRid());
						regCardParam.setMbrNo(certiVal.getpMbrNo());
						regCardParam.setCardNo(reqDto.getCardNo());
						regCardParam.setEmpId(reqDto.getEmpId());
						// 카드등록
						StatusResDto regCardRtn = new StatusResDto();
						regCardRtn = this.registSimpleMemCard(regCardParam);
					}

				}
			}
			// 카드 등록 로직 추가

		}

		return certiVal;
	}


	public LoyMbrProcResDto checkMypinNum(LoyMbrProcReqDto reqDto) {
		// 
		return null;
	}


	public LoyMbrProcResDto rereqCertiCode(LoyMbrProcReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoyMbrProcResDto certiVal = new LoyMbrProcResDto();
		try{
			certiVal = commonViewService.rereqCertiCode(reqDto);
		}catch(ParseException e) {
			LogUtil.error(e);
		}

		return certiVal;
	}



	public StatusResDto addMbrVocActyHist(LoyMbrChnlHistListReqDto actyDto) {
		// 
		return null;
	}


	 /*
	  * 1. 메소드명: viewAvlPoint
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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
	public LoyMbrItemResDto viewAvlPoint(LoyMbrItemReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrItemResDto rtnVal = new LoyMbrItemResDto();

		try{
			rtnVal = commonViewService.viewAvlPoint(reqDto);
		}catch(ParseException e){
			LogUtil.error(e);
		}
		return rtnVal;
	}

	 /*
	  * 1. 메소드명: dropMbrGroupUser
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
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
	public StatusResDto dropMbrGroupUser(LoyMbrGroupClubReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnDto = new StatusResDto();
		loyMbrMapper.dropMbrGroupUser(reqDto);
		rtnDto.setSuccess(true);
		return rtnDto;
	}


	public StatusResDto checkMypinNum4Rename(LoyMbrRenameReqDto reqDto) {
		// 
		return null;
	}


	public StatusResDto checkCertiCode4Rename(LoyMbrRenameReqDto reqDto) {
		// 
		return null;
	}


	public StatusResDto addMbrTmAgrHiat(LoyMbrTmAgrHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnDto = new StatusResDto();
		loyMbrMapper.insertMbrTmAgrHist(reqDto);
		rtnDto.setSuccess(true);
		return rtnDto;
	}


	public LoyMbrTmAgrHistListResDto getMbrTmAgrInfo(LoyMbrTmAgrHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrTmAgrHistListResDto resDto = loyMbrMapper.selectMbrTmAgrInfo(reqDto);
		return new AnnotationHelper<LoyMbrTmAgrHistListResDto>(AnnotationType.PersonalData, resDto).getItem();
	}


	public StatusResDto updateMbrTmAgrHist(LoyMbrTmAgrHistReqDto reqDto) {
		StatusResDto rtnVal = new StatusResDto();
		LoyMbrTmAgrHistListResDto compObj = new LoyMbrTmAgrHistListResDto();
		compObj = this.getMbrTmAgrInfo(reqDto);

		if (StringUtil.isNotEmpty(compObj.getTmAgreeYn())) {
			if (compObj.getTmAgreeYn().equals("Y") && reqDto.getTmAgreeYn().equals("Y")) {
				reqDto.setTmAgreeYn(null);
			}
		}

		loyMbrMapper.updateMbrTmAgrHist(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}


	public GridPagingResDto<LoyMbrSemiVipHistListResDto> getMbrSemiVipHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lvh");
		return new GridPagingResHelper<LoyMbrSemiVipHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrSemiVipHistList(reqDto));
	}


	/*public GridPagingResDto getMbrEventHistList(LoyMbrReqDto reqDto) {
		// 
		return null;
	}*/




	public LoyMbrChnlHistContentsResDto getMbrChnlHistContents(LoyMbrChnlHistContentsReqDto reqDto) {
		// 
		return null;
	}


	public GridPagingResDto<LoyMbrCampResResDto> getMbrCampaignResList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        reqDto.setSVCAlias("a");

        /*
         * GridPagingResponseDTO rtnCnt = this.queryForGridList( "LOYMbr.selectMbrCampaignResListCnt", reqDto);
         * Integer cnt = (Integer) rtnCnt.getRows().get(0);
         */
        Integer cnt = loyMbrMapper.selectMbrCampaignResListCnt(reqDto);

        GridPagingResDto<LoyMbrCampResResDto> rtnList = new GridPagingResHelper<LoyMbrCampResResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrCampaignResList(reqDto));
        if (rtnList.getRows().size() > 0) {
            rtnList.setRecords(cnt);
            rtnList.setTotal(cnt);

        }
        else {
            rtnList.setTotal(0);
            rtnList.setRecords(0);
        }
        return rtnList;
	}

	public int getMbrAllCount() {
	LogUtil.param(this.getClass(), "");
	return loyMbrMapper.selectMbrAllCount();
	}

	public StatusResDto delPhoneNum(LoyMbrReqDto reqDto) throws Exception {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		// 변경 이력 쌓기
		LoyMbrChgHistReqDto cRepDto = new LoyMbrChgHistReqDto();
		cRepDto.setRidMbr(reqDto.getRid());
		cRepDto.setMbrNo(reqDto.getMbrNo());
		cRepDto.setCreateBy(reqDto.getCreateBy());
		cRepDto.setModifyBy(reqDto.getModifyBy());
		cRepDto.setChgPstn("CRM");
		rtnVal = compareMbrValue(reqDto.getHhpNo(), "", cRepDto, true, "HHP_NO");

		LoyMbrDetailInfoReqDto srcReqDto = new LoyMbrDetailInfoReqDto();
		LoyMbrDetailInfoResDto srcResDto = new LoyMbrDetailInfoResDto();
		srcReqDto.setRid(reqDto.getRid());
		srcResDto = this.getMbrDetailInfo(srcReqDto);

		reqDto.setChnlAgreSms("");
		rtnVal = compareMbrValue(srcResDto.getChnlAgreSms(), reqDto.getChnlAgreSms(), cRepDto, true, "CHNL_AGRE_SMS");

		// 휴대폰 번호, sms수신여부 update
		loyMbrMapper.delPhoneNum(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}

	public LoyMbrChgHistAddResDto callAddMbrCngHist(LoyMbrChgHistAddReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        reqDto.setSVCAlias("");
        LoyMbrChgHistAddResDto rtnDto = new LoyMbrChgHistAddResDto();
        loyMbrMapper.insertMbrCngHist(reqDto);
        rtnDto.setSuccess(true);
        return rtnDto;
	}

	public GridPagingResDto<LoyDupMbrListResDto> getDupMbrList(LoyMbrReqDto reqDto) throws Exception {
		LogUtil.param(this.getClass(), reqDto);
		/*if (ICNStringUtility.isNotEmpty(reqDto.getHhpNo())) {
			reqDto.setHhpNo(cryptService.getEncrypt(reqDto.getHhpNo()));
		}
		if (ICNStringUtility.isNotEmpty(reqDto.getEmailAddr())) {
			reqDto.setEmailAddr(cryptService.getEncrypt(reqDto.getEmailAddr()));
		}*/
		reqDto.setSVCAlias("wmd");
		return new GridPagingResHelper<LoyDupMbrListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectDupMbrList(reqDto));
	}


	public GridPagingResDto getMbrTermsHistList(LoyMbrTermsHistListReqDto param) {
		// 
		return null;
	}


	public StatusResDto editMbrPntUsePw(LoyMbrEditPntUsePwReqDto param) throws Exception {
		// 기존 포인트사용비밀번호 조회
				String beforePntUsePw = loyMbrMapper.selectMbrPntUsePw(param);

				// 포인트사용비밀번호 sha 단방향 암호화
				param.setPntUsePw(SecurityUtil.encodeSHA256(param.getPntUsePw()));
				StatusResDto rtnValue = new StatusResDto(false, "");

				int cnt = loyMbrMapper.updateMbrPntUsePw(param);
				if(cnt > 0) {
					rtnValue.setSuccess(true);
					rtnValue.setMessage("포인트 사용 비밀번호가 성공적으로 변경되었습니다.");
				} else {
					rtnValue.setMessage("변경할 포인트 사용 비밀번호가 이전과 같습니다.");
				}


				/**
				 * 이경남 부장으로 요청으로 비밀번호 변경이력 ****로 하드코딩 2019.04.23 jk.kim
				 */
				// 비밀번호 변경 성공 시 변경이력 등록
				if (rtnValue.getSuccess()) {
					try {
						LoyMbrChgHistAddReqDto chgHist = new LoyMbrChgHistAddReqDto();
						chgHist.setCreateBy(param.getCreateBy());
						chgHist.setChgTbl("LOY_MBR");
						chgHist.setChgCol("PNT_USE_PW");
						chgHist.setMbrNo(param.getMbrNo());
						chgHist.setBchngEnYn("Y");
						chgHist.setBchngData("**** ");
						chgHist.setAchngEnYn("Y");
						chgHist.setAchngData("****");
						chgHist.setChgPstn("CRM");
						this.callAddMbrCngHist(chgHist);

					} catch (Exception e) {
						LogUtil.error(e);
					}
				}

				return rtnValue;
	}


	 /*
	  * 1. 메소드명: clearDupMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	public GridPagingResDto<LoyDupMbrListResDto> clearDupMbr(LoyDupMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr");
		reqDto.setSVCAlias("wmd");
		return new GridPagingResHelper<LoyDupMbrListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.clearDupMbr(reqDto),AnnotationType.PersonalData);
	}


	 /*
	  * 1. 메소드명: dropReason
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	public StatusResDto dropReason(LoyDropReasonReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        reqDto.setRid(CommonUtil.newRid());
        StatusResDto rtnDto = new StatusResDto();
        loyMbrMapper.insertDropReason(reqDto);
		rtnDto.setSuccess(true);
		rtnDto.setMessage(reqDto.getRid());
		return rtnDto;
	}


	public LoyMbrPntYnResDto getMbrPntAcrlUseYn(LoyMbrPntYnReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);

		 return loyMbrMapper.selectMbrPntAcrlUseYn(reqDto);
	}



	public GridPagingResDto<LoyTransPointListResDto> selectTransList(LoyTransPointListReqDto reqDto) throws Exception {
		LogUtil.param(this.getClass(), reqDto);
		GridPagingResDto<LoyTransPointListResDto> rtnList = new GridPagingResDto<LoyTransPointListResDto>();
	     //값 체크
        if(ObjectUtil.isEmpty(reqDto.getHhpNo())
               && reqDto.getStrCondWhere().equals("1=1")){
           rtnList.setSuccess(false);
           rtnList.setMessage("조회조건이 충분하지 않습니다.");
           return rtnList;
        }
        return new GridPagingResHelper<LoyTransPointListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectTransPoint(reqDto),AnnotationType.PersonalData);
	}


	public StatusResDto transPntReason(LoyDropReasonReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnDto = new StatusResDto();
		loyMbrMapper.insertTransHist(reqDto);
		rtnDto.setSuccess(true);
		rtnDto.setMessage(reqDto.getRid());
		return rtnDto;
	}


	public LoyTransCallExecResDto transPointExec(LoyTransPointListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyTransCallExecResDto rtnValue = loyMbrMapper.transPointExec(reqDto);

		rtnValue.setpRslt(reqDto.getpRslt());
		rtnValue.setpRsltMsg(reqDto.getpRsltMsg());
		rtnValue.setpRsltCd(reqDto.getpRsltCd());
		rtnValue.setSuccess(true);
		if (!rtnValue.getpRslt().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(rtnValue.getpRsltMsg());
		}

		return rtnValue;
	}


	public GridPagingResDto<LoyTransPntHistResDto> transPointHist(LoyTransPointListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyTransPntHistResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectTransPntHist(reqDto));
	}


	public StatusResDto editCustName(LoyMbrRenameReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyMbrMapper.updateMbrName(reqDto);
		rtnValue.setSuccess(true);
		if (rtnValue.getSuccess()) {
			LoyMbrChgHistAddReqDto chgHist = new LoyMbrChgHistAddReqDto();
			chgHist.setCreateBy(reqDto.getCreateBy());
			chgHist.setChgTbl("LOY_CUST");
			chgHist.setChgCol("CUST_NM");
			chgHist.setMbrNo(reqDto.getMbrNo());
			chgHist.setBchngEnYn("N");
			chgHist.setBchngData(reqDto.getPrevCustNm());
			chgHist.setAchngEnYn("N");
			chgHist.setAchngData(reqDto.getNewName());
			chgHist.setChgPstn("CRM");
			chgHist.setRmark(reqDto.getRmark());

			this.callAddMbrCngHist(chgHist);
		}
		return rtnValue;
	}

	public GridPagingResDto<LoyMbrDivListResDto> getMbrDivList(LoyMbrDivListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("lmu");
		return new GridPagingResHelper<LoyMbrDivListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrDivList(param),AnnotationType.CommCode);
	}


	public GridPagingResDto<LoyMbrUploadItemResDto> getMbrUpldItemList(LoyMbrUploadItemReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("lmui");
		return new GridPagingResHelper<LoyMbrUploadItemResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrUpldItemList(param),AnnotationType.ALL);
	}

	public StatusResDto editMbrTier(LoyMbrTierReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		loyMbrMapper.callProcMbrTierUpd(param);

		if ("S".equals(param.getRst())) {
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: getMaxPointLabel
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	public LoyMbrPointAuthResDto getMaxPointLabel(LoyMbrPointAuthReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrPointAuthResDto rtnValue = new LoyMbrPointAuthResDto();

		rtnValue = loyMbrMapper.selectMaxPointLabel(reqDto);

		// 데이터가 없을시 권한없음
		if (StringUtil.isEmpty(rtnValue.getMaxPoint()) || rtnValue.getMaxPoint() == null) {
			rtnValue.setAuthCheck("N");
		}

		return rtnValue;
	}


	 /*
	  * 1. 메소드명: getMbrOrangeCardList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 19.
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

	public GridPagingResDto<LoyMbrCardListResDto> getMbrOrangeCardList(LoyMbrCardListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		return new GridPagingResHelper<LoyMbrCardListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyMbrMapper.selectMbrOrangeCardList(reqDto),AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getMbrGroupAddInfo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	public LoyMbrGroupAddInfoResDto getMbrGroupAddInfo(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		LoyMbrGroupAddInfoResDto resDto = loyMbrMapper.selectMbrGroupAddInfo(reqDto);
		return new AnnotationHelper<LoyMbrGroupAddInfoResDto>(AnnotationType.CommCode, resDto).getItem();
	}

	 /*
	  * 1. 메소드명: checkDupIdentiVal
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	public int checkDupIdentiVal(LoyMbrItemReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyMbrMapper.checkDupIdentiVal(reqDto);
	}

	 /*
	  * 1. 메소드명: compareMbrValueProc
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param srcDto
	 *   @param tgtDto
	 *   @param cRepDto
	 *   @return
	 */
	public StatusResDto compareMbrValueProc(Object srcDto, Object tgtDto, LoyMbrChgHistAddReqDto cRepDto) {

		return compareMbrValueProc(srcDto, tgtDto, cRepDto, false, null);
	}

	public StatusResDto compareMbrValueProc(Object srcDto, Object tgtDto, LoyMbrChgHistAddReqDto cRepDto,
			boolean isOne, String fieldName) {
		LogUtil.debug("[Mbr Change History] start --------------- ");
		StatusResDto rtnVal = new StatusResDto();

		String[] checkedList = { "", null, "N", " " };
		boolean changed = false;
		int changeCnt = 0;

		// 한건의 컬럼정보만 넘겼을 경우
		if (isOne) {
			if (Arrays.asList(checkedList).contains(srcDto.toString())
					&& Arrays.asList(checkedList).contains(tgtDto.toString())) {
				changed = false;
			} else {
				cRepDto.setBchngData(srcDto.toString());
				cRepDto.setAchngData(tgtDto.toString());
				cRepDto.setChgCol(fieldName);
				cRepDto.setChgTbl(tableName(cRepDto.getChgCol()));
				rtnVal = this.callAddMbrCngHist(cRepDto);
				changed = true;
			}
		} else {
			Class srcClass = srcDto.getClass();
			Class tgtClass = tgtDto.getClass();

			Method srcMethods[] = srcClass.getMethods();
			Method tgtMethods[] = tgtClass.getMethods();

			for (int i = 0; i < srcMethods.length; i++) {
				Method srcMethod = srcMethods[i];
				String srcMethodName = srcMethod.getName();
				for (int j = 0; j < tgtMethods.length; j++) {
					Method tgtMethod = tgtMethods[j];
					String tgtMethodName = tgtMethod.getName();
					String field = srcMethodName.substring(3, srcMethodName.length());
					if (srcMethodName.equals(tgtMethodName)) {
						if (srcMethodName.equals("getClass")) {
							continue;
						}
						Object[] args = null;
						if (srcMethodName.length() >= 3 && srcMethodName.substring(0, 3).equals("get")) {

							try {
								Object returnSrcObj = srcMethod.invoke(srcDto, args);
								Object returnTgtObj = tgtMethod.invoke(tgtDto, args);

								if (ObjectUtil.isNotEmpty(returnSrcObj)
										&& tableColName(field).equalsIgnoreCase("HHP_NO")) {
									try {
										String dataKey = BeansUtil.getDbEncryptDataKey();
										returnSrcObj = SecurityUtil.decodeDbAES256(dataKey,returnSrcObj.toString());
									} catch (Exception e) {
										/**
										 * 변경전값 복호화 에러발생 시 복호화필요X 컬럼으로 판단하여 변경전값 그대로 사용한다. hhpNo의 경우 변경전값이 암호화된 상태이고
										 * 변경후값은 암호화X 상태이다. LOYMbrController 에서 무조건 암호화여부 'N' 으로 보내고있으므로 체크해줘야한다.
										 * (LOYMbrController 에서 암호화여부 'Y'로 수정할 경우 다른 필드에 대한 변경이력이 꼬이게 된다.)
										 */
										LogUtil.error(e);
									}
								}

								if (ObjectUtil.isNotEmpty(returnSrcObj)
										|| ObjectUtil.isNotEmpty(returnTgtObj)) {
									cRepDto.setChgCol(tableColName(field));
									cRepDto.setChgTbl(tableName(cRepDto.getChgCol()));

									cRepDto.setBchngData(returnSrcObj == null ? null : String.valueOf(returnSrcObj));
									cRepDto.setAchngData(returnTgtObj == null ? null : String.valueOf(returnTgtObj));

									rtnVal = this.callAddMbrCngHist(cRepDto);
									if ("S".equals(cRepDto.getResultFlg())) {
										LogUtil.debug("[Mbr Change History] insert history " + cRepDto.getChgTbl()
												+ "." + cRepDto.getChgCol());
										changed = true;
										changeCnt++;
									} else {
										LogUtil.debug(
												"[Mbr Change History] fail insert history " + cRepDto.getRsltMsg());
									}
								}
							} catch (Exception e) {
								LogUtil.error(e);
							}

						}
					}
				}
			}
		}

		LogUtil.debug("[Mbr Change History] result = " + changeCnt);
		LogUtil.debug("[Mbr Change History] end --------------- ");
		return rtnVal;
	}

	 /*
	  * 1. 메소드명: tableName
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param colNm
	 *   @return
	 */
	public String tableName(String colNm) {
		String replaceString = "loy_mbr";
		String[] custFields = { "MARRY_YN", "MARRY_ANIV", "GEN_GBN_CD", "CUST_NM", "LUNAR_GBN_CD", "BIRTH_DT",
				"FOREIGN_CD", "IDENTI_VAL" };
		for (String custField : custFields) {
			if (custField.equals(colNm)) {
				replaceString = "loy_cust";
			}
		}
		return replaceString.toUpperCase();
	}

	 /*
	  * 1. 메소드명: editMbrGroupAddInfo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 23.
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
	public StatusResDto editMbrGroupAddInfo(LoyMbrGroupAddInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrGroupAddInfoResDto oldReq = new LoyMbrGroupAddInfoResDto();
		LoyMbrGroupAddInfoResDto newReq = new LoyMbrGroupAddInfoResDto();
		LoginResDto loginInfo = new LoginResDto();
		/*loginInfo.setAccountOrgId(reqDto.getAccountId());
		loginInfo.setAppServiceId(reqDto.getAppServiceId());
		loginInfo.setCountry(reqDto.getCountry());*/

		// 사업자 번호 vali
		String bizNo = reqDto.getBizrNo();
		if (ObjectUtil.isNotEmpty(bizNo)) {
			StatusResDto rtnBiz = commonViewService.bizNumCheck(bizNo);
			if (!rtnBiz.getSuccess()) {
				return rtnBiz;
			} else {
				String bizNoSuc = rtnBiz.getMessage();
				reqDto.setBizrNo(bizNoSuc);
			}
		}

		LoyMbrReqDto tmpDto = new LoyMbrReqDto();
		tmpDto.setRid(reqDto.getRid());

		// 변경전
		oldReq = getMbrGroupAddInfo(tmpDto);

		// 변경...
		// 부정동호회 구분 값이 부정확신(BL41)이면 회원 상태를 불량(30)으로 update
		if (StringUtil.isNotEmpty(reqDto.getFraudDiv())) {
			if (reqDto.getFraudDiv().equals("BL41")) {
				reqDto.setMbrStatCd("30");
			} else {
				reqDto.setMbrStatCd("10");
			}
			loyMbrMapper.updateMbrGroupStat(reqDto);
		}
		loyMbrMapper.updateMbrGroupAddInfo(reqDto);
		// 변경후
		newReq = getMbrGroupAddInfo(tmpDto);

		loyChannelService.changeChannelValueHist(oldReq, newReq, reqDto.getChnlId(), reqDto.getCreateBy(), loginInfo);
		StatusResDto rtnVal = new StatusResDto();
		rtnVal.setSuccess(true);
		return rtnVal;
	}


//	public StatusResDto addVocPntTxn(LoyVocPntTxnReqDto lvptr, HttpServletRequest request) {
//        LogUtil.param(this.getClass(), lvptr);
//
//        //lvptr.setRid(iMKTBase.getRowID());
//        //Object returnValue = this.insert("LOYMbr.insertVocPntTxn", lvptr, true);
//
//        //System.out.println(returnValue);
//
//        String chnlNo = "GloLiveBO"; //글로라이브 BO
//        String intactTypePntTxtType = "VOC";
//        String intactTypePntTxtDtlType = "VOC_GEN";
//
//        String reqDt = DateUtil.getToday("yyyy-MM-dd HH:mm:ss");
//        String sndDate = DateUtil.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "yyyyMMdd");
//		String sndTime = DateUtil.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "HHmmss");
//
//		//2018.11.29 hy.jun VOC 포인트 요청 시 산출 X이므로 인터랙션 유형 및 인터랙션 이력테이블 rid 제외 - 김영환 부장님과 협의.
//		//2019.02.14 hy.jun VOC 거래이력 JOIN 을 위해 다시 추가함. - 이성원 과장님과 협의.
//		String ridIntactType;
//		String ridIntactData;
//
//        StatusResDto rtnDto = new StatusResDto(false, "");
//
//        //적립 요청
//        if(lvptr.getPntTxnType_1Cd().equals(PNT_TXN_TYPE.ACRL.getValue())) {
//	        //로열티admin권한 소유자가 아닌 경우 1회 포인트 적립 제한 - 운영환경 (개발은 제한하지 않는다.)
//	        /*if(CommonUtil.getServerType().equals(CommonUtil.SERVER_TYPE.Real)) {
//
//	        	boolean isChk = true;
//
//	        	HttpSession session = request.getSession(true);
//	        	MKTAuthorityResponseDTO authList = (MKTAuthorityResponseDTO) session.getAttribute(CommonUtil.SESSIONID_AUTH);
//	        	for(MKTAuthorityListResponseDTO auth : authList.getAuthList()) {
//	        		if(auth.getAuthNo().equals("31")) { //권한번호 31 : 로열티admin권한
//	        			isChk = false;
//	        			break;
//	        		}
//	        	}
//
//	        	if(isChk) {
//	        		//적립제한 포인트 체크
//	        		MKTCommCodeExGridRequestDTO mccegr = new MKTCommCodeExGridRequestDTO();
//	        		mccegr.setGroupCode("CS_PNT_ACRL_LIMIT");
//	        		mccegr.setCodeName("01");
//	        		mccegr.setAppServiceId(lvptr.getAppServiceId());
//	        		mccegr.setSidx("modify_date");
//	        		mccegr.setSord("desc");
//	        		mccegr.setPageSize(10);
//
//	        		List<Object> commCodeInfoList = iMKTCommCodeExDAO.selectCommCodeExGroupList(mccegr).getRows();
//	        		MKTCommCodeExGridResponseDTO commCodeInfo = (MKTCommCodeExGridResponseDTO) commCodeInfoList.get(0);;
//
//	        		if(commCodeInfoList.size() == 1) {
//	        			//적립제한 포인트 체크
//	        			if(Integer.parseInt(lvptr.getPntAmt().split("\\.")[0]) > Integer.parseInt(commCodeInfo.getAttrib01())) {
//	        				rtnDto.setMessage("1회 최대 적립 가능 포인트를 초과했습니다. 최대 적립 가능한 포인트 금액은 " + commCodeInfo.getAttrib01() + "점 입니다.");
//	        				return rtnDto;
//	        			}
//	        		} else {
//	        			rtnDto.setMessage("Too Many Common Code. [CS_PNT_ACRL_LIMIT:01]");
//	        			return rtnDto;
//	        		}
//	        	}
//	        }*/
//        }
//
//        int cnt = 0;
//        try {
//        	//VOC 직접 적립 - 인터랙션 유형 : 영수증 사후적립
//        	//2019.02.14 hy.jun 사후적립 산출태우지 않으므로 인터랙션 유형 VOC 로 넣는다.
////			if(ObjectUtil.isNotEmpty(lvptr.getRcptData())) {
////		        intactTypePntTxtType = "PURC";
////		        intactTypePntTxtDtlType = "PURC_AFTER";
////			}
//
//	        //loy_intact_voc 등록
//	        LoyMbrLoyIntactVocReqDto lmlivr = new LoyMbrLoyIntactVocReqDto();
//	        ridIntactData = CommonUtil.newRid();
//	        lmlivr.setRid(ridIntactData);
////	        lmlivr.setRid(iMKTBase.getRowID());
//	        lmlivr.setOccuDate(reqDt);
//	        lmlivr.setRidMbr(lvptr.getRidMbr());
//	        lmlivr.setVocReqby(lvptr.getModifyBy());
//	        lmlivr.setVocReqAmt(lvptr.getPntAmt());
//	        lmlivr.setVocDesc(lvptr.getVocDesc());
//
//	        lmlivr.setPntTxnType(lvptr.getPntTxnType_1Cd());
//	        lmlivr.setPntTxnDtlType(lvptr.getPntTxnType_2Cd());
//
//	        /*lmlivr.setAccountId(lvptr.getAccountId());
//	        lmlivr.setAppServiceId(lmlivr.getAppServiceId());
//	        lmlivr.setCountry(lvptr.getCountry());*/
//
//	        lmlivr.setOfferId(lvptr.getOfferId());
//	        lmlivr.setChnlNo(chnlNo);
//
//	        lmlivr.setPntTxnType_1Cd(intactTypePntTxtType);
//	        lmlivr.setPntTxnType_2Cd(intactTypePntTxtDtlType);
//
//	        lmlivr.setRidMktCamMst(lvptr.getRidMktCamMst());
//
//	        if(ObjectUtil.isNotEmpty(lvptr.getRcptData())) {
//	        	LoyRcptAftrPntAcrlReqDto rcptData = lvptr.getRcptData();
//	        	lmlivr.setRcptNo(rcptData.getInputRcptNo());
//
//	        	//영수증 통한 적립일 경우 VOC사유 자동생성한다.
//	        	lmlivr.setVocDesc("[사후적립] " + "영수증번호 : " + rcptData.getInputRcptNo() + ", 판매일자 : " + rcptData.getInputSalesDt() + ", 매장코드 : " + rcptData.getChnlNo());
//	        }
//
//	        //포인트적립 요청 시 넘길 인터랙션유형 rid 추가 조회
//	        ridIntactType = (String) this.queryForObject(String.class, "LOYMbr.getIntactTypeRid", lmlivr, false);
//
//	        cnt = (int) this.insert("LOYMbr.insertLoyIntactVoc", lmlivr, true);
//        } catch(Exception e) {
//        	LogUtil.error(e);
//        	LogUtil.error("VOC 이력 등록에 실패하였습니다.");
//        	rtnDto.setMessage("VOC 이력 등록에 실패하였습니다.");
//        	return rtnDto;
//        }
//
//        //적립 요청
//        if(lvptr.getPntTxnType_1Cd().equals(PNT_TXN_TYPE.ACRL.getValue())) {
//			try {
//				LOYPointAcrlRequestDTO lpar = new LOYPointAcrlRequestDTO();
//
//				//VOC 직접 적립
//				if(ObjectUtil.isEmpty(lvptr.getRcptData())) {
//					lpar.setIsConTran(1);
//					lpar.setAccountId(lvptr.getAccountId());
//					lpar.setAppServiceId(lvptr.getAppServiceId());
//					lpar.setLang(lvptr.getLang());
//					lpar.setCountry(lvptr.getCountry());
//					lpar.setModifyBy(lvptr.getModifyBy());
//					lpar.setPgmNo(lvptr.getLoyProgramNo());
//
//					lpar.setIdentiType("92"); //식별유형 : 92(회원RID)
//					lpar.setIdentiVal(lvptr.getRidMbr()); //식별값 : 회원RID
//
//					lpar.setTxnTypeCd(lvptr.getPntTxnType_1Cd()); //거래유형
//					lpar.setTxnTypeDtlCd(lvptr.getPntTxnType_2Cd()); //거래상세유형
//
//					lpar.setPntAmt(Integer.valueOf(lvptr.getPntAmt())); //적립포인트
//
//					lpar.setOfferNo(lvptr.getOfferNo());
//					lpar.setOfferType(lvptr.getOfferType());
//
//					lpar.setTxnUniqNo(iMKTBase.getRowID());
//
//					lpar.setCalcFlag("N");
//
//					lpar.setSndDate(sndDate);
//					lpar.setSndTime(sndTime);
//					lpar.setTxnDate(sndDate);
//					lpar.setTxnTime(sndTime);
//
//					lpar.setChnlNo(chnlNo); //적립처 : 아성다이소 고정값
//
//					lpar.setRidIntactType(ridIntactType);
//					lpar.setRidIntactDate(ridIntactData);
//				}
//				//VOC 영수증 통한 적립
//				else {
//					lpar.setIsConTran(1);
//					lpar.setAccountId(lvptr.getAccountId());
//					lpar.setAppServiceId(lvptr.getAppServiceId());
//					lpar.setLang(lvptr.getLang());
//					lpar.setCountry(lvptr.getCountry());
//					lpar.setModifyBy(lvptr.getModifyBy());
//					lpar.setPgmNo(lvptr.getLoyProgramNo());
//
//					lpar.setIdentiType("92"); //식별유형 : 92(회원RID)
//					lpar.setIdentiVal(lvptr.getRidMbr()); //식별값 : 회원RID
//
//					lpar.setTxnTypeCd(lvptr.getPntTxnType_1Cd()); //거래유형
//					lpar.setTxnTypeDtlCd(lvptr.getPntTxnType_2Cd()); //거래상세유형
//
//	//				lpar.setPntAmt(Integer.valueOf(lvptr.getPntAmt())); //적립포인트
//					lpar.setPntAmt(Integer.valueOf(lvptr.getPntAmt().split("\\.")[0])); //적립포인트
//					lpar.setTxnAmt(Integer.parseInt(lvptr.getRcptData().getPayAmt().replaceAll(",", ""))); //실결제금액
//
//					lpar.setOfferNo(lvptr.getOfferNo());
//					lpar.setOfferType(lvptr.getOfferType());
//
//					lpar.setTxnUniqNo(iMKTBase.getRowID());
//
//					lpar.setPosNo(lvptr.getRcptData().getPosNum());
//					lpar.setRcptNo(lvptr.getRcptData().getInputRcptNo());
//					lpar.setCalcFlag("N");
//
//					lpar.setSndDate(sndDate);
//					lpar.setSndTime(sndTime);
//					lpar.setTxnDate(IFVMDateUtility.getDateFormat(lvptr.getRcptData().getTxnDate(), "yyyy-MM-dd", "yyyyMMdd"));
//					lpar.setTxnTime(IFVMDateUtility.getDateFormat(lvptr.getRcptData().getTxnTime(), "HH:mm", "HHmm") + "00");
//
//					lpar.setChnlNo(lvptr.getRcptData().getChnlNo()); //적립처 : 영수증 정보의  가맹점코드
//
//					lpar.setRidIntactType(ridIntactType);
//					lpar.setRidIntactDate(ridIntactData);
//				}
//
//				//적립요청 프로시저 호출
//				rtnDto = iLOYCommonDAO.callProcPointAcrl(lpar);
//
//				//적립요청 성공 시
//				if(rtnDto.getSuccess()) {
//					rtnDto.setMessage("처리되었습니다.");
//
//					//푸시 발송 - 적립 건은 모바일앱에서 푸시메시지 우측 위치하도록 한다.
//					/*LOYChnlTransPushRequestDTO lctpr = new LOYChnlTransPushRequestDTO();
//					lctpr.setCuid(lvptr.getMbrNo());
//					lctpr.setSub_title("고객센터로부터 " + lvptr.getPntAmt() + "포인트 적립되었습니다.");
//					StatusResDto rtnPush = iLOYWebServiceService.sendPushUracle(lctpr);
//
//					if(!rtnPush.getSuccess()) {
//						LogUtil.error("LOYMbrDAO.addVocPntTxn 적립 푸시 발송 중 에러 발생 >> "+rtnPush.getMessage());
//					}*/
//
//				} else {
//					LogUtil.error("LOYMbrDAO.addVocPntTxn VOC 처리 중 에러 발생 >> "+"["+lpar.getRstCd()+"] "+lpar.getRstMsg());
//					rtnDto.setMessage("에러가 발생하였습니다. 관리자에게 문의해주세요. [에러코드 : "+lpar.getRstCd()+"] "+lpar.getRstMsg());
//					return rtnDto;
//				}
//			} catch (Exception e) {
//				LogUtil.error(e);
//				rtnDto.setMessage("에러가 발생하였습니다. 관리자에게 문의해주세요. [에러코드 : UNKNOWN_001]");
//			}
//        }
//        //차감 요청
//        else if(lvptr.getPntTxnType_1Cd().equals(PNT_TXN_TYPE.RDM.getValue())) {
//        	try {
//				LOYPointRdmRequestDTO lprr = new LOYPointRdmRequestDTO();
//				lprr.setIsConTran(1);
//				lprr.setAccountId(lvptr.getAccountId());
//				lprr.setAppServiceId(lvptr.getAppServiceId());
//				lprr.setLang(lvptr.getLang());
//				lprr.setCountry(lvptr.getCountry());
//				lprr.setModifyBy(lvptr.getModifyBy());
//				lprr.setPgmNo(lvptr.getLoyProgramNo());
//
//				lprr.setIdentiType("92"); //식별유형 : 92(회원RID)
//				lprr.setIdentiVal(lvptr.getRidMbr()); //식별값 : 회원RID
//
//				lprr.setTxnTypeCd(lvptr.getPntTxnType_1Cd()); //거래유형
//				lprr.setTxnTypeDtlCd(lvptr.getPntTxnType_2Cd()); //거래상세유형
//
//				lprr.setPntAmt(Integer.valueOf(lvptr.getPntAmt())); //차감포인트
//
////				lprr.setOfferNo(lvptr.getOfferNo());
//				lprr.setOfferType("POINT");
//
//				lprr.setTxnUniqNo(iMKTBase.getRowID());
//
//				lprr.setCalcFlag("N");
//
//				lprr.setSndDate(sndDate);
//				lprr.setSndTime(sndTime);
//				lprr.setTxnDate(sndDate);
//				lprr.setTxnTime(sndTime);
//
//				lprr.setChnlNo(chnlNo); //적립처 : 아성다이소 고정값
//				lprr.setRidIntactDate(ridIntactData);
//
//	        	//사용요청 프로시저 호출
//				rtnDto = iLOYCommonDAO.callProcPointRdm(lprr);
//
//				//사용요청 성공 시
//				if(rtnDto.getSuccess()) {
//					rtnDto.setMessage("처리되었습니다.");
//
//					//푸시 발송 - 차감 건은 모바일앱에서 푸시메시지 좌측 위치하도록 한다.
//					LoyChnlTransPushReqDto lctpr = new LoyChnlTransPushReqDto();
//					lctpr.setCuid(lvptr.getMbrNo());
//					lctpr.setSub_title("고객센터로부터 " + lvptr.getPntAmt() + "포인트 차감되었습니다.");
//					StatusResDto rtnPush = iLOYWebServiceService.sendPushUracle(lctpr);
//
//					if(!rtnPush.getSuccess()) {
//						LogUtil.error("LOYMbrDAO.addVocPntTxn 차감 푸시 발송 중 에러 발생 >> "+rtnPush.getMessage());
//					}
//
//				} else {
//					LogUtil.error("LOYMbrDAO.addVocPntTxn VOC 처리 중 에러 발생 >> "+"["+lprr.getRstCd()+"] "+lprr.getRstMsg());
//					rtnDto.setMessage("에러가 발생하였습니다. 관리자에게 문의해주세요. [에러코드 : "+lprr.getRstCd()+"] "+lprr.getRstMsg());
//					return rtnDto;
//				}
//			} catch (Exception e) {
//				LogUtil.error(e);
//				rtnDto.setMessage("에러가 발생하였습니다. 관리자에게 문의해주세요. [에러코드 : UNKNOWN_001]");
//			}
//        }
//
//        return rtnDto;
//    }

	public StatusResDto addMbrGroupUser(LoyMbrGroupClubReqDto reqDto) {
		StatusResDto rtnVal = new StatusResDto();
		// 중복확인
		reqDto.setSVCAlias("lcm");
		List<HashMap<String, String>> groupUserList = loyMbrMapper.selectMbrGroupUser(reqDto);

		if (groupUserList != null && groupUserList.size() > 0) {
			rtnVal.setSuccess(false);
			rtnVal.setMessage(Messages.getMessage("L01953", reqDto.getLang()));
		} else {
			String rid = CommonUtil.newRid();
			reqDto.setRid(rid);
			// 회원 추가
			 loyMbrMapper.insertMbrGroupUser(reqDto);
			 rtnVal.setSuccess(true);
		}
		return rtnVal;
	}

	 /*
	  * 1. 메소드명: registSimpleMemCard
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo
	  * 4. 작성일자: 2020. 3. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param param
	 *   @return
	 */
	public StatusResDto registSimpleMemCard(LoySimpleMbrRegProcReqDto param) {
		LogUtil.param(this.getClass(), param);

		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);
	//	LoySimpleMbrRegProcReqDto rtnObj =  new LoySimpleMbrRegProcReqDto();

		loyMbrMapper.callLoyProcInsertCard(param);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	public LoyMbrProcResDto joinMbrProcs(LoyMbrProcReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		LoyMbrProcResDto rtnDto = new LoyMbrProcResDto();
		try{
			loyMbrMapper.joinMbrProc(reqDto);
			if(reqDto.getpRslt().equals("S")) {
				rtnDto.setSuccess(true);
				rtnDto.setpRslt(reqDto.getpRslt());
				rtnDto.setpMbrRid(reqDto.getpMbrRid());
				rtnDto.setpMbrNo(reqDto.getMbrNo());
				rtnDto.setpRsltMsg(reqDto.getpRsltMsg());
				rtnDto.setpResultFlg(reqDto.getpResultFlg());
			}else {
				rtnDto.setSuccess(false);
				rtnDto.setpRsltMsg(reqDto.getpRsltMsg());
			}

		}catch(Exception e){
			rtnDto.setSuccess(false);
			rtnDto.setMessage("관리자에게 문의하세요");
		}

		return rtnDto;
	}

	public GridPagingResDto<LoyMbrListNewPageResDto> getMbrListNewPage(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		GridPagingResDto<LoyMbrListNewPageResDto> rtnValueCnt = new GridPagingResHelper<LoyMbrListNewPageResDto>().newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType()),loyMbrMapper.selectMbrListNewPageCnt(reqDto));

		int totalCnt = rtnValueCnt.getRows().get(0).getTotalCount();

		return new GridPagingResHelper<LoyMbrListNewPageResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrListNewPage(reqDto),AnnotationType.ALL,totalCnt);
	}


	 /*
	  * 1. 메소드명: clearMaskListMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 8.
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

	public LoyMbrListNewPageResDto clearMaskListMbr(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
		LoyMbrListNewPageResDto res =      loyMbrMapper.clearMaskListMbr(reqDto);
	    return new AnnotationHelper<LoyMbrListNewPageResDto>(AnnotationType.ALL, res).getItem();
	}


	 /*
	  * 1. 메소드명: getMmbrDetailNewPage
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 12.
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

	public LoyMbrDetailNewPageResDto getMmbrDetailNewPage(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
		LoyMbrDetailNewPageResDto res = loyMbrMapper.selectMbrDetailNewPage(reqDto);

		//사용안함 주석
        //혜택정보 (보유포인트, 가용포인트, 적입예정, 익월 소멸예정)
//		LoyPontBalanceB2cReqDto lpbbr = new LoyPontBalanceB2cReqDto();
//		lpbbr.setRid(reqDto.getRid());

//		selectPontBalanceB2c(lpbbr);
//		res.setAvlPoint(lpbbr.getP_UsePnt()); //가용포인트
//		res.setExtncPamPoint(lpbbr.getP_Expr1MonthPnt()); //소멸예정포인트
//		res.setPreAcrlPoint(lpbbr.getP_PreAcrlPnt()); //적립예정포인트
//		res.setTotalPoint(Integer.toString(Integer.parseInt(lpbbr.getP_UsePnt())+Integer.parseInt(lpbbr.getP_PreAcrlPnt())));
        
        //혜택정보(보유쿠폰, 보유티켓)
        res.setCoupon(loyMbrMapper.selectMbrCpnCnt(reqDto));
//        res.setTicket(loyMbrMapper.selectMbrTicketCnt(reqDto));
         
        //주거래 매장
        LoyMbrDetailPopResDto rtnPrStoreValue = new LoyMbrDetailPopResDto();
        rtnPrStoreValue = loyMbrMapper.seletMbrPrStore(reqDto);
        if(rtnPrStoreValue != null) {
			res.setPrStoreNm(rtnPrStoreValue.getPrStoreNm());
			res.setPrStoreCd(rtnPrStoreValue.getPrStoreCd());
		}
		
		//이벤트 참여
		LoyMbrDetailNewPageResDto evtValue =   loyMbrMapper.selectOneMbrEvt(reqDto);
		if(evtValue  != null) {
			res.setEvtNm(evtValue.getEvtNm());
			res.setEvtDt(evtValue.getEvtDt());
		}
		
		LoyMbrDetailNewPageResDto resRepId =loyMbrMapper.selectMbrDetailRepId(reqDto);
		
		//대표아이디세팅
		if(ObjectUtil.isEmpty(resRepId)|| resRepId.getUser_id() == null) {
			res.setUser_id(null);
		}else {
			res.setUser_id(resRepId.getUser_id());
		}

		//나이 설정
		if(ObjectUtil.isNotEmpty(res.getBirthdt())){
			int birthYear = Integer.parseInt(res.getBirthdt().substring(0,4));
			int birthMonth = Integer.parseInt(res.getBirthdt().substring(4,6));
			int birthDay = Integer.parseInt(res.getBirthdt().substring(6,8));
			//나이 구하기
			Calendar current = Calendar.getInstance();
			int currentYear  = current.get(Calendar.YEAR);
			int currentMonth = current.get(Calendar.MONTH) + 1;
			int currentDay   = current.get(Calendar.DAY_OF_MONTH);

			int ageValue = currentYear - birthYear;
			// 생일 안 지난 경우 -1
			if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
				ageValue--;
			}
			res.setAge(Integer.toString(ageValue));

			if(res.getBirthdt().equals("0")) {
				res.setAge(null);
			}
		}

		//고객문의 건수
		LoyMbrDetailNewPageResDto vocSrcReqValue = loyMbrMapper.selectVocSvcReqCnt(reqDto);
		if(ObjectUtil.isNotEmpty(vocSrcReqValue.getVocReqCnt())){
			res.setClosedCnt(vocSrcReqValue.getClosedCnt());
			res.setVocReqCnt(vocSrcReqValue.getVocReqCnt());
		}

		//등급 순위 설정
		LoyMbrDetailNewPageResDto tierLvlValue = new LoyMbrDetailNewPageResDto();
		if(ObjectUtil.isNotEmpty(res.getTierDST())){
			tierLvlValue = loyMbrMapper.selectTierLvl(res.getTierDST());
			res.setTierDSTLvl(tierLvlValue.getTierLvl());
			res.setTierDSTMaxLvl(tierLvlValue.getTierMaxLvl());
		}
		if(ObjectUtil.isNotEmpty(res.getTierLCS())){
			tierLvlValue = loyMbrMapper.selectTierLvl(res.getTierLCS());
			res.setTierLCSLvl(tierLvlValue.getTierLvl());
			res.setTierLCSMaxLvl(tierLvlValue.getTierMaxLvl());
		}
		if(ObjectUtil.isNotEmpty(res.getTierUMB())){
			tierLvlValue = loyMbrMapper.selectTierLvl(res.getTierUMB());
			res.setTierUMBLvl(tierLvlValue.getTierLvl());
			res.setTierUMBMaxLvl(tierLvlValue.getTierMaxLvl());
		}
		if(ObjectUtil.isNotEmpty(res.getTierDSG())){
			tierLvlValue = loyMbrMapper.selectTierLvl(res.getTierDSG());
			res.setTierDSGLvl(tierLvlValue.getTierLvl());
			res.setTierDSGMaxLvl(tierLvlValue.getTierMaxLvl());
		}
		if(ObjectUtil.isNotEmpty(res.getTierLCG())){
			tierLvlValue = loyMbrMapper.selectTierLvl(res.getTierLCG());
			res.setTierLCGLvl(tierLvlValue.getTierLvl());
			res.setTierLCGMaxLvl(tierLvlValue.getTierMaxLvl());
		}
		if(ObjectUtil.isNotEmpty(res.getTierMSW())){
			tierLvlValue = loyMbrMapper.selectTierLvl(res.getTierMSW());
			res.setTierMSWLvl(tierLvlValue.getTierLvl());
			res.setTierMSWMaxLvl(tierLvlValue.getTierMaxLvl());
		}

		//설문참여건수
		res.setSurveyTgtCnt(loyMbrMapper.selectMbrSurvSendTgt(reqDto)); //설문 회원 타겟팅 카운드
		res.setSurveyJoinCnt(loyMbrMapper.selectMbrSurvJoin(reqDto)); //설문 참여 회원 카운트
		
		LoyMbrDetailNewPageResDto rtnValue = new LoyMbrDetailNewPageResDto();
		rtnValue = new AnnotationHelper<LoyMbrDetailNewPageResDto>(AnnotationType.ALL, res).getItem();
		
		if("휴면".equals(res.getMbrStatCd())) {
			rtnValue.setCust_nm(rtnValue.getMaskCustNm());
			rtnValue.setHhp(rtnValue.getMaskHhp());
        }


		return rtnValue;
	}
	
//	public static Boolean empty(Object obj) {
//		
//		  if (obj instanceof String) return obj == null || "".equals(obj.toString().trim());
//		  else if (obj instanceof List) return obj == null || ((List) obj).isEmpty();
//		  else if (obj instanceof Map) return obj == null || ((Map) obj).isEmpty();
//		  else if (obj instanceof Object[]) return obj == null || Array.getLength(obj) == 0;
//		  else return obj == null;
//	}
//		 
//	/**
//	  * Object type 변수가 비어있지 않은지 체크
//	  * 
//	  * @param obj
//	  * @return Boolean : true / false
//	  */
//	public static Boolean notEmpty(Object obj) {
//		  return !empty(obj);
//	}



	 /*
	  * 1. 메소드명: getmbrCustList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 12.
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

	public GridPagingResDto<LoyMbCustListResDto> getmbrCustList(LoyMbrReqDto reqDto) {
		// 
		return null;
	}


	 /*
	  * 1. 메소드명: getmbrPointHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 12.
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

	public GridPagingResDto<LoyMbrPtnTxnHistListResDto> getMbrPointHistList(LoyMbrPtnTxnHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrPtnTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrPointHistList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getChnlRelHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 13.
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

	public GridPagingResDto<LoyMbrChnlRelListResDto> getChnlRelHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrChnlRelListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectChnlRelHistList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getCouponList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 13.
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

	public GridPagingResDto<LoyMbrCouponListResDto> getCouponList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrCouponListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectCouponList(reqDto),AnnotationType.CommCode);



	}


	 /*
	  * 1. 메소드명: getAlterHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 13.
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

	public GridPagingResDto<LoyMbrAlterHistListResDto> getAlterHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrAlterHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectAlterHistList(reqDto),AnnotationType.CommCode);
	}
	
	/*
	  * 1. 메소드명: getAllAboutAlterHistConts
	  * 2. 클래스명: LoyMbrMapper
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021. 02. 03.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 회원의 알림이력 탭에서 각 알림이력에 대한 '내용(컨텐츠)'에 관련된 것을 모두 조회하는 쿼리
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyMbrAlterHistContsResDto getAllAboutAlterHistConts(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		//알림이력 내용(컨텐츠)들에 대한 데이터들을 모두 가져온 객체
		LoyMbrAlterHistContsResDto contsObj = loyMbrMapper.selectAllAboutAlterHistConts(reqDto);		
		//알림이력내용에 엮여있는 태그내용들을 모두 가져온 객체
		List<LoyMbrAlterHistContsResDto> tagObjList = loyMbrMapper.selectTagForAlterHistConts(reqDto);		
		//사용될 객체 준비
		String contsSbst = null;
		if(contsObj.getExeChnlTypeCd().equals("EMAIL")) {
			contsSbst = contsObj.getContsHtml();
		} else {
			contsSbst = contsObj.getContsSbst();
		}
		
		String targetContsSbst = StringUtil.convertNull(contsSbst);
		String tagTempName = "";
		List<String> indexOfStrData = new ArrayList<String>(); // 태그명들을 인덱스처럼 순서대로 담아놓을 리스트배열
		
		// SMS든 LMS든 EMAIL이든 모든 채널유형 레코드들은 컨텐츠내용이(CONTS_SBST) '{{ 태그내용 }}' 식의 태그형식값을 품고 있다.
		for(LoyMbrAlterHistContsResDto obj : tagObjList) { // LOY_CUST_ALT_HIST의 rid값에 대응되는 (LOY_CUST_ALT_TAG_HIST의) 태그명,값들이 존재할 경우 => indexOfStrData안에 순서대로 쌓아넣는다
			if(StringUtil.isNotEmpty(obj.getTagNm()) && StringUtil.isNotEmpty(obj.getTagVal())) {
				indexOfStrData.add(obj.getTagNm()); // 태그명,태그값 들이 모두 존재하므로 -> 일종의 인덱스처럼 이용해줄 태그명들을 리스트배열안에 일단 넣는다	
			}
		}
		// 해당 {{태그명}} 부분에 임시로 etc1, etc2 ... 식으로 임시명칭으로 전환해주기
		Integer j = 1;
		for(String tagNm : indexOfStrData) {
			String indexOfStr = "{{" + tagNm + "}}";
			String replaceStr = "[{][{]" + tagNm + "[}][}]";
				//개인화 속성값 '(' or ')' 포함인 경우 '[]'로 감싸준다.
			replaceStr = replaceStr.replaceAll("[(]", Matcher.quoteReplacement("[(]"));  
			replaceStr = replaceStr.replaceAll("[)]", Matcher.quoteReplacement("[)]"));
			tagTempName = "etc" + j;
			
			if(targetContsSbst.indexOf(indexOfStr) > -1) {
				targetContsSbst = targetContsSbst.replaceAll(replaceStr, Matcher.quoteReplacement(tagTempName));
			}
			
			j++;
		}//targetContsSbst(내용글)안에 있는 '태그부위'들이 전부 치환될때까지 반복
		
		Integer i = 1;
		for(LoyMbrAlterHistContsResDto obj : tagObjList) {
			if(StringUtil.isNotEmpty(obj.getTagNm()) && StringUtil.isNotEmpty(obj.getTagVal())) { // 값이 비지 않았는지 확인
				if(obj.getEncYn().equals("Y")) { // 해당 태그객체내용값이 암호화된 것인가?(Y) => 해독 후 얻는다
					targetContsSbst = targetContsSbst.replaceAll("etc"+i, SecurityUtil.decodeDbAES256(obj.getTagVal())); // 해독 후 얻는다
				} else { // encYn이 "N" 일 경우
					targetContsSbst = targetContsSbst.replaceAll("etc"+i, obj.getTagVal()); // 그냥 바로 넣는다
				}
			}
            i++;
		}
		
		contsObj.setContsSbst(targetContsSbst);
		
		return contsObj;
	}//end getAllAboutAlterHistConts


	 /*
	  * 1. 메소드명: getMemberCardList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 15.
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

	public GridPagingResDto<LoyMbrMemberCardListResDto> getMemberCardList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrMemberCardListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMemberCardList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getBlackHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 15.
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

	public GridPagingResDto<LoyMbrBlackHistListResDto> getBlackHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrBlackHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectBlackHistList(reqDto),AnnotationType.Nothing);
	}


	 /*
	  * 1. 메소드명: getRecommendHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 5. 15.
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

	public GridPagingResDto<LoyMbrRecommendHistListResDto> getRecommendHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrRecommendHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectRecommendHistList(reqDto),AnnotationType.ALL);
	}


	 /*
	  * 1. 메소드명: getMbrTierListNew
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 1. 메소드명: getMbrTierListNew
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	public GridPagingResDto<LoyMbrTiersListResDto> getMbrTierListNew(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrTiersListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrTierListNew(reqDto),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: saveJoinCustAll
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyCallAddNewCustResDto saveJoinCustAll(LoyNewCustAddReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		String custNm = reqDto.getCust_nm();
		reqDto.setCust_nm(getStrEncrypt(reqDto.getCust_nm()));
		reqDto.setCust_nm_add(getStrEncrypt(reqDto.getCust_nm_add()));
		reqDto.setHhp(getStrEncrypt(reqDto.getHhp().replaceAll("-", "")));
		reqDto.setEmail(getStrEncrypt(reqDto.getEmail()));
		reqDto.setBunji(getStrEncrypt(reqDto.getBunji()));
		reqDto.setBunji_add(getStrEncrypt(reqDto.getBunji_add()));
		reqDto.setCertVal(getStrEncrypt(reqDto.getCertVal()));
		reqDto.setUser_id(getStrEncrypt(reqDto.getUser_id()));
		reqDto.setUser_pwd(getStrEncryptPassWd(reqDto.getUser_pwd()));
		reqDto.setMbrCCardNo(getStrEncrypt(reqDto.getMbrCCardNo()));
		reqDto.setBirthdt(reqDto.getBirthdt().replaceAll("-", ""));
		//법정 대리인
		reqDto.setLaName(getStrEncrypt(reqDto.getLaName()));
		reqDto.setLaCertVal(getStrEncrypt(reqDto.getLaCertVal()));
		reqDto.setCommitYn("Y");

		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
		SimpleDateFormat formatter2 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );
		String baseTime = formatter2.format ( currentTime );
		//System.out.println(dTime);

		String[] keyF = {"CUST_NM"
				, "BIRTHDT"
				, "LUNAR_CD"
				, "GEN_CD"
				, "HHP"
				, "EMAIL"
				, "ZIP"
				, "ADRES"
				, "BUNJI"
				, "B_CODE"
				, "SBSC_CHNL_NO"
				, "SBSC_PATH_CD"
				, "SBSC_DT"
				, "SBSC_DEVICE_CD"
				, "DRMNCY_CHNG_UNIT"
				, "CERT_TYPE_CD"
				, "CERT_SUB_TYPE_CD"
				, "CERT_VAL"
				, "RCMMD_NO"
				, "USER_ID"
				, "USER_PWD"
				, "LOGIN_TYPE_CD"
				, "CUST_NM_ADD"
				, "ZIP_ADD"
				, "ADRES_ADD"
				, "BUNJI_ADD"
				, "B_CODE_ADD"
				, "NLTY"
				, "NATIVE_YN"
				, "EMP_NO"
				, "MRRG_YN"
				, "ANNVRSRY"
				, "ANNVRSRY_TYPE_CD"
//				, "FRGNR_NO"
				, "WRC_NM"
				, "PSTN"
				, "LA_NAME"
				, "LA_CERT_VAL"
				, "LA_AGRE_DT"
				, "PR_STORE_CD"
				, "MBR_C_NO"
				, "MBR_C_BR_NO"
				, "MBR_C_CARD_NO"
		};
		String[] valF = {reqDto.getCust_nm()
				, reqDto.getBirthdt()
				, reqDto.getLunar_cd()
				, reqDto.getGen_cd()
				, reqDto.getHhp()
				, reqDto.getEmail()
				, reqDto.getZip()
				, reqDto.getAdres()
				, reqDto.getBunji()
				, reqDto.getbCode()
				, reqDto.getChnlNo()
				, reqDto.getSbscPathCd()
				, dTime
				, reqDto.getSbscDeviceCd()
				, reqDto.getDrmncy_chng_unit()
				, reqDto.getCertTypeCd()
				, reqDto.getCertSubTypeCd()
				, reqDto.getCertVal()
				, reqDto.getRcmmd_no()
				, reqDto.getUser_id()
				, reqDto.getUser_pwd()
				, reqDto.getLoginTypeCd()
				, reqDto.getCust_nm_add()
				, reqDto.getZip_add()
				, reqDto.getAdres_add()
				, reqDto.getBunji_add()
				, reqDto.getbCodeAdd()
				, reqDto.getNlty()
				, reqDto.getNative_yn()
				, reqDto.getEmpNo()
				, reqDto.getMrrg_yn()
				, reqDto.getAnnvrsry()
				, reqDto.getAnnvrsry_type_cd()
//				, reqDto.getFrgnrNo()
				, reqDto.getWrcNm()
				, reqDto.getPstn()
				, reqDto.getLaName()
				, reqDto.getLaCertVal()
				, reqDto.getLaAgreDt() /*dTime*/
				, reqDto.getPrStoreCd()
				, reqDto.getMbrCNo()
				, reqDto.getMbrCBrNo()
				, reqDto.getMbrCCardNo()
		};
		LoyCallAddNewCustResDto rtnValue = new LoyCallAddNewCustResDto();

		//cust
		List<Map<String,String>> custTbl = new ArrayList<Map<String,String>>();
		for(int i =0; i<keyF.length; i++) {
			Map<String,String> fieldValMap = new LinkedHashMap<String,String>();
			fieldValMap.put("FIELD", keyF[i]);
			fieldValMap.put("VAL",valF[i]);
			custTbl.add(i, fieldValMap);
		}

		Object  tCustTbl = custTbl;

		//cust company
		Map<String,Object> companyMap = new LinkedHashMap<String,Object>();
		companyMap.put("CMPNY_NM",null);
		companyMap.put("BIZR_NO",null);
		companyMap.put("JURIR_NO",null);
		companyMap.put("FOND_DT",null);
		companyMap.put("CEO",null);
		companyMap.put("CHARGER",null);
		companyMap.put("TEL_NO",null);
		companyMap.put("FAX",null);
		companyMap.put("ZIP",null);
		companyMap.put("ADRES",null);
		companyMap.put("BUNJI",null);
		companyMap.put("ETC",null);
		companyMap.put("SIGUNGU_CODE",null);
		companyMap.put("B_CODE",null);
		companyMap.put("BUILDING_CODE",null);
		companyMap.put("INDUTY",null);
		companyMap.put("BIZCND",null);
		companyMap.put("CAPL",null);

		Object  tCustCTbl = companyMap;

		//cust agree
		List<Map<String,Object>> custAgreTbl = new ArrayList<Map<String,Object>>();

		for(int i=0; i<reqDto.getTermsList().size(); i++) {
			Map<String,Object> agreMap = new LinkedHashMap<String,Object>();
			agreMap.put("AGRE_TYPE_CD", reqDto.getTermsList().get(i).getAgreTypeCd());
			agreMap.put("AGRE_YN", reqDto.getTermsList().get(i).getAgreYn());
			agreMap.put("REG_DT", dTime);
			agreMap.put("TERMS_VER_NO", reqDto.getTermsList().get(i).getTermsVerNo());
			custAgreTbl.add(i, agreMap);
		}

		Object  tCustAgreTbl = custAgreTbl;


		//cust add
		Map<String,Object> custAddTbl = new HashMap<String,Object>();

		custAddTbl.put("ADD_INF_CD", null);
		custAddTbl.put("ADD_INF_VAL", null);

		Object  tCustAddTbl = custAddTbl;

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("commitYn", "Y");
		map.put("empId",reqDto.getEmpId());
		map.put("custTypeCd",reqDto.getCusttypecd());
		map.put("mbrTypeCd",reqDto.getMbrTypeCd());
		map.put("pgmNo",reqDto.getPgmNo());

		map.put("tCustTbl",tCustTbl); 				// 회원
		map.put("tCustCTbl",tCustCTbl); 			// 사업자(사용x)
		map.put("tCustAgreTbl",tCustAgreTbl); 	// 동의항목
		map.put("tCustAddTbl",tCustAddTbl); 	// 추가

		loyMbrMapper.saveJoinCustAll(map);

		//output
		rtnValue.setRst((String)map.get("Rst"));
		rtnValue.setRstMsg((String)map.get("RstMsg"));
		rtnValue.setRstCd((String)map.get("RstCd"));
		rtnValue.setCustNo((String)map.get("oCustNo"));
		rtnValue.setMbrNo((String)map.get("oMbrNo"));
		rtnValue.setMbrCardNo((String)map.get("oMbrCardNo"));
		
		//부정회원 관리자에게 메일보내기로직(수정중)
//		if("200".equals(rtnValue.getRstCd())) {
//			SendInfo sInfo = new SendInfo();
//			sInfo.setSendTo("hr.noh@quintet.co.kr");
//			sInfo.setSubject("[멤버십 시스템 자동메일] 부정회원 의심고객 가입");
//			sInfo.setContent("회원명 : "+custNm+"\n"+"회원번호 : "+(String)map.get("oCustNo")+"\n"+"가입일시 : "+baseTime );
//			MailUtils.sendMailSmtp(sInfo);
//		}

		rtnValue.setSuccess(true);
		if (!rtnValue.getRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage((String)map.get("RstMsg"));
			//rtnValue.setMessage("RstMsg : "+(String)map.get("RstMsg")+", RstCd : "+(String)map.get("RstCd"));
		}

		return rtnValue;
	}

     /*
      * 1. 메소드명: getStrEncrypt
      * 2. 클래스명: LoyMbrService
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 6. 13.
      */
    /**
     * <PRE>
     * 1. 설명
     *		암호화 처리
     * 2. 사용법
     *
     * </PRE>
     *   @param txt
     *   @return
     */
    private String getStrEncrypt(String txt) {
   	    String dataValue = SecurityUtil.encodeDbAES256(BeansUtil.getDbEncryptDataKey(), txt);

        return dataValue;
    }
    
     /*
      * 1. 메소드명: getStrEncryptPassWd
      * 2. 클래스명: LoyMbrService
      * 3. 작성자명: hr.noh
      * 4. 작성일자: 2020. 7. 22.
      */
    /**
     * <PRE>
     * 1. 설명
     *		비밀번호 암호화 처리
     * 2. 사용법
     *		
     * </PRE>
     *   @param txt
     *   @return	
     */
    public String getStrEncryptPassWd(String txt) {
    	String dataValue = SecurityUtil.encodeSHA256(txt);
    	
    	return dataValue;
    }

	 /*
	  * 1. 메소드명: getMbrEventHistListNew
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 1. 메소드명: custItemConfVal
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 10.
	  */
	public GridPagingResDto<LoyMbrEventHistListResDto> getMbrEventHistListNew(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrEventHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrEventHistListNew(reqDto),AnnotationType.CommCode);
	}


	/**
	* <PRE>
	* 1. 설명
	*
	*		고객정보수집 항목 가져오기(대표 프로그램)
	* 2. 사용법
	*
	* </PRE>
	*   @param reqDto
	*   @return
	*/
	public GridPagingResDto<LoyCustItemConfListResDto> custItemConfVal(LoyCustItemConfReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		//대표 프로그램 여부 확인
		if(ObjectUtil.isNotEmpty(reqDto.getPgmNo())) {
			String repYn = loyMbrMapper.checkPgmRepYn(reqDto);
			reqDto.setRepYn(repYn);
		}
		
		return new GridPagingResHelper<LoyCustItemConfListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectCustItemConfVal(reqDto));
	}


	 /*
	  * 1. 메소드명: getMbrTxnHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 11.
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

	public GridPagingResDto<LoyMbrTxnHistListResDto> getMbrTxnHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrTxnHistList(reqDto),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getMbrOnBoardHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 12.
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

	public GridPagingResDto<LoyMbrOnBoardTxnHistListResDto> getMbrOnBoardHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrOnBoardTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrOnBoardHistList(reqDto),AnnotationType.CommCode);
	}


	public GridPagingResDto<LoyMbrCouponListResDto> getCouponHistList(LoyMbrReqDto reqDto) {
				LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrCouponListResDto>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()),
						loyMbrMapper.selectCouponHistList(reqDto),AnnotationType.CommCode);


	}


	 /*
	  * 1. 메소드명: getMbrAgreList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 15.
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

	public GridPagingResDto<LoyMbrAgreListResDto> getMbrAgreList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrAgreListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrAgreList(reqDto),AnnotationType.CommCode);
	}




	 /*
	  * 1. 메소드명: getMbrPointExcelHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 17.
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

	public GridPagingResDto<LoyMbrPtnTxnHistListResDto> getMbrPointExcelHistList(LoyMbrPtnTxnHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrPtnTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrPointExcelHistList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getMbrOnBoardExcelHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환
	  * 4. 작성일자: 2020. 6. 17.
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

	public GridPagingResDto<LoyMbrOnBoardTxnHistListResDto> getMbrOnBoardExcelHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrOnBoardTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrOnBoardExcelHistList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getMbrFamilyList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 패밀리 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyMbrFamilyListResDto> getMbrFamilyList(LoyMbrFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyMbrFamilyListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectMbrFamilyList(reqDto), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: saveNewFmlyMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 구성원 가입
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyFamilyCallbackResDto saveNewFmlyMbr(LoyFamilyListReqDto reqDto) {
		LoyFamilyCallbackResDto rtnValue = new LoyFamilyCallbackResDto();
		loyMbrMapper.saveNewFmlyMbr(reqDto);

		rtnValue.setRst(reqDto.getRst());
		rtnValue.setRstMsg(reqDto.getRstMsg());
		rtnValue.setRstCd(reqDto.getRstCd());
		rtnValue.setSuccess(true);
		if (!rtnValue.getRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(rtnValue.getRstMsg());
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: checkFmlyChief
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		대표회원 여부 체크
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyMbrFmlyResDto checkFmlyChief(LoyMbrFamilyListReqDto reqDto) {
		LoyMbrFmlyResDto rtnValue = new LoyMbrFmlyResDto();
		rtnValue.setSuccess(false);
		int checkFmly = loyMbrMapper.checkFmlyChiefCnt(reqDto);
		if(checkFmly > 0) {
			rtnValue = loyMbrMapper.checkFmlyChief(reqDto);
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeFmlyMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 회원 탈퇴
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyFamilyCallbackResDto removeFmlyMbr(LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyFamilyCallbackResDto rtnValue = new LoyFamilyCallbackResDto();
		loyMbrMapper.deleteFmlyMbr(reqDto);

		rtnValue.setRst(reqDto.getRst());
		rtnValue.setRstMsg(reqDto.getRstMsg());
		rtnValue.setRstCd(reqDto.getRstCd());
		rtnValue.setSuccess(true);
		if (!rtnValue.getRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(rtnValue.getRstMsg());
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: termsListVal
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 약관리스트 불러오기
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyTermsListResDto> termsListVal(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyTermsListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectTermsListVal(reqDto), AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: termsMktRcvListVal
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 약관 마켓팅 수신동의 항목 리스트 불러오기
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyTermsRcvChnlListResDto> termsMktRcvListVal(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyTermsRcvChnlListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectTermsMktRcvListVal(reqDto), AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getMbrDetailPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 정보 수정팝업 상세
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	@Transactional
	public LoyMbrDetailPopResDto getMbrDetailPop(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrDetailPopResDto rtnValue = new LoyMbrDetailPopResDto();

		loggingHelper.insertCustReleaLog(reqDto, "mbr_detail_pop"); // 이력 저장
		rtnValue = loyMbrMapper.selectMbrDetailPop(reqDto);
		
		//주거래 매장 조회 1건만
        LoyMbrDetailPopResDto rtnPrStoreValue = new LoyMbrDetailPopResDto();
        rtnPrStoreValue = loyMbrMapper.seletMbrPrStore(reqDto);
        
        if(ObjectUtil.isNotEmpty(rtnPrStoreValue)) {
        	rtnValue.setPrStoreCd(rtnPrStoreValue.getPrStoreCd());
    		rtnValue.setPrStoreNm(rtnPrStoreValue.getPrStoreNm());
        }

		return new AnnotationHelper<LoyMbrDetailPopResDto>(AnnotationType.ALL, rtnValue).getItem();
	}
	
	 /*
	  * 1. 메소드명: getCorpMbrDetailPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: lee gyeong young
	  * 4. 작성일자: 2020. 12. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 회원 정보 수정팝업 상세
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	@Transactional
	public LoyCorpMbrDetailPopResDto getCorpMbrDetailPop(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyCorpMbrDetailPopResDto rtnValue = new LoyCorpMbrDetailPopResDto();

		loggingHelper.insertCustReleaLog(reqDto, "mbr_detail_pop"); // 이력 저장
		
		rtnValue = loyMbrMapper.selectCorpMbrDetailPop(reqDto);
		
		
		//주거래 매장 조회 1건만
       LoyMbrDetailPopResDto rtnPrStoreValue = new LoyMbrDetailPopResDto();
       rtnPrStoreValue = loyMbrMapper.seletMbrPrStore(reqDto);
       
       	if(ObjectUtil.isNotEmpty(rtnPrStoreValue)) {
       		rtnValue.setPrStoreCd(rtnPrStoreValue.getPrStoreCd());
    		rtnValue.setPrStoreNm(rtnPrStoreValue.getPrStoreNm());
       	}

		return new AnnotationHelper<LoyCorpMbrDetailPopResDto>(AnnotationType.ALL, rtnValue).getItem();
	}



	 /*
	  * 1. 메소드명: getMbrTermsDetailList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 정보 수정팝업 동의이력 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyAgreTermsResDto> getMbrTermsDetailList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyAgreTermsResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectMbrTermsDetailList(reqDto), AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: saveMbrDetailPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원정보 상세 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyCallAddNewCustResDto saveMbrDetailPop(LoyNewCustAddReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setCust_nm(getStrEncrypt(reqDto.getCust_nm()));
		reqDto.setCust_nm_add(getStrEncrypt(reqDto.getCust_nm_add()));
		reqDto.setHhp(getStrEncrypt(reqDto.getHhp().replaceAll("-", "")));
		reqDto.setEmail(getStrEncrypt(reqDto.getEmail()));
		reqDto.setBunji(getStrEncrypt(reqDto.getBunji()));
		reqDto.setBunji_add(getStrEncrypt(reqDto.getBunji_add()));
		reqDto.setZip(getStrEncrypt(reqDto.getZip()));
		reqDto.setZip_add(getStrEncrypt(reqDto.getZip_add()));
		reqDto.setTel_no(getStrEncrypt(reqDto.getTel_no()));
		//reqDto.setCertVal(getStrEncrypt(reqDto.getCertVal()));	//수정필요
//		reqDto.setUser_id(getStrEncrypt(reqDto.getUser_id()));
//		reqDto.setUser_pwd(getStrEncryptPassWd(reqDto.getUser_pwd()));
		/*reqDto.setMbrCCardNo(getStrEncrypt(reqDto.getMbrCCardNo()));*/
		reqDto.setBirthdt(reqDto.getBirthdt().replaceAll("-", ""));
		//법정 대리인
		reqDto.setLaName(getStrEncrypt(reqDto.getLaName()));
		reqDto.setLaCertVal(getStrEncrypt(reqDto.getLaCertVal()));
		reqDto.setCommitYn("Y");

		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );

		String[] keyF = {
				  "mbrNm"
				/*  "birthDt"*/
				/*, "LUNAR_CD"*/
				, "genCd"
				, "mobileNo"
				, "email"
				, "zipCd"
				, "addr"
				, "addrDtl"
				, "bCode"
//				, "SBSC_CHNL_NO" 
//				, "SBSC_PATH_CD" 
//				, "SBSC_DT" 
//				, "SBSC_DEVICE_CD" 
				/*, "DRMNCY_CHNG_UNIT"
				, "CERT_TYPE_CD"
				, "CERT_SUB_TYPE_CD"
				, "CERT_VAL"*/
//				, "RCMMD_NO" 
//				, "USER_ID"
//				, "USER_PWD" 
//				, "LOGIN_TYPE_CD"
				/*, "custNmAdd"*/
				, "zipAdd"
				, "adresAdd"
				, "bunjiAdd"
				, "bCodeAdd"
				/*, "nlty"*/
				, "nativeYn"
//				, "EMP_NO"
				, "merryYn"
				, "annDt"
				, "annvrsryTypeCd"
				, "telNo"
				, "snsType"
				, "snsAddr"
				, "mStoreCd"
				, "childYn"
//				, "FRGNR_NO" 
				/*, "WRC_NM"*/
				/*, "PSTN"*/
//				, "LA_NAME"
//				, "LA_CERT_VAL"
//				, "LA_AGRE_DT"
//				, "PR_STORE_CD"
				/*, "MBR_C_NO"
				, "MBR_C_BR_NO"
				, "MBR_C_CARD_NO"*/
		};
		String[] valF = {
				  reqDto.getCust_nm()
				/*  reqDto.getBirthdt()*/
				/*, reqDto.getLunar_cd()*/
				, reqDto.getGen_cd()
				, reqDto.getHhp()
				, reqDto.getEmail()
				, reqDto.getZip()
				, reqDto.getAdres()
				, reqDto.getBunji()
				, reqDto.getbCode()
//				, reqDto.getChnlNo()
//				, reqDto.getSbscPathCd()
//				, dTime
//				, reqDto.getSbscDeviceCd()
				/*, reqDto.getDrmncy_chng_unit()*/
				/*, reqDto.getCertTypeCd()*/
				/*, reqDto.getCertSubTypeCd()
				, reqDto.getCertVal()*/
//				, reqDto.getRcmmd_no()
//				, reqDto.getUser_id()
//				, reqDto.getUser_pwd()
//				, reqDto.getLoginTypeCd()
				/*, reqDto.getCust_nm_add()*/
				, reqDto.getZip_add()
				, reqDto.getAdres_add()
				, reqDto.getBunji_add()
				, reqDto.getbCodeAdd()
				/*, reqDto.getNlty()*/
				, reqDto.getNative_yn()
//				, reqDto.getEmpNo()
				, reqDto.getMrrg_yn()
				, reqDto.getAnnvrsry()
				, reqDto.getAnnvrsry_type_cd()
				, reqDto.getTel_no()
				, reqDto.getSnsTypeCd()
				, reqDto.getSnsAddr()
				, reqDto.getPrStoreNo()
				, reqDto.getChild_yn()
//				, reqDto.getFrgnrNo() 
				/*, reqDto.getWrcNm()*/
				/*, reqDto.getPstn()*/
//				, reqDto.getLaName()
//				, reqDto.getLaCertVal()
//				, reqDto.getLaAgreDt() /*dTime*/
//				, reqDto.getPrStoreCd()
				/*, reqDto.getMbrCNo()
				, reqDto.getMbrCBrNo()
				, reqDto.getMbrCCardNo()*/
		};
		LoyCallAddNewCustResDto rtnValue = new LoyCallAddNewCustResDto();

		//cust
		List<Map<String,String>> custTbl = new ArrayList<Map<String,String>>();
		for(int i =0; i<keyF.length; i++) {
			Map<String,String> fieldValMap = new LinkedHashMap<String,String>();
			fieldValMap.put("FIELD", keyF[i]);
			fieldValMap.put("VAL",valF[i]);
			custTbl.add(i, fieldValMap);
		}

		Object  tCustTbl = custTbl;


		//cust agree
		List<Map<String,Object>> custAgreTbl = new ArrayList<Map<String,Object>>();

		for(int i=0; i<reqDto.getTermsList().size(); i++) {
			Map<String,Object> agreMap = new LinkedHashMap<String,Object>();
			agreMap.put("AGRE_TYPE_CD", reqDto.getTermsList().get(i).getAgreTypeCd());
			agreMap.put("AGRE_YN", reqDto.getTermsList().get(i).getAgreYn());
			agreMap.put("TERMS_VER_NO", reqDto.getTermsList().get(i).getTermsVerNo());
			agreMap.put("REG_DT", dTime);
			custAgreTbl.add(i, agreMap);
		}

		Object  tCustAgreTbl = custAgreTbl;


		//cust add
		Map<String,Object> custAddTbl = new HashMap<String,Object>();

		custAddTbl.put("ADD_INF_CD", null);
		custAddTbl.put("ADD_INF_VAL", null);

		Object  tCustAddTbl = custAddTbl;

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("commitYn", "Y");
		map.put("empId",reqDto.getModifyBy());
		map.put("pgmNo",reqDto.getPgmNo());
		map.put("chnlNo",reqDto.getChnlNo());
		map.put("mbrNo",reqDto.getMbrNo());

		map.put("tCustTbl",tCustTbl); 				// 회원
		map.put("tCustAgreTbl",tCustAgreTbl); 	// 동의항목
		map.put("tCustAddTbl",tCustAddTbl); 	// 추가

		loyMbrMapper.updateMbrDetailPop(map);

		//output
		rtnValue.setRst((String)map.get("Rst"));
		rtnValue.setRstMsg((String)map.get("RstMsg"));
		rtnValue.setRstCd((String)map.get("RstCd"));
		rtnValue.setSuccess(true);
		if (!rtnValue.getRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage((String)map.get("RstMsg"));
		}

		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: saveCorpMbrDetailPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: lee gyeong young
	  * 4. 작성일자: 2020. 12. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원정보 상세 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyCallAddNewCustResDto saveCorpMbrDetailPop(LoyNewCustAddReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setCust_nm(getStrEncrypt(reqDto.getCust_nm()));
		reqDto.setHhp(getStrEncrypt(reqDto.getHhp().replaceAll("-", "")));
		reqDto.setEmail(getStrEncrypt(reqDto.getEmail()));
		reqDto.setBunji(getStrEncrypt(reqDto.getBunji()));
		reqDto.setZip(getStrEncrypt(reqDto.getZip()));
		//reqDto.setCertVal(getStrEncrypt(reqDto.getCertVal()));	//수정필요
//		reqDto.setUser_id(getStrEncrypt(reqDto.getUser_id()));
//		reqDto.setUser_pwd(getStrEncryptPassWd(reqDto.getUser_pwd()));
		/*reqDto.setMbrCCardNo(getStrEncrypt(reqDto.getMbrCCardNo()));*/
//		reqDto.setBirthdt(reqDto.getBirthdt().replaceAll("-", ""));
		//법정 대리인
		reqDto.setLaName(getStrEncrypt(reqDto.getLaName()));
		reqDto.setLaCertVal(getStrEncrypt(reqDto.getLaCertVal()));
		reqDto.setCommitYn("Y");

		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );

		String[] keyF = {/*"mbrNm"*/
				/*  "birthDt"*/
				/*, "LUNAR_CD"*/
				/*, "GEN_CD"*/
				/*, "mobileNo"*/
				  "email"
				, "zipCd"
				, "addr"
				, "addrDtl"
				, "bCode"
//				, "SBSC_CHNL_NO" 
//				, "SBSC_PATH_CD" 
//				, "SBSC_DT" 
//				, "SBSC_DEVICE_CD" 
				/*, "DRMNCY_CHNG_UNIT"
				, "CERT_TYPE_CD"
				, "CERT_SUB_TYPE_CD"
				, "CERT_VAL"*/
//				, "RCMMD_NO" 
//				, "USER_ID"
//				, "USER_PWD" 
//				, "LOGIN_TYPE_CD"
				/*, "custNmAdd"*/
				, "zipAdd"
				, "adresAdd"
				, "bunjiAdd"
//				, "bCodeAdd"
				/*, "nlty"*/
//				, "nativeYn"
//				, "EMP_NO"
//				, "mrrgYn"
//				, "annDt"
//				, "annvrsryTypeCd"
				, "cTelNo"
//				, "snsType"
//				, "snsAddr"
				, "mStoreCd"
				, "ceo"
				, "charger"
//				, "FRGNR_NO" 
				/*, "WRC_NM"*/
				/*, "PSTN"*/
//				, "LA_NAME"
//				, "LA_CERT_VAL"
//				, "LA_AGRE_DT"
//				, "PR_STORE_CD"
				/*, "MBR_C_NO"
				, "MBR_C_BR_NO"
				, "MBR_C_CARD_NO"*/
		};
		String[] valF = {/*reqDto.getCust_nm()*/
				/*  reqDto.getBirthdt()*/
				/*, reqDto.getLunar_cd()*/
				/*, reqDto.getGen_cd()*/
				/*, reqDto.getHhp()*/
				  reqDto.getEmail()
				, reqDto.getZip()
				, reqDto.getAdres()
				, reqDto.getBunji()
				, reqDto.getbCode()
//				, reqDto.getChnlNo()
//				, reqDto.getSbscPathCd()
//				, dTime
//				, reqDto.getSbscDeviceCd()
				/*, reqDto.getDrmncy_chng_unit()*/
				/*, reqDto.getCertTypeCd()*/
				/*, reqDto.getCertSubTypeCd()
				, reqDto.getCertVal()*/
//				, reqDto.getRcmmd_no()
//				, reqDto.getUser_id()
//				, reqDto.getUser_pwd()
//				, reqDto.getLoginTypeCd()
				/*, reqDto.getCust_nm_add()*/
				, reqDto.getZip_add()
				, reqDto.getAdres_add()
				, reqDto.getBunji_add()
//				, reqDto.getbCodeAdd()
				/*, reqDto.getNlty()*/
//				, reqDto.getNative_yn()
//				, reqDto.getEmpNo()
//				, reqDto.getMrrg_yn()
//				, reqDto.getAnnvrsry()
//				, reqDto.getAnnvrsry_type_cd()
				, reqDto.getTel_no()
//				, reqDto.getSnsTypeCd()
//				, reqDto.getSnsAddr()
				, reqDto.getPrStoreNo()
				, reqDto.getCeo()
				, reqDto.getCharger()
//				, reqDto.getFrgnrNo() 
				/*, reqDto.getWrcNm()*/
				/*, reqDto.getPstn()*/
//				, reqDto.getLaName()
//				, reqDto.getLaCertVal()
//				, reqDto.getLaAgreDt() /*dTime*/
//				, reqDto.getPrStoreCd()
				/*, reqDto.getMbrCNo()
				, reqDto.getMbrCBrNo()
				, reqDto.getMbrCCardNo()*/
		};
		LoyCallAddNewCustResDto rtnValue = new LoyCallAddNewCustResDto();

		//cust
		List<Map<String,String>> custTbl = new ArrayList<Map<String,String>>();
		for(int i =0; i<keyF.length; i++) {
			Map<String,String> fieldValMap = new LinkedHashMap<String,String>();
			fieldValMap.put("FIELD", keyF[i]);
			fieldValMap.put("VAL",valF[i]);
			custTbl.add(i, fieldValMap);
		}

		Object  tCustTbl = custTbl;


		//cust agree
		List<Map<String,Object>> custAgreTbl = new ArrayList<Map<String,Object>>();

		for(int i=0; i<reqDto.getTermsList().size(); i++) {
			Map<String,Object> agreMap = new LinkedHashMap<String,Object>();
			agreMap.put("AGRE_TYPE_CD", reqDto.getTermsList().get(i).getAgreTypeCd());
			agreMap.put("AGRE_YN", reqDto.getTermsList().get(i).getAgreYn());
			agreMap.put("TERMS_VER_NO", reqDto.getTermsList().get(i).getTermsVerNo());
			agreMap.put("REG_DT", dTime);
			custAgreTbl.add(i, agreMap);
		}

		Object  tCustAgreTbl = custAgreTbl;


		//cust add
		Map<String,Object> custAddTbl = new HashMap<String,Object>();

		custAddTbl.put("ADD_INF_CD", null);
		custAddTbl.put("ADD_INF_VAL", null);

		Object  tCustAddTbl = custAddTbl;

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("commitYn", "Y");
		map.put("empId",reqDto.getModifyBy());
		map.put("pgmNo",reqDto.getPgmNo());
		map.put("mbrNo",reqDto.getMbrNo());

		map.put("tCustTbl",tCustTbl); 				// 회원
		map.put("tCustAgreTbl",tCustAgreTbl); 	// 동의항목
		map.put("tCustAddTbl",tCustAddTbl); 	// 추가

		loyMbrMapper.updateCorpMbrDetailPop(map);

		//output
		rtnValue.setRst((String)map.get("Rst"));
		rtnValue.setRstMsg((String)map.get("RstMsg"));
		rtnValue.setRstCd((String)map.get("RstCd"));
		rtnValue.setSuccess(true);
		if (!rtnValue.getRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage((String)map.get("RstMsg"));
		}

		return rtnValue;
	}


	 /*
	  * 1. 메소드명: getCorpMbrListPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인회원 조회 (회원번호 뽑기)
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyMbrListPopResDto> getCorpMbrListPop(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

	    return new GridPagingResHelper<LoyMbrListPopResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectCorpMbrListPop(reqDto),AnnotationType.ALL);
	}


	 /*
	  * 1. 메소드명: getCorpMbrListPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인회원 (고객) 브랜치 리스트 popup
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyCustBranchResDto> getCorpBranchListPop(LoyCustBranchReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCustBranchResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),	loyMbrMapper.selectCorpBranchListPop(reqDto));
	}


	 /*
	  * 1. 메소드명: withdrawMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 탈퇴
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyWithdrawMbrCallResDto withdrawMbr(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyWithdrawMbrCallResDto rtnValue =  new LoyWithdrawMbrCallResDto();

		//날짜 포멧
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddhhmmss", Locale.KOREA );
		Date currentTime = new Date ( );
		String dTime = formatter.format ( currentTime );

		reqDto.setCommitYn("Y");
		reqDto.setSecsnReqDt(dTime);

		loyMbrMapper.withdrawMbr(reqDto);

		rtnValue.setpRst(reqDto.getpRst());
		rtnValue.setpRstMsg(reqDto.getpRstMsg());
		rtnValue.setpRstCd(reqDto.getpRstCd());
		rtnValue.setSuccess(true);
		if (!rtnValue.getpRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(rtnValue.getpRstMsg());
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: checkCardNumber
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 법인카드번호 인증
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyMbrCCardResDto checkCardNumber(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrCCardResDto rtnValue = new LoyMbrCCardResDto();
		rtnValue.setSuccess(false);
		rtnValue = loyMbrMapper.checkCardNumber(reqDto);
		if("F".equals(rtnValue.getRst())) {
			rtnValue.setSuccess(false);
		}else {
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	public GridPagingResDto<LoyMbrCouponListResDto> getMbrCouponHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

return new GridPagingResHelper<LoyMbrCouponListResDto>().newGridPagingResDto(
			reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrCouponHistList(reqDto),AnnotationType.CommCode);


}

	 /*
	  * 1. 메소드명: checkUserId
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 웹아이디 검증
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrCCardResDto checkUserId(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrCCardResDto rtnValue = new LoyMbrCCardResDto();
		rtnValue.setSuccess(false);
		reqDto.setUserId(getStrEncrypt(reqDto.getUserId()));
		
		rtnValue = loyMbrMapper.checkUserId(reqDto);
		if("N".equals(rtnValue.getRst())) {
			rtnValue.setSuccess(false);
		}else {
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: checkRcmmdNo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 추천인코드 검증
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrCCardResDto checkRcmmdNo(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrCCardResDto rtnValue = new LoyMbrCCardResDto();
		rtnValue.setSuccess(false);
		rtnValue = loyMbrMapper.checkRcmmdNo(reqDto);
		if("N".equals(rtnValue.getRst())) {
			rtnValue.setSuccess(false);
		}else {
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}
	 /*
	  * 1. 메소드명: getCustSegmentHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: sh.park
	  * 4. 작성일자: 2020. 7. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */

	public GridPagingResDto<LoyMbrSegmentHistListResDto> getCustSegmentHistList(LoyMbrReqDto reqDto) {
		return new GridPagingResHelper<LoyMbrSegmentHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectCustSegmentHistList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getMbrTierHistListNew
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
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
	
	public GridPagingResDto<LoyMbrTiersListResDto> getMbrTierHistListNew(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrTiersListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrTierHistListNew(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getTierMgtPlcy
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
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
	
	public StatusResDto getTierMgtPlcy(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		Integer count = loyMbrMapper.selectTierMgtPlcy(reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		if(count>0) {
			String ynCheck;
			
			ynCheck = loyMbrMapper.selectTierMgtPlcyYn(reqDto);
			
			if("Y".equals(ynCheck)) {
				rtnValue.setSuccess(true);
			} else {
				rtnValue.setSuccess(false);
			}
		}
		
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: as
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
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
	
	public StatusResDto saveApproval(LoyTierApprovalReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue = onlineApprovalService.saveTierApproval(reqDto);
		return rtnValue;
	}
	


	 /*
	  * 1. 메소드명: getTierDetailPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
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
	
	public LoyMbrTiersDetailResDto getTierDetailPop(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrTiersDetailResDto resDto = new LoyMbrTiersDetailResDto();
		resDto = loyMbrMapper.selectTierDetailPop(reqDto);
		LoyMbrApprovalDetailResDto rtnValue = new LoyMbrApprovalDetailResDto();
		//rtnValue = loyMbrMapper.selectTierApprovalPop(reqDto);
		//resDto.setAprResDto(rtnValue);
		return resDto;
	}


	 /*
	  * 1. 메소드명: modifyTiers
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
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
	
	public StatusResDto modifyTiers(LoyMbrTiersDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		//resDto = new 
		if(reqDto.getRid()==null) {
			reqDto.setRid(CommonUtil.newRid());
		}
		//tierGrpRid별 등급 업데이트
		loyMbrMapper.updateTierHistYn(reqDto);
		loyMbrMapper.insertTierHist(reqDto);
		//사용안함 주석 hr.noh 2022.04.26
		//if("RID_TIER_LIFTTIME".equals(reqDto.getMbrTierCol())) {
		//	loyMbrMapper.updateMbrLiftTier(reqDto);
		//} else {
		//	loyMbrMapper.updateMbrTier(reqDto);
		//}

		//정기등급혜택 사용안함 hr.noh 2022.01.03
		//loyMbrMapper.updateMbrTierBnftProc(reqDto);
		//loyMbrMapper.updateMbrTierUpBnftProc(reqDto);
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("등급이 변경되었습니다.");

		//정기등급혜택 사용안함 hr.noh 2022.01.03
//		if (!reqDto.getpRst().equals("S")) {
//			rtnValue.setSuccess(false);
//			rtnValue.setMessage(reqDto.getpRstMsg());
//		}
		
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: purAcrlPointProc
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 구매이력 적립
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto purAcrlPointProc(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyMbrMapper.purAcrlPointProc(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: searchMbrGiftPntTgtMbr
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트양도 타켓 회원 찾기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrListPopResDto> searchMbrGiftPntTgtMbr(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyMbrListPopResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.searchMbrGiftPntTgtMbr(reqDto), AnnotationType.ALL);
	}


	 /*
	  * 1. 메소드명: setMbrPointGiftProc
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도하기 프로시져
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyWithdrawMbrCallResDto setMbrPointGiftProc(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyWithdrawMbrCallResDto rtnValue =  new LoyWithdrawMbrCallResDto();
		Date currentTime = new Date ( );
		reqDto.setTrDt(currentTime);
		reqDto.setCommitYn("Y");
		
		//포인트 사용가능 여부 확인
		rtnValue =  loyMbrMapper.chkPntUsable(reqDto);
		
		if("1".equals(rtnValue.getpRst())) {
			loyMbrMapper.setMbrPointGiftProc(reqDto);
			
			rtnValue.setpRst(reqDto.getpRst());
			rtnValue.setpRstMsg(reqDto.getpRstMsg());
			rtnValue.setpRstCd(reqDto.getpRstCd());
			rtnValue.setSuccess(true);
			if (!rtnValue.getpRst().equals("S")) {
				rtnValue.setSuccess(false);
				rtnValue.setMessage(rtnValue.getpRstMsg());
			}
		}else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("포인드 사용 불가");
		}
		
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: getGiftPointHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도 이력 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrPointHistListResDto> getGiftPointHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyMbrPointHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectGiftPointHistList(reqDto), AnnotationType.ALL);
	}


	 /*
	  * 1. 메소드명: getMbrUsePurMax
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도 1일 최대사용치
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrPointAuthResDto getMbrUsePurMax(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyMbrMapper.selectMbrUsePurMax(reqDto);
	}


	 /*
	  * 1. 메소드명: getMbrPgmChnlPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원상세 - 포인트 양도시 프로그램에 하위 채널 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyChnlListResDto> getMbrPgmChnlPop(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyChnlListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectMbrPgmChnlPop(reqDto), AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getPgmMgtPlcy
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		프로그램별 법인회원가입 운영정책있는지 여부(1 : 있다 ,0 : 없다)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public int getPgmMgtPlcy(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyMbrMapper.selectPgmMgtPlcy(reqDto);
	}


	 /*
	  * 1. 메소드명: getMbrIntList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
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
	
	public GridPagingResDto<LoyMbrIntListResDto> getMbrIntList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		String mbrIntCode = loyMbrMapper.selectMbrIntCode(reqDto);
		reqDto.setMbrIntCd(mbrIntCode);
		return new GridPagingResHelper<LoyMbrIntListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyMbrMapper.selectMbrIntList(reqDto), AnnotationType.PersonalData);
	}


	 /*
	  * 1. 메소드명: saveMbrInt
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
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
	
	public StatusResDto saveMbrInt(LoyMbrIntDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyMbrMapper.callSaveMbrInt(reqDto);
		
		if("S".equals(reqDto.getP_Rst())) {
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(reqDto.getP_RstMsg());
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: removeMbrInt
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 12.
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
	
	public StatusResDto removeMbrInt(LoyMbrIntDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		Integer cnt;
		if("Y".equals(reqDto.getRepYn())) {
			cnt = loyMbrMapper.selectMbrIntCnt(reqDto);
			if(cnt>1) {
				rtnValue.setMessage("구성회원 삭제가 먼저 필요합니다.");
				rtnValue.setSuccess(false);
			} else {
				loyMbrMapper.removeMbrInt(reqDto);
				rtnValue.setSuccess(true);
			}
		} else {
			loyMbrMapper.removeMbrInt(reqDto);
			rtnValue.setSuccess(true);
		}
		
		
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: addVocPntTxn
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lvptr
	 *   @param request
	 *   @return	
	 */
	
	public StatusResDto addVocPntTxn(LoyVocPntTxnReqDto lvptr, HttpServletRequest request) {
		LogUtil.param(this.getClass(), lvptr);

        String chnlNo = "CH0000001"; //글로라이브 BO
        String intactTypePntTxtType = "VOC";
        String intactTypePntTxtDtlType = "VOC_GEN";

        String reqDt = DateUtil.getToday("yyyy-MM-dd HH:mm:ss");
        String sndDate = DateUtil.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "yyyyMMdd");
		String sndTime = DateUtil.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "HHmmss");

		//2018.11.29 hy.jun VOC 포인트 요청 시 산출 X이므로 인터랙션 유형 및 인터랙션 이력테이블 rid 제외 - 김영환 부장님과 협의.
		//2019.02.14 hy.jun VOC 거래이력 JOIN 을 위해 다시 추가함. - 이성원 과장님과 협의.
		String ridIntactType;
		String ridIntactData;

        StatusResDto rtnDto = new StatusResDto(false, "");

        //적립 요청
//        if(lvptr.getPntTxnType_1Cd().equals(PNT_TXN_TYPE.ACRL.getValue())) {
//	        //로열티admin권한 소유자가 아닌 경우 1회 포인트 적립 제한 - 운영환경 (개발은 제한하지 않는다.)
////	        if(IFVMCommon.getServerType().equals(IFVMCommon.SERVER_TYPE.Real)) {
//
//	        	boolean isChk = true;
//
//	        	HttpSession session = request.getSession(true);
//	        	MKTAuthorityResponseDTO authList = (MKTAuthorityResponseDTO) session.getAttribute(IFVMCommon.SESSIONID_AUTH);
//	        	for(MKTAuthorityListResponseDTO auth : authList.getAuthList()) {
//	        		if(auth.getAuthNo().equals("31")) { //권한번호 31 : 로열티admin권한
//	        			isChk = false;
//	        			break;
//	        		}
//	        	}
//
//	        	if(isChk) {
//	        		//적립제한 포인트 체크
//	        		MKTCommCodeExGridRequestDTO mccegr = new MKTCommCodeExGridRequestDTO();
//	        		mccegr.setGroupCode("CS_PNT_ACRL_LIMIT");
//	        		mccegr.setCodeName("01");
//	        		mccegr.setAppServiceId(lvptr.getAppServiceId());
//	        		mccegr.setSidx("modify_date");
//	        		mccegr.setSord("desc");
//	        		mccegr.setPageSize(10);
//
//	        		List<Object> commCodeInfoList = iMKTCommCodeExDAO.selectCommCodeExGroupList(mccegr).getRows();
//	        		MKTCommCodeExGridResponseDTO commCodeInfo = (MKTCommCodeExGridResponseDTO) commCodeInfoList.get(0);;
//
//	        		if(commCodeInfoList.size() == 1) {
//	        			//적립제한 포인트 체크
//	        			if(Integer.parseInt(lvptr.getPntAmt().split("\\.")[0]) > Integer.parseInt(commCodeInfo.getAttrib01())) {
//	        				rtnDto.setMessage("1회 최대 적립 가능 포인트를 초과했습니다. 최대 적립 가능한 포인트 금액은 " + commCodeInfo.getAttrib01() + "점 입니다.");
//	        				return rtnDto;
//	        			}
//	        		} else {
//	        			rtnDto.setMessage("Too Many Common Code. [CS_PNT_ACRL_LIMIT:01]");
//	        			return rtnDto;
//	        		}
//	        	}
////	        }
//        }
        ridIntactData = CommonUtil.newRid();
        int cnt = 0;
//        try {
//        	//VOC 직접 적립 - 인터랙션 유형 : 영수증 사후적립
//        	//2019.02.14 hy.jun 사후적립 산출태우지 않으므로 인터랙션 유형 VOC 로 넣는다.
////			if(IFVMObjectUtility.isNotEmpty(lvptr.getRcptData())) {
////		        intactTypePntTxtType = "PURC";
////		        intactTypePntTxtDtlType = "PURC_AFTER";
////			}
//
//	        //loy_intact_voc 등록
//	        LOYMbrLoyIntactVocRequestDTO lmlivr = new LOYMbrLoyIntactVocRequestDTO();
//	        ridIntactData = iMKTBase.getRowID();
//	        lmlivr.setRid(ridIntactData);
////	        lmlivr.setRid(iMKTBase.getRowID());
//	        lmlivr.setOccuDate(reqDt);
//	        lmlivr.setRidMbr(lvptr.getRidMbr());
//	        lmlivr.setVocReqby(lvptr.getModifyBy());
//	        lmlivr.setVocReqAmt(lvptr.getPntAmt());
//	        lmlivr.setVocDesc(lvptr.getVocDesc());
//
//	        lmlivr.setPntTxnType(lvptr.getPntTxnType_1Cd());
//	        lmlivr.setPntTxnDtlType(lvptr.getPntTxnType_2Cd());
//
//	        lmlivr.setAccountId(lvptr.getAccountId());
//	        lmlivr.setAppServiceId(lmlivr.getAppServiceId());
//	        lmlivr.setCountry(lvptr.getCountry());
//
//	        lmlivr.setOfferId(lvptr.getOfferId());
//	        lmlivr.setChnlNo(chnlNo);
//
//	        lmlivr.setPntTxnType_1Cd(intactTypePntTxtType);
//	        lmlivr.setPntTxnType_2Cd(intactTypePntTxtDtlType);
//
//	        lmlivr.setRidMktCamMst(lvptr.getRidMktCamMst());
//
//	        if(IFVMObjectUtility.isNotEmpty(lvptr.getRcptData())) {
//	        	LOYRcptAftrPntAcrlRequestDTO rcptData = lvptr.getRcptData();
//	        	lmlivr.setRcptNo(rcptData.getInputRcptNo());
//
//	        	//영수증 통한 적립일 경우 VOC사유 자동생성한다.
//	        	lmlivr.setVocDesc("[사후적립] " + "영수증번호 : " + rcptData.getInputRcptNo() + ", 판매일자 : " + rcptData.getInputSalesDt() + ", 매장코드 : " + rcptData.getChnlNo());
//	        }
//
//	        //포인트적립 요청 시 넘길 인터랙션유형 rid 추가 조회
//	        ridIntactType = (String) this.queryForObject(String.class, "LOYMbr.getIntactTypeRid", lmlivr, false);
//
//	        cnt = (int) this.insert("LOYMbr.insertLoyIntactVoc", lmlivr, true);
//        } catch(Exception e) {
//        	LogUtility.error(e);
//        	LogUtility.error("VOC 이력 등록에 실패하였습니다.");
//        	rtnDto.setMessage("VOC 이력 등록에 실패하였습니다.");
//        	return rtnDto;
//        }

        //적립 요청
        if(lvptr.getPntTxnType().equals(PNT_TXN_TYPE.ACRL.getValue())) {
			try {
				LoyPointAcrlRequestDTO lpar = new LoyPointAcrlRequestDTO();

				//VOC 직접 적립
//				if(ObjectUtil.isEmpty(lvptr.getRcptData())) {
					lpar.setIsConTran(1);
					lpar.setLang(lvptr.getLang());
					lpar.setModifyBy(lvptr.getModifyBy());
					lpar.setPgmNo(lvptr.getPgmNo());
					lpar.setTranDtlTypeDesc(lvptr.getVocDesc());

					lpar.setIdentiType("92"); //식별유형 : 92(회원RID)
					lpar.setIdentiVal(lvptr.getRidMbr()); //식별값 : 회원RID

					lpar.setPntTxnType(lvptr.getPntTxnType()); //거래유형
					lpar.setPntTxnDtlType(lvptr.getPntTxnDtlType()); //거래상세유형

					lpar.setPntAmt(Integer.valueOf(lvptr.getPntAmt())); //적립포인트

					lpar.setOfferNo(lvptr.getOfferNo());
					lpar.setOfferType(lvptr.getOfferType());

					lpar.setTxnUniqNo(CommonUtil.newRid());

					lpar.setCalcFlag("N");

					lpar.setSndDate(sndDate);
					lpar.setSndTime(sndTime);
					lpar.setTxnDate(sndDate);
					lpar.setTxnTime(sndTime);

					lpar.setChnlNo(lvptr.getChnlNo()); //적립처 : 아성다이소 고정값

					/*lpar.setRidIntactType(ridIntactType);
					lpar.setRidIntactDate(ridIntactData);*/
//				}
				//VOC 영수증 통한 적립
//				else {
//					lpar.setIsConTran(1);
//					lpar.setAccountId(lvptr.getAccountId());
//					lpar.setAppServiceId(lvptr.getAppServiceId());
//					lpar.setLang(lvptr.getLang());
//					lpar.setCountry(lvptr.getCountry());
//					lpar.setModifyBy(lvptr.getModifyBy());
//					lpar.setPgmNo(lvptr.getLoyProgramNo());
//
//					lpar.setIdentiType("92"); //식별유형 : 92(회원RID)
//					lpar.setIdentiVal(lvptr.getRidMbr()); //식별값 : 회원RID
//
//					lpar.setTxnTypeCd(lvptr.getPntTxnType_1Cd()); //거래유형
//					lpar.setTxnTypeDtlCd(lvptr.getPntTxnType_2Cd()); //거래상세유형
//
//	//				lpar.setPntAmt(Integer.valueOf(lvptr.getPntAmt())); //적립포인트
//					lpar.setPntAmt(Integer.valueOf(lvptr.getPntAmt().split("\\.")[0])); //적립포인트
//					lpar.setTxnAmt(Integer.parseInt(lvptr.getRcptData().getPayAmt().replaceAll(",", ""))); //실결제금액
//
//					lpar.setOfferNo(lvptr.getOfferNo());
//					lpar.setOfferType(lvptr.getOfferType());
//
//					lpar.setTxnUniqNo(iMKTBase.getRowID());
//
//					lpar.setPosNo(lvptr.getRcptData().getPosNum());
//					lpar.setRcptNo(lvptr.getRcptData().getInputRcptNo());
//					lpar.setCalcFlag("N");
//
//					lpar.setSndDate(sndDate);
//					lpar.setSndTime(sndTime);
//					lpar.setTxnDate(IFVMDateUtility.getDateFormat(lvptr.getRcptData().getTxnDate(), "yyyy-MM-dd", "yyyyMMdd"));
//					lpar.setTxnTime(IFVMDateUtility.getDateFormat(lvptr.getRcptData().getTxnTime(), "HH:mm", "HHmm") + "00");
//
//					lpar.setChnlNo(lvptr.getRcptData().getChnlNo()); //적립처 : 영수증 정보의  가맹점코드
//
//					lpar.setRidIntactType(ridIntactType);
//					lpar.setRidIntactDate(ridIntactData);
//				}

				//적립요청 프로시저 호출
				rtnDto = callProcPointAcrl(lpar);

				//적립요청 성공 시
				if(rtnDto.getSuccess()) {
					rtnDto.setMessage("처리되었습니다.");

					//푸시 발송 - 적립 건은 모바일앱에서 푸시메시지 우측 위치하도록 한다.
					/*LOYChnlTransPushRequestDTO lctpr = new LOYChnlTransPushRequestDTO();
					lctpr.setCuid(lvptr.getMbrNo());
					lctpr.setSub_title("고객센터로부터 " + lvptr.getPntAmt() + "포인트 적립되었습니다.");
					StatusResponseDTO rtnPush = iLOYWebServiceService.sendPushUracle(lctpr);

					if(!rtnPush.getSuccess()) {
						LogUtility.error("LOYMbrDAO.addVocPntTxn 적립 푸시 발송 중 에러 발생 >> "+rtnPush.getMessage());
					}*/

				} else {
					LogUtil.error("LOYMbrDAO.addVocPntTxn VOC 처리 중 에러 발생 >> "+"["+lpar.getRstCd()+"] "+lpar.getRstMsg());
                    rtnDto.setMessage(lpar.getRstMsg());
					return rtnDto;
				}
			} catch (Exception e) {
				LogUtil.error(e);
				rtnDto.setMessage("에러가 발생하였습니다. 관리자에게 문의해주세요. [에러코드 : UNKNOWN_001]");
			}
        }
        //차감 요청
        else if(lvptr.getPntTxnType().equals(PNT_TXN_TYPE.RDM.getValue())) {
        	try {
        		LoyPointRdmRequestDTO lprr = new LoyPointRdmRequestDTO();
				lprr.setIsConTran(1);
				lprr.setLang(lvptr.getLang());
				lprr.setModifyBy(lvptr.getModifyBy());
				lprr.setPgmNo(lvptr.getPgmNo());
				lprr.setTranDtlTypeDesc(lvptr.getVocDesc());
				lprr.setIdentiType("92"); //식별유형 : 92(회원RID)
				lprr.setIdentiVal(lvptr.getRidMbr()); //식별값 : 회원RID

				lprr.setPntTxnType(lvptr.getPntTxnType()); //거래유형
				lprr.setPntTxnDtlType(lvptr.getPntTxnDtlType()); //거래상세유형

				lprr.setPntAmt(Integer.valueOf(lvptr.getPntAmt())); //차감포인트

//				lprr.setOfferNo(lvptr.getOfferNo());
				lprr.setOfferType("P");

				lprr.setTxnUniqNo(CommonUtil.newRid());

				lprr.setCalcFlag("N");

				lprr.setSndDate(sndDate);
				lprr.setSndTime(sndTime);
				lprr.setTxnDate(sndDate);
				lprr.setTxnTime(sndTime);

				lprr.setChnlNo(lvptr.getChnlNo()); //적립처 : 아성다이소 고정값
				//lprr.setRidIntactDate(ridIntactData);
				
	        	//사용요청 프로시저 호출
				rtnDto = callProcPointRdm(lprr);

				//사용요청 성공 시
				if(rtnDto.getSuccess()) {
					rtnDto.setMessage("처리되었습니다.");

					//푸시 발송 - 차감 건은 모바일앱에서 푸시메시지 좌측 위치하도록 한다.
//					LOYChnlTransPushRequestDTO lctpr = new LOYChnlTransPushRequestDTO();
//					lctpr.setCuid(lvptr.getMbrNo());
//					lctpr.setSub_title("고객센터로부터 " + lvptr.getPntAmt() + "포인트 차감되었습니다.");
//					StatusResponseDTO rtnPush = iLOYWebServiceService.sendPushUracle(lctpr);

//					if(!rtnPush.getSuccess()) {
//						LogUtil.error("LOYMbrDAO.addVocPntTxn 차감 푸시 발송 중 에러 발생 >> "+rtnPush.getMessage());
//					}

				} else {
					LogUtil.error("LOYMbrDAO.addVocPntTxn VOC 처리 중 에러 발생 >> "+"["+lprr.getRstCd()+"] "+lprr.getRstMsg());
                    rtnDto.setMessage(lprr.getRstMsg());
					return rtnDto;
				}
			} catch (Exception e) {
				LogUtil.error(e);
				rtnDto.setMessage("에러가 발생하였습니다. 관리자에게 문의해주세요. [에러코드 : UNKNOWN_001]");
			}
        }

        return rtnDto;
	}
	
	public StatusResDto callProcPointRdm(LoyPointRdmRequestDTO param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		
		loyMbrMapper.callProcPointRdm(param);
		
		//적립요청 성공시
		if(param.getRst().equals("S")) {
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("["+param.getRstCd()+"] "+param.getRstMsg());
		}
		
		return rtnValue;
	}
	
	public StatusResDto callProcPointAcrl(LoyPointAcrlRequestDTO param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		
		loyMbrMapper.callProcPointAcrl(param);
		
		//적립요청 성공시
		if(param.getRst().equals("S")) {
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("["+param.getRstCd()+"] "+param.getRstMsg());
		}
		
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: clearMaskMbrInt
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 13.
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
	
	public LoyMbrIntListResDto clearMaskMbrInt(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
		LoyMbrIntListResDto res =      loyMbrMapper.clearMaskMbrInt(reqDto);
	    return new AnnotationHelper<LoyMbrIntListResDto>(AnnotationType.PersonalData, res).getItem();
	}
	
	 /*
	  * 1. 메소드명: blackRuleFmly
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 이상거래정책 심사
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyFamilyCallbackResDto blackRuleFmly(LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyFamilyCallbackResDto rtnValue = new LoyFamilyCallbackResDto();
		loyMbrMapper.blackRuleFmly(reqDto);

		rtnValue.setRst(reqDto.getRst());
		rtnValue.setRstMsg(reqDto.getRstMsg());
		rtnValue.setRstCd(reqDto.getRstCd());
		rtnValue.setSuccess(true);
		if (!rtnValue.getRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(rtnValue.getRstMsg());
		}
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: executivesViewSelect
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		임직원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyExecutivesViewResDto executivesViewSelect(LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyExecutivesViewResDto res =      loyMbrMapper.executivesViewSelect(reqDto);
		
	    return new AnnotationHelper<LoyExecutivesViewResDto>(AnnotationType.ALL, res).getItem();
	}
	 /*
	  * 1. 메소드명: executivesExistSelect
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사번에 대한 임직원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyExecutivesViewResDto executivesExistSelect(LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
	    return loyMbrMapper.executivesExistSelect(reqDto);
	}

	 /*
	  * 1. 메소드명: empNoUpdateExecutives
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		임직원 사원 번호 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto empNoUpdateExecutives(LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(true);
		LoyExecutivesViewReqDto wrDeDataSplitTarget = loyMbrMapper.empNoFindFunctionExecutives(reqDto);
		LoyExecutivesViewResDto existMbr = loyMbrMapper.executivesMemberCheck(reqDto);
		
	  if(wrDeDataSplitTarget.getWrDeData() != null) {
			if(existMbr != null) {
				rtnValue.setMessage("exist");
			} else {
				String SplitTarget = wrDeDataSplitTarget.getWrDeData().toString();
				String [] splitData = SplitTarget.split("-");
				
				if(!splitData[0].toString().isEmpty()) {
					reqDto.setDeptNm(splitData[0]);
				}
				if(!splitData[1].toString().isEmpty()) {
					reqDto.setWrcNm(splitData[1]);
				}
				loyMbrMapper.empNoUpdateExecutives(reqDto);	
				loyMbrMapper.insertChgHist(reqDto);
				rtnValue.setMessage("notExist");
			}
		} 

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: StatCdUpdateExecutives
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		임직원 변경
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto StatCdUpdateExecutives(LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		if("활성".equals(reqDto.getOldMbrStatCd())) {
			reqDto.setOldMbrStatCd("A");
		} else if("중지".equals(reqDto.getOldMbrStatCd())){
			reqDto.setOldMbrStatCd("S");
		}
		loyMbrMapper.mbrStatCdUpdateExecutives(reqDto);	
		loyMbrMapper.insertMbrChgHistMbrStatCd(reqDto);
		loyMbrMapper.custStatCdUpdateExecutives(reqDto);
		loyMbrMapper.insertMbrChgHistCustStatCd(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}
	 /*
	  * 1. 메소드명: buyDetailSelect(오프라인 구매 이력)
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		구입 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrTxnHistListResDto> buyDetailSelect(LoyMbrReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
	
			return new GridPagingResHelper<LoyMbrTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
					loyMbrMapper.buyDetailSelectOffLine(reqDto),AnnotationType.CommCode);
		
	}
	 /*
	  * 1. 메소드명: buyDetailSelectOnline(온라인 구매 이력)
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2021. 04. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		구입 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */

	public GridPagingResDto<LoyMbrTxnHistListResDto> buyDetailSelectOnline(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyMbrTxnHistListResDto>().newGridPagingResDto(
			reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.buyDetailSelectOnline(reqDto),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getProdCustList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 상품평 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrProdCustListResDto> getProdCustList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrProdCustListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getProdCustList(reqDto),AnnotationType.CommCode);
	}
	 /*
	  * 1. 메소드명: prodCustListDetail
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객상품평 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrProdCustDetailResDto prodCustListDetail(LoyMbrProdCustListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyMbrMapper.prodCustListDetail(reqDto);
	}
	 /*
	  * 1. 메소드명: getDorMantList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		휴면 회원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrListNewPageResDto> getDorMantList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrListNewPageResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getDorMantList(reqDto),AnnotationType.ALL);
	}
	 /*
	  * 1. 메소드명: getBeforeDorMantList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		휴면 예정 회원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrListNewPageResDto> getBeforeDorMantList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		for(int i= 0; i<reqDto.getItem().size();i++) {
			if("EXP_SEND_DATE".equals(reqDto.getItem().get(i).getSrcCol())) {
				reqDto.getItem().get(i).setSrcCol("expSendDate");
			}else if("SEND_END_DATE".equals(reqDto.getItem().get(i).getSrcCol())) {
				reqDto.getItem().get(i).setSrcCol("sendEndDate");
			}
		}

		GridPagingResDto<LoyMbrListNewPageResDto> tot = new GridPagingResHelper<LoyMbrListNewPageResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getBeforeDorMantListTotalCnt(reqDto),AnnotationType.ALL);

		int totalCnt = tot.getRows().get(0).getTotalCount();

		return new GridPagingResHelper<LoyMbrListNewPageResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getBeforeDorMantList(reqDto),AnnotationType.ALL, totalCnt);
	}
	 /*
	  * 1. 메소드명: getexecutivesList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 임직원 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrListNewPageResDto> getexecutivesList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrListNewPageResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getexecutivesList(reqDto),AnnotationType.ALL);
	}
	
	 /*
	  * 1. 메소드명: getExecutivesPopComm
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 8. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 임직원 상태코드 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public List<LoyMbrCommResDto> getExecutivesPopComm() {

		return loyMbrMapper.getExecutivesPopComm();
	}

	 /*
	  * 1. 메소드명: getPrStoreNmPopList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 주 거래 매장 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyChnlListResDto> getPrStoreNmPopList(LoyCommonReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyChnlListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getPrStoreNmPopList(reqDto),AnnotationType.ALL);
	}
	 /*
	  * 1. 메소드명: getCampaignExecList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2020. 12. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		캠페인 이력
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCampaignExecListResDto> getCampaignExecList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCampaignExecListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getCampaignExecList(reqDto),AnnotationType.CommCode);
	}
	 /*
	  * 1. 메소드명: getNegativeAccList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2021. 01. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		부정회원 적립
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyNegativeAccResDto> getNegativeAccList(LoyNegativeAccReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyNegativeAccResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getNegativeAccList(reqDto),AnnotationType.ALL);
	}
	
    /**
     * @programId
     * @name clearMaskNegativeAccList
     * @date 2021. 01. 04.
     * @author lee gyeong young
     * @param request
     * @param response
     * @param reqDto
     * @return
     * @description 마스킹 해제 
     */
	public LoyNegativeAccResDto clearMaskNegativeAccList(LoyNegativeAccReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
	    LoyNegativeAccResDto res =      loyMbrMapper.clearMaskNegativeAccList(reqDto);
	    return new AnnotationHelper<LoyNegativeAccResDto>(AnnotationType.PersonalData, res).getItem();
	}
	
	 /*
	  * 1. 메소드명: negativeAccListExcelList
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2021. 01. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		부정회원 적립 엑셀
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyNegativeAccResDto> negativeAccListExcelList(LoyNegativeAccReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyNegativeAccResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.negativeAccListExcelList(reqDto),AnnotationType.ALL);
	}
	
	
	/*
	  * 1. 메소드명: getMbrMgtInfoList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: '회원관리정보'에서  한 회원에 대해 각 회원관리속성 별 정보를 나타낸 리스트를 불러오는 기능
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public GridPagingResDto<LoyMbrMgtInfoResDto> getMbrMgtInfoList(LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrMgtInfoResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getMbrMgtInfoList(reqDto), AnnotationType.ALL);
	}//end getMbrMgtInfoList
	
	
	/*
	  * 1. 메소드명: addMbrMgtInfo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 회원정보관리 신규 추가 기능
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return rtnValue
	 */
	public StatusResDto addMbrMgtInfo(LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		String rid = CommonUtil.newRid();
		reqDto.setRid(rid);
		
		rtnValue.setSuccess(false);
		loyMbrMapper.addMbrMgtInfo(reqDto);
		// 히스토리 저장 처리
		reqDto.setRidMbrMgtAttr(reqDto.getRid());
		String ridMbrMgtAttr = CommonUtil.newRid();
		reqDto.setRid(ridMbrMgtAttr);
		
		loyMbrMapper.addMbrMgtInfoHist(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}//end addMbrMgtInfo
	
	/*
	  * 1. 메소드명: getMbrMgtInfoBeforeUpdate
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 회원정보관리 수정 팝업 시 수정할 필드 내용들을 조회해 로드하는 기능
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto
	 */
	public LoyMbrMgtInfoResDto getMbrMgtInfoBeforeUpdate(LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyMbrMgtInfoResDto resDto = new LoyMbrMgtInfoResDto();
		resDto = loyMbrMapper.getMbrMgtInfoBeforeUpdate(reqDto);
		
		return resDto;
	}//end getMbrMgtInfoBeforeUpdate
	
	/*
	  * 1. 메소드명: updateMbrMgtInfo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 회원관리정보 수정 (+ 이력에도 저장)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return rtnValue
	 */
	public StatusResDto updateMbrMgtInfo(LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		// 상태 객체 생성
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyMbrMapper.updateMbrMgtInfo(reqDto);
		// 히스토리 저장 처리
		reqDto.setRidMbrMgtAttr(reqDto.getRid());
		String ridMbrMgtAttr = CommonUtil.newRid();
		reqDto.setRid(ridMbrMgtAttr);
		
		loyMbrMapper.addMbrMgtInfoHist(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/*
	  * 1. 메소드명: deleteMbrMgtInfo
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 회원관리정보 삭제(논리삭제)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return rtnValue
	 */
	public StatusResDto deleteMbrMgtInfo(LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyMbrMapper.deleteMbrMgtInfo(reqDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}//end deleteMbrMgtInfo
	
	
	/*
	  * 1. 메소드명: getMbrMgtInfoHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: '회원관리정보'의 이력내역(신규/수정에 관한)리스트를 조회해오는 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public GridPagingResDto<LoyMbrMgtInfoResDto> getMbrMgtInfoHistList(LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrMgtInfoResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getMbrMgtInfoHistList(reqDto), AnnotationType.ALL);
	}//end getMbrMgtInfoHistList
	
	
	/*
	  * 1. 메소드명: checkAttrCdAttrSubCd
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: '회원관리정보'에서 신규/수정 작업 시 유효성 검사 작업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public StatusResDto checkAttrCdAttrSubCd(LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		int theRecordCount = loyMbrMapper.countTheRecordMatched(reqDto);
		// 지금 들어가려는 처리건이 갖고 있는'회원관리속성(ATTR_CD),속성값(ATTR_SUB_CD)'과 동일하게 값을 갖고 있는 레코드가 기존에 존재하는지 체크한다.
		if(theRecordCount == 0) { // 중복되는 것이 없다 => 저장가능
			rtnValue.setSuccess(true);
		} else if(theRecordCount >= 1) { // 중복되는 것이 있음 => 저장불가
			rtnValue.setSuccess(false);
			//rtnValue.setMessage("[유효성 위배] 해당 '회원관리 속성-속성값'과 동일한 레코드가 이미 존재하고 있습니다.");
		}
		
		return rtnValue;
	}//end checkAttrCdAttrSubCd
	
	
	/*
	  * 1. 메소드명: countTheRecordMatched
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: '회원관리정보'에서 신규/수정 작업 시, 저장해넣으려는 건의 '회원관리속성(ATTR_CD)'과 '속성값(ATTR_SUB_CD)'이
	 *     똑같은 레코드가 기존 테이블 안에 존재하는가를 확인하는 작업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public int countTheRecordMatched(LoyMbrMgtInfoReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return loyMbrMapper.countTheRecordMatched(reqDto);
	}

	public GridPagingResDto<LoyMbrCouponListResDto> getOnlineMallCouponHistList(LoyMbrReqDto reqDto) {
			
		return new GridPagingResHelper<LoyMbrCouponListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectOnlineMallCouponHistList(reqDto),AnnotationType.CommCode);


	}
	
	/*
	  * 1. 메소드명: getTierBenefitHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 회원의 (RID_MBR) 등급혜택이력을 조회하는 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public GridPagingResDto<LoyMbrTierBenefitHistResDto> getTierBenefitHistList(LoyMbrTierBenefitHistReqDto reqDto) {

		return new GridPagingResHelper<LoyMbrTierBenefitHistResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getTierBenefitHistList(reqDto),AnnotationType.CommCode);
	}
	
	public LoyMbrListNewPageResDto getMbrCustTypeCd(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyMbrMapper.selectMbrCustTypeCd(reqDto);
	}

	/*
	  * 1. 메소드명: getMbrPntHistSumList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2021.02.22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 구매이력 판매금액,할인금액,최종 결제 금액 합계
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public GridPagingResDto<LoyMbrTxnHistListResDto> getMbrTxnHistSumList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrTxnHistSumList(reqDto),AnnotationType.CommCode);
	}

	/*
	  * 1. 메소드명: getMbrPntHistSumList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명:2sh.park
	  * 4. 작성일자: 2021.02.22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 포인트 결제금액, 포인트 합계
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public GridPagingResDto<LoyMbrTxnHistListResDto> getMbrPntHistSumList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrPntHistSumList(reqDto),AnnotationType.CommCode);
	}
	
	 /*
	  * 1. 메소드명: getNewMallCouponList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2021. 03. 05.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return
	 */

	public GridPagingResDto<LoyMbrCouponListResDto> getNewMallCouponList(LoyMbrReqDto reqDto) {
		return new GridPagingResHelper<LoyMbrCouponListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectNewMallCouponList(reqDto),AnnotationType.CommCode);

	}

	/*
	  * 1. 메소드명: getCpnIssueOfferList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명:2sh.park
	  * 4. 작성일자: 2021.03.10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 포인트 재발급
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public GridPagingResDto<LoyClubOfferListResDto> getCpnIssueOfferList(LoyClubOfferDetailReqDto reqDto) {
		return new GridPagingResHelper<LoyClubOfferListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectCpnIssueOfferList(reqDto),AnnotationType.CommCode);
	}


	public GridPagingResDto<LoyMbrCouponListResDto> getMbrCouponTxnHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrCouponListResDto>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()),
						loyMbrMapper.selectMbrCouponTxnHistList(reqDto),AnnotationType.CommCode);

	}
	
	/*
	  * 1. 메소드명: updatePntYn
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명:2sh.park
	  * 4. 작성일자: 2021.03.23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	: 포인트 적립 여부 변경 및 이력
	 *
	 **		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */

	public StatusResDto updatePntYn(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		StatusResDto rtnValue = new StatusResDto(false, "");

		loyMbrMapper.updatePntYn(reqDto);
		rtnValue.setSuccess(true);

		//변경 이력 
		if (rtnValue.getSuccess()) {
			try {
				reqDto.setBchngData(reqDto.getBeforePntAcrlYnVal());
				reqDto.setAchngData(reqDto.getAfterPntAcrlYnVal());
				reqDto.setChgTbl("LOY_MBR");
				reqDto.setChgCol("PNT_ACRL_YN");
				reqDto.setrMark(reqDto.getPntResn()); 
				loyMbrMapper.addMbrPntChngHistList(reqDto);
				rtnVal.setSuccess(true);
				rtnVal.setMessage(reqDto.getAfterPntAcrlYnVal());
				
			}catch (Exception e) {
				LogUtil.error(e);
			}
		}
	
		return rtnVal;
	}

	/*
	  * 1. 메소드명: updatePntYn
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명:2sh.park
	  * 4. 작성일자: 2021.03.23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 포인트 사용 여부 변경 및 이력
	 *	
	 **		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */

	public StatusResDto updateRdmPntYn(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		StatusResDto rtnValue = new StatusResDto(false, "");
		       
		loyMbrMapper.updateRdmPntYn(reqDto);
		rtnValue.setSuccess(true);
		
        
		//변경 이력 
		if (rtnValue.getSuccess()) {
			try {
			reqDto.setBchngData(reqDto.getBeforePntRdmYnVal());
			reqDto.setAchngData(reqDto.getAfterPntRdmYnVal());
			reqDto.setrMark(reqDto.getPntResn());
			reqDto.setChgTbl("LOY_MBR");
			reqDto.setChgCol("PNT_RDM_YN");
			loyMbrMapper.addMbrPntChngHistList(reqDto); 

			rtnVal.setSuccess(true);
			rtnVal.setMessage(reqDto.getAfterPntRdmYnVal());
			} catch (Exception e) {
				LogUtil.error(e);
			}
		}
		
		return rtnVal;
	}


	/*
	  * 1. 메소드명: editMbrPntUsePwLL
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명:2sh.park
	  * 4. 작성일자: 2021.03.30
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 포인트 임시비밀번호 발급 및 이력
	 *	
	 **		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */

	public StatusResDto editMbrPntUsePwLL(LoyMbrEditPntUsePwReqDto param) {
	
           
		StatusResDto rtnValue = new StatusResDto(false, "");
		String beforePntUsePw = loyMbrMapper.selectMbrPntUsePw(param);
		String RandomPntPwd = StringUtil.getRandomNum(4);
     
		param.setPlcyCd("A27");
		//content RID
		 LoyMbrItemResDto resDto =loyMbrMapper.selectChgVal(param); 
		 param.setParRid(resDto.getDataVAl());
		 
		 LoyMbrItemResDto contsResDto=loyMbrMapper.selectContsRid(param);
		 
		 //chnl DB INSERT
		 param.setRidConts(contsResDto.getContRid());
		 param.setAltTypeCd("PPC");
		 param.setRid(CommonUtil.newRid());
		 loyMbrMapper.addPwdSendChnl(param);
		 
		 param.setRidAlt(param.getRid()); 
		 param.setTagNm("회원명");
		 param.setTagVal(SecurityUtil.encodeDbAES256(param.getCustNm()));
		 param.setEncYn("Y");
		 
		 //chnl tag INSERT
		 loyMbrMapper.addPwdSendChnlTag(param);
		 
		 param.setRidAlt(param.getRid()); 
		 param.setTagNm("포인트사용비밀번호");
		 param.setTagVal(RandomPntPwd);
		 param.setEncYn("N");
		 
		 //chnl tag INSERT
		 loyMbrMapper.addPwdSendChnlTag(param);
		
		//비밀번호 업데이트 
		param.setPntUsePw(SecurityUtil.encodePassword(RandomPntPwd));
		loyMbrMapper.updateMbrPntUsePwLL(param);     	 
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("성공적으로 발급되었습니다.");
	
		// 비밀번호 변경 성공 시 변경이력 등록
		if (rtnValue.getSuccess()) {
			try {
				LoyMbrReqDto chgHist = new LoyMbrReqDto();
				chgHist.setRid(param.getRidMbr());
				chgHist.setModifyBy(param.getModifyBy());
				chgHist.setCreateBy(param.getCreateBy());
				chgHist.setChgTbl("LOY_MBR");
				chgHist.setChgCol("PNT_PWD");
				chgHist.setMbrNo(param.getMbrNo());
				chgHist.setBchngData(beforePntUsePw);
				chgHist.setAchngData(param.getPntUsePw());
				chgHist.setChgPstn("CRM");
				chgHist.setrMark(param.getPntResn());
				loyMbrMapper.addMbrPntChngHistList(chgHist);

			} catch (Exception e) {
				LogUtil.error(e);
			}
		}

		return rtnValue;
	}


	/*
	  * 1. 메소드명: editMbrLoiginPwLL
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명:2sh.park
	  * 4. 작성일자: 2021.03.29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 사용자 임시 비밀번호 발급  및 이력
	 *	
	 **		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */

	public StatusResDto editMbrLoiginPwLL(LoyMbrEditPntUsePwReqDto param) {
		
		String RandomPwd = StringUtil.getRandomChar(10);		
		
		StatusResDto rtnValue = new StatusResDto(false, "");
        
		 param.setPlcyCd("A26");
		 //content RID
		 LoyMbrItemResDto resDto =loyMbrMapper.selectChgVal(param); 
		 param.setParRid(resDto.getDataVAl());
		 
		 LoyMbrItemResDto contsResDto=loyMbrMapper.selectContsRid(param);
		 
		 //chnl DB INSERT
		 param.setRidConts(contsResDto.getContRid());
		 param.setAltTypeCd("UPC");
		 param.setRid(CommonUtil.newRid());
		 loyMbrMapper.addPwdSendChnl(param);
		 
		 param.setRidAlt(param.getRid()); 
		 param.setTagNm("회원명");
		 param.setTagVal(SecurityUtil.encodeDbAES256(param.getCustNm()));
		 param.setEncYn("Y");
		 
		 //chnl tag INSERT
		 loyMbrMapper.addPwdSendChnlTag(param);
		 
		 param.setRidAlt(param.getRid()); 
		 param.setTagNm("사용자비밀번호");
		 param.setTagVal(RandomPwd);
		 param.setEncYn("N");
		 
		 //chnl tag INSERT
		 loyMbrMapper.addPwdSendChnlTag(param);
		 
		 //비밀번호 변경
		 param.setUserPwd(SecurityUtil.encodePassword(RandomPwd));
	     LoyMbrItemResDto resDto2 =loyMbrMapper.selectChgNextDate(param); //패스워드 다음변경일
	     param.setPlusDateVal(Integer.parseInt(resDto2.getDataVAl()));
	        
	     LoyMbrItemResDto resDtoPwd =loyMbrMapper.selectBfPwd(param); //이전 패스워드(=업뎃하기전 현재 패스워드)
	     param.setBfPwd(resDtoPwd.getBfPwd());
	     loyMbrMapper.updateMbrLoiginPwLL(param);
	     
		rtnValue.setSuccess(true);
		rtnValue.setMessage("성공적으로 발급되었습니다.");
	
		
		// 비밀번호 변경 성공 시 변경이력 등록
		if (rtnValue.getSuccess()) {
			try {
				LoyMbrReqDto chgHist = new LoyMbrReqDto();
				chgHist.setRid(param.getRidMbr());
				chgHist.setModifyBy(param.getModifyBy());
				chgHist.setCreateBy(param.getCreateBy());
				chgHist.setChgTbl("LOY_CUST_LOGIN_INF");
				chgHist.setChgCol("USER_PWD");
				chgHist.setMbrNo(param.getMbrNo());
				chgHist.setBchngData(resDtoPwd.getBfPwd());
				chgHist.setAchngData(param.getUserPwd());
				chgHist.setChgPstn("CRM");
				chgHist.setrMark(param.getPntResn());
				loyMbrMapper.addMbrPntChngHistList(chgHist);

			} catch (Exception e) {
				LogUtil.error(e);
			}
		}

		return rtnValue;
	}

	/*
	  * 1. 메소드명: getOfrPntList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명:2sh.park
	  * 4. 작성일자: 2021.04.06.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 가용포인트 상세
	 *	
	 **		
	 * </PRE>
	 *   @param  reqDto
	 *   @return resDto	
	 */
	public GridPagingResDto<LoyClubOfferListResDto> getOfrPntList(LoyClubOfferDetailReqDto reqDto) {
		return new GridPagingResHelper<LoyClubOfferListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectOfrPntList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: mbrSecsnMbrToAble
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto mbrSecsnMbrToAble(LoyMbrReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnVal = new StatusResDto();
		
		if("C".equals(param.getCustTypeCd())) {
			loyMbrMapper.updateMbrSecsnMbrToAble(param);
			loyMbrMapper.updateMbrSecsnMbrCToAble(param);
		} else {
			loyMbrMapper.updateMbrSecsnMbrToAble(param);
			loyMbrMapper.updateMbrSecsnMbrIToAble(param);
		}
		loyMbrMapper.updateMbrSecsnMbr(param);
		rtnVal.setSuccess(true);
		return rtnVal;
	}
	
	 /*
	  * 1. 메소드명: setCustDorChange
	  * 2. 클래스명: LoyMbrController
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2021. 04. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		휴면 회원으로 전환 프로시저
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto setCustDorChange(LoyExecutivesViewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		
		loyMbrMapper.setCustDorChange(reqDto);
		
	    rtnVal.setSuccess(true);
		
	    return rtnVal;
	}
	
    /**
    * @programId :
    * @name : 
    * @date : 2021.04.22.
    * @author : LEE GYEONG YOUNG
    * @table :
    * @return : StatusResDto
    * @description : 익월 소멸예정 상세
    */
	public GridPagingResDto<LoyClubOfferListResDto> getExtncList(LoyClubOfferDetailReqDto reqDto) {
		return new GridPagingResHelper<LoyClubOfferListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.getExtncList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getMbrIntListSearch
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyMbrResDto> getMbrIntListSearch(LoyMbrReqDto param) {
		LogUtil.param(this.getClass(), param);

		return new GridPagingResHelper<LoyMbrResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
						loyMbrMapper.selectMbrIntListSearch(param),AnnotationType.ALL);
	}


	 /*
	  * 1. 메소드명: saveMbrInt
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto saveMbrInt(LoyMbrReqDto req) {
		LogUtil.param(this.getClass(), req);
		StatusResDto rtnVal = new StatusResDto();
		loyMbrMapper.updateMbrInt(req);
		loyMbrMapper.updateMbrTierBnft(req);
		rtnVal.setSuccess(true);
		return rtnVal;
	}


	 /*
	  * 1. 메소드명: getMbrTxnHistDeliSumList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 10.
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
	
	public GridPagingResDto<LoyMbrTxnHistListResDto> getMbrTxnHistDeliSumList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrTxnHistDeliSumList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getMbrDorHistList
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 17.
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
	
	public GridPagingResDto<LoyMbrDorHistResDto> getMbrDorHistList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrDorHistResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrDorHistList(reqDto),AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: saveMbrDorDetailPop
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 6. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 휴면회원 이름,전화번호 변경및 변경이력 저장 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto saveMbrDorDetailPop(LoyNewCustAddReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setCust_nm(getStrEncrypt(reqDto.getCust_nm()));
		reqDto.setHhp(getStrEncrypt(reqDto.getHhp().replaceAll("-", "")));
		
		LoyMbrResDto resDto = loyMbrMapper.selectDorMbrDetail(reqDto);
		reqDto.setRidCust(resDto.getRidCust());
		
		if (ObjectUtil.isNotEmpty(reqDto.getCust_nm()) && !(reqDto.getCust_nm().equals(resDto.getEncCustNm()))) {
			resDto.setChgBData(resDto.getEncCustNm());
			resDto.setChgAData(reqDto.getCust_nm());
			resDto.setChgTbl("LOY_CUST");
			resDto.setChgCol("CUST_NM");
			resDto.setModifyBy(reqDto.getModifyBy());
			resDto.setCreateBy(reqDto.getCreateBy());
			loyMbrMapper.insertDorCustChgHist(resDto);
		}
		if (ObjectUtil.isNotEmpty(reqDto.getHhp()) && !(reqDto.getHhp().equals(resDto.getEncHhp()))) {
			resDto.setChgBData(resDto.getEncHhp());
			resDto.setChgAData(reqDto.getHhp());
			resDto.setChgTbl("LOY_CUST");
			resDto.setChgCol("HHP");
			resDto.setModifyBy(reqDto.getModifyBy());
			resDto.setCreateBy(reqDto.getCreateBy());
			loyMbrMapper.insertDorCustChgHist(resDto);
		}
		
		loyMbrMapper.updateDorCust(reqDto);
		
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: modifyPntValidDate
	  * 2. 클래스명: LoyMbrService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 8. 2.
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
	
	public StatusResDto modifyPntValidDate(LoyMbrPointAcrlReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		loyMbrMapper.updatePntValidDate(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}

	/*
	 * 1. 메소드명: getMbrSurveyList
	 * 2. 클래스명: LoyMbrService
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 1. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	회원상세 - 설문 탭 리스트
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyMbrSurveyListResDto> getMbrSurveyList(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrSurveyListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrSurveyList(reqDto),AnnotationType.ALL);
	}

	/*
	 * 1. 메소드명: getMbrSurveyDetailPop
	 * 2. 클래스명: LoyMbrController
	 * 3. 작성자명: hr.noh
	 * 4. 작성일자: 2022. 1. 11.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 	회원상세 - 설문 탭 - 설문결과 상세 팝업
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyMbrSurveyListResDto> getMbrSurveyDetailPop(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrSurveyListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.selectMbrSurveyDetailPop(reqDto),AnnotationType.ALL);
	}

	/*
	 * 1. 메소드명: purDetailSelect(오프라인 구매 이력)
	 * 2. 클래스명: LoyMbrService
	 * 3. 작성자명: suji Jung
	 * 4. 작성일자: 2022. 1. 14.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		구입 상세
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyMbrTxnHistListResDto> purDetailSelect(LoyMbrReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyMbrTxnHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyMbrMapper.purDetailSelect(reqDto),AnnotationType.CommCode);

	}
}

