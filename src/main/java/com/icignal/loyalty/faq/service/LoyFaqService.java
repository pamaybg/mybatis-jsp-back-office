package com.icignal.loyalty.faq.service;

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
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.loyalty.faq.dto.request.LoyFaqDetailReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqInsertReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqListReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqUploadReqDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqDetailResDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqListResDto;
import com.icignal.loyalty.faq.dto.response.LoyFaqUploadResDto;
import com.icignal.loyalty.faq.mapper.LoyFaqMapper;



/**
 * @fileName : LOYNoticeService.java
 * @date : 2017. 03. 20.
 * @author : mjpyo
 * @변경이력 :
 * @descripton : 공지사항 관리
 */
@Service("LOYFaqService")
public class LoyFaqService {

	@Autowired
	private LoyFaqMapper loyFaqMapper;
	
	@Autowired
	AddBatchService addBatchService;
	
	/**
	 * @name : getFAQList
	 * @date : 2017. 03. 27
	 * @author : mjpyo
	 * @description : FAQ 리스트
	 */
	public GridPagingResDto<LoyFaqListResDto> getFAQList(LoyFaqListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lf");
		return new GridPagingResHelper<LoyFaqListResDto>().newGridPagingResDto(
				 reqDTO.init(CommonUtil.getInstance().getDBType()),
	    		 loyFaqMapper.selectFAQList(reqDTO));
	}

	
	/**
	 * @name : insertFaq
	 * @date : 2017. 03. 27
	 * @author : mjpyo
	 * @description : FAQ 등록
	 */
	public StatusResDto insertFaq(LoyFaqInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		StatusResDto rtnValue = new StatusResDto();
		
		if(reqDTO.getUpdateFlag()){
			loyFaqMapper.updateFaq(reqDTO);
			rtnValue.setSuccess(true);
		}
		else{
			loyFaqMapper.insertFaq(reqDTO);
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
		
	}

	 /*
	  * 1. 메소드명: increaseFaqCount
	  * 2. 클래스명: LoyFaqService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public StatusResDto increaseFaqCount(LoyFaqDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		loyFaqMapper.increaseFaqCount(reqDTO);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getFaqDetail
	  * 2. 클래스명: LoyFaqService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public LoyFaqDetailResDto getFaqDetail(LoyFaqDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lf");
		return loyFaqMapper.selectFaqDetail(reqDTO);
	}


	
	/**
	 * @name : insertMasterFaq
	 * @date : 2017. 04. 06
	 * @author : mjpyo
	 * @description : FAQ 마스터 등록
	 */
	public StatusResDto insertMasterFaq(LoyFaqInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		
		StatusResDto rtnValue = new StatusResDto();

		if(reqDTO.getFaqStatus().equals("true")){
			reqDTO.setFaqStatus("Y");
		}
		else{
			reqDTO.setFaqStatus("N");
		}
		
		if(reqDTO.getUpdateFlag()){
			loyFaqMapper.updateMasterFaq(reqDTO);
			rtnValue.setSuccess(true);
		}
		else{
			loyFaqMapper.insertMasterFaq(reqDTO);
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
	}



	/**
	 * @name : getFaqMasterDetail
	 * @date : 2017. 04. 06
	 * @author : mjpyo
	 * @description : FAQ 마스터 상세
	 */
	public LoyFaqDetailResDto getFaqMasterDetail(LoyFaqDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lfm");
		return loyFaqMapper.selectFaqMasterDetail(reqDTO);
	}


	/**
	* @programId :
	* @name : removeFaq
	* @date : 2019. 7. 24.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description : FAQ 삭제
	*/
	public StatusResDto removeFaq(LoyFaqInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyFaqMapper.removeMainFaq(reqDTO);
		loyFaqMapper.removeSubFaq(reqDTO);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	* @programId :
	* @name : FaqUploadData
	* @date : 2019. 11. 28.
	* @author : hr.noh
	* @table :
	* @return : 
	* @description : FAQ 엑셀 업로드
	*/
	public StatusResDto FaqUploadData(LoyFaqUploadReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyFaqMapper.updateFaqGrid(reqDto);
		loyFaqMapper.updateFaqMasterGrid(reqDto);
		rtnValue.setSuccess(true);
		
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		List<Map<Integer,Object>> params2 = new ArrayList<Map<Integer,Object>>();
		Map<Integer, String> selectRid  = new HashMap<Integer, String>();
		LogUtil.param(this.getClass(), reqDto);
		int ridCnt = 0;
		StatusResDto rtnValue2 = new StatusResDto();


		rtnValue2.setSuccess(false);
		StringBuffer sql = new StringBuffer();
		sql.append("insert into loy.loy_faq_master")
		   .append("(")
		   .append(" rid")
		   .append(", FAQ_TYPE")
		   .append(", SEQ")
		   .append(", faq_master_name")
		   .append(", OPEN_DATE")
		   .append(", exposure_yn")
		   .append(", CREATE_DATE")
		   .append(", CREATE_BY")
		   .append(", MODIFY_DATE")
		   .append(", MODIFY_BY")
		   .append(", COUNTRY")
		   .append(", LANG")
		   .append(") values (")
		   .append("  ?")
		   .append(", ?")
		   .append(", ?")
		   .append(", ?")
		   .append(", ?")
		   .append(", ?")
		   .append(", sysdate")
		   .append(", ?")
		   .append(", sysdate")
		   .append(", ?")
		   .append(", 'KR'")
		   .append(", 'ko'")
		   .append(")");
		
		for(LoyFaqUploadReqDto lplr : reqDto.getArray()) {
			String rid = CommonUtil.newRid();
			//lplr.setRid(rid);
			//LOYFaqUploadResponseDTO rtnCnt = (LOYFaqUploadResponseDTO) this.queryForObject(LOYFaqUploadResponseDTO.class, "LOYProd.prodValidCnt", lplr.getRid(), false);
			selectRid.put(ridCnt++, rid);
			//if(0 == rtnCnt.getCnt()) {
				int idx = 1;
				Map<Integer,Object> param = new HashMap<Integer,Object>();
				param.put(idx++, rid);
				param.put(idx++, lplr.getFaqType());
				param.put(idx++, lplr.getSeq());
				param.put(idx++, lplr.getFaqNm());
				param.put(idx++, lplr.getOpenDate());
				param.put(idx++, lplr.getFaqStatus());
				param.put(idx++, reqDto.getCreateBy());
				param.put(idx++, reqDto.getModifyBy());
				params.add(param);
				
			//}
		}
		
		addBatchService.addBatch(sql.toString(), params);

		//String Buffer 초기화
		//sql.setLength(0);
		StringBuffer sql2 = new StringBuffer();
		
		sql2.append("insert into loy.loy_faq")
		    .append("(")
		    .append(" rid")
		    .append(", FAQ_NM")
		    .append(", faq_detail")
		    .append(", MOD_NUM")
		    .append(", CREATE_DATE")
		    .append(", CREATE_BY")
		    .append(", MODIFY_DATE")
		    .append(", MODIFY_BY")
		    .append(", FAQ_MASTER_RID")
		    .append(", FLAG")
		    .append(", COUNTRY")
		    .append(", LANG")
		    .append(", FAQ_LANG")
		    .append(") values (")
		    .append("  ?")
		    .append(", ?")
		    .append(", ?")
		    .append(", 0")
		    .append(", sysdate")
		    .append(", ?")
		    .append(", sysdate")
		    .append(", ?")
		    .append(", ?")
		    .append(", 1")
		    .append(", 'KR'")
		    .append(", 'ko'")
		    .append(", 'ko'")
		    .append(")");
		
		ridCnt = 0;
		for(LoyFaqUploadReqDto lplr : reqDto.getArray()) {

			//lplr.setRid(rid);

				int idx = 1;
				Map<Integer,Object> param = new HashMap<Integer,Object>();
				param.put(idx++, UUID.randomUUID().toString().replace("-", ""));
				param.put(idx++, lplr.getFaqNm());
				param.put(idx++, lplr.getFaqDesc());
				param.put(idx++, reqDto.getCreateBy());
				param.put(idx++, reqDto.getModifyBy());
				param.put(idx++, selectRid.get(ridCnt));
				params2.add(param);
				ridCnt++;
			
		}
		addBatchService.addBatch(sql2.toString(), params2);
		rtnValue2.setSuccess(true);
		return rtnValue2;
	}

	/**
	* @programId :
	* @name : faqExcelDownload
	* @date : 2019. 11. 28.
	* @author : hr.noh
	* @table :
	* @return : LOYFaqUploadRequestDTO
	* @description : FAQ 전체 엑셀다운
	*/
	public GridPagingResDto<LoyFaqUploadResDto>  getFaqDetailList(LoyFaqUploadReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyFaqUploadResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyFaqMapper.selectFaqDetailList(reqDto));
	}

	

	/**
	* @programId :
	* @name : faqExcelDownloadGrid
	* @date : 2019. 12. 02.
	* @author : hr.noh
	* @table :
	* @return : LOYFaqUploadRequestDTO
	* @description : FAQ 전체 다운로드하기위한 리스트
	*/
	public GridPagingResDto<LoyFaqUploadResDto> getfaqExcelDownList(LoyFaqUploadReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyFaqUploadResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyFaqMapper.selectFaqDetailList(reqDto));
	}

}