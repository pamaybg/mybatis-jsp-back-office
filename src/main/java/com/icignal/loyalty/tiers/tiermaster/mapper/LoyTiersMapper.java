package com.icignal.loyalty.tiers.tiermaster.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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

/*
 * 1. 클래스명	: LoyTiersMapper
 * 2. 파일명	: LoyTiersMapper.java
 * 3. 패키지명	: com.icignal.loyalty.tiers.tiermaster.mapper
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		기준정보 - 등급 Mapper
 * </PRE>
 */ 
@Mapper
public interface LoyTiersMapper {

	List<LoyGetTierGroupListResDto> getTierGroupList(LoyGetTierGroupListReqDto reqDto);

	LoyGetTierGroupListResDto getTierGrpDtl(LoyGetTierGroupListReqDto reqDto);

	void setTierGrp(LoySetTierGroupListReqDto reqDto);

	void editTierGrp(LoyEditTierGroupListReqDto reqDto);

	List<LoyGetTierGrpDtlListResDto> getTierListPop(LoyGetTierGrpDtlListReqDto reqDto);

	List<LoyGetTierGrpDtlListResDto> getTierDtlList(LoyGetTierGrpDtlListReqDto reqDto);

	LoyGetTierGrpDtlListResDto getTierDtl(LoyGetTierGrpDtlListReqDto reqDto);

	LoyGetTierGrpDtlListResDto chkValid(LoySetTierDtlReqDto reqDto);

	void setTierDtl(LoySetTierDtlReqDto reqDto);

	void editTierDtl(LoyEditTierDtlReqDto reqDto);

	List<LoyGetTierChnlListResDto> getTierChnlList(LoyGetTierChnlListReqDto reqDto);

	void setTierChnl(LoySetTierChnlReqDto reqDto);

	void editTierChnl(LoyEditTierChnlReqDto reqDto);

	void removeTierChnl(LoyDelTierChnlReqDto reqDto);

	List<LoyGetTierupMatrixListResDto> getTierUpMatrixList(LoyGetTierupMatrixListReqDto reqDto);

	LoyGetTierupMatrixListResDto getTierUpMatrix(LoyGetTierupMatrixListReqDto reqDto);

	List<LoyGetTierupMatrixDtlResDto> getTierUpMatrixDtl(LoyGetTierupMatrixListReqDto reqDto);

	void editTierUpMatrix(LoyEditTierupMatrixReqDto reqDto);

	void setTierUpMatrix(LoyEditTierupMatrixReqDto reqDto);

	void editTierUpMatrixDtl(LoyEditTierupMatrixDtlReqDto conVal);

	void setTierUpMatrixDtl(LoyEditTierupMatrixDtlReqDto conVal);

	void delTierUpMatrixDtl(LoyEditTierupMatrixReqDto reqDto);

	void removeTierupMatrixDtl(LoyDelTierupMatrixReqDto reqDto);

	void removeTierupMatrix(LoyDelTierupMatrixReqDto reqDto);

	List<LoyGetMbrMstPopResDto> getMbrMstPop(LoyGetMbrMstPopReqDto reqDto);

	List<LoyGetTierBnftListResDto> getTierBnftList(LoyGetTierBnftListReqDto reqDto);

	LoyGetTierBnftListResDto getTierBnft(LoyGetTierBnftListReqDto reqDto);

	void setTierBnft(LoySetTierBnftReqDto reqDto);

	void editTierBnft(LoyEditTierBnftReqDto reqDto);

	/* ======= */
	//StatusResDto removeTierGrp(LoyEditTierGroupListReqDto reqDto);
	
	void removeTierupMatrixDtlByRidTiers(LoyEditTierGroupListReqDto reqDto);

	void removeTierupMatrixByRidTiers(LoyEditTierGroupListReqDto reqDto);

	void removeTiersCondByRidTiers(LoyEditTierGroupListReqDto reqDto);

	void removeTierBnftByRidTiers(LoyEditTierGroupListReqDto reqDto);

	void removeTiersByRidTiers(LoyEditTierGroupListReqDto reqDto);

	void removeTierGrpChnlByRidTiers(LoyEditTierGroupListReqDto reqDto);

	void removeTierGrp(LoyEditTierGroupListReqDto reqDto);

	LoyGetTierupMatrixListResDto getTierRuleDetail(LoyGetTierupMatrixListReqDto reqDto);

	void saveTierRuleDetail(LoyEditTierupMatrixReqDto reqDto);

	void editTierRuleDetail(LoyEditTierupMatrixReqDto reqDto);

	void removeTierRuleDetail(LoyEditTierupMatrixReqDto reqDto);

	List<LoyGetMbrMstPopResDto> getTierListByGroup(LoyGetMbrMstPopReqDto tlr);

	List<LoyTierListResDto> getCondTierList(LoyTierCondListReqDto tlr);

	void removeTiersCondAll(LoyTierCondReqDto tlr);

	LoyTierCondReqDto getTiersCond(LoyTierCondReqDto tlr);

	void editTiersCond(LoyTierCondDetailReqDto tierCondDetail);

	void saveTiersCond(LoyTierCondDetailReqDto tierCondDetail);

	void removeTiersCond(LoyTierCondDetailReqDto tierCondRemove);

	List<LoyTierCondListResDto> getTierCondList(LoyTierCondListReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGroupListNew
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyTierListNewResDto> selectTierGroupListNew(LoyGetTierGroupListReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGroupDetailNew
	  * 2. 클래스명: LoyTiersMapper
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
	
	LoyTierGroupDetailResDto selectTierGroupDetailNew(LoyGetTierGroupListReqDto param);

	 /*
	  * 1. 메소드명: insertTierGroup
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void insertTierGroup(LoyTierGroupDetailReqDto tlr);

	 /*
	  * 1. 메소드명: updateTierGroup
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void updateTierGroup(LoyTierGroupDetailReqDto tlr);

	 /*
	  * 1. 메소드명: selectDatasetList
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyDataSetListResDto> selectDatasetList(LoyGetTierGroupListReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierListNewPage
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyTierListNewPageResDto> selectTierListNewPage(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierDetail
	  * 2. 클래스명: LoyTiersMapper
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
	
	LoyTierListNewPageResDto selectTierDetail(LoyTierNewPageReqDto param);

	 /*
	  * 1. 메소드명: insertTier
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void insertTier(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: updateTier
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void updateTier(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierCnt
	  * 2. 클래스명: LoyTiersMapper
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
	
	Integer selectTierCnt(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: selectBaseTierCnt
	  * 2. 클래스명: LoyTiersMapper
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
	
	Integer selectBaseTierCnt(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierBnftList
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyTierBnftListResDto> selectTierBnftListNew(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierBnftDetail
	  * 2. 클래스명: LoyTiersMapper
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
	
	LoyTierBnftDetailResDto selectTierBnftDetail(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: insertTierBnft
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void insertTierBnft(LoyTierBnftReqDto tlr);

	 /*
	  * 1. 메소드명: updateTierBnft
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void updateTierBnft(LoyTierBnftReqDto tlr);

	 /*
	  * 1. 메소드명: deleteTierBnft
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void deleteTierBnft(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGroupJobList
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyTierGrpJobListResDto> selectTierGroupJobList(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGrpJobDetail
	  * 2. 클래스명: LoyTiersMapper
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
	
	LoyTierGrpJobDetailResDto selectTierGrpJobDetail(LoyTierGrpJobMasterReqDto tlr);

	 /*
	  * 1. 메소드명: insertTierGrpJob
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void insertTierGrpJob(LoyTierGrpJobDetailReqDto tlr);

	 /*
	  * 1. 메소드명: updateTierGrpJob
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void updateTierGrpJob(LoyTierGrpJobDetailReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGrpDsListNew
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyTierGrpDsListResDto> selectTierGrpDsListNew(LoyTierGrpDsMasterReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGrpDsDetail
	  * 2. 클래스명: LoyTiersMapper
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
	
	LoyTierGrpDsListResDto selectTierGrpDsDetail(LoyTierGrpDsMasterReqDto tlr);

	 /*
	  * 1. 메소드명: insertTierGrpDs
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void insertTierGrpDs(LoyTierGrpDsMasterReqDto tlr);

	 /*
	  * 1. 메소드명: updateTierGrpDs
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void updateTierGrpDs(LoyTierGrpDsMasterReqDto tlr);

	 /*
	  * 1. 메소드명: deleteTierGrpDs
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void deleteTierGrpDs(LoyTierGrpDsMasterReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGrpDsDatasetList
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyDataSetListResDto> selectTierGrpDsDatasetList(LoyGetTierGroupListReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGrpDsDatasetList
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyTierRuleResDto> selectTierRuleListNew(LoyTierRuleMasterReqDto tlr);

	 /*
	  * 1. 메소드명: selectTiersRuleListNew
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyTierRuleResDto> selectTierGrpRuleDetail(LoyTierRuleMasterReqDto tlr);

	 /*
	  * 1. 메소드명: selectTierGrpRuleList
	  * 2. 클래스명: LoyTiersMapper
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
	
	LoyTierRuleMasterReqDto selectTierGrpRuleList(LoyTierRuleMasterReqDto tlr);

	 /*
	  * 1. 메소드명: selectDataSetListNew
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyDataSetListResDto> selectDataSetListNew(LoyTierRuleMasterReqDto tlr);

	 /*
	  * 1. 메소드명: selectDataSetItemList
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyDataSetItemListResDto> selectDataSetItemList(LoyTierRuleMasterReqDto tlr);

	 /*
	  * 1. 메소드명: editTiersRule
	  * 2. 클래스명: LoyTiersMapper
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
	 *   @param tierCondDetail	
	 */
	
	void editTiersRule(LoyTierRuleMasterReqDto tierCondDetail);

	 /*
	  * 1. 메소드명: saveTiersRule
	  * 2. 클래스명: LoyTiersMapper
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
	 *   @param tierCondDetail	
	 */
	
	void saveTiersRule(LoyTierRuleMasterReqDto tierCondDetail);

	 /*
	  * 1. 메소드명: deleteTiersCond
	  * 2. 클래스명: LoyTiersMapper
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
	 *   @param tierCondRemove	
	 */
	
	void deleteTiersCond(LoyTierRuleMasterReqDto tierCondRemove);

	 /*
	  * 1. 메소드명: selectTiersDatasetItemList
	  * 2. 클래스명: LoyTiersMapper
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
	
	List<LoyDataSetItemListResDto> selectTiersDatasetItemList(LoyTierRuleMasterReqDto tlr);

	 /*
	  * 1. 메소드명: deleteTierRule
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void deleteTierRule(LoyTierRuleMasterReqDto tlr);

	 /*
	  * 1. 메소드명: deleteTiersGrp
	  * 2. 클래스명: LoyTiersMapper
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
	 *   @param tlr	
	 */
	
	void deleteTiersGrp(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: deleteTierGrpJob
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void deleteTierGrpJob(LoyTierGrpDsMasterReqDto tlr);

	 /*
	  * 1. 메소드명: deleteTier
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void deleteTier(LoyTierNewPageReqDto reqDto);

	 /*
	  * 1. 메소드명: tierBatchCall
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void tierBatchCall(LoyTierNewPageReqDto reqDto);

	 /*
	  * 1. 메소드명: tierInitCall
	  * 2. 클래스명: LoyTiersMapper
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
	 */
	
	void tierInitCall(LoyTierNewPageReqDto reqDto);

	 /*
	  * 1. 메소드명: selectTierGroupListPop
	  * 2. 클래스명: LoyTiersMapper
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
	 *   @param tlr
	 *   @return	
	 */
	
	List<LoyTierListNewPageResDto> selectTierGroupListPop(LoyTierNewPageReqDto tlr);

	 /*
	  * 1. 메소드명: selectTiersListPop
	  * 2. 클래스명: LoyTiersMapper
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
	 *   @param tlr
	 *   @return	
	 */
	
	List<LoyTierListNewPageResDto> selectTiersListPop(LoyTierNewPageReqDto tlr);

}
