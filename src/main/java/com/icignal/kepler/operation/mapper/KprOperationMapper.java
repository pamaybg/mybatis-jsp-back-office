/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemOperationMapper.java
 * 2. Package	: com.icignal.systemmanagement.operation.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 12. 오전 11:48:24
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 12.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.kepler.operation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.operation.dto.request.KprCardListReqDto;
import com.icignal.kepler.operation.dto.request.KprComboListReqDto;
import com.icignal.kepler.operation.dto.request.KprCustListReqDto;
import com.icignal.kepler.operation.dto.request.KprDatabaseUseSchemaReqDto;
import com.icignal.kepler.operation.dto.request.KprDbRegistReqDto;
import com.icignal.kepler.operation.dto.request.KprDelDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprDelIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprDelIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprDelSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprDelTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprDelTableReqDto;
import com.icignal.kepler.operation.dto.request.KprEditDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxAdvanceReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprEditIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprEditSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprEditSubjectDbReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableAdvanceReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableColConvertReqDto;
import com.icignal.kepler.operation.dto.request.KprEditTableListReqDto;
import com.icignal.kepler.operation.dto.request.KprExcelUpLoadReqDto;
import com.icignal.kepler.operation.dto.request.KprGetIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetTableColListReqDto;
import com.icignal.kepler.operation.dto.request.KprGetTableReqDto;
import com.icignal.kepler.operation.dto.request.KprGetUploadErrorReqDto;
import com.icignal.kepler.operation.dto.request.KprOperationListReqDto;
import com.icignal.kepler.operation.dto.request.KprProdListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesDtlListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesMileageListReqDto;
import com.icignal.kepler.operation.dto.request.KprSalesPayListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetDbInformReqDto;
import com.icignal.kepler.operation.dto.request.KprSetIdxColListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetIdxListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetSubjectAreaMappingReqDto;
import com.icignal.kepler.operation.dto.request.KprSetSubjectAreaReqDto;
import com.icignal.kepler.operation.dto.request.KprSetTableAddColReqDto;
import com.icignal.kepler.operation.dto.request.KprSetTableListReqDto;
import com.icignal.kepler.operation.dto.request.KprSetUploadErrorReqDto;
import com.icignal.kepler.operation.dto.request.KprSetUploadResultReqDto;
import com.icignal.kepler.operation.dto.request.KprStoreListReqDto;
import com.icignal.kepler.operation.dto.request.KprSubjectAreaListReqDto;
import com.icignal.kepler.operation.dto.request.KprTableColInfoReqDto;
import com.icignal.kepler.operation.dto.request.KprTableImportTreeReqDto;
import com.icignal.kepler.operation.dto.request.KprTableMstListReqDto;
import com.icignal.kepler.operation.dto.response.KprCardListResDto;
import com.icignal.kepler.operation.dto.response.KprComboListResDto;
import com.icignal.kepler.operation.dto.response.KprCustListResDto;
import com.icignal.kepler.operation.dto.response.KprDatabaseUseSchemaResDto;
import com.icignal.kepler.operation.dto.response.KprDbRegistResDto;
import com.icignal.kepler.operation.dto.response.KprDuplicateValResDto;
import com.icignal.kepler.operation.dto.response.KprExcelUploadResDto;
import com.icignal.kepler.operation.dto.response.KprExcelUploadResultResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxColListResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxColListsResDto;
import com.icignal.kepler.operation.dto.response.KprGetIdxListResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableColListResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableColListsResDto;
import com.icignal.kepler.operation.dto.response.KprGetTableResDto;
import com.icignal.kepler.operation.dto.response.KprOperationListResDto;
import com.icignal.kepler.operation.dto.response.KprProdListResDto;
import com.icignal.kepler.operation.dto.response.KprSalesDtlListResDto;
import com.icignal.kepler.operation.dto.response.KprSalesListResDto;
import com.icignal.kepler.operation.dto.response.KprSalesMileageListResDto;
import com.icignal.kepler.operation.dto.response.KprSalesPayListResDto;
import com.icignal.kepler.operation.dto.response.KprStoreListResDto;
import com.icignal.kepler.operation.dto.response.KprSubjectAreaListResDto;
import com.icignal.kepler.operation.dto.response.KprSubjectAreaTreesResDto;
import com.icignal.kepler.operation.dto.response.KprTableColInfoResDto;
import com.icignal.kepler.operation.dto.response.KprTableImportTreeOracleResDto;
import com.icignal.kepler.operation.dto.response.KprTableImportTreeResDto;
import com.icignal.kepler.operation.dto.response.KprTableImportTreesResDto;
import com.icignal.kepler.operation.dto.response.KprTableMstListResDto;

/*
 * 1. 클래스명	: SystemOperationMapper
 * 2. 파일명	: SystemOperationMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.operation.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 12.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface KprOperationMapper {

	 /*
	  * 1. 메소드명: selectDbInformList
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dir
	 *   @return	
	 */
	

	 /*
	  * 1. 메소드명: selectDbRegist
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dir
	 *   @return	
	 */
	
	KprDbRegistResDto selectDbRegist(KprDbRegistReqDto dir);

	 /*
	  * 1. 메소드명: selectDbChkRegist
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dir
	 *   @return	
	 */
	
	KprDbRegistResDto selectDbChkRegist(KprDbRegistReqDto dir);

	 /*
	  * 1. 메소드명: selectIpPortChk
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dir
	 *   @return	
	 */
	
	KprDbRegistResDto selectIpPortChk(KprDbRegistReqDto dir);

	 /*
	  * 1. 메소드명: selectdbInformDelChk
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dir
	 *   @return	
	 */
	
	KprDbRegistResDto selectdbInformDelChk(KprDbRegistReqDto dir);

	 /*
	  * 1. 메소드명: insertDbInform
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param _dir	
	 */
	
	void insertDbInform(KprSetDbInformReqDto _dir);

	 /*
	  * 1. 메소드명: updateDbInfrom
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param _dir
	 *   @return	
	 */
	
	void updateDbInfrom(KprEditDbInformReqDto _dir);

	 /*
	  * 1. 메소드명: deleteDbInfrom
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dir	
	 */
	
	void deleteDbInfrom(KprDelDbInformReqDto dir);

	 /*
	  * 1. 메소드명: selectDbInfromServiceNms
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param dbInformId
	 *   @return	
	 */
	
	List<String> selectDbInfromServiceNms(List<String> dbInformId);

	 /*
	  * 1. 메소드명: selectSubjectAreaList
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sb
	 *   @return	
	 */
	
	List<KprSubjectAreaListResDto> selectSubjectAreaList(KprSubjectAreaListReqDto sb);

	 /*
	  * 1. 메소드명: selectSubjectAreaChk
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sb
	 *   @return	
	 */
	
	KprSubjectAreaListResDto selectSubjectAreaChk(KprSubjectAreaListReqDto sb);

	 /*
	  * 1. 메소드명: subjectAreaDelChk
	  * 2. 클래스명: SystemOperationMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sb
	 *   @return	
	 */
	
	KprSubjectAreaListResDto subjectAreaDelChk(KprSubjectAreaListReqDto sb);

	void insertSubjectArea(KprSetSubjectAreaReqDto sb);

	void updateSubjectArea(KprEditSubjectAreaReqDto sb);

	void deleteSubjectArea(KprDelSubjectAreaReqDto sb);

	KprSubjectAreaListResDto subjectDBDelChk(KprSubjectAreaListReqDto sb);

	void deleteSubjectDb(KprDelSubjectAreaReqDto sb);

	void updateSubjectDb(KprEditSubjectDbReqDto sb);

	void insertSubjectAreaMapping(KprSetSubjectAreaMappingReqDto sb);

	void updateSubjectAreaMapping(KprSetSubjectAreaMappingReqDto sb);

	KprGetTableResDto selectTableList(KprGetTableReqDto dir);

	KprTableMstListResDto selectTableIdReturn(KprTableMstListReqDto dir);

	KprTableMstListResDto selectTableNmChk(KprTableMstListReqDto dir);

	KprTableMstListResDto selectTblLgcChk(KprTableMstListReqDto dir);

	KprGetTableColListResDto tableAddColDelChk(KprGetTableColListReqDto dir);

	void insertTableList(KprSetTableListReqDto dir);

	void updateTableList(KprEditTableListReqDto dir);

	void insertTableAddColList(KprSetTableAddColReqDto sb);

	void updateTableAddColList(KprEditTableAddColReqDto sb);

	void deleteTableAddColList(KprDelTableAddColReqDto sb);

	void updateTableAdvance(KprEditTableAdvanceReqDto sb);

	List<KprGetIdxListResDto> selectIdxList(KprGetIdxListReqDto dir);

	KprGetIdxListResDto selectIdxInform(KprGetIdxListReqDto dir);

	KprGetIdxListResDto selectIdxNmChk(KprGetIdxListReqDto dir);

	void insertIndexList(KprSetIdxListReqDto dir);

	void updateIndexList(KprEditIdxListReqDto dir);

	void deleteIndexList(KprDelIdxListReqDto dir);

	List<KprGetIdxColListResDto> selectIdxColList(KprGetIdxColListReqDto dir);

	KprGetIdxColListResDto selectIdxColInform(KprGetIdxColListReqDto dir);

	KprGetIdxColListResDto selectIdxColNmChk(KprGetIdxColListReqDto dir);

	void insertIndexColList(KprSetIdxColListReqDto dir);

	void updateIndexColList(KprEditIdxColListReqDto dir);

	void deleteIndexColList(KprDelIdxColListReqDto dir);

	KprGetIdxListResDto selectIdxAdvance(KprGetIdxListReqDto dir);

	void updateIdxAdvance(KprEditIdxAdvanceReqDto sb);

	List<KprGetTableColListsResDto> selectCreatTableColList(KprGetTableColListReqDto sb);

	List<KprGetIdxColListsResDto> selectCreatIdxColList(KprGetIdxColListReqDto sb);

	KprTableImportTreeResDto selectSourceTreeMysqlList(KprTableImportTreeReqDto sb);

	KprTableImportTreeOracleResDto selectSourceTreeOracleList(KprTableImportTreeReqDto sb);

	List<String> selectDatabaseUseSchemaNameList(String dbInformId);

	List<KprTableImportTreesResDto> selectTargetTreeList(KprTableImportTreeReqDto sb);

	void insertTableColImport(KprSetTableAddColReqDto dir);

	KprOperationListResDto selectDBInfo(KprOperationListReqDto di);

	KprTableMstListResDto tableLgcChk(KprTableMstListReqDto dir);

	void removeTableColumn(KprDelTableReqDto dir);

	void removeTable(KprDelTableReqDto dir);

	KprSubjectAreaListResDto selectSubjectAreaNmRtn(KprSubjectAreaListReqDto sb);

	List<KprComboListResDto> selectAccountComboList(KprComboListReqDto reqDto);

	List<KprTableColInfoResDto> selectTableColInfo(KprTableColInfoReqDto dir);

	KprExcelUploadResDto insertCustList(KprCustListReqDto slr);

	KprExcelUploadResDto insertStoreList(KprStoreListReqDto slr);

	KprExcelUploadResDto insertSalesList(KprSalesListReqDto slr);

	KprExcelUploadResDto insertSalesDtlList(KprSalesDtlListReqDto slr);

	KprExcelUploadResDto insertSalesPayList(KprSalesPayListReqDto slr);

	KprExcelUploadResDto insertCardList(KprCardListReqDto slr);

	KprExcelUploadResDto insertSalesMileageList(KprSalesMileageListReqDto slr);

	KprExcelUploadResDto insertProdList(KprProdListReqDto slr);

	KprExcelUploadResultResDto insertExcelUpResult(KprSetUploadResultReqDto slr);

	void deleteSalesList(KprExcelUpLoadReqDto eul);
	
	void deleteSalesDtlList(KprExcelUpLoadReqDto eul);

	void deleteCustList(KprExcelUpLoadReqDto eul);

	void deleteStoreList(KprExcelUpLoadReqDto eul);

	void deleteSalesPayList(KprExcelUpLoadReqDto eul);

	void deleteCardList(KprExcelUpLoadReqDto eul);

	void deleteProdList(KprExcelUpLoadReqDto eul);

	void deleteSalesMileageList(KprExcelUpLoadReqDto eul);

	List<KprCustListResDto>  selectTmpCustList(KprExcelUpLoadReqDto slr);

	List<KprDuplicateValResDto> selectCustDupList(KprExcelUpLoadReqDto slr);

	Integer selectCustNoCnt(KprExcelUpLoadReqDto slr);

	void deleteReCustList(KprExcelUpLoadReqDto slr);

	void insertReCustList(KprExcelUpLoadReqDto slr);

	void insertNotInCustList(KprExcelUpLoadReqDto slr);

	void updateReCustList(KprCustListReqDto custDto);

	List<KprStoreListResDto> selectTmpStoreList(KprExcelUpLoadReqDto slr);

	List<KprDuplicateValResDto> selectStoreDupList(KprExcelUpLoadReqDto slr);

	Integer selectStoreNoCnt(KprExcelUpLoadReqDto slr);

	void deleteReStoreList(KprExcelUpLoadReqDto slr);

	void insertReStoreList(KprExcelUpLoadReqDto slr);

	void insertNotInStoreList(KprExcelUpLoadReqDto slr);
	
	void updateReStoreList(KprStoreListReqDto storeDto);

	List<KprSalesListResDto> selectTmpSalesList(KprExcelUpLoadReqDto slr);

	List<KprDuplicateValResDto> selectSalesDupList(KprExcelUpLoadReqDto slr);

	Integer selectSalesNoCnt(KprExcelUpLoadReqDto slr);

	void deleteReSalesList(KprExcelUpLoadReqDto slr);

	void insertReSalesList(KprExcelUpLoadReqDto slr);

	void insertNotInSalesList(KprExcelUpLoadReqDto slr);

	void updateReSalesList(KprSalesListReqDto salesDto);

	Integer selectSalesDtlNoCnt(KprExcelUpLoadReqDto slr);

	void deleteReSalesDtlList(KprExcelUpLoadReqDto slr);

	void insertReSalesDtlList(KprExcelUpLoadReqDto slr);

	void insertNotInSalesDtlList(KprExcelUpLoadReqDto slr);

	void updateReSalesDtlList(KprSalesDtlListReqDto salesDtlDto);

	List<KprSalesPayListResDto> selectTmpSalesPayList(KprExcelUpLoadReqDto slr);

	Integer selectSalesPayNoCnt(KprExcelUpLoadReqDto slr);

	void deleteReSalesPayList(KprExcelUpLoadReqDto slr);

	void insertReSalesPayList(KprExcelUpLoadReqDto slr);

	void insertNotInSalesPayList(KprExcelUpLoadReqDto slr);

	void updateReSalesPayList(KprSalesPayListReqDto salesPayDto);

	List<KprCardListResDto> selectTmpCardList(KprExcelUpLoadReqDto slr);

	List<KprDuplicateValResDto> selectCardDupList(KprExcelUpLoadReqDto slr);

	Integer selectCardNoCnt(KprExcelUpLoadReqDto slr);

	void deleteReCardList(KprExcelUpLoadReqDto slr);

	void insertReCardList(KprExcelUpLoadReqDto slr);

	void insertNotInCardList(KprExcelUpLoadReqDto slr);

	void updateReCardList(KprCardListReqDto cardDto);

	List<KprSalesMileageListResDto> selectTmpSalesMileageList(KprExcelUpLoadReqDto slr);

	List<KprDuplicateValResDto> selectSalesMileageDupList(KprExcelUpLoadReqDto slr);

	Integer selectSalesMileageNoCnt(KprExcelUpLoadReqDto slr);

	void deleteReSalesMileageList(KprExcelUpLoadReqDto slr);

	void insertReSalesMileageList(KprExcelUpLoadReqDto slr);

	void insertNotInSalesMileageList(KprExcelUpLoadReqDto slr);

	void updateReSalesMileageList(KprSalesMileageListReqDto salesMilDto);

	List<KprProdListResDto> selectTmpProdList(KprExcelUpLoadReqDto slr);

	List<KprDuplicateValResDto> selectProdDupList(KprExcelUpLoadReqDto slr);

	Integer selectProdNoCnt(KprExcelUpLoadReqDto slr);

	void deleteReProdList(KprExcelUpLoadReqDto slr);

	void insertReProdList(KprExcelUpLoadReqDto slr);

	void insertNotInProdList(KprExcelUpLoadReqDto slr);

	void updateReProdList(KprProdListReqDto prodDto);

	void insertExcelUpErrorList(KprSetUploadErrorReqDto uer);

	List<KprExcelUploadResDto> selectExcelUpResultList(KprExcelUpLoadReqDto dir);

	List<KprExcelUploadResDto> selectExcelUpResult(KprExcelUpLoadReqDto dir);

	List<KprExcelUploadResDto> selectUploadErrorList(KprExcelUpLoadReqDto dir);

	List<KprGetTableColListResDto> selectTableColListByType(KprGetTableColListReqDto reqDto);

	void updateTableColsType(KprEditTableColConvertReqDto reqDto);

	void deleteDatabaseUseSchema(KprDatabaseUseSchemaReqDto reqDto);

	Integer selectDatabaseUseSchemaNameCount(KprDatabaseUseSchemaReqDto useSchemaDto);

	void insertDatabaseUseSchema(KprDatabaseUseSchemaReqDto useSchemaDto);

	List<KprSubjectAreaTreesResDto> selectSubjectAreaMapping(KprSubjectAreaListReqDto sb);

	List<KprOperationListResDto> selectDbInformList(KprOperationListReqDto dir);

	List<KprGetTableColListResDto> selectTableColList(KprGetTableColListReqDto tm);

	List<KprSubjectAreaListResDto> selectSubjectAreaPop(KprSubjectAreaListReqDto sb);

	List<KprTableMstListResDto> selectTableMstList(KprTableMstListReqDto tm);

	List<KprComboListResDto> selectDbServiceComboList(KprComboListReqDto reqDto);

	List<KprComboListResDto> selectSubjectAreaComboList(KprComboListReqDto reqDto);

	List<KprSalesDtlListResDto> selectTmpSalesDtlList(KprExcelUpLoadReqDto slr);

	List<KprDuplicateValResDto> selectSalesDtlDupList(KprExcelUpLoadReqDto slr);

	List<KprDuplicateValResDto> selectSalesPayDupList(KprExcelUpLoadReqDto slr);

	KprSubjectAreaListResDto selectSubjectArea(KprSubjectAreaListReqDto sb);

	KprSubjectAreaListResDto selectSubjectRelCnt(KprSubjectAreaListReqDto sb);

	KprGetTableColListResDto selectTableAddColList(KprGetTableColListReqDto dir);

	KprGetTableColListResDto selectTblColNmChk(KprGetTableColListReqDto dir);

	KprGetTableResDto selectTableAdvance(KprGetTableReqDto dir);

	KprDbRegistResDto selectDbType(KprDbRegistReqDto dir);

	KprGetTableColListResDto selectColSeq(KprGetTableColListReqDto dir);

	Integer selectExcelUpSeq(KprGetUploadErrorReqDto dir);

	List<String> getDbInfromServiceNms(List<String> dbInformId);

	List<KprDatabaseUseSchemaResDto> selectDatabaseUseSchemaList(KprDatabaseUseSchemaReqDto reqDto);

	void insertTableImport(KprSetTableListReqDto dir);


}
