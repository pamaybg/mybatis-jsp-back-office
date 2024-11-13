/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyVocService.java
 * 2. Package	: com.icignal.loyalty.voc.requestConsultation.service
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 7. 오전 11:09:12
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 7.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.voc.requestConsultation.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.ErrorHelper;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.LoggableStatementUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.core.database.dto.request.MKTDBQueryDTO;
import com.icignal.core.exception.DataFailException;
import com.icignal.core.exception.DataSQLException;
import com.icignal.loyalty.membership.dto.response.LoyMbrTmAgrHistListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetActyHistoryListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetActyHistoryMsgReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetRecordFileListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetReplyHistoryListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetRgstCardListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocGetTransactionListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocModifyRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocRequestConsultationListReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocSetActyHistoryReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.request.VocSetRequestConsultationReqDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetActyHistoryListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetActyHistoryMsgResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetRecordFileListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetReplyHistoryListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetRgstCardListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocGetTransactionListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationExcelListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationListResDto;
import com.icignal.loyalty.voc.requestConsultation.dto.response.VocRequestConsultationResDto;
import com.icignal.loyalty.voc.requestConsultation.mapper.LoyVocMapper;

/*
 * 1. 클래스명	: LoyVocService
 * 2. 파일명	: LoyVocService.java
 * 3. 패키지명	: com.icignal.loyalty.voc.requestConsultation.service
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 7.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyVocService {

	@Autowired 
	LoyVocMapper loyVocMapper;
	
	@Autowired
	StandardPBEStringEncryptor encrypor;
	/**
	 * @name : getConsultList
	 * @date : 2017. 10. 16.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @throws Exception
	 * @description : 상담요청 목록 조회
	 */
	public GridPagingResDto<VocRequestConsultationListResDto> getConsultList(VocRequestConsultationListReqDto bccr) throws Exception {
		LogUtil.param(this.getClass(), bccr);
		//String dataKey = BeansUtil.getDbEncryptDataKey();
		/*bccr.setMemName(SecurityUtil.encodeDbAES256(dataKey,bccr.getMemName()));
		bccr.setEmail(SecurityUtil.encodeDbAES256(dataKey,bccr.getMemName()));
		bccr.setMemName(SecurityUtil.encodeDbAES256(dataKey,bccr.getMemName()));*/
		/*if(ObjectUtil.isNotEmpty(bccr.getPhoneNo())){
			String tPhoneNo = bccr.getPhoneNo().trim().replaceAll("-", "");
			tPhoneNo = iCryptoService.getEncrypt(tPhoneNo);
			bccr.setPhoneNo(tPhoneNo);
		}
		if(ObjectUtil.isNotEmpty(bccr.getContactInfo())){
			String tContactInfo = bccr.getContactInfo().trim().replaceAll("-", "");
			tContactInfo = iCryptoService.getEncrypt(tContactInfo);
			bccr.setContactInfo(tContactInfo);
		}
		if(ObjectUtil.isNotEmpty(bccr.getEmail())){
			String tEmail = iCryptoService.getEncrypt(bccr.getEmail());
			bccr.setEmail(tEmail);
		}*/
		//Integer cnt =  (Integer) loyVocMapper.selectRequestConsultationListCount(bccr);

	    /*GridPagingResponseDTO rtnValue = this.queryForGridBigList("VOCReqConsultation.selectRequestConsultationList", bccr, cnt);

	    if(rtnValue.getRows().size()>0){
	    	rtnValue.setRecords(cnt);
	    	rtnValue.setTotal(cnt);
	    }else{
	    	rtnValue.setTotal(0);
	    	rtnValue.setRecords(0);
	    }*/
		return new GridPagingResHelper<VocRequestConsultationListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyVocMapper.selectRequestConsultationList(bccr),AnnotationType.ALL
				);
		
	}
	
	public GridPagingResDto<VocRequestConsultationExcelListResDto> getConsultMaskList(VocRequestConsultationListReqDto bccr) throws Exception {
		LogUtil.param(this.getClass(), bccr);

		Integer cnt =  (Integer) loyVocMapper.selectRequestConsultationListCount(bccr);

		return new GridPagingResHelper<VocRequestConsultationExcelListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyVocMapper.selectConsultMaskList(bccr),AnnotationType.PersonalData
				);
		
	}

	/**
	 * @name : getConsultDetail
	 * @date : 2017. 10. 16.
	 * @author : jun.lee
	 * @return : VOCRequestConsultationResponseDTO
	 * @description : 상담요청 상세 조회
	 */
	public VocRequestConsultationResDto getConsultDetail(VocRequestConsultationReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		VocRequestConsultationResDto rtnValue = new VocRequestConsultationResDto();
	
		VocRequestConsultationResDto res =      loyVocMapper.selectRequestConsultation(bccr);
		rtnValue = new AnnotationHelper<VocRequestConsultationResDto>(AnnotationType.PersonalData, res).getItem();

		if(rtnValue.getRidCust() != null && !(rtnValue.getRidCust().equals("")) ){
			bccr.setRidCust(rtnValue.getRidCust());
			bccr.setMemNo(rtnValue.getMemNo());

			String ridMbr = (String) loyVocMapper.selectRidMbrByRidCust(bccr);

			rtnValue.setRidMbr(ridMbr);
		}

		return rtnValue;
	}

	/**
	 * @name : getActyHistoryList
	 * @date : 2017. 10. 17.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : 활동내역 목록 조회
	 */
	public GridPagingResDto<VocGetActyHistoryListResDto> getActyHistoryList(VocGetActyHistoryListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		Integer cnt =  (Integer) loyVocMapper.selectActyHistoryListCount(bccr);
		
		return new GridPagingResHelper<VocGetActyHistoryListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyVocMapper.selectActyHistoryList(bccr));
		
	    /*if(rtnValue.getRows().size()>0){
	    	rtnValue.setRecords(cnt);
	    	rtnValue.setTotal(cnt);
	    }else{
	    	rtnValue.setTotal(0);
	    	rtnValue.setRecords(0);
	    }

		return rtnValue;*/
	
	}

	/**
	 * @name : getTransactionListByRidMbr
	 * @date : 2017. 10. 17.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : 포인트거래 목록 조회
	 */
	public GridPagingResDto<VocGetTransactionListResDto> getTransactionListByRidMbr(VocGetTransactionListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<VocGetTransactionListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyVocMapper.selectTransactionListByRidMbr(bccr),AnnotationType.ALL);
	}

	/**
	 * @name : setActyHistory
	 * @date : 2017. 10. 18.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 활동내역 추가
	 */
	public StatusResDto setActyHistory(VocSetActyHistoryReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyVocMapper.insertActyHistory(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @name : modifyRequestConsultation
	 * @date : 2017. 10. 18.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 상담요청 상세 수정
	 */
	public StatusResDto modifyRequestConsultation(VocModifyRequestConsultationReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

//		StatusResDto rtnVal = new StatusResDto();

		//상담요청 상세 수정
		if(bccr.getSrTrtStatus().equals("detailUpdate")){
			//연락처 '-' 제거
			if(bccr.getCntcDesk() != null && bccr.getCntcDesk().length() != 0 ){
				bccr.setCntcDesk(bccr.getCntcDesk().trim().replaceAll("-", ""));
			}

			//휴대폰번호 '-' 제거
			if(bccr.getMemPtblNo() != null && bccr.getMemPtblNo().length() != 0 ){
				bccr.setMemPtblNo(bccr.getMemPtblNo().trim().replaceAll("-", ""));
			}

//			//연락처 마스킹 확인
//			if(bccr.getCntcDesk().indexOf("*") != -1){
//				//연락처 마스킹 해제
//				ICNMaskingRequestDTO mParam = new ICNMaskingRequestDTO();
//				StatusResDto mRtnVal = new StatusResDto();
//
//				mParam.setRid(bccr.getRid());
//				mParam.setType("voc");
//				mParam.setField("cntcDesk");
//
//				mRtnVal = ICNCommonDAO.getMasking(mParam);
//
//				if(!mRtnVal.getSuccess()){
//					rtnVal.setSuccess(false);
//		    		rtnVal.setErrorType(1);
//		    		rtnVal.setMessage("연락처 마스킹 해제에 실패하였습니다.");
//		    		return rtnVal;
//				}else{
//					bccr.setCntcDesk(mRtnVal.getMessage());
//				}
//
//			}
//
//			//휴대폰번호 마스킹 확인
//			if(bccr.getMemPtblNo().indexOf("*") != -1){
//				//휴대폰번호 마스킹 해제
//				ICNMaskingRequestDTO mParam = new ICNMaskingRequestDTO();
//				StatusResDto mRtnVal = new StatusResDto();
//
//				mParam.setRid(bccr.getRid());
//				mParam.setType("voc");
//				mParam.setField("memPtblNo");
//
//				mRtnVal = ICNCommonDAO.getMasking(mParam);
//
//				if(!mRtnVal.getSuccess()){
//					rtnVal.setSuccess(false);
//		    		rtnVal.setErrorType(1);
//		    		rtnVal.setMessage("휴대폰번호 마스킹 해제에 실패하였습니다.");
//		    		return rtnVal;
//				}else{
//					bccr.setMemPtblNo(mRtnVal.getMessage());
//				}
//			}
//
//			//이메일 마스킹 확인
//			if(bccr.getEmailAddr().indexOf("*") != -1){
//				//이메일 마스킹 해제
//				ICNMaskingRequestDTO mParam = new ICNMaskingRequestDTO();
//				StatusResDto mRtnVal = new StatusResDto();
//
//				mParam.setRid(bccr.getRid());
//				mParam.setType("voc");
//				mParam.setField("emailAddr");
//
//				mRtnVal = ICNCommonDAO.getMasking(mParam);
//
//				if(!mRtnVal.getSuccess()){
//					rtnVal.setSuccess(false);
//		    		rtnVal.setErrorType(1);
//		    		rtnVal.setMessage("이메일 마스킹 해제에 실패하였습니다.");
//		    		return rtnVal;
//				}else{
//					bccr.setEmailAddr(mRtnVal.getMessage());
//				}
//			}
		}

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		String updateCrmUser = loyVocMapper.selectUpdateCrmUser(bccr);
		String cuserId = loyVocMapper.selectCrmUser(bccr);
		VocSetActyHistoryReqDto reqDto = new VocSetActyHistoryReqDto();
		reqDto.setUpdateCrmName(updateCrmUser);
		reqDto.setRid(CommonUtil.newRid());
		reqDto.setModifyBy(bccr.getModifyBy());
		reqDto.setCreateBy(bccr.getCreateBy());
		reqDto.setCrmName(bccr.getCrmName());
		reqDto.setRidSvcReq(bccr.getVocReqRid());
		reqDto.setCuserId(cuserId);
		
		if(bccr.getSrTrtStatus().equals("Closed")){
			//상담요청 상태 완료 수정
			loyVocMapper.updateRequestConsultationComplete(bccr);
			//reqDto.setRidSvcReq(bccr.getRid());
			if(reqDto.getRidSvcReq()==null) {
				reqDto.setRidSvcReq(bccr.getRid());
			}
			loyVocMapper.insertRequestConsultationCompleActyHist(reqDto);
		}else if(bccr.getSrTrtStatus().equals("Transfer")){
			//상담요청 상담원 이관
			loyVocMapper.updateRequestConsultationTransfer(bccr);
			loyVocMapper.insertRequestConsultationActyHist(reqDto);
		}else if(bccr.getSrTrtStatus().equals("detailUpdate")){
			//상담요청 상세 수정
			loyVocMapper.updateRequestConsultation(bccr);
		}
		
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @name : setRequestConsultation
	 * @date : 2017. 10. 19.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 상담요청 신규
	 */
	public StatusResDto setRequestConsultation(VocSetRequestConsultationReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		//연락처 '-' 제거
		if(bccr.getCntcDesk() != null && bccr.getCntcDesk().length() != 0 ){
			bccr.setCntcDesk(bccr.getCntcDesk().trim().replaceAll("-", ""));
		}

		//휴대폰번호 '-' 제거
		if(bccr.getMemPtblNo() != null && bccr.getMemPtblNo().length() != 0 ){
			bccr.setMemPtblNo(bccr.getMemPtblNo().trim().replaceAll("-", ""));
		}

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		String rid = CommonUtil.newRid();
		VocModifyRequestConsultationReqDto reqDto = new VocModifyRequestConsultationReqDto();
		reqDto.setRidCrmuser(bccr.getRidCrmuser());
		
		String cuserId = loyVocMapper.selectCrmUser(reqDto);
		VocSetActyHistoryReqDto vocReqDto = new VocSetActyHistoryReqDto();
		vocReqDto.setModifyBy(bccr.getModifyBy());
		vocReqDto.setCreateBy(bccr.getCreateBy());
		vocReqDto.setCrmName(bccr.getCrmName());
		vocReqDto.setRcpMeth(bccr.getRcpMeth());
		vocReqDto.setRidSvcReq(rid);
		vocReqDto.setCuserId(cuserId);
		
		bccr.setRid(rid);
		vocReqDto.setRid(CommonUtil.newRid());
		loyVocMapper.insertRequestConsultation(bccr);
		String rcpMethNm = loyVocMapper.selectRcpMethNm(bccr);
		vocReqDto.setRcpMethNm(rcpMethNm);
		//String rid = (String)
		loyVocMapper.insertRequestConsultationHist(vocReqDto);
		

		rtnValue.setMessage(rid);
		rtnValue.setSuccess(true);
		
		return rtnValue;
		
	}

	/**
	 * @name : getRecordFileList
	 * @date : 2017. 11. 30.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : NEXUS 녹취청취 목록 조회
	 */
	public GridPagingResDto getRecordFileListForNexus(VocGetRecordFileListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		GridPagingResDto rtnValue = new GridPagingResDto();
		StringBuilder sqlQuery = new StringBuilder();

		//접속DB날짜 설정
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREAN);
		Calendar calendar = Calendar.getInstance();
		Date temp = null;
		try {
			temp =  dateFormat.parse(bccr.getCallDate());
			calendar.setTime(temp);
		} catch (ParseException e) {
			LogUtil.error(e);
		}

		int month = calendar.get(Calendar.MONTH) + 1;

		if(month == 10 || month == 11 || month == 12){
			bccr.setCallDate(calendar.get(Calendar.YEAR)+Integer.toString(month));
		}else{
			bccr.setCallDate(calendar.get(Calendar.YEAR)+"0"+month);
		}

		//접속DB정보 설정
		MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();

		dbInfo.setConDbType(System.getProperty("jdbc.cti.dbType"));
		dbInfo.setDriverClassName(encrypor.decrypt(System.getProperty("jdbc.cti.driverClassName")));
		dbInfo.setUrl(encrypor.decrypt(System.getProperty("jdbc.cti.url")));
		dbInfo.setUserName(encrypor.decrypt(System.getProperty("jdbc.cti.username")));
		dbInfo.setPassword(encrypor.decrypt(System.getProperty("jdbc.cti.password")));

		sqlQuery.append(" SELECT ")
    	.append(" 	idx	AS idx ")
    	.append(" 	, owner AS owner  ")
    	.append(" 	, caller_ext AS callerExt  ")
    	.append(" 	, timediff(str_to_date(endtime,'%Y%m%d %H%i%s'),str_to_date(starttime,'%Y%m%d %H%i%s'))	AS	callTime  ")
    	.append(" 	, insert_time AS insertTime  ")
    	.append(" 	, callcenterseq AS callId  ")
    	.append(" 	, path AS filePath  ")
    	.append(" 	, filename AS fileName  ")
//    	.append(" 	,   ")
    	.append(" FROM SKYRECORD.t_record_file_"+bccr.getCallDate())
    	.append(" WHERE callcenterseq = '" + bccr.getCallId() + "' ");
//    	.append(" FROM SKYRECORD.t_record_file_201802");
//		.append(" WHERE callcenterseq = '15' ");

        if (ObjectUtil.isNotEmpty(dbInfo) && ObjectUtil.isNotEmpty(sqlQuery)) {
            //쿼리 실행
            rtnValue = callSelectForGridList("SKYRECORD.selectRecordFileList", sqlQuery.toString(), new ArrayList<String>(), dbInfo, bccr);
        }

		return rtnValue;
	}

	/**
	 * @name : getPbxRecordFileListForNexus
	 * @date : 2018. 2. 5.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : NEXUS 녹취청취 목록 조회(PBX callId 인 경우)
	 */
	public GridPagingResDto getPbxRecordFileListForNexus(VocGetRecordFileListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		GridPagingResDto rtnValue = new GridPagingResDto();
		StringBuilder sqlQuery = new StringBuilder();
		//접속DB정보 설정
		MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();

		dbInfo.setConDbType(System.getProperty("jdbc.cti.dbType"));
		dbInfo.setDriverClassName(encrypor.decrypt(System.getProperty("jdbc.cti.driverClassName")));
		dbInfo.setUrl(encrypor.decrypt(System.getProperty("jdbc.cti.url")));
		dbInfo.setUserName(encrypor.decrypt(System.getProperty("jdbc.cti.username")));
		dbInfo.setPassword(encrypor.decrypt(System.getProperty("jdbc.cti.password")));

		sqlQuery.append(" SELECT ")
    	.append(" 	idx	AS idx ")
    	.append(" 	, '3' AS owner  ")
    	.append(" 	, update_time AS insertTime  ")
    	.append(" 	, call_id AS callId  ")
//    	.append(" 	, path AS filePath  ")
    	.append(" 	, record_file AS fileName  ")
//    	sqlQuery.append(" 	, scd_num AS nexType  ")
    	.append(" FROM SKYIVR.t_e1_record_data ")
    	.append(" WHERE call_id = '" + bccr.getCallId() + "' ");

        if (ObjectUtil.isNotEmpty(dbInfo) && ObjectUtil.isNotEmpty(sqlQuery)) {
            //쿼리 실행
            rtnValue = callSelectForGridList("SKYIVR.selectPbxRecordFileList", sqlQuery.toString(), new ArrayList<String>(), dbInfo, bccr);
        }

		return rtnValue;
	}

	/**
	 * @name : getRecordFileListForCCA
	 * @date : 2017. 12. 19.
	 * @author : jun.lee
	 * @return : VOCGetRecordFileListResponseDTO
	 * @description : CCA 녹취청취 목록 조회
	 */
	public VocGetRecordFileListResDto getRecordFileListForCCA(VocGetRecordFileListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return loyVocMapper.selectRecordFileListForCCA(bccr);
	}

	/**
	 * @name : modifyActyHistory
	 * @date : 2018. 1. 4.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 활동내역 이메일 또는 SMS 발송 후, 활동내역 수정
	 */
	public StatusResDto modifyActyHistory(VocSetActyHistoryReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		StatusResDto rtnValue = new StatusResDto();
		loyVocMapper.updateActyHistory(bccr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @name : getCtiRecordUrl
	 * @date : 2018. 1. 23.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : CTI NEXUS 녹취청취 URL 정보 호출
	 */
	public StatusResDto getCtiRecordUrl(VocGetRecordFileListReqDto bccr) {
		LogUtil.info("VOCRequestConsultationService");

		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);

		if(bccr.getCallIdFlag().equals("1")){
			//일반 callId 인 경우
			rtnValue.setMessage(encrypor.decrypt(System.getProperty("cti.record.url")));
		}else if(bccr.getCallIdFlag().equals("0")){
			rtnValue.setMessage(encrypor.decrypt(System.getProperty("cti.pbxRecord.url")));
		}

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : getRgstCardListByRidMbr
	 * @date : 2018. 1. 27.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : 포인트카드 목록 조회
	 */
	public GridPagingResDto<VocGetRgstCardListResDto> getRgstCardListByRidMbr(VocGetRgstCardListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);

		return new GridPagingResHelper<VocGetRgstCardListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyVocMapper.selectRgstCardListByRidMbr(bccr), AnnotationType.ALL
				);
	}

	/**
	 * @name : getActyHistoryMsg
	 * @date : 2018. 3. 19.
	 * @author : jun.lee
	 * @return : VOCGetActyHistoryMsgResponseDTO
	 * @description : 활동이력 > 활동내역 메시지 조회
	 */
	public VocGetActyHistoryMsgResDto getActyHistoryMsg(VocGetActyHistoryMsgReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return loyVocMapper.selectActyHistoryMsg(bccr);
	}
	
	@SuppressWarnings({ "unchecked", "resource", "rawtypes", "unused" })
	public GridPagingResDto callSelectForGridList(String page_info, String selectContent, List inParams, MKTDBInfoDTO dbInfo, Object obj) {
		LogUtil.param(MKTCallQueryDao.class, page_info);
		String query = "";
		String err_message = "";
		String rsTotalCount = "";
		List rsList = new ArrayList();
		String sqlQuery = "";
		String dbType = dbInfo.getConDbType();

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = null;
		PreparedStatement prepareStmt = null;
		ResultSet rs = null;

		try {
			if (BeanDB.openConnection(dbInfo)) {
				// 페이징 쿼리 설정
				sqlQuery = selectQueryPageing(selectContent, obj, dbType);

				conn = BeanDB.getConnection(dbInfo);
				prepareStmt = new LoggableStatementUtil(conn, sqlQuery);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rs = prepareStmt.executeQuery();

				while (rs.next()) {
					Hashtable hashRow = new Hashtable();
					int columnCount = rs.getMetaData().getColumnCount();
					for (int i = 1; i <= columnCount; i++) {
						hashRow.put(rs.getMetaData().getColumnLabel(i), StringUtil.convertNull(rs.getString(i), "").trim());
					}

					rsList.add(hashRow);
				}

				if ("MYSQL".equals(dbType)) {
					String countQuery = "select FOUND_ROWS() as count";
					prepareStmt = new LoggableStatementUtil(conn, countQuery);
					rs = prepareStmt.executeQuery();

					while (rs.next()) {
						rsTotalCount = StringUtil.convertNull(rs.getString(1), "").trim();
					}
				}
			} else {
				err_message = "DB Connection Error";
				LogUtil.error(err_message);
				throw new DataSQLException();
			}
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();
			} catch (SQLException e) {
				LogUtil.error(e.getMessage(), e);
				throw new DataSQLException();
			} 
		}

		// null 확인
		if (rsList == null) {
			LogUtil.error("results is null");
			throw new DataFailException(ErrorHelper.MSG_1001);

		}

		// 그리드 설정
		GridPagingResDto rtnValue = new GridPagingResDto();
		try {
			if (rsList.size() > 0) {
				int page = 0;
				int totalCount = 0;
				int pageCount = 1;

				if ("ORACLE".equals(dbType) || "POSTGRESQL".equals(dbType)) {
					page = 0;
					totalCount = 0;
					pageCount = 1;
					Hashtable tmp = (Hashtable) rsList.get(0);

					page = Integer.parseInt(tmp.get("pageNum").toString());
					pageCount = Integer.parseInt(tmp.get("totalPage").toString());
					totalCount = Integer.parseInt(tmp.get("totalCount").toString());
				} else {
					((GridPagingReqDto) obj).init(DB_TYPE.MYSQL);
					GridPagingReqDto parseParam = (GridPagingReqDto) obj;
					page = parseParam.getPage();
					totalCount = 0;
					pageCount = 1;

					String totalCountStr = rsTotalCount;
					if (!"".equals(totalCountStr)) {
						totalCount = Integer.parseInt(totalCountStr);
					}

					if (parseParam.getRows() != 0) {
						if (totalCount % parseParam.getRows() == 0) {
							pageCount = totalCount / parseParam.getRows();
						} else {
							pageCount = totalCount / parseParam.getRows() + 1;
						}
					}
				}

				rtnValue.setSuccess(true);
				rtnValue.setRows(rsList);
				rtnValue.setRecords(totalCount);
				rtnValue.setPage(page);
				rtnValue.setTotal(pageCount);
			}
		} catch (Exception e) {
			LogUtil.error(e.getMessage(),e);
			throw new DataSQLException();
		}

		return rtnValue;
	}
	
	/**
	 * @name : selectQueryPageing
	 * @date : 2016. 8. 3.
	 * @author : 류동균
	 * @return :
	 * @description : 해당 쿼리를 DB유형별 그리드 페이징 쿼리로 변환
	 */
	@SuppressWarnings("unused")
	public String selectQueryPageing(String queryStr, Object obj, String type) {
		String rtnQuery = "";
		GridPagingReqDto parseParam = new GridPagingReqDto();
		List<Object> rsList = new ArrayList<Object>();

		try {
			parseParam = (GridPagingReqDto) obj;
			
			if (parseParam.getRows() == 0) {
				parseParam.setRows(10);
			}

			String sidx = parseParam.getSidx();
//			if (!"1".equals(sidx)) {
//				sidx = "\"" + sidx + "\"";
//			}

			if ("ORACLE".equals(type) || "POSTGRESQL".equals(type)) {
				rtnQuery += "select t.*\n";
				rtnQuery += "  from (\n";
				rtnQuery += "    select t.*\n";
				rtnQuery += "         , floor((row_number() over(order by " + sidx + " " + parseParam.getSord() + ") - 1) / " + parseParam.getPageSize() + ") + 1 as \"pageNum\"\n";
				rtnQuery += "         , ceil(count(1) over() / " + parseParam.getPageSize() + ") as \"totalPage\"\n";
				rtnQuery += "         , ceil(count(1) over()) as \"totalCount\"\n";
				rtnQuery += "      from (\n";
				rtnQuery += "        select t.*\n";
				rtnQuery += "          from (\n" + queryStr + "\n";
				rtnQuery += "        ) t\n";

				// 그리드 검색 조건 추가
  				if (ObjectUtil.isNotEmpty(parseParam.getSearchWord())) {
					rtnQuery += "     where t.\"" + parseParam.getSearchText() + "\" like '%" + parseParam.getSearchWord() + "%'\n";
				}

 				int page = parseParam.getPage() == 0 ? 1 : parseParam.getPage();
				rtnQuery += ") t\n ) t\n where t.\"pageNum\" = " + page;
			} else {
				rtnQuery += "select sql_calc_found_rows a.* ";
				rtnQuery += "  from ( ";
				rtnQuery += "    " + queryStr;
				rtnQuery += ") a";

				// 그리드 검색 조건 추가
				if (ObjectUtil.isNotEmpty(parseParam.getSearchWord())) {
					rtnQuery += " where a." + parseParam.getSearchText() + " like '%" + parseParam.getSearchWord() + "%'\n";
				}

				rtnQuery += " order by " + sidx + " " + parseParam.getSord();
				rtnQuery += " limit " + parseParam.getSkipCount() + ", " + parseParam.getPageSize();
			}
		} catch (Exception e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		}

		return rtnQuery;
	}
	
	/**
	 * @name : setPrepareStmtInParams
	 * @date : 2016. 8. 3.
	 * @author : 류동균
	 * @return : PreparedStatement
	 * @description : PreparedStatement의 파라메터 설정
	 */
	@SuppressWarnings("rawtypes")
	public PreparedStatement setPrepareStmtInParams(PreparedStatement prepareStmt, List list) {

		int index = 1;
		try {
			for (Object obj : list) {
				if (obj == null) {
					prepareStmt.setNull(index++, java.sql.Types.NULL);
				} else if (obj.equals(java.lang.Integer.class) || "java.lang.Integer".equals(obj.getClass().getName())) {
					prepareStmt.setInt(index++, (int) obj);
				} else {
					prepareStmt.setString(index++, (String) obj);
				}
			}
		} catch (Exception e) {
			LogUtil.error("setPrepareStmtInParams : " , e);
			
		}

		return prepareStmt;
	}

	 /*
	  * 1. 메소드명: getConsultMasking
	  * 2. 클래스명: LoyVocService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	public VocRequestConsultationResDto getConsultMasking(VocRequestConsultationReqDto bccr) {
        LogUtil.param(this.getClass(), bccr);

        VocRequestConsultationResDto res =      loyVocMapper.clearMaskDrop(bccr);
	    return new AnnotationHelper<VocRequestConsultationResDto>(AnnotationType.PersonalData, res).getItem();
	}


	 /*
	  * 1. 메소드명: getReplyHistoryList
	  * 2. 클래스명: LoyVocService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2021.02. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	public GridPagingResDto<VocGetReplyHistoryListResDto> getReplyHistoryList(VocGetReplyHistoryListReqDto bccr) {
			
		return new GridPagingResHelper<VocGetReplyHistoryListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				loyVocMapper.selectReplyHistoryList(bccr),AnnotationType.ALL);
	}

}
