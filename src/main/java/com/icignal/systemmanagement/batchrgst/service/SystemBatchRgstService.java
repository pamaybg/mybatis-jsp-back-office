package com.icignal.systemmanagement.batchrgst.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.benefit.point.dto.request.LoyPointAcrlRequestDTO;
import com.icignal.onlineapproval.dto.request.CommonApprovalReqDto;
import com.icignal.onlineapproval.service.OnlineApprovalService;
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
import com.icignal.systemmanagement.batchrgst.mapper.SystemBatchRgstMapper;


/*
 * 1. 클래스명	: SystemBatchRgstService
 * 2. 파일명	: SystemBatchRgstService.java
 * 3. 패키지명	: com.icignal.systemmanagement.batchrgst.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2017. 11. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 -   승인서버 관리 로그 , 080수신자거부 관리 Service
 * </PRE>
 */ 
@Service("SystemBatchRgstService")
public class SystemBatchRgstService {

	@Autowired
	private SystemBatchRgstMapper systemBatchRgstMapper;
	
	@Autowired
	OnlineApprovalService onlineApprovalService;
	
	@Autowired
	AddBatchService addBatchService;

	/**
	 * @programId :
	 * @name : getㅂBatchRegistList
	 * @date : 2017. 11. 13.
	 * @author : kimjunki
	 * @table :
	 * @return :
	 * @description : 파일업로드 리스트를 가져온다
	 **/
	public GridPagingResDto<SystemBatchRgstListReqDto> getBatchRgstList(SystemBatchRgstListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemBatchRgstListReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.getBatchRgstList(param), AnnotationType.CommCode);
	}

	/**
	 * @programId :
	 * @name : getUpldItemList
	 * @date : 2017. 11. 28.
	 * @author : kimjunki
	 * @table :
	 * @return :
	 * @description : 파일 아이템 리스트를 가져온다
	 **/
	public GridPagingResDto<SystemUpldItemListReqDto> getUpldItemList(SystemUpldItemListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemUpldItemListReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.getUpldItemList(param),AnnotationType.CommCode );
	}

	/**
	 * @programId :
	 * @name : getBatchRgstDetail
	 * @date : 2017. 11. 28.
	 * @author : kimjunki
	 * @table :
	 * @return :
	 * @description :
	 **/
	public SystemBatchRgstDetailResDto getBatchRgstDetail(SystemBatchRgstDetailReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return systemBatchRgstMapper.getBatchRgstDetail(param);
	}

	/**
	 * @programId :
	 * @name : updateBatchRgstDetail
	 * @date : 2017. 11. 28.
	 * @author : kimjunki
	 * @table :
	 * @return :
	 * @description :
	 **/
	public StatusResDto updateBatchRgstDetail(SystemBatchRgstDetailInsertReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);

		SystemBatchRgstDetailReqDto dObj = new SystemBatchRgstDetailReqDto();
		StatusResDto rtnVal = new StatusResDto();

		if (param.getAcuRdn() == null) {
			dObj.setAcuRdn(param.getAcuRdn());
			// 적립 차감사유의 parentCode가져와서 널기
			String pointType = systemBatchRgstMapper.getParentAcuRdn(dObj);

			param.setTypeCd(pointType);
			systemBatchRgstMapper.updateBatchRgstTypeCd(param);
			rtnVal.setSuccess(true);
		}
		return rtnVal;
	}


	/**
	 * @programId :
	 * @name : callLookUpValue
	 * @date : 2017. 11. 28.
	 * @author : kimjunki
	 * @table :
	 * @return :
	 * @description :
	 **/
	public String callLookUpValue(SystemBatchRgstDetailReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return systemBatchRgstMapper.callLookUpValue(param);
	}


	/**
	 * @programId :
	 * @name : Get_Tax_Rate
	 * @date : 2018. 1. 16.
	 * @author : kimjunki
	 * @table :
	 * @return : String
	 * @description : 경품의 제세공과금 계산
	 **/
	public String Get_Tax_Rate(String nPoints, String sTaxRate) {
		int nIncomeTax;
		int nResidentTax;

		// 소득세 계산
		nIncomeTax = Integer.parseInt(nPoints) * Integer.parseInt(sTaxRate) / 100;

		// 10원미만 절사
		nIncomeTax = nIncomeTax - nIncomeTax % 10;

		// 주민세 계산
		nResidentTax = (int) (nIncomeTax * 0.1);

		// 10원미만 절사
		nResidentTax = nResidentTax - nResidentTax % 10;

		int result = 0;
		result = nIncomeTax + nResidentTax;
		return String.valueOf(result);
	}

	/**
	 * @programId :
	 * @name : Get_TR_Type
	 * @date : 2018. 1. 16.
	 * @author : kimjunki
	 * @table :
	 * @return : String
	 * @description :
	 **/
	public String Get_TR_Type(String psTrType) {
		// 적립/차감유형을 여러 개 사용할 때.....
		String sTrType = null;
		switch (psTrType) {
		case "P":
			// case "p":
			// case "1":
			// case "적립":
			sTrType = "P";
			break;

		case "M":
			// case "m":
			// case "0":
			// case "차감":
			sTrType = "M";
			break;

		default:
			sTrType = "X";
			break;
		}
		return sTrType;
	}

	/**
	 * @programId :
	 * @name : Change_Date_Fmt
	 * @date : 2018. 1. 16.
	 * @author : kimjunki
	 * @table :
	 * @return : String
	 * @description : 문자열을 mysql의 date형으로 변환한다.
	 **/
	public String Change_Date_Fmt(String psDate, String psTime) {
		/***************************************************************************
		이  름 : Change_Date_Fmt
		기  능 : 문자열을 Siebel의 date형으로 변환한다.
		작성자 : LWY@Quintet
		작성일 : 2009/01/12
		수정이력 :
		기타사항 :
		*****************************************************************************/

		String sDateFmt = "";
		String sTimeFmt = "";

		if (psDate.length() == 8) /* YYYY-MM-DD 형식으로 변환 */
		{
			sDateFmt = psDate.substring(0, 4) + '-' + psDate.substring(4, 6) + '-' + psDate.substring(6, 8);
		}

		if (psTime.length() == 6) /* HH:MM:SS 형식으로 변환 */
		{
			sTimeFmt = " " + psTime.substring(0, 2) + ":" + psTime.substring(2, 4) + ":" + psTime.substring(4, 6);

		}

		return sDateFmt + sTimeFmt;
	}

	/**
	 * @programId :
	 * @name : updateUpldFileReqStatus
	 * @date : 2018. 1. 16.
	 * @author : kimjunki
	 * @table :
	 * @return : StatusResDto
	 * @description : 검수요청 결과 upld_file 상태 업데이트
	 **/
	public StatusResDto updateUpldFileReqStatus(CommonApprovalReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		if(param.getStatus().equals("20")){ //  검수자 승인 처리
			param.setTrtStatus("65");
		}else if(param.getStatus().equals("30")){ // 검수자 승인 거절
			param.setTrtStatus("55");
		}else if(param.getStatus().equals("40")){  // 승인자 승인 처리
			param.setTrtStatus("75");
		}else if(param.getStatus().equals("50")){ // 승인자 승인 거절
			param.setTrtStatus("70");
		}
		systemBatchRgstMapper.updateUpldFileReqStatus(param);
		rtnValue.setSuccess(true);
		return  rtnValue;
	}

	public StatusResDto cancelBatchIns(SystemBatchRgstDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		systemBatchRgstMapper.updateBatchCancel(param);
		rtnValue.setSuccess(true);
		return  rtnValue;
	}

	public StatusResDto cancelBatchRequest(SystemBatchRgstDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		systemBatchRgstMapper.cancelBatchRequest(param);
		rtnValue.setSuccess(true);
		return  rtnValue;
	}

	/**
	 * @programId :
	 * @name : insertPntUploadData
	 * @date : 2018. 11. 5.
	 * @author : hy.jun
	 * @table :
	 * @return :
	 * @description :
	 */
	public StatusResDto insertPntUploadData(SystemPntBatchRgstUploadReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		if (param.getProcTypeCd().equals("TARGET_SMS")) {
			//systemBatchRgstMapper.addTargetSmsUploadData(param);
			rtnValue.setMessage("addTargetSmsUploadData");
			rtnValue.setSuccess(true);
			return rtnValue;
		} else if (param.getProcTypeCd().equals("TARGET_MEMBER_CI")) {
			//systemBatchRgstMapper.insertPntCIUploadData(param);
			rtnValue.setMessage("insertPntCIUploadData");
			rtnValue.setSuccess(true);
			return rtnValue;
		} else if (param.getProcTypeCd().equals("PROD")) {
			//systemBatchRgstMapper.insertProdUploadData(param);
			rtnValue.setMessage("insertProdUploadData");
			rtnValue.setSuccess(true);
			return rtnValue;
		} else if (param.getProcTypeCd().equals("100") || param.getProcTypeCd().equals("200")) {
			rtnValue = savePntUploadDataSurveys(param);
			rtnValue.setSuccess(true);
			return rtnValue;
		} else {
			//systemBatchRgstMapper.savePntUploadDataSurvey(param);
			rtnValue = savePntUploadDataSurveys(param);
			rtnValue.setSuccess(true);
			return rtnValue;
		}

	}

	/**
	 * @programId :
	 * @name : getPntBatchRgstList
	 * @date : 2018. 11. 5.
	 * @author : hy.jun
	 * @table :
	 * @return :
	 * @description :
	 */
	public GridPagingResDto<SystemPntBatchRgstListResDto> getPntBatchRgstList(SystemPntBatchRgstListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemPntBatchRgstListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.getPntBatchRgstList(param),AnnotationType.CommCode );
	}

	/**
	 * @programId :
	 * @name : confirmPntBatchRgstList
	 * @date : 2018. 11. 5.
	 * @author : hy.jun
	 * @table :
	 * @return :
	 * @description :
	 */
	public StatusResDto confirmPntBatchRgstList(SystemPntBatchRgstListReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto();
		
		SystemAcrlPntManualReqDto reqDto = new SystemAcrlPntManualReqDto();
			
		List<SystemBatchRgstListResDto> rtnList = new ArrayList<SystemBatchRgstListResDto>();
		rtnValue.setSuccess(false);		
		
		//확정여부 : 미확정 -> 확정
		systemBatchRgstMapper.confirmPntBatchRgstList(param);
		
		/************************************
		 ** BAT 프로젝트 포인트 수동등록 으로인한 소스변경 **
		 **       기존소스는 위와 같습니다.         **
		 ************************************/
		try {	
			LoyPointAcrlRequestDTO lpar = new LoyPointAcrlRequestDTO();
			
			//적립할 회원정보 추출
			rtnList  = systemBatchRgstMapper.selectAcrlPntMbrList(param);
			for(SystemBatchRgstListResDto acrlList : rtnList) {
				reqDto.setCamNo(acrlList.getCamNo());
				reqDto.setRidMbr(acrlList.getRidMbr());
				reqDto.setPromRid(acrlList.getPromRid());
				reqDto.setPromNo(acrlList.getPromNo());
				reqDto.setOfrNo(acrlList.getOfrNo());
				
				String reqDt = DateUtil.getToday("yyyy-MM-dd HH:mm:ss");
		        String sndDate = DateUtil.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "yyyyMMdd");
		        String sndTime = DateUtil.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "HHmmss");
				
		      //회원정보 존재 여부 확인
		        int noExistMbr = (int) systemBatchRgstMapper.selectNoExistMbr(reqDto);
		        if(noExistMbr != 0 ) {
		        	
			        //오늘자 이미 같은 프로모션으로 등록한 사람 체크 
					//int validCheck = (int) systemBatchRgstMapper.selectOverLapMbrAcrlPnt(reqDto);
					
					//if(validCheck == 0) {
						
						//item table 셋팅
						param.setItemRid(acrlList.getItemRid());
						param.setStatus("S");
						param.setErrorDesc("");
						
						//intact voc 셋팅
						lpar.setCamMstRid(acrlList.getCamMstRid());
						
						//적립프로시저 셋팅
						lpar.setIsConTran(0);
						lpar.setLang(param.getLang());
						lpar.setModifyBy(param.getModifyBy());
						lpar.setCreateBy(param.getCreateBy());
						//lpar.setPgmNo(acrlList.getPgmRid());	//
						lpar.setChnlNo("CH0000001");
						lpar.setIdentiType("92");	//식별 유형 : 92 회원 RID
						lpar.setIdentiVal(acrlList.getRidMbr());	//식별값 : 회원 RID
						lpar.setTxnTypeCd(acrlList.getBigTypeCd());						//거래유형
						lpar.setTxnTypeDtlCd(acrlList.getMidtypeCd());					//거래상세유형
						
						lpar.setPntAmt(Integer.valueOf(acrlList.getAcrlAmt().replaceAll(",", ""))); //적립포인트
						lpar.setTxnAmt(acrlList.getTxnAmt());
						
						lpar.setOfferNo(acrlList.getOfrNo());
						lpar.setOfferType(acrlList.getOfferTypecd());
						
						lpar.setSndDate(sndDate);
				        lpar.setSndTime(sndTime);
				        lpar.setTxnDate(sndDate+sndTime);
				        lpar.setTxnTime(sndTime);
				        lpar.setOfferNo(acrlList.getOfrNo());
				        lpar.setOfferType(acrlList.getOfferType());
				        lpar.setPgmNo(acrlList.getPgmNo());
				        lpar.setProcTypeCd(acrlList.getProcTypeCd());
				        lpar.setProcDtlTypeCd(acrlList.getProcDtlTypeCd());
				        lpar.setTxnUniqNo(UUID.randomUUID().toString().replace("-", "").toString());
				        //lpar.setChnlNo("GloLiveBO"); //적립처
				         
				        //intact voc insert
				        //systemBatchRgstMapper.insertIntactVoc(lpar);
				        
						//적립 프로시저
				        rtnValue = callProcPointAcrl(lpar);
				        
				        if(!rtnValue.getSuccess()) {
				        	param.setItemRid(acrlList.getItemRid());
				        	param.setStatus("F");
							param.setErrorDesc("기타 사유 미지급");
				        }
					/*} else {
						//item table 셋팅
						param.setItemRid(acrlList.getItemRid());
						param.setStatus("F");
						param.setErrorDesc("금일 중복된 포인트 지급");
						
					}*/
		        }else {
		        	//item table 셋팅
					param.setItemRid(acrlList.getItemRid());
					param.setStatus("F");
					param.setErrorDesc("회원 미존재");
		        }
				//item table update
		        systemBatchRgstMapper.updateUploadItemStatus(param);
			}
			rtnValue.setSuccess(true);
		}catch(Exception e) {
			rtnValue.setSuccess(false);
			LogUtil.error(e);
		}
			
		
		return rtnValue;
	}
	
	public StatusResDto callProcPointAcrl(LoyPointAcrlRequestDTO param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		
		systemBatchRgstMapper.callProcPointAcrl(param);
		
		//적립요청 성공시
		if(param.getRst().equals("S")) {
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("["+param.getRstCd()+"] "+param.getRstMsg());
		}
		
		return rtnValue;
	}
	
	public StatusResDto callUseProcPointAcrl(LoyPointAcrlRequestDTO param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		
		systemBatchRgstMapper.callUseProcPointAcrl(param);
		
		//적립요청 성공시
		if(param.getRst().equals("S")) {
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("["+param.getRstCd()+"] "+param.getRstMsg());
		}
		
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : deletePntBatchRgstList
	 * @date : 2018. 11. 5.
	 * @author : hy.jun
	 * @table :
	 * @return :
	 * @description :
	 */
	public StatusResDto deletePntBatchRgstList(SystemPntBatchRgstListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		systemBatchRgstMapper.deletePntBatchRgstList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : getPntUpldItemList
	 * @date : 2018. 11. 5.
	 * @author : hy.jun
	 * @table :
	 * @return :
	 * @description :
	 */
	public GridPagingResDto<SystemPntBatchRgstItemResDto> getPntUpldItemList(SystemPntBatchRgstItemReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemPntBatchRgstItemResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.getPntUpldItemList(param), AnnotationType.ALL );
	}
				

	/**
	 * @programId :
	 * @name : calcPnt
	 * @date : 2018. 11. 29.
	 * @author : hy.jun
	 * @table :
	 * @return : String
	 * @description : 프로그램 포인트 적립정책에 따른 포인트 계산
	 */
//	@SuppressWarnings("unused")
//	private String calcPnt(LoyPgmResDto pgmInfo, int payAmt, String acrlAmt, String acrlType) {
//
//		double calcPnt = 0;
//		String calcPntStr = "";
//		if (acrlType.equals("RATE")) { // 정률
//
//			// 포인트 적립정책 - 계산방식 에 따른 적립포인트 소수점 처리
//			calcPnt = payAmt / 100 * Double.parseDouble(acrlAmt);
//
//			if (pgmInfo.getRoundType().equals("D")) { // 소수점 버림
//
//				// 소수점 이하 0번째 버림인 경우
//				if (Integer.valueOf(pgmInfo.getRoundNum()) == 0) {
//					calcPntStr = String.valueOf(Math.floor(calcPnt));
//				} else {
//					// 소수점 자리 체크
//					String idx = "1";
//					for (int i = 1; i < Integer.parseInt(pgmInfo.getRoundNum()); i++) {
//						idx += "0";
//					}
//					idx += "d";
//					calcPntStr = String.valueOf(Math.floor(calcPnt * Double.valueOf(idx)) / Double.valueOf(idx));
//				}
//
//			} else if (pgmInfo.getRoundType().equals("F")) { // 반올림
//
//				// 소수점 이하 0번째 반올림인 경우 - 절사
//				if (Integer.valueOf(pgmInfo.getRoundNum()) == 0) {
//					calcPntStr = String.valueOf(Math.floor(calcPnt));
//				} else {
//					// 소수점 자리 체크
//					String idx = "1";
//					for (int i = 1; i < Integer.parseInt(pgmInfo.getRoundNum()); i++) {
//						idx += "0";
//					}
//					idx += "d";
//					calcPntStr = String.valueOf(Math.round(calcPnt * Double.valueOf(idx)) / Double.valueOf(idx));
//				}
//			}
//
//		} else if (acrlType.equals("AMT")) { // 정액
//			calcPntStr = acrlAmt;
//		}
//
//		return calcPntStr;
//	}

	/**
	 * @programId :
	 * @name : setBatchLog
	 * @date : 2018. 12. 7.
	 * @author : mj.kim
	 * @table :
	 * @return :
	 * @description :
	 */
	public GridPagingResDto<SystemBatchLogListResDto> setBatchLog(SystemBatchLogListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemBatchLogListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.setBatchLog(param), AnnotationType.CommCode );
	}

	/**
	 * @programId :
	 * @name : getAprLogDetail
	 * @date : 2018. 12. 10.
	 * @author : mj.kim
	 * @table :
	 * @return :
	 * @description :
	 */
	public GridPagingResDto<SystemBatchLogListResDto> getAprLogDetail(SystemBatchLogListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemBatchLogListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.getAprLogDetail(param) );
	}

	/**
	 * @programId :
	 * @name : setApprFailList
	 * @date : 2018. 12. 10.
	 * @author : mj.kim
	 * @table :
	 * @return :
	 * @description :
	 */
	public GridPagingResDto<SystemBatchLogListResDto> setApprFailList(SystemBatchLogListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemBatchLogListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.setApprFailList(param) );
	}

	 /*
	  * 1. 메소드명: setReqResData
	  * 2. 클래스명: SystemBatchRgstService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 10.
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
	public SystemAprReqResResDto setReqResData(SystemBatchLogListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return systemBatchRgstMapper.setReqResData(param);
	}

	 /*
	  * 1. 메소드명: getUnSubExcelUploadList
	  * 2. 클래스명: SystemBatchRgstService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 10.
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
	public GridPagingResDto<SystemSmsUnSubscribeListReqDto> getUnSubExcelUploadList(SystemSmsUnSubscribeListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemSmsUnSubscribeListReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.getUnSubExcelUploadList(param) );
	}

	 /*
	  * 1. 메소드명: smsUpldItemList
	  * 2. 클래스명: SystemBatchRgstService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 10.
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
	public GridPagingResDto<SystemSmsUnSubscribeListReqDto> smsUpldItemList(SystemSmsUnSubscribeListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemSmsUnSubscribeListReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.smsUpldItemList(param) );
	}

	 /*
	  * 1. 메소드명: callUnSubscribeSms
	  * 2. 클래스명: SystemBatchRgstService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 10.
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
	public StatusResDto callUnSubscribeSms(SystemSmsUnSubscribeListReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		systemBatchRgstMapper.callUnSubscribeSms(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: insertMbrUploadData
	  * 2. 클래스명: SystemBatchRgstService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 10.
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
	public StatusResDto insertMbrUploadData(SystemPntBatchRgstUploadReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		systemBatchRgstMapper.insertMbrUploadData(param);
		rtnValue.setSuccess(true);
		return rtnValue;

	}

	 /*
	  * 1. 메소드명: getExcelDownPntUpldItemList
	  * 2. 클래스명: SystemBatchRgstService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2020. 3. 10.
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
	public GridPagingResDto<SystemPntBatchRgstItemReqDto> getExcelDownPntUpldItemList(SystemPntBatchRgstItemReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemPntBatchRgstItemReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.getExcelDownPntUpldItemList(param), AnnotationType.ALL );
	}

	/**
	 * @programId :
	 * @name : insertStampUploadData
	 * @date : 2017. 11. 28.
	 * @author : kimjunki
	 * @table :
	 * @return :
	 * @description :
	 **/
	public StatusResDto insertStampUploadData(SystemBatchRgstUploadReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		param.setInsertUploadDataRid(CommonUtil.newRid());
		systemBatchRgstMapper.insertUploadData(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	
	public StatusResDto savePntUploadDataSurveys(SystemPntBatchRgstUploadReqDto param) {
		LogUtil.param(this.getClass(), param);
	    StatusResDto rtnValue = new StatusResDto(false, "");
	    rtnValue.setSuccess(false);
	    // 2019.09.30 salldr -> addBatch 변경 (BAT 프로젝트)
	    List<SystemPntBatchRgstItemReqDto> array = param.getArray();
	    int cntUpload = array.size();
	    
	    //LOY_PNT_UPLOAD 테이블 INSERT
	    systemBatchRgstMapper.insertPntUpload(param);
	    
	    String dataKey = BeansUtil.getDbEncryptDataKey();
	    
	    //LOYPNT_UPLOAD_ITEM 테이블 INSERT
	    StringBuffer sql = new StringBuffer();
	    sql.append(" INSERT INTO LOY.LOY_PNT_UPLOAD_ITEM")
	       .append(" ( ")
	       .append("   RID")
	       .append(" , CREATE_BY")
	       .append(" , MODIFY_BY")
	       .append(" , CREATE_DATE")
	       .append(" , MODIFY_DATE")	       
	       .append(" , FLAG")
	       .append(" , RID_PNT_UPLOAD")
	       .append(" , MBR_NO")	       
	       .append(" , TARGET_NM")
	       .append(" , TARGET_HHP_NO")
	       .append(" , WEB_ID")
	       .append(" , ACRL_AMT")	       
	       .append(" , RID_MBR")
	       .append(" , RID_CAM")
	       .append(" , SEQ")
	       .append(" , BATCH_RESULT_CD")
	       .append(") VALUES (")
	       .append("   ?")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , sysdate")
	       .append(" , sysdate")
	       .append(" , 1")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , ?")
	       .append(" , 'W'")
	       .append(")");
	    
	    List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
	    
	    int itemSeq = 1;
	    for(SystemPntBatchRgstItemReqDto pbri : param.getArray()) {
	    	try {
	    		String mbrNo , rid;
	    		SystemPntBatchRgstUploadResDto info = new SystemPntBatchRgstUploadResDto();
	    		pbri.setCustTypeCd(param.getCustTypeCd());
	    		if(ObjectUtil.isNotEmpty(pbri.getWebId())){
	    			pbri.setWebId(SecurityUtil.encodeDbAES256(dataKey,pbri.getWebId()));
	    		}
	    		if(ObjectUtil.isNotEmpty(pbri.getCustNm())){
	    			pbri.setCustNm(SecurityUtil.encodeDbAES256(dataKey,pbri.getCustNm()));
	    		}
	    		if(ObjectUtil.isNotEmpty(pbri.getHhpNo())){
	    			pbri.setHhpNo(StringUtil.convertNull(pbri.getHhpNo(), "").replaceAll("-", "").trim());
	    			pbri.setHhpNo(SecurityUtil.encodeDbAES256(dataKey,pbri.getHhpNo()));
	    		}	
	    		Integer mbrCnt;
	    		if(ObjectUtil.isNotEmpty(pbri.getMbrNo())) mbrCnt = (Integer) systemBatchRgstMapper.selectValidMbrDetailMbrNoCnt(pbri);
	    		else mbrCnt = (Integer) systemBatchRgstMapper.selectValidMbrDetailCnt(pbri);
	    		if(mbrCnt >= 2) {
	    			mbrNo = null;
	    			rid = null;
	    		}
	    		else {
	    			if(ObjectUtil.isNotEmpty(pbri.getMbrNo())) info = systemBatchRgstMapper.selectValidMbrDetailMbrNoInfo2(pbri);
		    		else info = systemBatchRgstMapper.selectValidMbrDetailInfo2(pbri);
					//회원번호 rid 추출 및 valid check
	    		}
	    		
	    		if(ObjectUtil.isEmpty(info)) {
	    			mbrNo = null;
	    			rid = null;
	    		}else {
	    			mbrNo = info.getMbrNo();
	    			rid = info.getRid();
	    		}
	    		
		    	Map<Integer,Object> reqDto = new HashMap<Integer,Object>();
		    	int idx = 1;
				
				reqDto.put(idx ++, UUID.randomUUID().toString().replace("-", "")); //rid
				reqDto.put(idx ++, param.getCreateBy());
				reqDto.put(idx ++, param.getModifyBy());
				reqDto.put(idx ++, param.getRid());
				reqDto.put(idx ++, StringUtil.convertNull(pbri.getMbrNo(),""));
				reqDto.put(idx ++, StringUtil.convertNull(pbri.getCustNm(),""));
				reqDto.put(idx ++, StringUtil.convertNull(pbri.getHhpNo(),""));
				reqDto.put(idx ++, StringUtil.convertNull(pbri.getWebId(),""));
				if(!StringUtil.isNumeric(StringUtil.convertNull(pbri.getAcrlAmt().replaceAll(",", "").trim()))) {
					reqDto.put(idx ++, "");
				}else {
				reqDto.put(idx ++, StringUtil.convertNull(pbri.getAcrlAmt().replaceAll(",", ""),"").trim());
				}
				reqDto.put(idx ++, StringUtil.convertNull(rid,""));
				reqDto.put(idx ++, param.getRidCam());
				reqDto.put(idx ++, itemSeq);
				itemSeq++;
				    
				params.add(reqDto);

		    }catch(Exception e) {
		    		rtnValue.setMessage("파일업로드 오류");
		    		LogUtil.error(e);
		    }
		    
		    
	    	
	    }
	    addBatchService.addBatch(sql.toString(),params);
	    
	    //등록 건수 조회
	    int cntItem = systemBatchRgstMapper.selectPntUploadItemCnt(param);

	    //업로드 결과 세팅
	    if(cntItem  == cntUpload) {
	    	param.setBatchResultCd("S");
	    	param.setBatchErrorDesc(null);

		    /*
		     * 유효 업로드 아이템 체크
		     *
		     * 회원유형	: 회원번호 기준 회원RID 모두 존재해야한다. 캠페인번호 기준 캠페인ID 모두 존재해야한다. 적립포인트 0원 이상.
		     * 이벤트유형	: 회원명, 전화번호가 모두 존재해야한다. 캠페인번호 기준 캠페인ID 모두 존재해야한다. 적립포인트 0원 이상.
		     */

	    	LoyPntBatchRgstUploadReqDto pbrur = new LoyPntBatchRgstUploadReqDto();
	    	pbrur.setRid(param.getRid());
	    	pbrur.setProcTypeCd(param.getProcTypeCd());
	    	pbrur.setBatchResultCd("F");

		    //포인트 수동일괄등록 유효하지않은 아이템 업로드 결과 업데이트
	    	if(pbrur.getProcTypeCd().equals("TARGET_MEMBER")) {

		    	pbrur.setValidType("1");
		    	pbrur.setBatchErrorDesc("회원정보 미존재");
		    	systemBatchRgstMapper.updatePntUploadInvalidItemRslt(pbrur);

		    	pbrur.setValidType("2");
		    	pbrur.setBatchErrorDesc("적립포인트 누락 (0원 이상)");
		    	systemBatchRgstMapper.updatePntUploadInvalidItemRslt(pbrur);

		    	pbrur.setValidType("3");
		    	pbrur.setBatchErrorDesc("프로모션 캠페인 미존재");
		    	systemBatchRgstMapper.updatePntUploadInvalidItemRslt(pbrur);

	    	} else if(pbrur.getProcTypeCd().equals("TARGET_SURVEY")) {

		    	pbrur.setValidType("1");
		    	pbrur.setBatchErrorDesc("회원정보 미존재");
		    	systemBatchRgstMapper.updatePntUploadInvalidItemRslt(pbrur);

		    	pbrur.setValidType("2");
		    	pbrur.setBatchErrorDesc("회원정보 미존재");
		    	systemBatchRgstMapper.updatePntUploadInvalidItemRslt(pbrur);

		    	pbrur.setValidType("3");
		    	pbrur.setBatchErrorDesc("적립포인트 오류");
		    	systemBatchRgstMapper.updatePntUploadInvalidItemRslt(pbrur);

		    	pbrur.setValidType("4");
		    	pbrur.setBatchErrorDesc("프로모션 캠페인 미존재");
		    	systemBatchRgstMapper.updatePntUploadInvalidItemRslt(pbrur);

	    	}

	    	//포인트 수동일괄등록 유효하지않은 아이템 업로드 건수 조회
		    int invalidCnt = systemBatchRgstMapper.selectPntUploadItemCntByBatchResultCd(pbrur);
		    if(invalidCnt > 0) {
//		    	//헤더 결과
//		    	param.setBatchResultCd("F");
		    	param.setBatchErrorDesc("부적합 데이터 존재. 업로드 건수:"+cntUpload+" 부적합 건수:"+invalidCnt);
		    }

	    } else {
	    	//헤더 결과
	    	param.setBatchResultCd("F");
	    	param.setBatchErrorDesc("업로드/등록 건수 불일치. 업로드 건수:"+cntUpload+" 등록 건수:"+cntItem);
	    }

	    //헤더 결과 업데이트 (업로드결과/업로드결과상세/총지급포인트)
	    systemBatchRgstMapper.updatePntUploadResult(param);
	    
	    rtnValue.setSuccess(true);
	    
	    if(rtnValue.getSuccess()){
	    	rtnValue.setMessage(Messages.getMessage("L01684", param.getLang()));
	    }

	    return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTxnCodeList
	  * 2. 클래스명: SystemBatchRgstService
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
	
	public GridPagingResDto<SystemTxnCodeListResDto> getTxnCodeList(SystemPntBatchRgstItemReqDto param) {
		LogUtil.param(SystemBatchRgstService.class, param);
		return new GridPagingResHelper<SystemTxnCodeListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemBatchRgstMapper.selectTxnCodeList(param), AnnotationType.ALL );
	}

	 /*
	  * 1. 메소드명: clearMaskPntItemMbr
	  * 2. 클래스명: SystemBatchRgstService
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
	
	public SystemPntBatchRgstItemResDto clearMaskPntItemMbr(SystemPntBatchRgstItemReqDto param) {
		LogUtil.param(this.getClass(), param);
		SystemPntBatchRgstItemResDto res =      systemBatchRgstMapper.selectClearMaskPntItemMbr(param);
	    return new AnnotationHelper<SystemPntBatchRgstItemResDto>(AnnotationType.PersonalData, res).getItem();
	}

	 /*
	  * 1. 메소드명: useConfirmPntBatchRgstList
	  * 2. 클래스명: SystemBatchRgstService
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
	 *   @return	
	 */
	
	public StatusResDto useConfirmPntBatchRgstList(SystemPntBatchRgstListReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto();
		
		SystemAcrlPntManualReqDto reqDto = new SystemAcrlPntManualReqDto();
			
		List<SystemBatchRgstListResDto> rtnList = new ArrayList<SystemBatchRgstListResDto>();
		rtnValue.setSuccess(false);		
		
		//확정여부 : 미확정 -> 확정
		systemBatchRgstMapper.confirmPntBatchRgstList(param);
		
		/************************************
		 ** BAT 프로젝트 포인트 수동등록 으로인한 소스변경 **
		 **       기존소스는 위와 같습니다.         **
		 ************************************/
		try {	
			LoyPointAcrlRequestDTO lpar = new LoyPointAcrlRequestDTO();
			
			//적립할 회원정보 추출
			rtnList  = systemBatchRgstMapper.selectAcrlPntMbrList(param);
			for(SystemBatchRgstListResDto acrlList : rtnList) {
				reqDto.setCamNo(acrlList.getCamNo());
				reqDto.setRidMbr(acrlList.getRidMbr());
				reqDto.setPromRid(acrlList.getPromRid());
				reqDto.setPromNo(acrlList.getPromNo());
				reqDto.setOfrNo(acrlList.getOfrNo());
				
				String reqDt = DateUtil.getToday("yyyy-MM-dd HH:mm:ss");
		        String sndDate = DateUtil.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "yyyyMMdd");
		        String sndTime = DateUtil.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "HHmmss");
				
		      //회원정보 존재 여부 확인
		        int noExistMbr = (int) systemBatchRgstMapper.selectNoExistMbr(reqDto);
		        if(noExistMbr != 0 ) {
		        	
			        //오늘자 이미 같은 프로모션으로 등록한 사람 체크 
					/*int validCheck = (int) systemBatchRgstMapper.selectOverLapMbrAcrlPnt(reqDto);
					
					if(validCheck == 0) {*/
						
						//item table 셋팅
						param.setItemRid(acrlList.getItemRid());
						param.setStatus("S");
						param.setErrorDesc("");
						
						//intact voc 셋팅
						lpar.setCamMstRid(acrlList.getCamMstRid());
						
						//적립프로시저 셋팅
						lpar.setIsConTran(0);
						lpar.setLang(param.getLang());
						lpar.setModifyBy(param.getModifyBy());
						lpar.setCreateBy(param.getCreateBy());
						//lpar.setPgmNo(acrlList.getPgmRid());	//
						lpar.setChnlNo("CH0000001");
						lpar.setIdentiType("92");	//식별 유형 : 92 회원 RID
						lpar.setIdentiVal(acrlList.getRidMbr());	//식별값 : 회원 RID
						lpar.setTxnTypeCd(acrlList.getBigTypeCd());						//거래유형
						lpar.setTxnTypeDtlCd(acrlList.getMidtypeCd());					//거래상세유형
						
						lpar.setPntAmt(Integer.valueOf(acrlList.getAcrlAmt().replaceAll(",", ""))); //적립포인트
						
						lpar.setOfferNo(acrlList.getOfrNo());
						lpar.setOfferType(acrlList.getOfferTypecd());
						
						lpar.setSndDate(sndDate);
				        lpar.setSndTime(sndTime);
				        lpar.setTxnDate(sndDate+sndTime);
				        lpar.setTxnTime(sndTime);
				        lpar.setOfferNo(acrlList.getOfrNo());
				        lpar.setPgmNo(acrlList.getPgmNo());
				        lpar.setProcTypeCd(acrlList.getProcTypeCd());
				        lpar.setProcDtlTypeCd(acrlList.getProcDtlTypeCd());
				        lpar.setTxnUniqNo(UUID.randomUUID().toString().replace("-", "").toString());
				        //lpar.setChnlNo("GloLiveBO"); //적립처
				         
				        //intact voc insert
				        //systemBatchRgstMapper.insertIntactVoc(lpar);
				        
						//적립 프로시저
				        rtnValue = callUseProcPointAcrl(lpar);
						
				        if(!rtnValue.getSuccess()) {
				        	param.setItemRid(acrlList.getItemRid());
				        	param.setStatus("F");
							param.setErrorDesc(rtnValue.getMessage());
				        }
					/*} else {
						
						//item table 셋팅
						param.setItemRid(acrlList.getItemRid());
						param.setStatus("F");
						param.setErrorDesc("금일 중복된 포인트 지급");
						
					}*/
		        }else {
		        	//item table 셋팅
					param.setItemRid(acrlList.getItemRid());
					param.setStatus("F");
					param.setErrorDesc("회원 미존재");
		        }
				//item table update
		        systemBatchRgstMapper.updateUploadItemStatus(param);
			}
			rtnValue.setSuccess(true);
		}catch(Exception e) {
			rtnValue.setSuccess(false);
			LogUtil.error(e);
		}
			
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: blackRuleTest
	  * 2. 클래스명: SystemBatchRgstService
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
	 *   @return	
	 */
	
	public StatusResDto blackRuleTest(SystemSmsUnSubscribeListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		
		systemBatchRgstMapper.callFraudMbrInsert(param);
		
		//적립요청 성공시
		if(param.getpRst().equals("S")) {
			rtnValue.setSuccess(true);
		} else {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("["+param.getpRstCd()+"] "+param.getpRstMsg());
		}
		
		return rtnValue;
	}
	
	
	
	
}
