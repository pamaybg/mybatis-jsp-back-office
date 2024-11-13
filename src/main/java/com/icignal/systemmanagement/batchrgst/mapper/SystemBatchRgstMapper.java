package com.icignal.systemmanagement.batchrgst.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.benefit.point.dto.request.LoyPointAcrlRequestDTO;
import com.icignal.onlineapproval.dto.request.CommonApprovalReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.LoyPntBatchRgstUploadReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemAcrlPntManualReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchLogListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstDetailInsertReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstDetailReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstUploadReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemPntBatchRgstItemReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemPntBatchRgstListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemPntBatchRgstUploadReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemSmsUnSubscribeListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemUpldItemListReqDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemAprReqResResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemBatchLogListResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemBatchRgstDetailResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemBatchRgstListResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemPntBatchRgstItemResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemPntBatchRgstListResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemPntBatchRgstUploadResDto;
import com.icignal.systemmanagement.batchrgst.dto.response.SystemTxnCodeListResDto;

/*
 * 1. 클래스명	: SystemBatchRgstMapper
 * 2. 파일명	: SystemBatchRgstMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.batchrgst.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2017. 11. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 -  승인서버 관리 로그 , 080수신자거부 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemBatchRgstMapper {

	List<SystemBatchRgstListReqDto> getBatchRgstList(SystemBatchRgstListReqDto param);

	List<SystemUpldItemListReqDto> getUpldItemList(SystemUpldItemListReqDto param);

	SystemBatchRgstDetailResDto getBatchRgstDetail(SystemBatchRgstDetailReqDto param);

	String getParentAcuRdn(SystemBatchRgstDetailReqDto dObj);

	void updateBatchRgstTypeCd(SystemBatchRgstDetailInsertReqDto param);

	String callLookUpValue(SystemBatchRgstDetailReqDto param);

	void updateUpldFileReqStatus(CommonApprovalReqDto param);

	void addTargetSmsUploadData(SystemPntBatchRgstUploadReqDto param);

	void insertPntCIUploadData(SystemPntBatchRgstUploadReqDto param);

	void insertProdUploadData(SystemPntBatchRgstUploadReqDto param);

	void insertPntUploadData(SystemPntBatchRgstUploadReqDto param);

	void insertPntUploadDataSurvey(SystemPntBatchRgstUploadReqDto param);

	List<SystemPntBatchRgstListResDto> getPntBatchRgstList(SystemPntBatchRgstListReqDto param);

	void confirmPntBatchRgstList(SystemPntBatchRgstListReqDto param);

	void deletePntBatchRgstList(SystemPntBatchRgstListReqDto param);

	List<SystemPntBatchRgstItemResDto> getPntUpldItemList(SystemPntBatchRgstItemReqDto param);

	List<SystemBatchLogListResDto> setBatchLog(SystemBatchLogListReqDto param);

	List<SystemBatchLogListResDto> getAprLogDetail(SystemBatchLogListReqDto param);

	List<SystemBatchLogListResDto> setApprFailList(SystemBatchLogListReqDto param);

	SystemAprReqResResDto setReqResData(SystemBatchLogListReqDto param);

	void updateBatchCancel(SystemBatchRgstDetailReqDto param);

	void cancelBatchRequest(SystemBatchRgstDetailReqDto param);

	List<SystemSmsUnSubscribeListReqDto> getUnSubExcelUploadList(SystemSmsUnSubscribeListReqDto param);

	List<SystemSmsUnSubscribeListReqDto> smsUpldItemList(SystemSmsUnSubscribeListReqDto param);

	void callUnSubscribeSms(SystemSmsUnSubscribeListReqDto param);

	void insertMbrUploadData(SystemPntBatchRgstUploadReqDto param);

	List<SystemPntBatchRgstItemReqDto> getExcelDownPntUpldItemList(SystemPntBatchRgstItemReqDto param);

	void insertUploadData(SystemBatchRgstUploadReqDto param);

	 /*
	  * 1. 메소드명: insertPntUpload
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void insertPntUpload(SystemPntBatchRgstUploadReqDto param);

	 /*
	  * 1. 메소드명: selectValidMbrDetailInfo2
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param pbri
	 *   @return	
	 */
	
	SystemPntBatchRgstUploadResDto selectValidMbrDetailInfo2(SystemPntBatchRgstItemReqDto pbri);

	 /*
	  * 1. 메소드명: selectPntUploadItemCnt
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
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
	
	int selectPntUploadItemCnt(SystemPntBatchRgstUploadReqDto param);

	 /*
	  * 1. 메소드명: updatePntUploadInvalidItemRslt
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param pbrur	
	 */
	
	void updatePntUploadInvalidItemRslt(LoyPntBatchRgstUploadReqDto pbrur);

	 /*
	  * 1. 메소드명: selectPntUploadItemCntByBatchResultCd
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param pbrur
	 *   @return	
	 */
	
	int selectPntUploadItemCntByBatchResultCd(LoyPntBatchRgstUploadReqDto pbrur);

	 /*
	  * 1. 메소드명: updatePntUploadResult
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void updatePntUploadResult(SystemPntBatchRgstUploadReqDto param);

	 /*
	  * 1. 메소드명: selectValidMbrDetailCnt
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param pbri
	 *   @return	
	 */
	
	Integer selectValidMbrDetailCnt(SystemPntBatchRgstItemReqDto pbri);

	 /*
	  * 1. 메소드명: selectAcrlPntMbrList
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 3.
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
	
	List<SystemBatchRgstListResDto> selectAcrlPntMbrList(SystemPntBatchRgstListReqDto param);

	 /*
	  * 1. 메소드명: callProcPointAcrl
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void callProcPointAcrl(LoyPointAcrlRequestDTO param);

	 /*
	  * 1. 메소드명: insertIntactVoc
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lpar	
	 */
	
	void insertIntactVoc(LoyPointAcrlRequestDTO lpar);

	 /*
	  * 1. 메소드명: updateUploadItemStatus
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void updateUploadItemStatus(SystemPntBatchRgstListReqDto param);

	 /*
	  * 1. 메소드명: selectNoExistMbr
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 3.
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
	
	int selectNoExistMbr(SystemAcrlPntManualReqDto reqDto);

	 /*
	  * 1. 메소드명: selectOverLapMbrAcrlPnt
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 3.
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
	
	int selectOverLapMbrAcrlPnt(SystemAcrlPntManualReqDto param);

	 /*
	  * 1. 메소드명: selectTxnCodeList
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 7.
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
	
	List<SystemTxnCodeListResDto> selectTxnCodeList(SystemPntBatchRgstItemReqDto param);

	 /*
	  * 1. 메소드명: selectClearMaskPntItemMbr
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 7.
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
	
	SystemPntBatchRgstItemResDto selectClearMaskPntItemMbr(SystemPntBatchRgstItemReqDto param);

	 /*
	  * 1. 메소드명: callUseProcPointAcrl
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void callUseProcPointAcrl(LoyPointAcrlRequestDTO param);

	 /*
	  * 1. 메소드명: selectOverLapMbrRdmlPnt
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 7.
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
	
	int selectOverLapMbrRdmlPnt(SystemAcrlPntManualReqDto reqDto);

	 /*
	  * 1. 메소드명: callFraudMbrInsert
	  * 2. 클래스명: SystemBatchRgstMapper
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
	 *   @param param	
	 */
	
	void callFraudMbrInsert(SystemSmsUnSubscribeListReqDto param);

	 /*
	  * 1. 메소드명: selectValidMbrDetailMbrNoCnt
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param pbri
	 *   @return	
	 */
	
	Integer selectValidMbrDetailMbrNoCnt(SystemPntBatchRgstItemReqDto pbri);

	 /*
	  * 1. 메소드명: selectValidMbrDetailMbrNoInfo2
	  * 2. 클래스명: SystemBatchRgstMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param pbri
	 *   @return	
	 */
	
	SystemPntBatchRgstUploadResDto selectValidMbrDetailMbrNoInfo2(SystemPntBatchRgstItemReqDto pbri);

	
}
