package com.icignal.marketing.contents.mapper;

import java.util.List;

import com.icignal.loyalty.survey.dto.request.LoySurveyListReqDto;
import com.icignal.loyalty.survey.dto.response.LoySurveyListResDto;
import com.icignal.marketing.contents.dto.request.*;
import com.icignal.marketing.contents.dto.response.*;
import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.offer.dto.request.OfferReqDto;
import com.icignal.offer.dto.response.OfferResDto;

/**
	@file ChannelDAO.java
	@date 2015. 9. 21.
	@author 박지열
 */
@Mapper
public interface MktContentMapper {

	/**
	 * @programId : 
	 * @name : insertMerImage
	 * @date : 2015. 9. 21.
	 * @author : dg.ryu
	 * @table : com.image
	 * @return : 
	 * @description : 이미지 병합 후 DB에 Insert
	 */
	public void insertMerImage(MktFileUploadReqDto param);
	
	/**
	 * @programId : 
	 * @name : updateContent
	 * @date : 2015. 9. 21.
	 * @author : dg.ryu
	 * @table : mkt.mkt_conts_mst
	 * @return : 
	 * @description : 컨텐츠 수정
	 */
	public void updateContent(MktContentReqDto param);
	
	/**
	 * @programId : 
	 * @name : insertContent
	 * @date : 2015. 9. 21.
	 * @author : dg.ryu
	 * @table : mkt.mkt_conts_mst
	 * @return : 
	 * @description : 컨텐츠 등록
	 */
	public void insertContent(MktContentReqDto param);
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : removeContent
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 콘첸츠 삭제
	 */
	public void deleteContent(MktContentReqDto mcr);
	
	/**
	 * @programId : MKT_CTE_001
	 * @name : getContent
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 콘텐츠 목록 조회 - 조건 조회를 통한 콘텐츠 목록 조회
	 */
	public List<MktContentListResDto> selectContent(MktContentReqDto mcr);
	
	/**
	 * @programId : MKT_CTE_P05
	 * @name : getContentChlType
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : List<MKTContentResponseDTO>
	 * @description : 콘텐츠 유형 조회 - 신규 버튼 클릭 시 콘텐츠 유형 목록 조회
	 */
	public List<MktContentResDto> selectContentChlType(MktContentReqDto mcr);

	/**
	 * @programId : MKT_CTE_002
	 * @name : selectChannelType
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel (콘텐츠 채널 관계 테이블)
	 * @return : MKTContentChlResponseDTO
	 * @description : 콘텐츠 유형 조회
	 */
	public List<MktContentChlResDto> selectChannelType(MktContentChlReqDto mcr);
	/**
	 * @programId : MKT_CTE_002
	 * @name : getChnnl
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_conts_type_chnl_rel (콘텐츠 채널 관계 테이블)
	 * @return : List<MKTContentChlResponseDTO>
	 * @description : 콘텐츠 유형 조회
	 */
	public List<MktContentChlResDto> selectChnnl(MktContentChlReqDto mcr);

	/**
	 * @programId : MKT_CTE_002
	 * @name : getDeatilContent
	 *
	 *
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : MKTContentResponseDTO
	 * @description : 컨텐츠 상세 조회
	 */
	public MktContentResDto selectDetailContent(MktContentReqDto mcr);

	/**
	 * @programId : MKT_CTE_004
	 * @name : getMmsDtlList
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : MKTContentResponseDTO
	 * @description : MMS 상세 조회
	 */
	public MktMmsDtlResDto selectMmsDtlList(MktMmsDtlReqDto mcr);


	/**
	 * @programId : MKT_CTE_003
	 * @name : getEmailDtlList
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : MKTEmailDtlResponseDTO
	 * @description : 이메일 상세 조회
	 */
	public MktEmailDtlResDto selectEmailDtlList(MktEmailDtlReqDto mcr);

	/**
	 * @programId : MKT_CTE_P02
	 * @name : getPersonalType
	 * @date : 2015. 11. 05.
	 * @author : 박지열
	 * @table : com_code (공통 관리 테이블)
	 * @return : List<MKTPersonalResponseDTO>
	 * @description : 개인화 속성 리스트 전달(Test 발송의 $$회원명$$ 문자와 개인화 속성의 markName값을 비교해서 Table,Colum 등등의 값을 전달)
	 */
	public List<MktCondResDto> selectPersonalType(MktCondReqDto mpr);

    /**
     * @programId :
     * @name : getPushTokenInfo
     * @date : 2018. 2. 15.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public List<MktCondResDto> selectPushTokenInfo(MktCondReqDto mpr);

    /**
     * @programId : MKT_CTE_P02
     * @name : getTranceType
     * @date : 2015. 11. 05.
     * @author : 박지열
     * @table : COM_extr_col (공통 관리 테이블)
     * @return : List<MKTPersonalResponseDTO>
     * @description : 회원 정보를 가져오기 위한 전송 정보 가져오기
     */
	public List<MktgetTranceTypeResDto> selectTranceType(MktgetTranceTypeReqDto mpr);

	/**
	 * @programId : MKT_CTE_P02
	 * @name : getPushInfo
	 * @date : 2015. 11. 05.
	 * @author : 박지열
	 * @table : com_code (공통 관리 테이블)
	 * @return : List<MKTPersonalResponseDTO>
	 * @description : 푸쉬 전송을 위한 푸쉬 정보 가져오기
	 */
	public List<MktCondResDto> selectPushInfo(MktCondReqDto mpr);

	/**
	 * @programId : MKT_CTE_P02
	 * @name : getPersonalType
	 * @date : 2015. 11. 05.
	 * @author : 박지열
	 * @table : member (회원 관리 테이블)
	 * @return : MKTPersonalResponseDTO
	 * @description : 개인화 속성 리스트 전달(Test 발송의 $$회원명$$ 등을 member에서 조회하여 회원 정보를 가져오기.)
	 */
	public MktCondResDto selectPersnalCond(MktCondReqDto mpr);

	/**
	 * @programId : MKT_CTE_003
	 * @name : addfile
	 * @date : 2015. 10. 30.
	 * @author : 박지열
	 * @table : file (파일 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 파일 추가
	 */
	public void insertContentFile(MktFileUploadReqDto adr);

	/**
	 * @programId : MKT_CTE_003
	 * @name : removeContentFile
	 * @date : 2015. 10. 30.
	 * @author : 박지열
	 * @table : com.file (콘텐츠 채널 관계 테이블, 마케팅 채널)
	 * @return : StatusResponseDTO
	 * @description : 파일을 바꿀 시 연결되어 있는 파일 제거
	 */
	public void deleteContentFile(MktFileUploadReqDto mfr);

	/**
	 * @programId : MKT_CTE_002
	 * @name : setBarcode
	 * @date : 2015. 9. 21.
	 * @author : 박지열
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 바코드 추가
	 */
	public MktContentResDto insertBarcode(MktFileUploadReqDto adr);

	/**
	 * @programId : MKT_CHL_P03
	 * @name : getFileUpType
	 * @date : 2015. 11. 16.
	 * @author : 박지열
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<MKTCondResponseDTO>
	 * @description : 해당 채널에 관련된 파일 업로드 타입 반환.
	 */
	public List<MktCondResDto> selectFileUpType(MktContentReqDto mcr);

	/**
	 * @programId : MKT_CTE_P06
	 * @name : selectImageOptionList
	 * @date : 2015. 11. 16.
	 * @author : 박지열
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<MKTImgOptionResponseDTO>
	 * @description : 바코드 생성을 위한 해당 채널에 대한 이미지 옵션을 가져오기.
	 */
	public List<MktImgOptionResDto> selectImageOptionList(MktImgOptionReqDto mior);

	/**
	 * @programId : MKT_CTE_P05
	 * @name : getChnlCodeName
	 * @date : 2015. 11. 16.
	 * @author : 박지열
	 * @table : mkt_chnl (채널 관리 테이블)
	 * @return : MKTCondResponseDTO
	 * @description : Test 발송을 위한 채널 시스템 코드 가져오기.
	 */
	public MktCondResDto selectChnlCodeName(MktCondReqDto mcr);

	/**
	 * @programId : MKT_CTE_002
	 * @name : getPersonalList
	 * @date : 2016. 01. 11.
	 * @author : 박지열
	 * @table : mkt_chnl (채널 관리 테이블)
	 * @return : MKTCondResponseDTO
	 * @description : 개인화 속성 리스트 가져오기
	 */
	public List<MktCondResDto> selectPersonalList(MktCondReqDto mcr);

	/**
	 * @programId : MKT_CTE_002
	 * @name : getChnlId
	 * @date : 2016. 01. 11.
	 * @author : 박지열
	 * @table : mkt_chnl (채널 관리 테이블)
	 * @return : MKTCondResponseDTO
	 * @description : 채널 아이디 가져오기
	 */
	public List<MktChnlResDto> selectChnlId(MktChnlReqDto mcr);

    /**
     * @programId :
     * @name : getChannelByCodeName
     * @date : 2016. 3. 7.
     * @author : "류동균"
     * @table : mkt_chnl
     * @return : MKTContentChlResponseDTO
     * @description : 채널정보 조회
     */
    public MktContentChlResDto selectChannelByCodeName(MktContentChlReqDto mcr);

    /**
     * @programId :
     * @name : getCampaignIdByContentsId
     * @date : 2016. 10. 20.
     * @author : 류동균
     * @table : mkt.mkt_conts_mst, mkt.mkt_conts_chnl_rel, mkt.mkt_cam_mst
     * @return :
     * @description : 캠페인 아이디 조회 By 콘텐츠 아이디
     */
    public String selectCampaignIdByContentsId(String contentsId);

	/**
	 * @name : getFacebookPageInfo
	 * @date : 2017. 5. 2.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : Facebook 페이지 정보 조회
	 */
	public List<MktGetFacebookPageInfoResDto> selectFacebookPageInfo(MktGetFacebookPageInfoReqDto bccr);

	/**
	 * @name : getFacebookDtlList
	 * @date : 2017. 5. 2.
	 * @author : jun.lee
	 * @return : MKTFacebookDtlResponseDTO
	 * @description : Facebook 상세 조회
	 */
	public MktFacebookDtlResDto selectFacebookDtlList(MktFacebookDtlReqDto mcr);

	/**
	 * @name : getFacebookPageInfoById
	 * @date : 2017. 5. 22.
	 * @author : jun.lee
	 * @return : MKTGetFacebookPageInfoResponseDTO
	 * @description : 페이스북 소셜부가정보 조회
	 */
	public MktGetFacebookPageInfoResDto selectFacebookPageInfoById(MktGetFacebookPageInfoReqDto bccr);

	/**
	 * @name : updateFacebookPageInfo
	 * @date : 2017. 5. 22.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 페이스북 페이지 정보 수정
	 */
	public void updateFacebookPageInfo(MktGetFacebookPageInfoReqDto mcr);

	/**
	 * @name : setPostId
	 * @date : 2017. 5. 29.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 포스팅 시, postId 저장
	 */
	public void updatePostId(MktSetPostIdReqDto bccr);

	/**
	 * @name : getFacebookOpenRangeInfo
	 * @date : 2017. 6. 7.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : 페이스북 공개 범위 정보 조회
	 */
	public List<MktGetFacebookOpenRangeInfoResDto> selectFacebookOpenRangeInfo(MktGetFacebookOpenRangeInfoReqDto bccr);

	/**
	 * @name : setRspnsInfo
	 * @date : 2017. 6. 7.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 페이스북 반응정보 수집 등록
	 */
	public void insertRspnsInfo(MktSetRspnsInfoReqDto bccr);
	
	/**
	 * @name : setRspnsInfo
	 * @date : 2017. 6. 7.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 페이스북 반응정보 수집 수정
	 */
	public void updateRspnsInfo(MktSetRspnsInfoReqDto bccr);
	
	/**
	 * @name : setRspnsInfo
	 * @date : 2017. 6. 7.
	 * @author : jun.lee
	 * @return : StatusResponseDTO
	 * @description : 페이스북 반응정보 수집 건수
	 */
	public int selectIsRspnsInfoExist(MktSetRspnsInfoReqDto bccr);

	/**
	 * @name : getAttachmentType
	 * @date : 2017. 7. 5.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : 페이스북 첨부파일 종류 조회
	 */
	public List<MktGetAttachmentTypeResDto> selectAttachmentType(MktGetAttachmentTypeReqDto bccr);

	/**
	 * @name : getInstagramInfo
	 * @date : 2017. 7. 17.
	 * @author : jun.lee
	 * @return : GridPagingResponseDTO
	 * @description : 인스타그램 계정 정보 조회
	 */
	public List<MktGetInstagramInfoResDto> selectInstagramInfo(MktGetInstagramInfoReqDto bccr);

	/**
	 * @name : getInstagramDtlList
	 * @date : 2017. 7. 17.
	 * @author : jun.lee
	 * @return : MKTGetInstagramDtlResponseDTO
	 * @description : 인스타그램 채널 상세 조회
	 */
	public MktGetInstagramDtlResDto selectInstagramDtlList(MktGetInstagramDtlReqDto mcr);

	/**
	 * @name : getInstagramInfoById
	 * @date : 2017. 7. 17.
	 * @author : jun.lee
	 * @return : MKTGetInstagramInfoResponseDTO
	 * @description : id로 인스타그램 계정 정보 조회
	 */
	public MktGetInstagramInfoResDto selectInstagramInfoById(MktGetInstagramInfoReqDto bccr);
	
    /**
     * 개인화 파일 조회
     *
     * @programId :
     * @name : getContsPrsnlFile
     * @date : 2017. 12. 7.
     * @author : jh.kim
     * @description :
     */
    public MktPersnalFileResDto selectContsPrsnlFile(MktPersnalFileReqDto param);

    /**
     * 개인화 등록
     *
     * @programId :
     * @name : addPrsnl
     * @date : 2017. 12. 8.
     * @author : jh.kim
     * @table :
     * @return : StatusResponseDTO
     * @description :
     */
    public void insertPrsnl(MktParsnalEditReqDto param);

    /**
     * 개인화 삭제
     *
     * @programId :
     * @name : removePrsnl
     * @date : 2017. 12. 8.
     * @author : jh.kim
     * @table :
     * @return : StatusResponseDTO
     * @description :
     */
    public void deletePrsnl(MktParsnalEditReqDto param);

    /**
     * 캠페인의 컨텐츠 목록 조회
     *
     * @programId :
     * @name : getDetailContentByCamId
     * @date : 2018. 3. 27.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public List<MktContentListResDto> selectContentListByCamId(MktContentListReqDto param);

    /**
     * 캠페인 채널의 외부 이미지 url 수정
     *
     * @programId :
     * @name : editContsExtrlImgUrl
     * @date : 2018. 3. 27.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public void updateContsExtrlImgUrl(MktContentEditReqDto param);

	/**
	 * @programId :
	 * @name : getChnlGuide
	 * @date : 2018 .09 .18
	 * @author : 금동우
	 * @table : 
	 * @return : MKTMmsDtlResponseDTO
	 * @description : 채널 가이드 조회
	 */
	public MktMmsDtlResDto selectChnlGuide(MktMmsDtlReqDto mcr);
	
	/**
	* @programId :
	* @name : getCallBackNo
	* @date : 2019. 3. 11.
	* @author : dw.keum
	* @table :
	* @return : String
	* @description : SMS 콜백번호 조회
	*/
	public String selectCallBackNo(MktCondReqDto request);

	public MktContentResDto selectImgSize(MktContentReqDto mcr);

	public List<OfferResDto> selectCpnList(OfferReqDto reqDto);

	public List<OfferResDto> getCampaignKeyList(OfferReqDto reqDto);

	public List<OfferResDto> selectRanCpnList(OfferReqDto reqDto);

	public List<OfferResDto> selectPointOfrList(OfferReqDto reqDto);


	public StatusResDto insertContsOfr(OfferReqDto reqDto);

	public int checkContsCamUse(MktContentReqDto mcr);
	
	public int checkContsOpm(MktContentReqDto mcr);
	
	public int checkContsPromUse(MktContentReqDto mcr);
	
	public void insertContsKakao(MktContentReqDto reqDto);
	
	public void insertContsKakaoBtn(MktContentKaKaoReqDto reqDto);

	public void updateContsKakao(MktContentReqDto reqDto);
	
//	public void updateContsKakaoBtn(MktContentKaKaoReqDto reqDto);
	
//	public void deleteContsKakaoBtn(MktContentKaKaoReqDto reqDto);
	
	public void allDeleteContsKakaoBtn(MktContentReqDto reqDto);

	public List<MktContentKaKaoResDto> alreadyContsKakaoBtn(MktContentReqDto reqDto);
	
	public MktContentResDto getDescContsKakao(MktContentReqDto reqDto);

	public MktContentResDto getTestSendDescContsKakao(notiAltTestReqDto reqDto);

	public List<ContentKaKaoResDto> selectTestSendContentBtnKaKao(notiAltTestReqDto reqDto);
	
	public MktContentResDto selectTestSendContentEmail(notiAltTestReqDto reqDto);

	public MktExternalListResDto selectExternal();

	public String selectBrazeCamApiDataForMatching(BrazeCamApiReqDto param);

	public MktExternalListResDto selectExternalCamDetail();

	int insertBrazeCamApiData(BrazeCamApiReqDto param);

	public MktContentResDto selectPhoneNo(MktContentReqDto reqDto);

	public MktContentResDto selectContentOfr(MktContentReqDto reqDto);

	public String selectAuthInfoDescente(String param);

}
