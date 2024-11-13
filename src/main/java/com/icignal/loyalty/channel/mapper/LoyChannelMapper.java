package com.icignal.loyalty.channel.mapper;

import java.util.List;

import com.icignal.loyalty.channel.dto.response.*;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.channel.dto.request.LoyChnlAddInfoDetailResDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlAddInfoReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlChangeHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlDetailReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlInsertChangeHistReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlLoyProgramReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlMasterReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlMbrRelListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlNewDetailReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlPointChangeHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSearchHelpListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSettleMasterReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSettleReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSubTxnHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlTxnHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyProgramListReqDto;
import com.icignal.marketing.storeReport.dto.response.MktStoreReportResDto;


/*
 * 1. 클래스명	: LoyChannelMapper
 * 2. 파일명	: LoyChannelMapper.java
 * 3. 패키지명	: com.icignal.loyalty.channel.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *		기준정보 - 채널 Mapper
 * </PRE>
 */
@Mapper
public interface LoyChannelMapper {


	public List<LoyChnlSearchHelpListReqDto> getChannelSearchHelp(LoyChnlSearchHelpListReqDto param);

	public List<LoyChnlListResDto> getChannelList(LoyChnlListReqDto param);

	public LoyChnlDetailResDto getChannelDetail(LoyChnlDetailResDto param);

	public List<LoyChnlDetailReqDto> getChnlTxnMemList(LoyChnlDetailReqDto param);

	public List<LoyChnlDetailReqDto> getChnlSubList(LoyChnlDetailReqDto param);

	public List<LoyChnlDetailReqDto> getChnlAcrlInfoList(LoyChnlDetailReqDto param);

	public List<LoyChnlDetailReqDto> getChnlRdmInfoList(LoyChnlDetailReqDto param);

	public List<LoyChnlDetailReqDto> getChnlStlInfoList(LoyChnlDetailReqDto param);

	public LoyChnlAddInfoResDto getChnlAddInfo(LoyChnlDetailReqDto param);

	public void editChnlAddInfo(LoyChnlAddInfoReqDto param);

	public void insertChnlChangeHist(LoyChnlInsertChangeHistReqDto histReq);

	public void updateChnlChangePointHist(LoyChnlAddInfoResDto newData);

	public void insertChnlChangePointHist(LoyChnlAddInfoResDto newData);

	public List<LoyChnlChangeHistListReqDto> getChnlChangeHistList(LoyChnlChangeHistListReqDto param);

	public List<LoyChnlPointChangeHistListReqDto> getChnlPointChangeHistList(LoyChnlPointChangeHistListReqDto param);

	public List<LoyChnlTxnHistListReqDto> getChnlTxnHistList(LoyChnlTxnHistListReqDto param);
	
	public Integer getChnlSubTxnHistListCnt(LoyChnlTxnHistListReqDto param);

	public List<LoyChnlSubTxnHistListReqDto> getChnlSubTxnHistList(LoyChnlSubTxnHistListReqDto param);

	public void saveChannelDetail(LoyChnlMasterReqDto param);

	public void editChannelDetail(LoyChnlMasterReqDto param);

	public void removeChannel(LoyChnlMasterReqDto param);

	public LoyChnlDefaultInfoResDto getChannelDefaultInfo(LoyChnlMasterReqDto param);
	
	public void insertChnlMbr(LoyChnlMasterReqDto reqDTO);

	public Integer setChnlMbr(LoyChnlMasterReqDto reqDTO);

	public void removeChnlMbr(LoyChnlMasterReqDto reqDto);

	public LoyChnlDefaultInfoResDto selectStoreCd(LoyChnlMasterReqDto reqDTO);

	public void insertStroeCd(LoyChnlMasterReqDto reqDTO);

	public void updateStoreCd(LoyChnlMasterReqDto reqDTO);

	 /*
	  * 1. 메소드명: selectChnlListPage
	  * 2. 클래스명: LoyChannelMapper
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
	 *   @param param
	 *   @return	
	 */
	
	public List<LoyChannelListPageResDto> selectChnlListPage(LoyChnlSubTxnHistListReqDto param);

	 /*
	  * 1. 메소드명: selectParentChnlTList
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
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
	
	public List<LoyChannelListPageResDto> selectParentChnlTList(LoyChnlReqDto param);

	 /*
	  * 1. 메소드명: selectChnlDetailNew
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
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
	
	public LoyChnlDetailNewResDto selectChnlDetailNew(LoyChnlNewDetailReqDto param);

	 /*
	  * 1. 메소드명: insertChnlDetail
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
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
	
	public void insertChnlDetail(LoyChnlNewDetailReqDto param);

	 /*
	  * 1. 메소드명: updateChnlDetail
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
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
	
	public void updateChnlDetail(LoyChnlNewDetailReqDto param);

	 /*
	  * 1. 메소드명: selectChnlAddInfoDetailNew
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	
	public LoyChnlAddInfoDetailNewResDto selectChnlAddInfoDetailNew(LoyChnlNewDetailReqDto param);

	 /*
	  * 1. 메소드명: updateChnlAddInfoDetail
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	
	public void updateChnlAddInfoDetail(LoyChnlAddInfoDetailResDto param);

	 /*
	  * 1. 메소드명: insertChnlAddInfoDetail
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	
	public void insertChnlAddInfoDetail(LoyChnlAddInfoDetailResDto param);

	 /*
	  * 1. 메소드명: selectChnlLoyPgmList
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
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
	
	public List<LoyChnlLoyPgmListResDto> selectChnlLoyPgmList(LoyChnlReqDto param);

	 /*
	  * 1. 메소드명: selectLoyPgmListNew
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 20.
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
	
	public List<LoyProgramListResDto> selectLoyPgmListNew(LoyProgramListReqDto param);

	 /*
	  * 1. 메소드명: insertChnlLoyPgm
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 20.
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
	
	public void insertChnlLoyPgm(LoyChnlLoyProgramReqDto param);

	 /*
	  * 1. 메소드명: updateChnlLoyPgm
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 20.
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
	
	public void updateChnlLoyPgm(LoyChnlLoyProgramReqDto param);

	 /*
	  * 1. 메소드명: selectLoyPgmDetailNew
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 20.
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
	
	public LoyChnlPgmDetailResDto selectLoyPgmDetailNew(LoyChnlLoyProgramReqDto param);

	 /*
	  * 1. 메소드명: selectChnlMbrRelList
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	
	public List<LoyChnlMbrRelResDto> selectChnlMbrRelList(LoyChnlMbrRelListReqDto param);

	 /*
	  * 1. 메소드명: selectChnlSettleList
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
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
	
	public List<LoyChnlSettleListResDto> selectChnlSettleList(LoyChnlSettleMasterReqDto param);

	 /*
	  * 1. 메소드명: selectChnlLoyPgmListNew
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
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
	
	public List<LoyChnlLoyPgmListResDto> selectChnlLoyPgmListNew(LoyProgramListReqDto param);

	 /*
	  * 1. 메소드명: insertChnlSettle
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
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
	
	public void insertChnlSettle(LoyChnlSettleReqDto param);

	 /*
	  * 1. 메소드명: updateChnlSettle
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
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
	
	public void updateChnlSettle(LoyChnlSettleReqDto param);

	 /*
	  * 1. 메소드명: selectLoyChnlPgmDetailNew
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
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
	
	public LoyChnlSettleResDto selectLoyChnlPgmDetailNew(LoyChnlLoyProgramReqDto param);

	 /*
	  * 1. 메소드명: selectChnlLoyPgmHist
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
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
	
	public List<LoyChnlLoyPgmListResDto> selectChnlLoyPgmHist(LoyProgramListReqDto param);

	 /*
	  * 1. 메소드명: insertChnlLoyPgmHist
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
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
	
	public void insertChnlLoyPgmHist(LoyChnlLoyProgramReqDto param);

	 /*
	  * 1. 메소드명: insertChnlSettleHist
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
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
	
	public void insertChnlSettleHist(LoyChnlSettleReqDto param);

	 /*
	  * 1. 메소드명: selectChnlSettleHist
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
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
	
	public List<LoyChnlSettleListResDto> selectChnlSettleHist(LoyChnlSettleMasterReqDto param);

	 /*
	  * 1. 메소드명: deleteChnlChannel
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 26.
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
	
	public void deleteChnlChannel(LoyChnlReqDto param);

	 /*
	  * 1. 메소드명: deleteChnlLoyPgm
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 26.
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
	
	public void deleteChnlLoyPgm(LoyChnlReqDto param);

	 /*
	  * 1. 메소드명: deleteChnlSettle
	  * 2. 클래스명: LoyChannelMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 26.
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
	
	public void deleteChnlSettle(LoyChnlReqDto param);

	public List<LoyChnlLoyPgmListResDto> selectChnlLoyImgInfoList(LoyChnlReqDto param);

	public List<LoyChnlLoyPgmListResDto> selectLoyImgDesc(LoyChnlReqDto param);

	public void deleteChnlImg(LoyChnlReqDto param);

	public void insertChnlImgInfo(LoyChnlReqDto param);

	public Integer selectChnlImgSeq(LoyChnlReqDto param);

	public void updateImgDetail(LoyChnlReqDto param);

	public String selectChnlImgSeqNo(LoyChnlReqDto param);

	public Integer selectChnlImgIsSeqNo(LoyChnlReqDto param);

	public LoyProgramListResDto selectLoyPgmTopDesc();

	public MktStoreReportResDto selectBrandCode(String empId);

	List<LoyChnlExcelDnDto> selectChnlListExcelDown();

	void updateChnlList(LoyChnlReqDto reqDto);
}
