package com.icignal.loyalty.tiers.tiermaster.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.TASK_DATA_STATUS;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyDelTierChnlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyDelTierupMatrixReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierBnftReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierChnlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierDtlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierGroupListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierupMatrixDtlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyEditTierupMatrixReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetMbrMstPopReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierBnftListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierChnlListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierGroupListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierGrpDtlListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyGetTierupMatrixListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoySetTierBnftReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoySetTierChnlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoySetTierDtlReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoySetTierGroupListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierBnftReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierCondDetailReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierCondListReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierCondReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierGroupDetailReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierGrpDsMasterReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierGrpJobDetailReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierGrpJobMasterReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierNewPageReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierRuleMasterReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyDataSetItemListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyDataSetListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetMbrMstPopResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierBnftListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierChnlListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierGroupListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierGrpDtlListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierupMatrixDtlResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyGetTierupMatrixListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierBnftDetailResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierBnftListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierCondListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierGroupDetailResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierGrpDsListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierGrpJobDetailResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierGrpJobListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListNewPageResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListNewResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierRuleResDto;
import com.icignal.loyalty.tiers.tiermaster.mapper.LoyTiersMapper;

/*
 * 1. 클래스명	: LoyTiersService
 * 2. 파일명	: LoyTiersService.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.service
 * 4. 작성자명	: 이원준
 * 5. 작성일자	: 2016. 11. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *   기준정보 - 등급 Service
 * </PRE>
 */
@Service("LoyTiersService")
public class LoyTiersService {

	@Autowired
	private LoyTiersMapper loyTiersMapper;

	/*
	 * 1. 메소드명: getTierGroupList 
	 * 2. 클래스명: LoyTiersService 
	 * 3. 작성자명: 이원준 
	 * 4. 작성일자: 2016. 11. 8.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 목록 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDto
	 * @programId : PLOY_101
	 * @table : loy_tier_group, loy_tiers
	 * @return
	 */
	public GridPagingResDto<LoyGetTierGroupListResDto> getTierGroupList(LoyGetTierGroupListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("ltg");

		return new GridPagingResHelper<LoyGetTierGroupListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getTierGroupList(reqDto), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getTierGrpDtl 
	 * 2. 클래스명: LoyTiersService 
	 * 3. 작성자명: 이원준 
	 * 4. 작성일자: 2016. 11. 9.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급그룹 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDto
	 * @programId : PLOY_102
	 * @table : loy_tier_group, loy_tiers
	 * @return
	 */
	public LoyGetTierGroupListResDto getTierGrpDtl(LoyGetTierGroupListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("ltg");
		return loyTiersMapper.getTierGrpDtl(reqDto);
	}

	/*
	 * 1. 메소드명: setTierGrp 
	 * 2. 클래스명: LoyTiersService 
	 * 3. 작성자명: 이원준 
	 * 4. 작성일자: 2016. 11. 11.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급그룹 저장
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDto
	 * @programId : PLOY_102
	 * @table : loy_tier_group
	 * @return
	 */
	public StatusResDto setTierGrp(LoySetTierGroupListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
        String rid = CommonUtil.newRid();
        reqDto.setRid(rid);
		
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.setTierGrp(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editTierGrp
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 11. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급그룹 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_102
	 *   @table : loy_tier_group
	 *   @return	
	 */
	public StatusResDto editTierGrp(LoyEditTierGroupListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.editTierGrp(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierListPop
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급목록 팝업 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : POP_905
	 *   @table : loy_tiers
	 *   @return	
	 */
	public GridPagingResDto<LoyGetTierGrpDtlListResDto> getTierListPop(LoyGetTierGrpDtlListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		 reqDto.setSVCAlias("lt");

		return new GridPagingResHelper<LoyGetTierGrpDtlListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getTierListPop(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierDtlList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급상세 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_103
	 *   @table : loy_tiers
	 *   @return	
	 */
	public GridPagingResDto<LoyGetTierGrpDtlListResDto> getTierDtlList(LoyGetTierGrpDtlListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		 reqDto.setSVCAlias("lt");

		return new GridPagingResHelper<LoyGetTierGrpDtlListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getTierDtlList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierDtl
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-등급 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_103
	 *   @table : loy_tiers
	 *   @return	
	 */
	public LoyGetTierGrpDtlListResDto getTierDtl(LoyGetTierGrpDtlListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		 reqDto.setSVCAlias("lt");

		return new AnnotationHelper<LoyGetTierGrpDtlListResDto>(AnnotationType.CommCode, loyTiersMapper.getTierDtl(reqDto)).getItem();
	}

	 /*
	  * 1. 메소드명: chkValid
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 11. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-등급 중복 순서_기간 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_103
	 *   @table : loy_tiers
	 *   @return	
	 */
	public LoyGetTierGrpDtlListResDto chkValid(LoySetTierDtlReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		 reqDto.setSVCAlias("lt");

		return loyTiersMapper.chkValid(reqDto);
	}

	 /*
	  * 1. 메소드명: setTierDtl
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-등급 목록 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_103
	 *   @table : loy_tiers
	 *   @return	
	 */
	public StatusResDto setTierDtl(LoySetTierDtlReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
        String rid = CommonUtil.newRid();
        reqDto.setRid(rid);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.setTierDtl(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editTierDtl
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-등급 목록 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_103
	 *   @table : loy_tiers
	 *   @return	
	 */
	public StatusResDto editTierDtl(LoyEditTierDtlReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.editTierDtl(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierChnlList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-채널 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_104
	 *   @table : loy_tier_grp_chnl, loy_channel
	 *   @return	
	 */
	public GridPagingResDto<LoyGetTierChnlListResDto> getTierChnlList(LoyGetTierChnlListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("ltgc");
		
		return new GridPagingResHelper<LoyGetTierChnlListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getTierChnlList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: setTierChnl
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-채널 목록 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_104
	 *   @table : loy_tier_grp_chnl, loy_channel
	 *   @return	
	 */
	public StatusResDto setTierChnl(LoySetTierChnlReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
        String rid = CommonUtil.newRid();
        reqDto.setRid(rid);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.setTierChnl(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editTierChnl
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-채널 목록 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_104
	 *   @table : loy_tier_grp_chnl, loy_channel
	 *   @return	
	 */
	public StatusResDto editTierChnl(LoyEditTierChnlReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.editTierChnl(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTierChnl
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 11. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-채널 목록 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_104
	 *   @table : loy_tier_grp_chnl, loy_channel
	 *   @return	
	 */
	public StatusResDto removeTierChnl(LoyDelTierChnlReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
        if ( reqDto.getRid() != null && reqDto.getRid().size() > 0 ) {
        	loyTiersMapper.removeTierChnl(reqDto);
            rtnValue.setSuccess(true);
        }
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierUpMatrixList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-승급 매트릭스 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_105
	 *   @table : loy_tierup_matrix, loy_tierup_matrix_dtl, loy_tiers
	 *   @return	
	 */
	public GridPagingResDto<LoyGetTierupMatrixListResDto> getTierUpMatrixList(LoyGetTierupMatrixListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("ltm");

		return new GridPagingResHelper<LoyGetTierupMatrixListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getTierUpMatrixList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierUpMatrix
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2017.01.26
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		승급 매트릭스 상세조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_106
	 *   @table : loy_tierup_matrix, loy_tierup_matrix_dtl
	 *   @return	
	 */
	public LoyGetTierupMatrixListResDto getTierUpMatrix(LoyGetTierupMatrixListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("ltm");

		// 승급매트릭스 조회
		LoyGetTierupMatrixListResDto rtnValue = new LoyGetTierupMatrixListResDto();
		rtnValue = new AnnotationHelper<LoyGetTierupMatrixListResDto>(AnnotationType.CommCode, loyTiersMapper.getTierUpMatrix(reqDto)).getItem();

		if (ObjectUtil.isNotEmpty(rtnValue)) {

			List<LoyGetTierupMatrixDtlResDto> condValList = new ArrayList<LoyGetTierupMatrixDtlResDto>();
			// 승급매트릭스 상세 조회
			reqDto.setSVCAlias("ltmd");
			condValList = new AnnotationHelper<>(AnnotationType.CommCode ,loyTiersMapper.getTierUpMatrixDtl(reqDto)).getItem();
			if (ObjectUtil.isNotEmpty(condValList)) {
				rtnValue.setCondValList(condValList);
			}
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editTierUpMatrix
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2017.01.26
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		승급 매트릭스 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_106
	 *   @table : loy_tierup_matrix, loy_tierup_matrix_dtl
	 *   @return	
	 */
	public StatusResDto editTierUpMatrix(LoyEditTierupMatrixReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
    	String id = CommonUtil.newRid();
    	reqDto.setRid(id);
		StatusResDto rtnValue = new StatusResDto();

		if (TASK_DATA_STATUS.I.name().equals(reqDto.getDataStatus())
				|| TASK_DATA_STATUS.U.name().equals(reqDto.getDataStatus())) {

			String ridTierupMatrix = "";

			if (ObjectUtil.isNotEmpty(reqDto.getRidTierupMatrix())) {
				// 기존 값이 있을 경우
				// 승급매트릭스 수정

				loyTiersMapper.editTierUpMatrix(reqDto);
				rtnValue.setSuccess(true);
				ridTierupMatrix = reqDto.getRidTierupMatrix();
			} else {
				// 승급 매트릭스 저장
				loyTiersMapper.setTierUpMatrix(reqDto);
				ridTierupMatrix = rtnValue.getMessage();
				rtnValue.setSuccess(true);
			}

			for (LoyEditTierupMatrixDtlReqDto conVal : reqDto.getCondValList()) {
				conVal.setCreateBy(reqDto.getCreateBy());
				conVal.setModifyBy(reqDto.getModifyBy());
				conVal.setRidTierupMatrix(ridTierupMatrix);
				conVal.setType(reqDto.getType());

				if (ObjectUtil.isNotEmpty(conVal.getRid())) {
					// 기존 값이 있을경우
					// 승급 매트릭스 상세 수정
					loyTiersMapper.editTierUpMatrixDtl(conVal);
					rtnValue.setSuccess(true);
				} else {
					// 승급 매트릭스 상세 저장
					loyTiersMapper.setTierUpMatrixDtl(conVal);
					rtnValue.setSuccess(true);
				}
			}
			if (ObjectUtil.isNotEmpty(reqDto.getDelRidRierupMatrixDtl())) {
				// 승급 매트릭스 상세 삭제
				loyTiersMapper.delTierUpMatrixDtl(reqDto);
				rtnValue.setSuccess(true);
			}
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTierupMatrix
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2017.01.26
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		승급 매트릭스 상세 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_106
	 *   @table : loy_tierup_matrix, loy_tierup_matrix_dtl
	 *   @return	
	 */
	public StatusResDto removeTierupMatrix(LoyDelTierupMatrixReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);

		StatusResDto rtnValue = new StatusResDto();
		// 승급 매트릭스 상세 삭제
		loyTiersMapper.removeTierupMatrixDtl(reqDto);
		// 승급 매트릭스 삭제
		loyTiersMapper.removeTierupMatrix(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getMbrMstPop
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원마스터 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : POP_902
	 *   @table : loy_mbr, loy_chnl_mbr, loy_cust, loy_tiers
	 *   @return	
	 */
	public GridPagingResDto<LoyGetMbrMstPopResDto> getMbrMstPop(LoyGetMbrMstPopReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("lm");
		
		return new GridPagingResHelper<LoyGetMbrMstPopResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getMbrMstPop(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierBnftList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 05
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급별 혜택 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_102
	 *   @table : loy_tiers, loy_tier_bnft, mkt_cam_mst
	 *   @return	
	 */
	public GridPagingResDto<LoyGetTierBnftListResDto> getTierBnftList(LoyGetTierBnftListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("lt");
		
		return new GridPagingResHelper<LoyGetTierBnftListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getTierBnftList(reqDto));
	}

	 /*
	  * 1. 메소드명: getTierBnft
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급혜택 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_105
	 *   @table : loy_tier_bnft, loy_tier_bnft_hist
	 *   @return	
	 */
	public LoyGetTierBnftListResDto getTierBnft(LoyGetTierBnftListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("ltb");

		return loyTiersMapper.getTierBnft(reqDto);
	}

	 /*
	  * 1. 메소드명: setTierBnft
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 11. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급혜택 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_105
	 *   @table : loy_tier_bnft, loy_tier_bnft_hist
	 *   @return	
	 */
	public StatusResDto setTierBnft(LoySetTierBnftReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
        String id = CommonUtil.newRid();
        reqDto.setRid(id);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.setTierBnft(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editTierBnft
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 11. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급혜택 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_105
	 *   @table : loy_tier_bnft, loy_tier_bnft_hist
	 *   @return	
	 */
	public StatusResDto editTierBnft(LoyEditTierBnftReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.editTierBnft(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTierGrp
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 이성원 
	  * 4. 작성일자: 2017. 03. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeTierGrp(LoyEditTierGroupListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.removeTierupMatrixDtlByRidTiers(reqDto);
        
        loyTiersMapper.removeTierupMatrixByRidTiers(reqDto);
        
        loyTiersMapper.removeTiersCondByRidTiers(reqDto);
        
        loyTiersMapper.removeTierBnftByRidTiers(reqDto);
        
        loyTiersMapper.removeTiersByRidTiers(reqDto);
        
        loyTiersMapper.removeTierGrpChnlByRidTiers(reqDto);
        
        loyTiersMapper.removeTierGrp(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: getTierRuleDetail 
	 * 2. 클래스명: LoyTiersService 
	 * 3. 작성자명: 
	 * 4. 작성일자: 2020. 2. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDto
	 * @return
	 */
	public LoyGetTierupMatrixListResDto getTierRuleDetail(LoyGetTierupMatrixListReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setSVCAlias("a");

		LoyGetTierupMatrixListResDto rtnValue = new LoyGetTierupMatrixListResDto();
		rtnValue = loyTiersMapper.getTierRuleDetail(reqDto);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: saveTierRuleDetail 
	 * 2. 클래스명: LoyTiersService 
	 * 3. 작성자명: 
	 * 4. 작성일자: 2020. 2. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDto
	 * @return
	 */
	public StatusResDto saveTierRuleDetail(LoyEditTierupMatrixReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		reqDto.setRid(CommonUtil.newRid());
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.saveTierRuleDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: editTierRuleDetail 
	 * 2. 클래스명: LoyTiersService 
	 * 3. 작성자명: 
	 * 4. 작성일자: 2020. 2. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDto
	 * @return
	 */
	public StatusResDto editTierRuleDetail(LoyEditTierupMatrixReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.editTierRuleDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: removeTierRuleDetail 
	 * 2. 클래스명: LoyTiersService 
	 * 3. 작성자명: 
	 * 4. 작성일자: 2020. 2. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDto
	 * @return
	 */
	public StatusResDto removeTierRuleDetail(LoyEditTierupMatrixReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.removeTierRuleDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierListByGroup
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 11. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		그룹별로 등급 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	public GridPagingResDto<LoyGetMbrMstPopResDto> getTierListByGroup(LoyGetMbrMstPopReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		tlr.setSVCAlias("t1");

		return new GridPagingResHelper<LoyGetMbrMstPopResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getTierListByGroup(tlr));
	}

	/*
	 * 1. 메소드명: getCondTierList 
	 * 2. 클래스명: LoyTiersService 
	 * 3. 작성자명: 
	 * 4. 작성일자: 2020. 2. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param tlr
	 * @return
	 */
	public GridPagingResDto<LoyTierListResDto> getCondTierList(LoyTierCondListReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		tlr.setSVCAlias("lt");
		
		return new GridPagingResHelper<LoyTierListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getCondTierList(tlr), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierCondList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: hy.jun
	  * 4. 작성일자: 2019. 4. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-승급 룰 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	public GridPagingResDto<LoyTierCondListResDto> getTierCondList(LoyTierCondListReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		tlr.setSVCAlias("");
		return new GridPagingResHelper<LoyTierCondListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.getTierCondList(tlr), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: removeTiersCondAll
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: hy.jun
	  * 4. 작성일자: 2019. 4. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-승급 룰 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	public StatusResDto removeTiersCondAll(LoyTierCondReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.removeTiersCondAll(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTiersCond
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: hy.jun
	  * 4. 작성일자: 2019. 4. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		등급 그룹 상세(탭)-승급 룰 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	public LoyTierCondReqDto getTiersCond(LoyTierCondReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);
		return loyTiersMapper.getTiersCond(tlr);
	}

	/**
	 * @programId :
	 * @name : editTiersCond
	 * @date : 2019. 4. 10.
	 * @author : hy.jun
	 * @table :
	 * @return :
	 * @description : 등급 그룹 상세(탭)-승급 룰 상세 수정
	 */
	 /*
	  * 1. 메소드명: editTiersCond
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: hr.noh 
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
	public StatusResDto editTiersCond(LoyTierCondReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);

		StatusResDto rtnValue = new StatusResDto(false, "");

		if (TASK_DATA_STATUS.I.name().equals(reqDto.getDataStatus())
				|| TASK_DATA_STATUS.U.name().equals(reqDto.getDataStatus())) {

			ArrayList<LoyTierCondDetailReqDto> tierCondList = reqDto.getTierCondDetail();
			if (ObjectUtil.isNotEmpty(tierCondList)) {
				for (LoyTierCondDetailReqDto tierCondDetail : reqDto.getTierCondDetail()) {
					tierCondDetail.setRidTier(reqDto.getRidTier());
					tierCondDetail.setModifyBy(reqDto.getModifyBy());
					tierCondDetail.setType(reqDto.getType());
					tierCondDetail.setSaveRid(CommonUtil.newRid());

					if (ObjectUtil.isNotEmpty(tierCondDetail.getRid())) {
						//등급 그룹 상세(탭)-승급 룰 수정
						loyTiersMapper.editTiersCond(tierCondDetail);
					} else {
						//등급 그룹 상세(탭)-승급 룰 저장 (신규)
						loyTiersMapper.saveTiersCond(tierCondDetail);
					}
				}

			}

			ArrayList<LoyTierCondDetailReqDto> tierCondRemoveList = reqDto.getTierCondDetailRemove();
			if (ObjectUtil.isNotEmpty(tierCondRemoveList)) {
				for (LoyTierCondDetailReqDto tierCondRemove : tierCondRemoveList) {
					if (ObjectUtil.isNotEmpty(tierCondRemove.getRid())) {
						tierCondRemove.setRidTier(reqDto.getRidTier());
						tierCondRemove.setModifyBy(reqDto.getModifyBy());
						//등급 그룹 상세(탭)-승급 룰 삭제
						loyTiersMapper.removeTiersCond(tierCondRemove);
					}
				}
			}
		}

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierGroupListNew
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierListNewResDto> getTierGroupListNew(LoyGetTierGroupListReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyTierListNewResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()), loyTiersMapper.selectTierGroupListNew(tlr), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierGroupDetailNew
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
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
	
	public LoyTierGroupDetailResDto getTierGroupDetailNew(LoyGetTierGroupListReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		LoyTierGroupDetailResDto res = loyTiersMapper.selectTierGroupDetailNew(param);
		return new AnnotationHelper<LoyTierGroupDetailResDto>(AnnotationType.CommCode, res).getItem();
	}

	 /*
	  * 1. 메소드명: savetierGroup
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto savetierGroup(LoyTierGroupDetailReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		tlr.setRid(CommonUtil.newRid());
		loyTiersMapper.insertTierGroup(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifytierGroup
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto modifytierGroup(LoyTierGroupDetailReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.updateTierGroup(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getDatasetList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyDataSetListResDto> getDatasetList(LoyGetTierGroupListReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyDataSetListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectDatasetList(tlr),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierListNewPage
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierListNewPageResDto> getTierListNewPage(LoyTierNewPageReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyTierListNewPageResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTierListNewPage(tlr),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getLoyPgmDetailNew
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 1.
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
	
	public LoyTierListNewPageResDto getTierDetail(LoyTierNewPageReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		LoyTierListNewPageResDto res = loyTiersMapper.selectTierDetail(param);
		return new AnnotationHelper<LoyTierListNewPageResDto>(AnnotationType.Nothing, res).getItem();
	}

	 /*
	  * 1. 메소드명: saveTier
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto saveTier(LoyTierNewPageReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		tlr.setRid(CommonUtil.newRid());
		
		Integer validTierCnt = loyTiersMapper.selectTierCnt(tlr);
		Integer validBaseTierCnt = loyTiersMapper.selectBaseTierCnt(tlr);
		
		if(validTierCnt > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("이미 해당 순위의 등급이 존재합니다.");
			return rtnValue;
		} else if(validBaseTierCnt > 0 && tlr.getBaseTierYn().equals("Y")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("이미 기본 등급이 존재합니다.");
			return rtnValue;
		}
		loyTiersMapper.insertTier(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyTier
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto modifyTier(LoyTierNewPageReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		
		Integer validTierCnt = loyTiersMapper.selectTierCnt(tlr);
		Integer validBaseTierCnt = loyTiersMapper.selectBaseTierCnt(tlr);
		
		if(validTierCnt > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("이미 해당 순위의 등급이 존재합니다.");
			return rtnValue;
		} else if(validBaseTierCnt > 0 && tlr.getBaseTierYn().equals("Y")) {
				rtnValue.setSuccess(false);
				rtnValue.setMessage("이미 기본 등급이 존재합니다.");
				return rtnValue;
		}
			loyTiersMapper.updateTier(tlr);
			rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierBnftList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierBnftListResDto> getTierBnftListNew(LoyTierNewPageReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyTierBnftListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTierBnftListNew(tlr),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierBnftDetail
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public LoyTierBnftDetailResDto getTierBnftDetail(LoyTierNewPageReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);
		
		LoyTierBnftDetailResDto res = loyTiersMapper.selectTierBnftDetail(tlr);
		return new AnnotationHelper<LoyTierBnftDetailResDto>(AnnotationType.Nothing, res).getItem();
	}

	 /*
	  * 1. 메소드명: saveTierBnft
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto saveTierBnft(LoyTierBnftReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		tlr.setRid(CommonUtil.newRid());
		loyTiersMapper.insertTierBnft(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyTierBnft
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto modifyTierBnft(LoyTierBnftReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.updateTierBnft(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTierBnft
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto removeTierBnft(LoyTierNewPageReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.deleteTierBnft(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierGroupJobList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierGrpJobListResDto> getTierGroupJobList(LoyTierNewPageReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);


		return new GridPagingResHelper<LoyTierGrpJobListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType())
				, loyTiersMapper.selectTierGroupJobList(tlr)
				,AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getTierGrpJobDetail
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public LoyTierGrpJobDetailResDto getTierGrpJobDetail(LoyTierGrpJobMasterReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);
		
		LoyTierGrpJobDetailResDto res = loyTiersMapper.selectTierGrpJobDetail(tlr);
		return new AnnotationHelper<LoyTierGrpJobDetailResDto>(AnnotationType.Nothing, res).getItem();
	}

	 /*
	  * 1. 메소드명: saveTierGrpJob
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto saveTierGrpJob(LoyTierGrpJobDetailReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		tlr.setRid(CommonUtil.newRid());
		loyTiersMapper.insertTierGrpJob(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyTierGrpJob
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto modifyTierGrpJob(LoyTierGrpJobDetailReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.updateTierGrpJob(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierGrpDsListNew
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierGrpDsListResDto> getTierGrpDsListNew(LoyTierGrpDsMasterReqDto tlr) {
			LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyTierGrpDsListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTierGrpDsListNew(tlr),AnnotationType.Nothing);
	}

	 /*
	  * 1. 메소드명: getTierGrpDsDetail
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public LoyTierGrpDsListResDto getTierGrpDsDetail(LoyTierGrpDsMasterReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);
		
		LoyTierGrpDsListResDto res = loyTiersMapper.selectTierGrpDsDetail(tlr);
		return new AnnotationHelper<LoyTierGrpDsListResDto>(AnnotationType.Nothing, res).getItem();
	}

	 /*
	  * 1. 메소드명: saveTierGrpDs
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto saveTierGrpDs(LoyTierGrpDsMasterReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		tlr.setRid(CommonUtil.newRid());
		loyTiersMapper.insertTierGrpDs(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyTierGrpDs
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto modifyTierGrpDs(LoyTierGrpDsMasterReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.updateTierGrpDs(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTierGrpDs
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto removeTierGrpDs(LoyTierGrpDsMasterReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.deleteTierGrpDs(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierGrpDsDatasetList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyDataSetListResDto> getTierGrpDsDatasetList(LoyGetTierGroupListReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyDataSetListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTierGrpDsDatasetList(tlr),AnnotationType.Nothing);
	}

	 /*
	  * 1. 메소드명: getTierGrpDsDatasetList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierRuleResDto> getTierRuleListNew(LoyTierRuleMasterReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyTierRuleResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTierRuleListNew(tlr),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getTierGrpRuleList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public LoyTierRuleMasterReqDto getTierGrpRuleList(LoyTierRuleMasterReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);
		
		return loyTiersMapper.selectTierGrpRuleList(tlr);
	}

	 /*
	  * 1. 메소드명: getTierGrpRuleDetailPop
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierRuleResDto> getTierGrpRuleDetailPop(LoyTierRuleMasterReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyTierRuleResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTierGrpRuleDetail(tlr),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getDataSetList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyDataSetListResDto> getDataSetList(LoyTierRuleMasterReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyDataSetListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectDataSetListNew(tlr),AnnotationType.Nothing);
	}

	 /*
	  * 1. 메소드명: getDataSetItemList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyDataSetItemListResDto> getDataSetItemList(LoyTierRuleMasterReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyDataSetItemListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectDataSetItemList(tlr),AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: editTiersRule
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 8.
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
	
	public StatusResDto editTiersRule(LoyTierRuleMasterReqDto reqDto) {
		LogUtil.param(LoyTiersService.class, reqDto);

		StatusResDto rtnValue = new StatusResDto(false, "");
		/*int cnt=1;*/
	

			ArrayList<LoyTierRuleMasterReqDto> tierCondList = reqDto.getTierCondDetail();
			if (ObjectUtil.isNotEmpty(tierCondList)) {
				for (LoyTierRuleMasterReqDto tierCondDetail : reqDto.getTierCondDetail()) {
					tierCondDetail.setRidTier(reqDto.getRidTier());
					tierCondDetail.setModifyBy(reqDto.getModifyBy());
					tierCondDetail.setCreateBy(reqDto.getCreateBy());
					tierCondDetail.setTierRid(reqDto.getTierRid());
					tierCondDetail.setTierGrpJobRid(reqDto.getTierGrpJobRid());
					/*tierCondDetail.setTierGrpDataSetRid(reqDto.getTierGrpDataSetRid());
					tierCondDetail.setTierGrpDataSetItemRid(reqDto.getTierGrpDataSetItemRid());*/
					tierCondDetail.setSaveRid(CommonUtil.newRid());
					/*tierCondDetail.setSeqNo(cnt);*/
					if (ObjectUtil.isNotEmpty(tierCondDetail.getRid())) {
						//등급 그룹 상세(탭)-승급 룰 수정
						loyTiersMapper.editTiersRule(tierCondDetail);
						/*cnt++;*/
					} else {
						//등급 그룹 상세(탭)-승급 룰 저장 (신규)
						loyTiersMapper.saveTiersRule(tierCondDetail);
						/*cnt++;*/
					}
				}

			}

			ArrayList<LoyTierRuleMasterReqDto> tierCondRemoveList = reqDto.getTierCondDetailRemove();
			if (ObjectUtil.isNotEmpty(tierCondRemoveList)) {
				for (LoyTierRuleMasterReqDto tierCondRemove : tierCondRemoveList) {
					if (ObjectUtil.isNotEmpty(tierCondRemove.getRid())) {
						tierCondRemove.setRidTier(reqDto.getRidTier());
						tierCondRemove.setModifyBy(reqDto.getModifyBy());
						//등급 그룹 상세(탭)-승급 룰 삭제
						loyTiersMapper.deleteTiersCond(tierCondRemove);
					}
				}
			}
		

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTiersDatasetItemList
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyDataSetItemListResDto> getTiersDatasetItemList(LoyTierRuleMasterReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyDataSetItemListResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTiersDatasetItemList(tlr),AnnotationType.Nothing);
	}

	 /*
	  * 1. 메소드명: removeTierRule
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto removeTierRule(LoyTierRuleMasterReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.deleteTierRule(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTiersGrp
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 10.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param
	 *   @return	
	 */
	
	public StatusResDto removeTiersGrp(LoyTierNewPageReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.deleteTiersGrp(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTierGrpJob
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param tlr
	 *   @return	
	 */
	
	public StatusResDto removeTierGrpJob(LoyTierGrpDsMasterReqDto tlr) {
		LogUtil.param(this.getClass(), tlr);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.deleteTierGrpJob(tlr);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeTier
	  * 2. 클래스명: LoyTiersService
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
	
	public StatusResDto removeTier(LoyTierNewPageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.deleteTier(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: tierBatchCall
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	public StatusResDto tierBatchCall(LoyTierNewPageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.tierBatchCall(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: tierInitCall
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	public StatusResDto tierInitCall(LoyTierNewPageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyTiersMapper.tierInitCall(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTierGroupListPop
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierListNewPageResDto> getTierGroupListPop(LoyTierNewPageReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyTierListNewPageResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTierGroupListPop(tlr),AnnotationType.Nothing);
	}

	 /*
	  * 1. 메소드명: getTiersListPop
	  * 2. 클래스명: LoyTiersService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierListNewPageResDto> getTiersListPop(LoyTierNewPageReqDto tlr) {
		LogUtil.param(LoyTiersService.class, tlr);
		
		return new GridPagingResHelper<LoyTierListNewPageResDto>().newGridPagingResDto(
				tlr.init(CommonUtil.getInstance().getDBType()),
				loyTiersMapper.selectTiersListPop(tlr),AnnotationType.Nothing);
	}
}
