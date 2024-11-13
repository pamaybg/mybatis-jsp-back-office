package com.icignal.loyalty.benefit.point.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.loyalty.benefit.point.dto.request.LOYPntManualRgstUploadReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyPntManualRgstItemReqDto;




/*
 * 1. 클래스명	: LoyPointManualRegisterService
 * 2. 파일명	: LoyManualPointService.java
 * 3. 패키지명	: com.icignal.loyalty.benefit.point.service
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 포인트수동등록 서비스
 * Mybatis Batch 처리를 이용하여 일괄 등록한다.
 *
 * </PRE>
 */ 
//@Service
public class LoyPointManualRegisterService {

	
//	@Autowired LoyManualPoinrMapper loyManualMapper;
	
	
	    @Autowired
	    @Qualifier("sqlSessionTemplateBatch")
		SqlSessionTemplate batchSqlSessionTemplate;    // 앞서 설정한 batch방식으로 처리할 SqlSessionTemplate Bean을 선언
	         
	    public SqlSession getBatchSqlSession() {
	        return batchSqlSessionTemplate;            // SqlSessionTemplate Bean을 사용한다.
	    }
	         
	    @Transactional(value="transactionManager-batch", propagation = Propagation.REQUIRED, rollbackFor = Exception.class)    
	    public void insertPntUploadData(LOYPntManualRgstUploadReqDto param) throws RuntimeException {
	        // ... param 처리 등등
	       //  List<Map<String,Object>> doData = (List<Map<String,Object>>)paramMap.get("doData");
	    	      
	         List<LoyPntManualRgstItemReqDto> array = param.getArray();
	 	    int cntUpload = array.size();
	         
	        for(LoyPntManualRgstItemReqDto item : array) {
	         //   getBatchSqlSession().insert("insertPntUploadItem", item);    // Batch SqlSessionTemplate을 이용해 밀어 넣는다.
	         // 아래의 주석 로직 mybatis xml로 전환후 호출 및 다음 로직 구현하세요...
	        	
	        }
	    }
	
	/*
	
	public StatusResDto insertPntUploadData(LoyManualPointReqDto param) {
		StatusResDto rtnValue = new StatusResDto(false, "");
	    rtnValue.setSuccess(false);
	    // 2019.09.30 salldr -> addBatch 변경 (BAT 프로젝트)
	    List<LoyManualReqDto> array = param.getArray();
	    int cntUpload = array.size();
	    
	    //LOY_PNT_UPLOAD 테이블 INSERT
	    loyManualMapper.insertPntUpload(param);
	    
	    //LOYPNT_UPLOAD_ITEM 테이블 INSERT
	    StringBuffer sql = new StringBuffer();
	    sql.append(" INSERT INTO LOY.LOY_PNT_UPLOAD_ITEM");
	    sql.append(" ( ");
	    sql.append("   RID");
	    sql.append(" , CREATE_BY");
	    sql.append(" , MODIFY_BY");
	    sql.append(" , CREATE_DATE");
	    sql.append(" , MODIFY_DATE");
	    
	    sql.append(" , FLAG");
	    sql.append(" , COUNTRY");
	    sql.append(" , APP_SERVICE_TYPE");
	    sql.append(" , ACCNT_ID");
	    sql.append(" , RID_PNT_UPLOAD");
	    sql.append(" , MBR_NO");
	    
	    sql.append(" , TARGET_NM");
	    sql.append(" , TARGET_HHP_NO");
	    sql.append(" , WEB_ID");
	    sql.append(" , ACRL_AMT");
	    
	    sql.append(" , RID_MBR");
	    sql.append(" , RID_CAM");
	    sql.append(" , SEQ");
	    sql.append(" , BATCH_RESULT_CD");
	    sql.append(") VALUES (");
	    sql.append("   ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , sysdate");
	    sql.append(" , sysdate");
	    sql.append(" , 1");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , ?");
	    sql.append(" , 'W'");
	    sql.append(")");
	    
	    List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
	    
	    int itemSeq = 1;
	    for(LoyManualReqDto pbri : param.getArray()) {
	    	try {
	    		String mbrNo , rid;
	    		LoyManualResDto info = new LoyManualResDto();
	    		
	    		 if(ObjectUtil.isNotEmpty(pbri.getWebId())){
	    			pbri.setWebId(cryptService.getEncrypt(pbri.getWebId()));
	    		}if(ObjectUtil.isNotEmpty(pbri.getCustNm())){
	    			pbri.setCustNm(cryptService.getEncrypt(pbri.getCustNm()));
	    		}
	    		 if(ObjectUtil.isNotEmpty(pbri.getHhpNo())){
	    			pbri.setHhpNo(IFVMStringUtility.convertNull(pbri.getHhpNo(), "").replaceAll("-", "").trim());
					pbri.setHhpNo(cryptService.getEncrypt(pbri.getHhpNo()));
	    		}
	    		
				//회원번호 rid 추출 및 valid check
	    		info = (LoyManualResDto) loyManualMapper.selectValidMbrDetailInfo(pbri);
	    		
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
				reqDto.put(idx ++, param.getCountry());
				reqDto.put(idx ++, param.getAppServiceId());
				reqDto.put(idx ++, param.getAccountId());
				reqDto.put(idx ++, param.getRid());
				reqDto.put(idx ++, IFVMStringUtility.convertNull(mbrNo,""));
				reqDto.put(idx ++, IFVMStringUtility.convertNull(pbri.getCustNm(),""));
				reqDto.put(idx ++, IFVMStringUtility.convertNull(pbri.getHhpNo(),""));
				reqDto.put(idx ++, IFVMStringUtility.convertNull(pbri.getWebId(),""));
				if(!IFVMStringUtility.isNumeric(IFVMStringUtility.convertNull(pbri.getAcrlAmt().replaceAll(",", "").trim()))) {
					reqDto.put(idx ++, "");
				}else {
				reqDto.put(idx ++, IFVMStringUtility.convertNull(pbri.getAcrlAmt().replaceAll(",", ""),"").trim());
				}
				reqDto.put(idx ++, IFVMStringUtility.convertNull(rid,""));
				reqDto.put(idx ++, param.getRidCam());
				reqDto.put(idx ++, itemSeq);
				itemSeq++;
				    
				params.add(reqDto);
		    }catch(Exception e) {
		    		rtnValue.setMessage("파일업로드 오류");
		    		e.printStackTrace();
		    }
	    	
	    }
	    
	    this.addBatch(sql.toString(), params);
	    
	    //등록 건수 조회
	    int cntItem = (int) loyManualMapper.selectPntUploadItemCnt(param);

	    //업로드 결과 세팅
	    if(cntItem  == cntUpload) {
	    	param.setBatchResultCd("S");
	    	param.setBatchErrorDesc(null);

		    
		     * 유효 업로드 아이템 체크
		     *
		     * 회원유형	: 회원번호 기준 회원RID 모두 존재해야한다. 캠페인번호 기준 캠페인ID 모두 존재해야한다. 적립포인트 0원 이상.
		     * 이벤트유형	: 회원명, 전화번호가 모두 존재해야한다. 캠페인번호 기준 캠페인ID 모두 존재해야한다. 적립포인트 0원 이상.
		     

	    	LoyManualReqDto pbrur = new LoyManualReqDto();
	    	pbrur.setRid(param.getRid());
	    	pbrur.setProcTypeCd(param.getProcTypeCd());
	    	pbrur.setBatchResultCd("F");

		    //포인트 수동일괄등록 유효하지않은 아이템 업로드 결과 업데이트
	    	if(pbrur.getProcTypeCd().equals("TARGET_MEMBER")) {

		    	pbrur.setValidType("1");
		    	pbrur.setBatchErrorDesc("회원정보 미존재");

		    	pbrur.setValidType("2");
		    	pbrur.setBatchErrorDesc("적립포인트 누락 (0원 이상)");

		    	pbrur.setValidType("3");
		    	pbrur.setBatchErrorDesc("프로모션 캠페인 미존재");

	    	} else if(pbrur.getProcTypeCd().equals("TARGET_EVENT")) {
	    		pbrur.setValidType("1");
		    	pbrur.setBatchErrorDesc("회원정보 미존재");
	    		
		    	pbrur.setValidType("2");
		    	pbrur.setBatchErrorDesc("적립포인트 오류");

		    	pbrur.setValidType("3");
		    	pbrur.setBatchErrorDesc("프로모션 캠페인 미존재");

	    	}
	    	loyManualMapper.updatePntUploadInvalidItemRslt(pbrur);

	    	//포인트 수동일괄등록 유효하지않은 아이템 업로드 건수 조회
		    int invalidCnt = (int)loyManualMapper.selectPntUploadItemCntByBatchResultCd(pbrur);
		    if(invalidCnt > 0) {
//		    	//헤더 결과
//		    	reqDto.setBatchResultCd("F");
		    	param.setBatchErrorDesc("부적합 데이터 존재. 업로드 건수:"+cntUpload+" 부적합 건수:"+invalidCnt);
		    }

	    } else {
	    	//헤더 결과
	    	param.setBatchResultCd("F");
	    	param.setBatchErrorDesc("업로드/등록 건수 불일치. 업로드 건수:"+cntUpload+" 등록 건수:"+cntItem);
	    }

	    //헤더 결과 업데이트 (업로드결과/업로드결과상세/총지급포인트)
	    loyManualMapper.updatePntUploadResult(param);
	    
	    rtnValue.setSuccess(true);
	    
	    if(rtnValue.getSuccess()){
	    	rtnValue.setMessage(Messages.getMessage("L01684", param.getLang()));
	    }

	    return rtnValue;
	}*/
	/**
	* @programId :
	* @name : getPntBatchRgstList
	* @date : 2018. 11. 5.
	* @author : hy.jun
	* @table :
	* @return :
	* @description :
	*/
/*	public GridPagingResDto<LoyManualResDto> getPntBatchRgstList(LoyManualReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyManualResDto>().newGridPagingResDto(
				reqDto.init(Common.getInstance().getDBType()),loyManualMapper.selectPntBatchRgstList(reqDto)
				,false);
	}
	*/
	
	/**
	* @programId :
	* @name : getPntUpldItemList
	* @date : 2018. 11. 5.
	* @author : hy.jun
	* @table :
	* @return :
	* @description :
	*/
	
/*	public GridPagingResDto<LoyManualResDto> getPntUpldItemList(LoyManualReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyManualResDto>().newGridPagingResDto(
				reqDto.init(Common.getInstance().getDBType()),loyManualMapper.selectPntUpldItemList(reqDto)
				,false);
	}*/
	
	/**
	* @programId :
	* @name : getExcelDownPntUpldItemList
	* @date : 
	* @author :
	* @table :
	* @return :
	* @description :
	*//*
	public GridPagingResDto<LoyManualResDto> getExcelDownPntUpldItemList(LoyManualReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyManualResDto>().newGridPagingResDto(
				reqDto.init(Common.getInstance().getDBType()),loyManualMapper.selectExcelDownPntUpldItemList(reqDto)
				,false);
	}*/
	
	/**
	* @programId :
	* @name : deletePntBatchRgstList
	* @date : 2018. 11. 5.
	* @author : hy.jun
	* @table :
	* @return :
	* @description :
	*/
	
/*	
	public StatusResDto deletePntBatchRgstList(LoyManualReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyManualMapper.deletePntBatchRgstList(reqDto);
				
	}
	*/
	
	/**
	* @programId :
	* @name : confirmPntBatchRgstList
	* @date : 2018. 11. 5.
	* @author : hy.jun
	* @table :
	* @return :
	* @description :
	*/
	/*public StatusResDto confirmPntBatchRgstList(LoyManualReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto();
		LoyManualReqDto reqDto = new LoyManualReqDto();
			
		List<LoyManualResDto> rtnList = new ArrayList<LoyManualResDto>();
		rtnValue.setSuccess(false);		
		
		//확정여부 : 미확정 -> 확정
		loyManualMapper.updateConfirmPntBatchRgstList(param);
		
		*//************************************
		 ** BAT 프로젝트 포인트 수동등록 으로인한 소스변경 **
		 **       기존소스는 위와 같습니다.         **
		 ************************************//*
		try {	
			LoyManualReqDto lpar = new LoyManualReqDto();
			
			//적립할 회원정보 추출
			rtnList  = loyManualMapper.selectAcrlPntMbrList(param);
			for(LoyManualResDto acrlList : rtnList) {
				reqDto.setCamNo(acrlList.getCamNo());
				reqDto.setRidMbr(acrlList.getRidMbr());
				
				String reqDt = IFVMDateUtility.getToday("yyyy-MM-dd HH:mm:ss");
		        String sndDate = IFVMDateUtility.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "yyyyMMdd");
		        String sndTime = IFVMDateUtility.getDateFormat(reqDt, "yyyy-MM-dd HH:mm:ss", "HHmmss");
				
		        //회원정보 존재 여부 확인
		        int noExistMbr = (int) loyManualMapper.selectNoExistMbr(reqDto);
		        if(noExistMbr != 0 ) {
		        	
			        //오늘자 이미 같은 프로모션으로 등록한 사람 체크
					int validCheck = (int) loyManualMapper.selectOverLapMbrAcrlPnt(reqDto);
					
					if(validCheck == 0) {
						
						//item table 셋팅
						param.setItemRid(acrlList.getItemRid());
						param.setStatus("S");
						param.setErrorDesc("");
						
						//intact voc 셋팅
						lpar.setCamMstRid(acrlList.getCamMstRid());
						
						//적립프로시저 셋팅
						lpar.setIsConTran(1);
						lpar.setAccountId(param.getAccountId());
						lpar.setAppServiceId(param.getAppServiceId());
						lpar.setLang(param.getLang());
						lpar.setCountry(param.getCountry());
						lpar.setModifyBy(param.getModifyBy());
						lpar.setCreateBy(param.getCreateBy());
						lpar.setPgmNo("P000001");	//
						
						lpar.setIdentiType("92");	//식별 유형 : 92 회원 RID
						lpar.setIdentiVal(acrlList.getRidMbr());	//식별값 : 회원 RID
						
						lpar.setTxnTypeCd(acrlList.getBigTypeCd());						//거래유형
						lpar.setTxnTypeDtlCd(acrlList.getMidtypeCd());					//거래상세유형
						
						lpar.setPntAmt(Integer.valueOf(acrlList.getAcrlAmt().replaceAll(",", ""))); //적립포인트
						
						lpar.setOfferNo(acrlList.getOfferNo());
						lpar.setOfferType(acrlList.getOfferTypecd());
						
						lpar.setSndDate(sndDate);
				        lpar.setSndTime(sndTime);
				        lpar.setTxnDate(sndDate);
				        lpar.setTxnTime(sndTime);
						
				        lpar.setTxnUniqNo(UUID.randomUUID().toString().replace("-", "").toString());
				        lpar.setChnlNo("GloLiveBO"); //적립처
				         
				        //intact voc insert
				        this.insert("LOYBatchRgst.insertIntactVoc", lpar);
				        
						//적립 프로시저
						iLOYCommonDAO.callProcPointAcrl(lpar);
						
					} else {
						
						//item table 셋팅
						param.setItemRid(acrlList.getItemRid());
						param.setStatus("F");
						param.setErrorDesc("금일 중복된 프로모션");
						
					}
		        }else {
		        	//item table 셋팅
					param.setItemRid(acrlList.getItemRid());
					param.setStatus("F");
					param.setErrorDesc("회원 미존재");
		        }
				//item table update
		        this.update("LOYBatchRgst.updateUploadItemStatus", param);
			}
			rtnValue.setSuccess(true);
		}catch(Exception e) {
			rtnValue.setSuccess(false);
			e.printStackTrace();
		}
			
		
		return rtnValue;
		
	}*/
	
	
	
	
	
}
