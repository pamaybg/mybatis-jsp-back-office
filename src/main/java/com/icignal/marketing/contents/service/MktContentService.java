package com.icignal.marketing.contents.service;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import com.icignal.common.tranChnl.dto.TranChnlPushDto;
import com.icignal.common.tranChnl.mapper.TranChnlEshopMapper;
import com.icignal.common.tranChnl.mapper.TranChnlMapper;
import com.icignal.common.tranChnl.model.TranChnlDto;
import com.icignal.marketing.campaign.dto.request.MktCampaignReqDto;
import com.icignal.marketing.campaign.mapper.MktCampaignEshopMapper;
import com.icignal.marketing.contents.dto.request.*;
import com.icignal.marketing.contents.dto.response.*;
import org.apache.commons.lang3.tuple.Pair;
import org.brunocvcunha.instagram4j.Instagram4j;
import org.brunocvcunha.instagram4j.requests.InstagramUploadPhotoRequest;
import org.brunocvcunha.instagram4j.requests.InstagramUploadVideoRequest;
import org.brunocvcunha.instagram4j.requests.payload.InstagramConfigurePhotoResult;
import org.brunocvcunha.instagram4j.requests.payload.StatusResult;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.base.dto.request.FileReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.response.FileUploadResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.MultiUploadResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.dto.response.TempUploadResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.base.service.EnDeCryptedService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.tranChnl.dto.request.TranChnlReqDto;
import com.icignal.common.tranChnl.service.TranChnlService;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.common.util.CommonUtil.MKT_CAM_CHNL_TYPE_CD;
import com.icignal.common.util.ImageUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.external.aws.SesManager;
import com.icignal.external.aws.dto.request.AwsSesManagerReqDto;
import com.icignal.external.ftpservice.service.FtpService;
import com.icignal.marketing.campaign.dto.response.MktCampaignImportPrsnlValResDto;
import com.icignal.marketing.contents.controller.MktContentController;
import com.icignal.marketing.contents.mapper.MktContentMapper;
import com.icignal.offer.dto.request.OfferReqDto;
import com.icignal.offer.dto.response.OfferResDto;
import com.opencsv.CSVReader;

import static com.icignal.common.util.CommonUtil.MKT_CAM_CHNL_TYPE_CD.*;


/**
 * @author : 박지열
 * @name : com.icignal.marketing.contents.service.impl.MKTContentService
 * @date : 2015. 9. 21.
 * @description :
 */
@Service
public class MktContentService {

    @Autowired
    private MktContentMapper mktContentMapper;

    @Autowired
    private CommonService commonService;

    @Autowired
    private MKTCallQueryDao mktCallQueryDao;

    @Autowired
    private StandardPBEStringEncryptor encryptor;

    @Autowired
    private TranChnlService tranChnlService;

    @Autowired
    private FtpService ftpService;

    @Autowired
    AddBatchService addBatchService;

    @Autowired
    TranChnlMapper tranChnlMapper;

    @Autowired
    TranChnlEshopMapper tranChnlEshopMapper;

    @Autowired
    private MktCampaignEshopMapper mktCampaignEshopMapper;

    /**
     * @return : List<MKTTemplateListResponseDTO>
     * @programId : MKT_CTE_002
     * @name : setContent
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 콘첸츠 추가 - 유형 선택 후 콘텐츠를 추가
     */

    public StatusResDto setContent(HttpSession session, MktContentReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        //머지 이미지
        MktFileUploadReqDto request = new MktFileUploadReqDto();

        //리사이징 이미지
        MktFileUploadReqDto resizingReq = new MktFileUploadReqDto();

        //현재 채널에 세팅되어 잇는 이미지의 옵션 값 가져오기
//		MKTImgOptionRequestDTO ImageOption = new MKTImgOptionRequestDTO();

        StatusResDto rtnValue = new StatusResDto();

        //게시물 예약 설정
        if (mcr.getPostDate() != null) {
            mcr.setReservePost(mcr.getPostDate().replace("-", "") + mcr.getPostTime().replace(":", ""));
        }

        rtnValue = addContent(mcr, request, resizingReq);

        if (rtnValue.getSuccess() && mcr.getSubImages() != null && mcr.getSubImages().size() > 0) {
            MultiUploadReqDto muReqSub = new MultiUploadReqDto();
            muReqSub.setParentId(rtnValue.getMessage());
            muReqSub.setCategory(IMAGE_UPLOAD_TYPE.USERCONTS);
            muReqSub.setFileName(mcr.getSubImageFileNames());
            muReqSub.setFilePath(mcr.getSubImageFilePaths());
            muReqSub.setOriName(mcr.getSubImageOriNames());
            muReqSub.setRotateAngle(mcr.getSubImageRotateAngles());
            muReqSub.setSchemas("com");
            muReqSub.setLang(mcr.getLang());

            //MultiUploadResDto mur =
            commonService.multiUploadImage(session.getServletContext().getRealPath("/"), session.getId(), muReqSub);
        }

        return rtnValue;
    }

    /**
     * @return : StatusResponseDTO
     * @programId : MKT_CTE_002
     * @name : setContent
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 콘첸츠 추가 - 유형 선택 후 콘텐츠를 추가
     */
    public StatusResDto addContent(MktContentReqDto mcr, MktFileUploadReqDto mfr, MktFileUploadReqDto mfrreq) {
        LogUtil.param(this.getClass(), mcr);

        String memId = mcr.getMemId();

        StatusResDto rtnValue = new StatusResDto(false, "");
        mcr.setId(commonService.getRowID());
        mcr.setSVCAlias("mc");

        mfr.setId(commonService.getRowID());
        mfr.setMemId(memId);
        mfr.setSVCAlias("");

        mfrreq.setId(commonService.getRowID());
        mfrreq.setMemId(memId);

        if (mfrreq.getPath() != null) {
            mktContentMapper.insertMerImage(mfrreq);

            mcr.setImageId(mfrreq.getId());
            mcr.setImgId(mfrreq.getId());
        }

        //바코드와 이미지가 있는지 파악하여 분기 태우기.
        if (mfr.getPath() != null) {
            mktContentMapper.insertMerImage(mfr);
            mcr.setMerId(mfr.getId());
        } else if (mcr.getImgBarCnt() == 0) {
            mcr.setMerId(mcr.getImgId());
        } else if (mcr.getImgCnt() == 0) {
            mcr.setMerId(mcr.getBarId());
        } else {
            mcr.setMerId("");
        }

        // 컨텐츠 등록
        mktContentMapper.insertContent(mcr);
        rtnValue.setMessage(mcr.getId());
        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : List<MKTTemplateListResponseDTO>
     * @throws IOException
     * @programId : MKT_CTE_002
     * @name : editResponseContent
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 콘첸츠 수정 - 콘텐츠를 선택하고 들어온 뒤 수정
     */

    public StatusResDto editResponseContent(HttpSession session, MktContentReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        StatusResDto rtnValue = new StatusResDto();

        MktFileUploadReqDto request = new MktFileUploadReqDto();
        MktFileUploadReqDto resizingReq = new MktFileUploadReqDto();

        MktContentResDto ofrCheckData = mktContentMapper.selectContentOfr(mcr);

        if(StringUtil.isNotEmpty(ofrCheckData)) {
            if(StringUtil.isNotEmpty(mcr.getRidOfr())) {
                if (!ofrCheckData.getRidOfr().equals(mcr.getRidOfr())) {
//                    MktCampaignReqDto param = new MktCampaignReqDto();
//                    param.setId(ofrCheckData.getId());
//
//                    if (ofrCheckData.getComOfrType().equals("C")) {
//                        param.setOfferTableName("ESHOPUSER.TB_IF_CRM_CPN");
//                    } else if (ofrCheckData.getComOfrType().equals("P")) {
//                        param.setOfferTableName("ESHOPUSER.TB_IF_CRM_POINT");
//                    }
//
//                    if (mktCampaignEshopMapper.selectOfferDataIsNull(param) > 0) {
                        rtnValue.setSuccess(false);
                        rtnValue.setMessage("승인완료 된 캠페인에서 사용된 컨텐츠의 오퍼는 변경할 수 없습니다.");
                        return rtnValue;
//                    }
                }
            } else {
                rtnValue.setSuccess(false);
                rtnValue.setMessage("승인완료 된 캠페인에서 사용된 컨텐츠의 오퍼는 변경할 수 없습니다.");
                return rtnValue;
            }
        }

        //게시물 예약 설정
        if (mcr.getPostDate() != null) {
            mcr.setReservePost(mcr.getPostDate().replace("-", "") + mcr.getPostTime().replace(":", ""));
        }

        if (ObjectUtil.isNotEmpty(mcr.getSubImages())) {
            MultiUploadReqDto muReqSub = new MultiUploadReqDto();
            muReqSub.setParentId(mcr.getId());
            muReqSub.setCategory(IMAGE_UPLOAD_TYPE.USERCONTS);
            muReqSub.setFileName(mcr.getSubImageFileNames());
            muReqSub.setOriName(mcr.getSubImageOriNames());
            muReqSub.setFilePath(mcr.getSubImageFilePaths());
            muReqSub.setRotateAngle(mcr.getSubImageRotateAngles());

            muReqSub.setSchemas("com");
            muReqSub.setLang(mcr.getLang());

            MultiUploadResDto mur = commonService.multiUploadImage(session.getServletContext().getRealPath("/"), session.getId(), muReqSub);

            rtnValue.setSuccess(mur.getSuccess());
        } else {
            MultiUploadReqDto muReqSub = new MultiUploadReqDto();
            muReqSub.setParentId(mcr.getId());
            muReqSub.setCategory(IMAGE_UPLOAD_TYPE.USERCONTS);
            muReqSub.setFileName(mcr.getSubImageFileNames());
            muReqSub.setRotateAngle(mcr.getSubImageRotateAngles());

            muReqSub.setSchemas("com");
            muReqSub.setLang(mcr.getLang());
            List<String> orgImages = commonService.getParentImages(muReqSub);

            for (String imgUrl : orgImages) {
                ImageUtil.deleteMImageFiles(session.getServletContext().getRealPath("/"), imgUrl);
            }
        }

        return editResponseContent(mcr, request, resizingReq);
    }

    /**
     * @return : StatusResponseDTO
     * @programId : MKT_CTE_002
     * @name : editResponseContent
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 콘첸츠 수정 - 콘텐츠를 선택하고 들어온 뒤 수정
     */
    public StatusResDto editResponseContent(MktContentReqDto mcr, MktFileUploadReqDto mfr, MktFileUploadReqDto mfrreq) {
        LogUtil.param(this.getClass(), mcr);

        String memId = mcr.getMemId();

        StatusResDto rtnValue = new StatusResDto(false, "");
        mcr.setSVCAlias("");

        mfr.setId(commonService.getRowID());
        mfr.setMemId(memId);
        mfr.setSVCAlias("");

        mfrreq.setId(commonService.getRowID());
        mfrreq.setMemId(memId);

        if (mfrreq.getPath() != null) {
            mktContentMapper.insertMerImage(mfrreq);
            mcr.setImageId(mfrreq.getId());
            mcr.setImgId(mfrreq.getId());
        }

        //바코드와 이미지가 있는지 파악하여 분기 태우기.
        if (mfr.getPath() != null) {
            mktContentMapper.insertMerImage(mfr);
            mcr.setMerId(mfr.getId());
        } else if (mcr.getImgBarCnt() == 0) {
            mcr.setMerId(mcr.getImgId());
            mcr.setBarId("");
        } else if (mcr.getImgCnt() == 0) {
            mcr.setImgId("");
            mcr.setSubImgId("");
            mcr.setMerId(mcr.getBarId());
        } else {
            mcr.setMerId("");
        }

        mktContentMapper.updateContent(mcr);

        rtnValue.setSuccess(true);
        rtnValue.setMessage(memId);

        return rtnValue;
    }


    /**
     * @return : List<MKTTemplateListResponseDTO>
     * @programId : MKT_CTE_002
     * @name : removeContent
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 콘첸츠 삭제
     */

    public StatusResDto removeContent(MktContentReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        //캠페인
        int cnt = mktContentMapper.checkContsCamUse(mcr);
        //운영정책
        int cntOpm = mktContentMapper.checkContsOpm(mcr);
        //프로모션
        int cntProm = mktContentMapper.checkContsPromUse(mcr);

        if (cnt < 1 && cntOpm < 1 && cntProm < 1) {
            mktContentMapper.deleteContent(mcr);
            rtnValue.setSuccess(true);
            rtnValue.setMessage("삭제되었습니다.");
        } else {
            if (cnt > 0) rtnValue.setMessage("선택한 컨텐츠는 캠페인에서 사용중이므로 삭제할 수 없습니다.");
            if (cntOpm > 0) rtnValue.setMessage("선택한 컨텐츠는 운영정책에서 사용중이므로 삭제할 수 없습니다.");
            if (cntProm > 0) rtnValue.setMessage("선택한 컨텐츠는 프로모션에서 사용중이므로 삭제할 수 없습니다.");
            if (cnt > 0 && cntOpm > 0) rtnValue.setMessage("선택한 컨텐츠는 캠페인,운영정책에서 사용중이므로 삭제할 수 없습니다.");
            if (cnt > 0 && cntProm > 0) rtnValue.setMessage("선택한 컨텐츠는 캠페인,프로모션에서 사용중이므로 삭제할 수 없습니다.");
            if (cntProm > 0 && cntOpm > 0) rtnValue.setMessage("선택한 컨텐츠는 프로모션,운영정책에서 사용중이므로 삭제할 수 없습니다.");
            if (cnt > 0 && cntProm > 0 && cntOpm > 0) rtnValue.setMessage("선택한 컨텐츠는 캠페인,프로모션 및 운영정책에서 사용중이므로 삭제할 수 없습니다.");

            rtnValue.setSuccess(true);
        }


        return rtnValue;
    }


    /**
     * @return : List<MKTTemplateListResponseDTO>
     * @programId : MKT_CTE_001
     * @name : getContent
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 콘텐츠 목록 조회 - 조건 조회를 통한 콘텐츠 목록 조회
     */

    public GridPagingResDto<MktContentListResDto> getContent(MktContentReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktContentListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktContentMapper.selectContent(param), AnnotationType.CommCode);
    }

    /**
     * @return : List<MKTTemplateListResponseDTO>
     * @programId : MKT_CTE_P05
     * @name : getContentChlType
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 콘텐츠 유형 조회 - 신규 버튼 클릭 시 콘텐츠 유형 목록 조회
     */
    public List<MktContentResDto> getContentChlType(MktContentReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectContentChlType(mcr);
    }


    /**
     * @return : MKTContentResponseDTO
     * @programId : MKT_CTE_002
     * @name : getDeatilContent
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 컨텐츠 상세 조회
     */
    public MktContentResDto getDetailContent(MktContentReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectDetailContent(mcr);
    }

    /**
     * @return : MKTContentResponseDTO
     * @programId : MKT_CTE_004
     * @name : getMmsDtlList
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : MMS 상세 조회
     */
    public MktMmsDtlResDto getMmsDtlList(MktMmsDtlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectMmsDtlList(mcr);
    }


    /**
     * @return : MKTEmailDtlResponseDTO
     * @programId : MKT_CTE_003
     * @name : getEmailDtlList
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 이메일 상세 조회
     */
    public MktEmailDtlResDto getEmailDtlList(MktEmailDtlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectEmailDtlList(mcr);
    }

    /**
     * @return : List<MKTContentChlResponseDTO>
     * @programId : MKT_CTE_002
     * @name : getChannelType
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_conts_type_chnl_rel (콘텐츠 채널 관계 테이블)
     * @description : 채널 유형 조회
     */
    public List<MktContentChlResDto> getChannelType(MktContentChlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectChannelType(mcr);
    }

    /**
     * @return : List<MKTContentChlResponseDTO>
     * @programId : MKT_CTE_002
     * @name : getChnnl
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_conts_type_chnl_rel,mkt_chnl (콘텐츠 채널 관계 테이블, 마케팅 채널)
     * @description : 콘텐츠에 따른 등록한 채널 조회
     */
    public List<MktContentChlResDto> getChnnl(MktContentChlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectChnnl(mcr);
    }

    /**
     * @return : List<MKTContentChlResponseDTO>
     * @programId : MKT_CTE_003
     * @name : deleteContentFile
     * @date : 2015. 10. 30.
     * @author : 박지열
     * @table : mkt_conts_type_chnl_rel,mkt_chnl (콘텐츠 채널 관계 테이블, 마케팅 채널)
     * @description : 파일을 바꿀 시 연결되어 있는 파일 제거
     */
    public StatusResDto removeContentFile(MktFileUploadReqDto mcr) {
        LogUtil.param(MktContentController.class, mcr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        mktContentMapper.deleteContentFile(mcr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @param
     * @return : GridPagingResDto
     * @programId : MKT_CTE_002
     * @name : getContenttypeList
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_contents (콘텐츠 관리 테이블)
     * @description : 이미지 넣기
     */
    public StatusResDto addImage(String empId, String ralpath, String sessionId, MultipartFile file) {

        StatusResDto rtnValue = new StatusResDto();

        //임시 업로드
        List<TempUploadResDto> tempUploadList = commonService.tempUpload(ralpath, sessionId, file);

        //임시파일 업로드 여부 확인
        if (ObjectUtil.isNotEmpty(tempUploadList)) {
            MultiUploadReqDto muReqSub = new MultiUploadReqDto();

            //파일명, 원본파일명 목록 (콤마 구분)
            StringBuilder fileName = new StringBuilder();
            StringBuilder oriName = new StringBuilder();
            StringBuilder filePath = new StringBuilder();

            for (TempUploadResDto tempUpload : tempUploadList) {
                fileName.append(tempUpload.getName());
                fileName.append(",");

                oriName.append(tempUpload.getOriName());
                oriName.append(",");

                filePath.append(tempUpload.getUrl());
                filePath.append(",");
            }

            String fileNames = fileName.length() > 0 ? fileName.substring(0, fileName.length() - 1) : "";
            String oriNames = oriName.length() > 0 ? oriName.substring(0, oriName.length() - 1) : "";
            String filePaths = filePath.length() > 0 ? filePath.substring(0, filePath.length() - 1) : "";

            muReqSub.setCategory(IMAGE_UPLOAD_TYPE.CAMPAIGN);
            muReqSub.setFileName(fileNames);
            muReqSub.setOriName(oriNames);
            muReqSub.setFilePath(filePaths);
            muReqSub.setRotateAngle("0");
            muReqSub.setSchemas("com");
            muReqSub.setSize(file.getSize());
            muReqSub.setEmpId(empId);

            //이미지 업로드
            MultiUploadResDto mur = commonService.multiUploadImage(ralpath, sessionId, muReqSub);
            rtnValue.setSuccess(mur.getSuccess());
        }

        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @programId : MKT_CTE_003
     * @name : addfile
     * @date : 2015. 10. 30.
     * @author : 박지열
     * @table : file (파일 관리 테이블)
     * @description : 파일 추가
     */
    public StatusResDto addfile(MktFileUploadReqDto adr, String realPath, HttpSession session) {
        LogUtil.param(this.getClass(), adr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        Calendar cl = Calendar.getInstance();
        int year = cl.get(Calendar.YEAR);
        int month = cl.get(Calendar.MONTH) + 1;
        int day = cl.get(Calendar.DATE);

        File orgFile = new File(realPath + File.separator + BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadUrl") + year + File.separator + month + File.separator + day + File.separator + session.getId() + File.separator + adr.getFileName());

        InputStream input = null;
        OutputStream output = null;

        String commCodeType = "PDF";
        //mktContentMapper.getFileTypeCommcode(adr.getFileType());

        File yearDic = new File(realPath + File.separator + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + File.separator + commCodeType + File.separator + year);
        if (!yearDic.isDirectory()) {
            yearDic.mkdirs();
        }

        File monthDic = new File(yearDic.getAbsolutePath() + File.separator + month);
        if (!monthDic.isDirectory()) {
            monthDic.mkdirs();
        }

        File dayDic = new File(monthDic.getAbsolutePath() + File.separator + day);
        if (!dayDic.isDirectory()) {
            dayDic.mkdirs();
        }

        try {
            input = new FileInputStream(orgFile.getAbsolutePath());
            //adr.setFilePath(dayDic.getAbsolutePath()+File.separator+adr.getFileName());
            //실제파일명으로 저장
            adr.setFilePath(dayDic.getAbsolutePath() + File.separator + adr.getRealfileName());
            output = new FileOutputStream(adr.getFilePath());
            byte[] buf = new byte[1024];
            int bytesRead;

            while ((bytesRead = input.read(buf)) > 0) {
                output.write(buf, 0, (char) bytesRead);
            }

        } catch (IOException e) {
            LogUtil.debug(e.getMessage());
        } finally {
            try {
                if (input != null) {
                    input.close();
                }

                if (output != null) {
                    output.close();
                }

            } catch (IOException e) {

                LogUtil.error(e);
            }
        }

        if (input != null) {
            String realDirs = adr.getFilePath().substring(realPath.length());
            realDirs = realDirs.substring(0, realDirs.lastIndexOf(File.separator.toString()) + 1);

            adr.setFilePath(realDirs);
            adr.setExtension(adr.getFileName().substring(adr.getFileName().lastIndexOf(".") + 1));
            adr.setFileName(adr.getRealfileName().substring(0, adr.getRealfileName().lastIndexOf(".")));
            orgFile.delete();

            adr.setId(commonService.getRowID());

            mktContentMapper.insertContentFile(adr);

            //rtnValue.setMessage(adr.getId());
            //rtnValue.setSuccess(true);
        }

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @programId : MKT_CTE_P02
     * @name : sendChannelTest
     * @date : 2015. 11. 05.
     * @author : 박지열
     * @table : mst_conts_mst (콘텐츠 마스터 테이블)
     * @description : sms Test 발송
     */
    public StatusResDto sendChannelTest(MktContentReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        StatusResDto resDto = new StatusResDto(false, "");

        String messageTitle = Optional.ofNullable(reqDto.getTitle()).orElse("");
        String messageBody = Optional.ofNullable(reqDto.getContents()).orElse("");
        if ("".equals(messageTitle) && "".equals(messageBody)) {
            resDto.setMessage("제목 혹은 상세내용이 있어야 합니다.");
            return resDto;
        }

        List<MktSendTestTargetReqDto> sendTargetList = reqDto.getPhoneArr();
        if (sendTargetList == null || sendTargetList.isEmpty()) {
            resDto.setMessage("발송 대상 목록이 존재해야합니다.");
            return resDto;
        }

        MktCondReqDto condReqDto = new MktCondReqDto();
        condReqDto.setSystemColumn(reqDto.getSystemColumn());

        List<String> denialList = Arrays.asList(SMS.name(), MMS.name(), LMS.name());
        String contentType = reqDto.getContentsType();
        if (denialList.contains(contentType)) {
            messageBody += "\n" + reqDto.getDenial();
        }

        String senderInfo = reqDto.getSenderInfo();
        if (senderInfo == null || senderInfo.isEmpty()) {
            //reqDto.setSenderInfo(this.mktContentMapper.selectCallBackNo(condReqDto));
        }

        List<MktCondResDto> personalResList = this.mktContentMapper.selectPersonalType(condReqDto);

        String encryptType = BeansUtil.getApplicationProperty("icignal.security.endecrytped.endecrypted");
        String dataKey = BeansUtil.getDbEncryptDataKey();
        EnDeCryptedService cryptService = (EnDeCryptedService) BeansUtil.getBean("enDeCryptedService");

        StringBuilder resultMessage = new StringBuilder();
        boolean firstFlag = true;


        String fileName = "";
        Pair<String, Long> filePair = Pair.of("", 0L);

        for (MktSendTestTargetReqDto sendTargetDto : sendTargetList) {

            messageTitle = Optional.ofNullable(reqDto.getTitle()).orElse("");
            messageBody = Optional.ofNullable(reqDto.getContents()).orElse("");

            if (denialList.contains(contentType)) {
                messageBody += "\n" + reqDto.getDenial();
            }

            MktCampaignImportPrsnlValResDto psrnlValRes = new MktCampaignImportPrsnlValResDto();

            TranChnlReqDto tranChnlReq = new TranChnlReqDto();
            tranChnlReq.setSystemColumn(reqDto.getSystemColumn());
            tranChnlReq.setCamId(this.commonService.getRowID());

            int personalCount = 0;


            for (MktCondResDto personalDto : personalResList) {
                String checkValue = String.format("{{%s}}", personalDto.getMarkName());

                if (messageTitle.contains(checkValue) || messageBody.contains(checkValue) || "MBR_NO".equals(personalDto.getColName())) {
                    String columnName = StringUtil.isNotEmpty(personalDto.getCondCalmt())
                            ? personalDto.getCondCalmt()
                            : personalDto.getColName();

                    String personalValue = "";
                    String memId = "";

                    if ("PRSNL_VAL01".equals(columnName)) personalValue = psrnlValRes.getPrsnlVal01();
                    else if ("PRSNL_VAL02".equals(columnName)) personalValue = psrnlValRes.getPrsnlVal02();
                    else if ("PRSNL_VAL03".equals(columnName)) personalValue = psrnlValRes.getPrsnlVal03();
                    else if ("PRSNL_VAL04".equals(columnName)) personalValue = psrnlValRes.getPrsnlVal04();
                    else if ("PRSNL_VAL05".equals(columnName)) personalValue = psrnlValRes.getPrsnlVal05();
                    else if ("CPN_NO".equals(columnName)) personalValue = "00000000000000";
                    else if ("SURVEY_URL".equals(columnName)) personalValue = "https://images.descentekorea.co.kr/crm/survey/dev/index.html";
                    else {
                        String keyColumnName = String.format(
                                ", %s as \"memId\"",
                                ObjectUtil.isNotEmpty(personalDto.getSchMemId())
                                        ? personalDto.getSchMemId()
                                        : ""
                        );

                        StringBuilder sqlBuilder = new StringBuilder()
                                .append(String.format("select top 1 %s as \"value\" %s", columnName, keyColumnName))
                                .append(String.format(" from %s.%s", personalDto.getSchName(), personalDto.getTblName()));

                        try {
                            String encryptedData = "Java".equals(encryptType)
                                    ? SecurityUtil.encodeDbAES256(dataKey, sendTargetDto.getPhone())
                                    : cryptService.getDbEncrypted(sendTargetDto.getPhone());

                            String memberName = "Java".equals(encryptType)
                                    ? SecurityUtil.encodeDbAES256(dataKey, sendTargetDto.getMemName())
                                    : cryptService.getDbEncrypted(sendTargetDto.getMemName());

                            if (EMAIL.name().equals(contentType)) {
                                sqlBuilder.append(String.format(" where %s = '%s'", personalDto.getSchEmail(), encryptedData));
                            } else if (PUSH.name().equals(contentType)) {
                                sqlBuilder.append(String.format(" where %s = '%s'", personalDto.getSchMemId(), encryptedData));
                            } else {
                                sqlBuilder.append(String.format(" where %s = '%s'", personalDto.getSchPhone(), encryptedData));
                            }
//							sqlBuilder.append(String.format(" and %s = '%s'", "CUST_NM", memberName));
                            sqlBuilder.append(" and CUST_TYPE_CD = 'I'");
                        } catch (Exception e) {
                            LogUtil.error(e);
                        }

                        MKTDBInfoDTO dbInfoDto = new MKTDBInfoDTO();
                        dbInfoDto.setDriverClassName(personalDto.getClassNm());
                        dbInfoDto.setConIp(personalDto.getConIp());
                        dbInfoDto.setConPort(personalDto.getConPort());
                        dbInfoDto.setUserName(personalDto.getConId());
                        dbInfoDto.setPassword(personalDto.getConPw());
                        dbInfoDto.setUrl(personalDto.getConUrl());
                        dbInfoDto.setConDbType(personalDto.getConDbType());
                        dbInfoDto.setSecretNm(personalDto.getSecretNm());
                        dbInfoDto = this.getDbInfo(dbInfoDto);

                        Map resultMap = this.mktCallQueryDao.callSelectForMap("getPersonalValue", sqlBuilder.toString(), new ArrayList<String>(), dbInfoDto);
                        if (!resultMap.isEmpty()) {
                            String resultValue = (String) resultMap.get("value").toString();

                            if ("Y".equals(personalDto.getEncColYn())) {
                                personalValue = "Java".equals(encryptType)
                                        ? SecurityUtil.decodeDbAES256(dataKey, resultValue)
                                        : cryptService.getDbDecrypted(resultValue);
                            } else personalValue = resultValue;

                            memId = (String) resultMap.get("memId");
                        }


                        if ("CUST_NM".equals(columnName)) {
                            if (StringUtil.isNotEmpty(sendTargetDto.getMemName())) {
                                personalValue = sendTargetDto.getMemName();
                            }
                        }

                    }

                    if (ObjectUtil.isNotEmpty(memId)) {
                        tranChnlReq.setRevcMemId(memId);
                    }

                    // null 공백 처리
                    personalValue = StringUtil.convertNull(personalValue);

//                    if (EMAIL.name().equals(contentType)) {
//                        String thunderMailText = String.format("{{etc%s}}", ++personalCount);
//
//                        messageTitle = messageTitle.replace(checkValue, thunderMailText);
//                        messageBody = messageBody.replace(checkValue, thunderMailText);
//
//                        tranChnlReq.setEtc(personalCount, personalValue);
//                    } else {
                        messageTitle = messageTitle.replace(checkValue, personalValue);
                        messageBody = messageBody.replace(checkValue, personalValue);
//                    }
                }
            }

			/*if (ObjectUtil.isEmpty(tranChnlReq.getRevcMemId())) {
				tranChnlReq.setRevcMemId(reqDto.getMemId());
			}*/

            if (EMAIL.name().equals(contentType)) {
                tranChnlReq.setEmailType(reqDto.getEmailType());
                tranChnlReq.setRecvEmail(sendTargetDto.getPhone());
                tranChnlReq.setMemName(sendTargetDto.getMemName());
                tranChnlReq.setRevcMemId(sendTargetDto.getPhone());
            } else {
                tranChnlReq.setRevcMemId(sendTargetDto.getPhone());
                tranChnlReq.setRevcCallNo(sendTargetDto.getPhone());
            }

            String forEmpId = reqDto.getCreateBy();
            String sendEmpDesName = mktContentMapper.selectAuthInfoDescente(forEmpId);

            tranChnlReq.setMsgSubject(messageTitle);
            tranChnlReq.setMsgSbst(messageBody);
            tranChnlReq.setSenderNm(reqDto.getSenderNm());
            tranChnlReq.setSenderEmail(reqDto.getSenderEmail());
            tranChnlReq.setMemId(reqDto.getMemId());
            tranChnlReq.setScheduleType("0");
            tranChnlReq.setMsgType("0");
            tranChnlReq.setMsgSendType(reqDto.getContentsType());
            tranChnlReq.setBatSendStatus("N");
            tranChnlReq.setAttrib1("TEST");
            tranChnlReq.setToCallbackNo(reqDto.getToCallbackNo());
            tranChnlReq.setCdrId("");
            tranChnlReq.setVenderOfficeCode("");
            tranChnlReq.setFileCnt(0);
            tranChnlReq.setFileType1("");
            tranChnlReq.setFilePath1("");
            tranChnlReq.setContsId(reqDto.getId());
            tranChnlReq.setTranceChk("T");
            tranChnlReq.setTranceMsg(String.format("%s Success", sendTargetDto.getPhone()));
            tranChnlReq.setAuthInfoDes(sendEmpDesName);


            StatusResDto channelSendResDto = new StatusResDto(false, "");
            switch (MKT_CAM_CHNL_TYPE_CD.valueOf(contentType)) {
                case PUSH:

                    if (StringUtil.isEmpty(reqDto.getBrazeCamApiKey())) {
                        resDto.setSuccess(false);
                        resDto.setErrorType(4444);
                        return resDto;
                    } else {
                        tranChnlReq.setContsPushSubTypeVal(reqDto.getContsPushSubTypeVal());
                        tranChnlReq.setBrazeCamApiKey(reqDto.getBrazeCamApiKey());
                        // 이미지 파일정보
                        if (StringUtil.isNotEmpty(reqDto.getFilePath())) {
                            tranChnlReq.setFilePath1(reqDto.getFilePath());
                        }
                    }
                    channelSendResDto = this.tranChnlService.tranPush(tranChnlReq);
                    break;

                case SMS:
                    channelSendResDto = this.tranChnlService.tranSms(tranChnlReq);
                    break;

                case MMS:
                    String mmsSendUrl = BeansUtil.getApplicationProperty("icignal.context.imageSendUrl");
                    tranChnlReq.setMsgType("1");

                    // 이미지 파일정보
                    if (reqDto.getImgCnt() > 0) {
                        tranChnlReq.setFileCnt(1);

                        if (firstFlag) {
                            // fileName = reqDto.getFileName();
                            // filePair = this.ftpService.sftpFileUpload(reqDto.getFilePath(), "IMG_FILE", fileName);
                        }
                        String filePath = reqDto.getFilePath();

                        // 먼저 @ 의 인덱스를 찾는다 - 인덱스 값: 5
                        int idxTarget = filePath.indexOf("/UploadFile/");

                        filePath = filePath.substring(idxTarget+1);

                        filePath = mmsSendUrl+filePath;

                        filePair = Pair.of(filePath, 0L);

                        tranChnlReq.setFilePath1(filePair.getLeft());
                        tranChnlReq.setFileSize1(filePair.getRight());
                        tranChnlReq.setFileName(fileName);
                    }

                    channelSendResDto = this.tranChnlService.tranMms(tranChnlReq);
                    break;

                case LMS:
                    channelSendResDto = this.tranChnlService.tranLms(tranChnlReq);
                    break;

                case EMAIL:
                    channelSendResDto = this.tranChnlService.tranDescenteEmail(tranChnlReq);
                    break;

                default:
                    throw new IllegalArgumentException();
            }

            firstFlag = false;

            if (channelSendResDto.getSuccess()) {
                resultMessage.append(String.format("%s 전송 성공\n", sendTargetDto.getPhone()));
            } else {
                resultMessage.append(String.format("%s 전송 실패 : %s\n", sendTargetDto.getPhone(), channelSendResDto.getMessage()));
            }
        }

        resDto.setSuccess(true);
        resDto.setMessage(resultMessage.toString());

        return resDto;
    }

    /**
     * @programId : MKT_CTE_002
     * @name : getCouponList
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_offer_mst (오퍼 마스터 테이블)
     * @return : GridPagingResDto
     * @description : 바코드 생성 후 경로 뿌려주기.
     */
	/*
	public MKTContentResponseDTO getBarcode(HttpSession session, MKTOfferRequestDTO mor){
		 //RealPath, CategoryPath
		 String path = session.getServletContext().getRealPath("/");
		 String FileType = mor.getFileType().toLowerCase();
		 mor.setFileType(mor.getFileType().toLowerCase());
		 String uuid = UUID.randomUUID().toString().replace("-","");

		 //채널 시스템의 width, height 가져오기
		 MKTImgOptionRequestDTO ImageOption = new MKTImgOptionRequestDTO();
		 ImageOption.setChnlId(mor.getChnlId());
		 ImageOption.setFileType(FileType.toUpperCase());
		 ImageOption.setAccntId(mor.getAccntId());
		 ImageOption.setCountry(mor.getCountry());
		 ImageOption.setLang(mor.getLang());
		 MKTImgOptionResponseDTO rtnValue = mktContentMapper.getImageOption(ImageOption);

		 MKTContentResponseDTO rtnValueStatus = new MKTContentResponseDTO();

	     try{
	    	   String MergeFIle;
	    	   String DFileName = "DM" + mor.getIdfyNO();
	    	   String BFileName = "BR" + mor.getIdfyNO();
	    	   String BarcodePath = CommonUtil.getInstance().getMmsPath() + "BARCODE";
	    	   String DatePath = BarcodePath + File.separator  + "USEDATE"+ File.separator;
	    	   String BarcodePStore = BarcodePath;

			   //PATH 설정
			   BarcodePath = path + BarcodePath;
			   DatePath = path + DatePath;
			   File DicCreate = new File(BarcodePath);
			   File DicCreate2 = new File(DatePath);
			   BarcodePath = BarcodePath + File.separator + uuid + "." + FileType;

			   //폴더 없을 시 생성
			   if(!DicCreate.isDirectory()) {
			  	 DicCreate.mkdirs();
			   }
			   if(!DicCreate2.isDirectory()) {
				  	 DicCreate2.mkdirs();
			   }

	    	   String[] start = mor.getApplyStrDate().split(" ");
	    	   String[] end =  mor.getApplyEndDate().split(" ");

			   //Date 날짜 파일 생성
	    	   String UseDate = start[0] + "~" + end[0];

	    	   DatePath =  DatePath + DFileName + "." + FileType;
	    	   tranceText(UseDate,DatePath,rtnValue.getWidth(),FileType);

	    	   String Numpath =  DatePath + BFileName + "," + FileType;
	    	   tranceText(mor.getIdfyNO(),Numpath,rtnValue.getWidth(),FileType);

	    	   // Barcode Create //
	    	   Barcode barcode = BarcodeFactory.createCode128B(mor.getIdfyNO());
	    	   BitMatrix bitMatrix = new Code128Writer().encode(mor.getIdfyNO(), BarcodeFormat.CODE_128, rtnValue.getWidth(),25, null);
			   MatrixToImageWriter.writeToStream(bitMatrix, "png", new FileOutputStream(new File(BarcodePath)));

			   String barcodeRealPath = BarcodePStore + File.separator;
			   imageMerge(BarcodePath,Numpath,BarcodePath);

	    	   MergeFIle = BarcodePath + imageMerge(DatePath,BarcodePath,"");

	  		   MKTFileUploadRequestDTO upFile = new MKTFileUploadRequestDTO();
	  		   upFile.setName(uuid);
	  		   upFile.setFileType("." + FileType);
	  	       upFile.setPath(barcodeRealPath);

	  	       rtnValueStatus = mktContentMapper.setBarcode(upFile);

	     } catch(Exception e){
	    	   LogUtil.error(e);
	     }

	     return rtnValueStatus;
	}
	*/

    /**
     * @return : StatusResponseDTO
     * @programId : MKT_CTE_002
     * @name : setBarcode
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : image (이미지 관리 테이블)
     * @description : 바코드 추가
     */
    public MktContentResDto setBarcode(MktFileUploadReqDto adr) {
        LogUtil.param(this.getClass(), adr);
        String filePath = "/" + adr.getPath() + adr.getName() + adr.getFileType();
        MktContentResDto rtnValue = new MktContentResDto();
        String id = commonService.getRowID();

        adr.setId(id);
        adr.setPath(adr.getPath().replace("\\", "/"));

        mktContentMapper.insertBarcode(adr);

        rtnValue.setBarId(id);
        rtnValue.setBarpath(filePath);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : MKT_CTE_002
     * @name : resizeImage
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table :
     * @description : 이미지 리사이즈
     */
    public static BufferedImage resizeImage(final Image image, int w, int h, int widthParam) {
        int height = h;
        int width = widthParam;

        if (w <= width) {
            width = w;
            height = h;
        } else {
            float per = (float) width / (float) w;
            height = (int) (h * per);
        }

        final BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        final Graphics2D graphics2D = bufferedImage.createGraphics();
        graphics2D.setComposite(AlphaComposite.Src);
        graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        graphics2D.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        graphics2D.drawImage(image, 0, 0, width, height, null);
        graphics2D.dispose();

        return bufferedImage;
    }

    /**
     * @return : GridPagingResDto
     * @programId : MKT_CTE_002
     * @name : getCouponList
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_offer_mst (오퍼 마스터 테이블)
     * @description : 바코드 생성 후 경로 뿌려주기.
     */
    public String imageMerge(String Datepath, String Barcodepath, String fileName) {

        try {
            BufferedImage image1 = ImageIO.read(new File(Datepath));
            BufferedImage image2 = ImageIO.read(new File(Barcodepath));

            int width = Math.max(image1.getWidth(), image2.getWidth());
            int height = image1.getHeight() + image2.getHeight();

            BufferedImage mergerImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
            Graphics2D graphics = (Graphics2D) mergerImage.getGraphics();

            graphics.setBackground(Color.white);
            graphics.setColor(Color.WHITE);
            graphics.drawImage(image1, 0, 0, null);
            graphics.drawImage(image2, 0, image1.getHeight(), null);
            if ("".equals(fileName)) {
                ImageIO.write(mergerImage, "jpg", new File(Barcodepath));
            } else {
                ImageIO.write(mergerImage, "jpg", new File(fileName));
            }

        } catch (IOException ioe) {
            LogUtil.error(ioe);
        }

        return fileName;

    }

    /**
     * @return : List<MKTCondResponseDTO>
     * @programId : MKT_CHL_P03
     * @name : getFileUpType
     * @date : 2015. 11. 16.
     * @author : 박지열
     * @table : mkt_chnl_capa (채널 용량 관리 테이블)
     * @description : 해당 채널에 관련된 파일 업로드 타입 반환.
     */
    public List<MktCondResDto> getFileUpType(MktContentReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectFileUpType(mcr);
    }

    /**
     * @return : List<MKTImgOptionResponseDTO>
     * @programId : MKT_CTE_P06
     * @name : getImageOptionList
     * @date : 2015. 11. 16.
     * @author : 박지열
     * @table : mkt_chnl_capa (채널 용량 관리 테이블)
     * @description : 바코드 생성을 위한 해당 채널에 대한 이미지 옵션을 가져오기.
     */
    public List<MktImgOptionResDto> getImageOptionList(MktImgOptionReqDto mior) {
        LogUtil.param(this.getClass(), mior);

        return mktContentMapper.selectImageOptionList(mior);
    }

    /**
     * @return : MKTCondResponseDTO
     * @programId : MKT_CTE_P05
     * @name : getchnlCodeName
     * @date : 2015. 11. 16.
     * @author : 박지열
     * @table : mkt_chnl (채널 관리 테이블)
     * @description : Test 발송을 위한 채널 시스템 코드 가져오기.
     */
    public MktCondResDto getchnlCodeName(MktCondReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectChnlCodeName(mcr);
    }


    /**
     * @return : MKTCondResponseDTO
     * @programId : MKT_CTE_002
     * @name : getPersonalList
     * @date : 2016. 01. 11.
     * @author : 박지열
     * @table : mkt_chnl (채널 관리 테이블)
     * @description : 개인화 속성 리스트 가져오기
     */
    public List<MktCondResDto> getPersonalList(MktCondReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectPersonalList(mcr);
    }

    /**
     * @return : void
     * @throws IOException
     * @programId : MKT_CTE_002
     * @name :
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table :
     * @description : 텍스트 이미지화
     */
    public void tranceText(String textParam, String FIlePath, int Rtnwidth, String FileType) throws IOException {

        String text = textParam;
        text = URLDecoder.decode(text, "utf-8");
        File Datefile = new File(FIlePath);
        Font font = new Font("arial", Font.BOLD, 10);
        FontRenderContext frc = new FontRenderContext(null, true, true);
        Rectangle2D bounds = font.getStringBounds(text, frc);

        int w = Rtnwidth;
        int h = (int) bounds.getHeight();
        BufferedImage image = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        g.setBackground(Color.WHITE);
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, w, h);
        g.setColor(Color.BLACK);
        g.setFont(font);
        g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
                RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        g.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS,
                RenderingHints.VALUE_FRACTIONALMETRICS_ON);
        int stringLen = (int) g.getFontMetrics().getStringBounds(text, g).getWidth();
        int start1 = w / 2 - stringLen / 2;

        g.drawString(text, start1 + (float) bounds.getX(), (float) -bounds.getY());
        g.dispose();
        ImageIO.write(image, FileType, Datefile);
    }


    /**
     * @return : MKTCondResponseDTO
     * @programId : MKT_CTE_002
     * @name : getChnlId
     * @date : 2016. 01. 11.
     * @author : 박지열
     * @table : mkt_chnl (채널 관리 테이블)
     * @description : 채널 아이디 가져오기
     */
    public GridPagingResDto<MktChnlResDto> getChnlId(MktChnlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return new GridPagingResHelper<MktChnlResDto>().newGridPagingResDto(
                mcr.init(CommonUtil.getInstance().getDBType()),
                mktContentMapper.selectChnlId(mcr), AnnotationType.CommCode);
    }

    /**
     * @return : MKTContentChlResponseDTO
     * @programId :
     * @name : getChannelByCodeName
     * @date : 2016. 3. 7.
     * @author : "류동균"
     * @table : mkt_chnl
     * @description : 채널정보 조회
     */
    public MktContentChlResDto getChannelByCodeName(MktContentChlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectChannelByCodeName(mcr);
    }

    /**
     * @return : GridPagingResDto
     * @name : getFacebookPageInfo
     * @date : 2017. 5. 2.
     * @author : jun.lee
     * @description : Facebook 페이지 정보 조회
     */
    public GridPagingResDto<MktGetFacebookPageInfoResDto> getFacebookPageInfo(MktGetFacebookPageInfoReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktGetFacebookPageInfoResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktContentMapper.selectFacebookPageInfo(param), AnnotationType.CommCode);
    }

    /**
     * @return : MKTFacebookDtlResponseDTO
     * @name : getFacebookDtlList
     * @date : 2017. 5. 2.
     * @author : jun.lee
     * @description : Facebook 상세 조회
     */
    public MktFacebookDtlResDto getFacebookDtlList(MktFacebookDtlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectFacebookDtlList(mcr);
    }

    /**
     * @return : List<TempUploadResDto>
     * @name : tempUpload
     * @date : 2017. 5. 22.
     * @author : jun.lee
     * @description : tempUpload
     */

    public List<TempUploadResDto> tempUpload(String realPath, String sessionId, MultipartFile file) {

        List<TempUploadResDto> rtnValue = new ArrayList<TempUploadResDto>();

        if (file != null && file.getSize() > 0 && file.getSize() < 10240000) { //10MB 제한

            try {

                String fileName = new String(file.getOriginalFilename().getBytes("8859_1"), "UTF-8");  //MyltipartFile 의 getOriginalFileNmae 은 file 의 실제 파일명을 가져온다.

                String[] fileTypeArr = fileName.split("\\.");
                String fileType = fileTypeArr[fileTypeArr.length - 1]; // 파일 유형

                if ("gif".equals(fileType) || "jpg".equals(fileType) || "png".equals(fileType)
                        || "tif".equals(fileType) || "bmp".equals(fileType) || "tiff".equals(fileType)

                ) {

                    //getBytes 는 문자열을 바이트 배열로 바꿔줌
                    fileName = fileName.replace(" ", "");  //파일명의 공백을 없애준다.
                    fileName = UUID.randomUUID().toString() + fileName.substring(fileName.indexOf('.'), fileName.length()); //substring은 .의 갯수로부터 파일의 길이까지를 추출
                    //Unique User Identidfier 고유한 방문자를 구분할 수 있는 그 무엇. key 로는 주민번호나 회원아이디로 사용됨 UUID.randomUUID()는 유니크한 아이디를 생성함

                    Calendar cl = Calendar.getInstance(); //날짜와 시간을 객체모델링화한 클래스.시스템으로부터 시간 정보를 얻기 때문에 getInstance() 클래스 메서드를 이용
                    int year = cl.get(Calendar.YEAR);
                    int month = cl.get(Calendar.MONTH) + 1;
                    int day = cl.get(Calendar.DATE);
                    File yearDic = new File(realPath + File.separator + BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadUrl") + File.separator + year); //파일객체 생성 , 디랙토리 경로 설정,  경로값 , 날짜로 분류
                    //주어진 경로명을 추상 경로명으로 변환하여 새로운 file 객체 생성
                    //File.separator 는 운영체제에 맞는 구분자를 표시해 주기위해 사용  (리눅스와 윈도우의 경로 구분자가 다르기 때문)
                    if (!yearDic.isDirectory()) {
                        yearDic.mkdirs(); //디렉토리 유무 판별 없으면 생성, mkdir은 만들고자 하는 디렉토리의 상위 디렉토리가 존재하지 않을 경우 생성 불가, mkdirs 는 존재하지 않을 경우 디렉토리 까지 생성
                    }

                    File monthDic = new File(yearDic.getAbsolutePath() + File.separator + month); //경로 + month 에 파일생성
                    if (!monthDic.isDirectory()) {
                        monthDic.mkdirs();
                    }

                    File dayDic = new File(monthDic.getAbsolutePath() + File.separator + day); //경로 + day 에 파일생성
                    if (!dayDic.isDirectory()) {
                        dayDic.mkdirs();
                    }

                    String path = dayDic.getAbsolutePath().toString(); //getAbsolutePath 파일의 절대경로를 반환해 주는 함수인데 경로에 입력된 그대로를 표현한다.  getCanonicalPath() 는 실제로 위치하는 절대경로를 표현

                    File dir = new File(path + File.separator + sessionId); // 경로 + 세션아이디 에 파일생성
                    if (!dir.isDirectory()) {
                        dir.mkdirs();
                    }

                    file.transferTo(new File(dir.getAbsolutePath() + File.separator + fileName));  //파일복사

                    TempUploadResDto u = new TempUploadResDto(fileName,
                            Long.valueOf(file.getSize()).intValue(),
                            BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + year + "/" + month + "/" + day + "/" + sessionId + "/" + fileName); //최종경로

                    rtnValue.add(u);
                } else {
                    LogUtil.error("비인가된 파일확장자 오류: " + fileType);

                }
            } catch (Exception e) {
                LogUtil.error(e);
            }

        }
        return rtnValue;
    }

    /**
     * @return : MKTAddFacebookPostingResponseDTO
     * @name : makeShortToLongLivedToken
     * @date : 2017. 5. 22.
     * @author : jun.lee
     * @description : 단기 액세스 토큰을 장기 액세스 토큰으로 전환
     */

    public MktAddFacebookPostingResDto makeShortToLongLivedToken(MktGetFacebookPageInfoReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        MktAddFacebookPostingResDto rtnValue = new MktAddFacebookPostingResDto();

        BufferedReader br = null;
        HttpURLConnection conn = null;

        try {
            URL longLivedAccessToken = new URL("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token"
                    + "&client_id=" + mcr.getAppId()
                    + "&client_secret=" + mcr.getAppSecurCode()
                    + "&fb_exchange_token=" + mcr.getShortLivedToken());

            LogUtil.info("shortLivedAccessToken:" + mcr.getShortLivedToken());
            LogUtil.info("longLivedAccessToken:" + longLivedAccessToken);

            conn = (HttpURLConnection) longLivedAccessToken.openConnection();

            conn.setRequestMethod("GET");
            conn.setConnectTimeout(3000);
            conn.setReadTimeout(3000);

            br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            String temp;

            while ((temp = br.readLine()) != null) {
                JSONParser parser = new JSONParser();
                Object obj = parser.parse(temp);
                JSONObject jsonObj = (JSONObject) obj;

                //장기 액세스 토큰
                mcr.setLongLivedToken((String) jsonObj.get("access_token"));
                rtnValue.setLongLivedToken((String) jsonObj.get("access_token"));

                //장기 액세스 토큰 만료까지 남은 시간 계산(초 -> 날짜 변환)
                /*mcr.setExpiresIn(Long.toString((Long)jsonObj.get("expires_in")));*/
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss", Locale.KOREA);
                Date currentTime = new Date();
                String dTime = formatter.format(currentTime);
                LogUtil.info("현재시간 :" + dTime);

                Calendar cal = Calendar.getInstance();
                cal.setTime(currentTime);

                long expires_in = (Long) jsonObj.get("expires_in");
                //cal.add(Calendar.SECOND, Math.toIntExact((Long)jsonObj.get("expires_in")));
                cal.add(Calendar.SECOND, (int) expires_in);

                dTime = formatter.format(cal.getTime());

                LogUtil.info("만료일 :" + dTime);

                mcr.setExpiresIn(dTime);
            }

            //데이터베이스에 장기 토큰 및 추가 정보 삽입
            mktContentMapper.updateFacebookPageInfo(mcr);

            conn.disconnect();

        } catch (MalformedURLException e) {
            LogUtil.error(e.toString(), e);
        } catch (IOException e) {
            LogUtil.error(e.toString(), e);
        } catch (ParseException e) {
            LogUtil.error(e.toString(), e);
        } finally {
            try {
                if (br != null) br.close();
            } catch (Exception e) {
                br = null;
            }

            try {
                if (conn != null) conn.disconnect();
            } catch (Exception e) {
                conn = null;
            }
        }

        return rtnValue;
    }

    /**
     * @return : MKTGetFacebookPageInfoResponseDTO
     * @name : getFacebookPageInfoById
     * @date : 2017. 5. 22.
     * @author : jun.lee
     * @description : 페이스북 페이지 정보 조회
     */
    public MktGetFacebookPageInfoResDto getFacebookPageInfoById(MktGetFacebookPageInfoReqDto bccr) {
        LogUtil.param(this.getClass(), bccr);

        return mktContentMapper.selectFacebookPageInfoById(bccr);
    }

    /**
     * @return : StatusResDto
     * @name : setPostId
     * @date : 2017. 5. 29.
     * @author : jun.lee
     * @description : 포스팅 시, postId 저장
     */
    public StatusResDto setPostId(MktSetPostIdReqDto bccr) {
        LogUtil.param(this.getClass(), bccr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        mktContentMapper.updatePostId(bccr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : MKTConvertDateToUnixTimestampResponseDTO
     * @name : convertDateToUnixTimestamp
     * @date : 2017. 5. 29.
     * @author : jun.lee
     * @description : date를 unix timestamp로 변환
     */
    public MktConvertDateToUnixTimestampResDto convertDateToUnixTimestamp(MktConvertDateToUnixTimestampReqDto bccr) {
        LogUtil.param(this.getClass(), bccr);

        MktConvertDateToUnixTimestampResDto rtnValue = new MktConvertDateToUnixTimestampResDto();

        String date2 = "";
        try {
            SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd,hh:mm", Locale.KOREA);
            Date date = format1.parse(bccr.getParameter());
            SimpleDateFormat format2 = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm", Locale.KOREA);
            date2 = format2.format(date);
            date2 = date2 + ":00 GMT+09:00";
            LogUtil.debug("DB Time3 : " + date2);

            //date to unix timestamp
            DateFormat dateFormat = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z", Locale.KOREA);
            Date date3 = dateFormat.parse(date2);
            long unixTime = date3.getTime() / 1000;
            LogUtil.debug("time : " + date2);
            LogUtil.debug("unix time : " + unixTime);
            rtnValue.setReservedDate(date2);
            rtnValue.setResult(unixTime);
        } catch (java.text.ParseException ex) {
            LogUtil.error(ex);
        }

        return rtnValue;
    }

    /**
     * @return : GridPagingResDto
     * @name : getFacebookOpenRangeInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @description : 페이스북 공개 범위 정보 조회
     */
    public GridPagingResDto<MktGetFacebookOpenRangeInfoResDto> getFacebookOpenRangeInfo(MktGetFacebookOpenRangeInfoReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktGetFacebookOpenRangeInfoResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktContentMapper.selectFacebookOpenRangeInfo(param), AnnotationType.CommCode);
    }

    /**
     * @return : StatusResDto
     * @name : setReactionsRspnsInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @description : 페이스북 종류별 좋아요 반응정보 수집
     */
    public StatusResDto setReactionsRspnsInfo(MktSetRspnsInfoReqDto bccr) throws IOException, ParseException {
        LogUtil.param(this.getClass(), bccr);

        //1. 종류별 좋아요
        List dataList = new ArrayList<>();
        URL url = null;
        Boolean flag = true;
        int likeCount = 0;
        int loveCount = 0;
        int wowCount = 0;
        int hahaCount = 0;
        int sadCount = 0;
        int angryCount = 0;
        int thankfulCount = 0;
        HttpURLConnection conn1 = null;
        BufferedReader br1 = null;
        try {
            url = new URL("https://graph.facebook.com/v2.9/" + bccr.getPostId() + "/reactions?access_token=" + bccr.getAccessToken());
            //테스트용 url
            //url =  new URL("https://graph.facebook.com/v2.9/1290431577692360/reactions?access_token=EAALfrAimxuIBAHYF1PYAibHvZAG4kfRkFY5zZCY6rccHTD2Ps4KMZBIOIHy5o63dZCabSvd0wLjcrcxZB5fS9tqw9Uo5ldjLeeQRMnLqaEtXOWck7hz2AWunYoKTHZCD213nM075ZA8eRX1TI8aAdRZCh1GIXtZAoNQWneZCvVfP1OohLGs0xnd72i");

            do {
                conn1 = (HttpURLConnection) url.openConnection();

                conn1.setRequestMethod("GET");
                conn1.setConnectTimeout(999999999);
                conn1.setReadTimeout(999999999);

                br1 = new BufferedReader(new InputStreamReader(conn1.getInputStream(), "utf-8"));
                String temp1 = br1.readLine();
                if (temp1 != null) {
                    JSONParser parser1 = new JSONParser();
                    Object obj1 = parser1.parse(temp1);
                    JSONObject jsonObj1 = (JSONObject) obj1;

                    if (jsonObj1 != null) {
                        // data를 list에 삽입
                        dataList.add(jsonObj1.get("data"));
                        // next값이 null인지 확인
                        Object next = jsonObj1.get("paging");
                        JSONObject nextObj = (JSONObject) next;
                        if (!"null".equals(nextObj.get("next")) && nextObj.get("next") != null) {
                            url = new URL((String) nextObj.get("next"));
                        } else {
                            flag = false;
                        }
                    } else flag = false;
                } else flag = false;
            }
            while (flag);

            //dataList 결과를 JSONArray 형식으로 파싱

            JSONParser parser = new JSONParser();

            Object obj1 = parser.parse(dataList.toString());
            JSONArray jsonArray1 = (JSONArray) obj1;

            for (int x = 0; x < jsonArray1.size(); x++) {
                Object obj = parser.parse(dataList.get(x).toString());
                JSONArray jsonArray2 = (JSONArray) obj;
                for (int y = 0; y < jsonArray2.size(); y++) {
                    JSONObject jsonObj = (JSONObject) jsonArray2.get(y);
                    if (jsonObj.get("type").equals("LIKE")) {
                        likeCount++;
                    } else if (jsonObj.get("type").equals("LOVE")) {
                        loveCount++;
                    } else if (jsonObj.get("type").equals("WOW")) {
                        wowCount++;
                    } else if (jsonObj.get("type").equals("HAHA")) {
                        hahaCount++;
                    } else if (jsonObj.get("type").equals("SAD")) {
                        sadCount++;
                    } else if (jsonObj.get("type").equals("ANGRY")) {
                        angryCount++;
                    } else if (jsonObj.get("type").equals("THANKFUL")) {
                        thankfulCount++;
                    }
                }
            }
        } catch (Exception e) {
            LogUtil.error(e);
        } finally {
            try {
                if (br1 != null) br1.close();
            } catch (Exception e) {
                br1 = null;
            }

            try {
                if (conn1 != null) conn1.disconnect();
            } catch (Exception e) {
                conn1 = null;
            }
        }


        //나눠서 데이터 삽입
        //날짜 설정
        Date today = new Date();
        /*bccr.setRspnsId((String) jsonObj.get("id"));*/
        SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.KOREA);
        bccr.setRspnsDate(date.format(today));

        bccr.setCamRspnsId("FB021");
        bccr.setRspnsIdCnt(String.valueOf(likeCount));
        setRspnsInfo(bccr);

        bccr.setCamRspnsId("FB022");
        bccr.setRspnsIdCnt(String.valueOf(loveCount));
        setRspnsInfo(bccr);

        bccr.setCamRspnsId("FB023");
        bccr.setRspnsIdCnt(String.valueOf(wowCount));
        setRspnsInfo(bccr);

        bccr.setCamRspnsId("FB024");
        bccr.setRspnsIdCnt(String.valueOf(hahaCount));
        setRspnsInfo(bccr);

        bccr.setCamRspnsId("FB025");
        bccr.setRspnsIdCnt(String.valueOf(sadCount));
        setRspnsInfo(bccr);

        bccr.setCamRspnsId("FB026");
        bccr.setRspnsIdCnt(String.valueOf(angryCount));
        setRspnsInfo(bccr);

        bccr.setCamRspnsId("FB027");
        bccr.setRspnsIdCnt(String.valueOf(thankfulCount));
        setRspnsInfo(bccr);

        return null;
    }

    /**
     * @return : StatusResponseDTO
     * @name : setRspnsInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @description : 페이스북 반응정보 수집
     */
    public StatusResDto setRspnsInfo(MktSetRspnsInfoReqDto bccr) {
        LogUtil.param(this.getClass(), bccr);

        StatusResDto rtnValue = new StatusResDto(false, "");
        bccr.setSVCAlias("");

        //해당 반응정보가 이미 데이터베이스에 있는지 확인
        int isRspnsInfoExist = mktContentMapper.selectIsRspnsInfoExist(bccr);

        if (isRspnsInfoExist <= 0) {
            //없는 반응정보, 삽입
            mktContentMapper.insertRspnsInfo(bccr);
        } else {
            //있는 반응정보, 수정
            mktContentMapper.updateRspnsInfo(bccr);
        }

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @name : setSharedpostsRspnsInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @description : 페이스북 공유 반응정보 수집
     */
    public StatusResDto setSharedpostsRspnsInfo(MktSetRspnsInfoReqDto bccr) throws IOException, ParseException {
        LogUtil.param(this.getClass(), bccr);

        //2. 공유 정보
        List<Object> dataList = new ArrayList<>();
        URL url = null;
        Boolean flag = true;
        int count = 0;
        HttpURLConnection conn1 = null;
        BufferedReader br1 = null;
        try {
            url = new URL("https://graph.facebook.com/v2.9/" + bccr.getPostId() + "/sharedposts?access_token=" + bccr.getAccessToken());

            do {
                conn1 = (HttpURLConnection) url.openConnection();

                conn1.setRequestMethod("GET");
                conn1.setConnectTimeout(999999999);
                conn1.setReadTimeout(999999999);

                br1 = new BufferedReader(new InputStreamReader(conn1.getInputStream(), "utf-8"));
                String temp1 = br1.readLine();
                if (temp1 != null) {
                    JSONParser parser1 = new JSONParser();
                    Object obj1 = parser1.parse(temp1);
                    JSONObject jsonObj1 = (JSONObject) obj1;
                    if (jsonObj1 != null) {
                        //data를 list에 삽입
                        dataList.add(jsonObj1.get("data"));

                        //next값이 null인지 확인
                        Object next = jsonObj1.get("paging");
                        JSONObject nextObj = (JSONObject) next;
                        if (!"null".equals(nextObj.get("next")) && nextObj.get("next") != null) {
                            url = new URL((String) nextObj.get("next"));
                        } else {
                            flag = false;
                        }

                    } else flag = false;
                } else flag = false;

            } while (flag);

            //dataList 결과를 JSONArray 형식으로 파싱
            JSONParser parser = new JSONParser();

            Object obj1 = parser.parse(dataList.toString());
            JSONArray jsonArray1 = (JSONArray) obj1;

            for (int x = 0; x < jsonArray1.size(); x++) {
                Object obj = parser.parse(dataList.get(x).toString());
                JSONArray jsonArray2 = (JSONArray) obj;
                for (int y = 0; y < jsonArray2.size(); y++) {
                    JSONObject jsonObj = (JSONObject) jsonArray2.get(y);
                    count++;
                }
            }
            LogUtil.info("공유 총 갯수 : " + count);
        } catch (Exception e) {
            LogUtil.error(e);
        } finally {
            try {
                if (br1 != null) br1.close();
            } catch (Exception e) {
                br1 = null;
            }

            try {
                if (conn1 != null) conn1.disconnect();
            } catch (Exception e) {
                conn1 = null;
            }
        }

        //데이터 삽입
        Date today = new Date();
        bccr.setCamRspnsId("FB041");
        /*bccr.setRspnsId((String) jsonObj.get("id"));*/
        SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.KOREA);
        bccr.setRspnsDate(date.format(today));
        bccr.setRspnsIdCnt(String.valueOf(count));

        return setRspnsInfo(bccr);
    }


    /**
     * @return : StatusResDto
     * @name : setCommentsRspnsInfo
     * @date : 2017. 6. 7.
     * @author : jun.lee
     * @description : 페이스북 댓글 반응정보 수집
     */
    public StatusResDto setCommentsRspnsInfo(MktSetRspnsInfoReqDto bccr) throws IOException, ParseException {
        LogUtil.param(this.getClass(), bccr);

        //3. 댓글  정보
        List<Object> dataList = new ArrayList<>();
        URL url = null;
        Boolean flag = true;
        int count = 0;

        HttpURLConnection conn1 = null;
        BufferedReader br1 = null;
        try {
            url = new URL("https://graph.facebook.com/v2.9/" + bccr.getPostId() + "/comments?access_token=" + bccr.getAccessToken());
            //테스트용 url
            //url =  new URL("https://graph.facebook.com/v2.9/1290431577692360/comments?access_token=EAALfrAimxuIBAHYF1PYAibHvZAG4kfRkFY5zZCY6rccHTD2Ps4KMZBIOIHy5o63dZCabSvd0wLjcrcxZB5fS9tqw9Uo5ldjLeeQRMnLqaEtXOWck7hz2AWunYoKTHZCD213nM075ZA8eRX1TI8aAdRZCh1GIXtZAoNQWneZCvVfP1OohLGs0xnd72i");

            do {
                conn1 = (HttpURLConnection) url.openConnection();

                conn1.setRequestMethod("GET");
                conn1.setConnectTimeout(999999999);
                conn1.setReadTimeout(999999999);

                br1 = new BufferedReader(new InputStreamReader(conn1.getInputStream(), "utf-8"));

                String temp1 = br1.readLine();
                if (temp1 != null) {
                    JSONParser parser1 = new JSONParser();
                    Object obj1 = parser1.parse(temp1);
                    JSONObject jsonObj1 = (JSONObject) obj1;

                    if (jsonObj1 != null) {
                        //data를 list에 삽입
                        dataList.add(jsonObj1.get("data"));

                        //next값이 null인지 확인
                        Object next = jsonObj1.get("paging");
                        JSONObject nextObj = (JSONObject) next;
                        if (!"null".equals(nextObj.get("next")) && nextObj.get("next") != null) {
                            url = new URL((String) nextObj.get("next"));
                        } else {
                            flag = false;
                        }
                    } else flag = false;
                } else flag = false;

            } while (flag);

            //dataList 결과를 JSONArray 형식으로 파싱
            JSONParser parser = new JSONParser();

            Object obj1 = parser.parse(dataList.toString());
            JSONArray jsonArray1 = (JSONArray) obj1;

            for (int x = 0; x < jsonArray1.size(); x++) {
                Object obj = parser.parse(dataList.get(x).toString());
                JSONArray jsonArray2 = (JSONArray) obj;
                for (int y = 0; y < jsonArray2.size(); y++) {
                    JSONObject jsonObj = (JSONObject) jsonArray2.get(y);
                    count++;
                }
            }
            LogUtil.debug("댓글 총 갯수 : " + count);
        } catch (Exception e) {
            LogUtil.error(e);
        } finally {
            try {
                if (br1 != null) br1.close();
            } catch (Exception e) {
                br1 = null;
            }

            try {
                if (conn1 != null) conn1.disconnect();
            } catch (Exception e) {
                conn1 = null;
            }
        }

        //데이터 삽입
        bccr.setCamRspnsId("FB010");
        //bccr.setRspnsId((String) jsonObj.get("id"));
        //날짜 포맷 변환(hhhh-MM-dd hh:mm:ss)
		/*String temp = (String) jsonObj.get("created_time");
		String temp2 = temp.replace("T", " ");
		String createdTime = temp2.replace("+0000", "");
		bccr.setRspnsDate(createdTime);*/
        Date today = new Date();
        SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.KOREA);
        bccr.setRspnsDate(date.format(today));
        bccr.setRspnsIdCnt(String.valueOf(count));

        return setRspnsInfo(bccr);
    }


    /**
     * @return : GridPagingResDto
     * @name : getAttachmentType
     * @date : 2017. 7. 5.
     * @author : jun.lee
     * @description : 페이스북 첨부파일 종류 조회
     */
    public GridPagingResDto<MktGetAttachmentTypeResDto> getAttachmentType(MktGetAttachmentTypeReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktGetAttachmentTypeResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktContentMapper.selectAttachmentType(param), AnnotationType.CommCode);
    }

    /**
     * @return : StatusResDto
     * @name : uploadImageToInsta
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @description : 인스타그램에 단일이미지 업로드
     */
    public StatusResDto uploadImageToInsta(MktUploadImageToInstaReqDto bccr) {
        LogUtil.param(this.getClass(), bccr);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);

        //인스타그램에 로그인
        Instagram4j instagram = Instagram4j.builder().username(bccr.getUsername()).password(bccr.getPassword()).build();
        instagram.setup();
        try {
            instagram.login();
        } catch (IOException e) {
            LogUtil.error(e.toString(), e);
            rtnValue.setMessage("0");
        }

        for (int x = 0; x < bccr.getImageInfo().length; x++) {
            //downloadUrlToFile(Image)
            FileOutputStream fos = null;
            InputStream is = null;
            try {
                URL u = new URL(bccr.getImageInfo()[x]);
                File filePath = new File("C:\\Download\\");
                filePath.mkdirs();

                fos = new FileOutputStream("C:\\Download\\" + bccr.getFile()[x]);

                is = u.openStream();

                byte[] buf = new byte[1024];
                double len = 0;

                while ((len = is.read(buf)) > 0) {
                    fos.write(buf, 0, (int) len);
                }

                fos.close();
                is.close();

                //UploadImageToInstagram
                InstagramConfigurePhotoResult uploadResponse = instagram.sendRequest(new InstagramUploadPhotoRequest(
                        //단일 이미지 업로드 테스트
                        new File("C:\\Download\\" + bccr.getFile()[x]),
                        bccr.getContents()));
                //System.out.println("uploadResponse : "+uploadResponse);
                rtnValue.setMessage(uploadResponse.getMedia().getId());
            } catch (IOException e1) {
                LogUtil.error(e1.toString(), e1);
                rtnValue.setMessage("2");
            } catch (Exception e) {
                LogUtil.error("다운로드 오류입니다. 나중에 다시 받아보세요.", e);
                rtnValue.setMessage("1");
            } finally {
                try {
                    if (fos != null) fos.close();
                } catch (Exception e2) {
                    fos = null;
                }

                try {
                    if (is != null) is.close();
                } catch (Exception e2) {
                    is = null;
                }

            }
        }

        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @name : uploadVideoToInsta
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @description : 인스타그램에 단일동영상 업로드
     */
    public StatusResDto uploadVideoToInsta(MktUploadVideoToInstaReqDto bccr) {
        LogUtil.param(this.getClass(), bccr);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);

        //인스타그램에 로그인
        Instagram4j instagram = Instagram4j.builder().username(bccr.getUsername()).password(bccr.getPassword()).build();
        instagram.setup();
        try {
            instagram.login();
        } catch (IOException e) {
            LogUtil.error(e.toString(), e);
            rtnValue.setMessage("0");
        }

        //downloadUrlToFile(Video)
        FileOutputStream fos = null;
        InputStream is = null;
        try {
            //Thread.sleep(5000);
            //URL u = new URL("http://devmkt2.icignal.com/resources/UploadFile/A25151161401081997.mp4");
            URL u = new URL(bccr.getFileUrl());
            File filePath = new File("C:\\Download\\");
            filePath.mkdirs();
            //FileOutputStream fos = new FileOutputStream("C:\\Download\\A25151161401081997.mp4");
            fos = new FileOutputStream("C:\\Download\\" + bccr.getFile());

            is = u.openStream();

            byte[] buf = new byte[1024];
            double len = 0;

            while ((len = is.read(buf)) > 0) {
                fos.write(buf, 0, (int) len);
            }

            fos.close();
            is.close();

            //UploadVideoToInstagram
            StatusResult uploadResponse = instagram.sendRequest(new InstagramUploadVideoRequest(
                    //단일 동영상 업로드 테스트
                    //new File("C:\\Download\\A25151161401081997.mp4"),
                    new File("C:\\Download\\" + bccr.getFile()),
                    bccr.getContents()));
            //System.out.println("uploadResponse : "+uploadResponse);
            rtnValue.setMessage(uploadResponse.getMessage());
        } catch (IOException e1) {
            LogUtil.error(e1.toString(), e1);
            rtnValue.setMessage("2");
        } catch (Exception e) {
            LogUtil.error(e.toString(), e);
            LogUtil.info("다운로드 오류입니다. 나중에 다시 받아보세요.");
            rtnValue.setMessage("1");
        } finally {
            try {
                if (fos != null) fos.close();
            } catch (Exception e2) {
                fos = null;
            }

            try {
                if (is != null) is.close();
            } catch (Exception e2) {
                is = null;
            }

        }

        return rtnValue;
    }

    /**
     * @return : GridPagingResDto
     * @name : getInstagramInfo
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @description : 인스타그램 계정 정보 조회
     */
    public GridPagingResDto<MktGetInstagramInfoResDto> getInstagramInfo(MktGetInstagramInfoReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktGetInstagramInfoResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktContentMapper.selectInstagramInfo(param), AnnotationType.CommCode);
    }

    /**
     * @return : MKTGetInstagramDtlResponseDTO
     * @name : getInstagramDtlList
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @description : 인스타그램 채널 상세 조회
     */

    public MktGetInstagramDtlResDto getInstagramDtlList(MktGetInstagramDtlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectInstagramDtlList(mcr);
    }

    /**
     * @return : MKTGetInstagramInfoResponseDTO
     * @name : getInstagramInfoById
     * @date : 2017. 7. 17.
     * @author : jun.lee
     * @description : id로 인스타그램 계정 정보 조회
     */

    public MktGetInstagramInfoResDto getInstagramInfoById(MktGetInstagramInfoReqDto bccr) {
        LogUtil.param(this.getClass(), bccr);

        return mktContentMapper.selectInstagramInfoById(bccr);
    }

    /**
     * 개인화 파일 조회
     *
     * @programId :
     * @name : getPersnalFile
     * @date : 2017. 12. 7.
     * @author : jh.kim
     * @description :
     */
    public MktPersnalFileResDto getContsPrsnlFile(MktPersnalFileReqDto param) {
        LogUtil.param(this.getClass(), param);

        return mktContentMapper.selectContsPrsnlFile(param);
    }

    /**
     * 개인화 파일 등록
     * <p>
     * 1. 개인화 파일 업로드 및 데이터베이스 등록
     * 2.
     *
     * @programId :
     * @name : uploadPrsnlFile
     * @date : 2017. 12. 8.
     * @author : jh.kim
     * @description :
     */
    public MktPersnalFileUploadResDto uploadPrsnlFile(MktPersnalFileUploadReqDto param, MultipartFile file) {
        LogUtil.param(this.getClass(), param);

        MktPersnalFileUploadResDto rtnDto = null;

        StatusResDto fileUpload = new StatusResDto();
        StatusResDto dataInsert = new StatusResDto();
        fileUpload.setSuccess(false);
        dataInsert.setSuccess(false);

        // 1. 파일 등록
        FileReqDto fileRequestDTO = new FileReqDto();
        fileRequestDTO.setParentId(param.getContsId());
        fileRequestDTO.setFile(file);

        FileUploadResDto fileUploadRes = commonService.fileUpload(param.getOrgFilePath(), fileRequestDTO);

        rtnDto = new MktPersnalFileUploadResDto(
                fileUploadRes.getId(),
                fileUploadRes.getFileName(),
                fileUploadRes.getOriFileName(),
                fileUploadRes.getFilePath(),
                fileUploadRes.getFileSize(),
                fileUploadRes.getFileType());

        fileUpload.setSuccess(true);
        rtnDto.setFileUpload(fileUpload);

        String saveFilePath = param.getOrgFilePath() + File.separator + BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path") + File.separator + fileUploadRes.getFileName();

        // 2. 파일 분석 및 개인화 등록
        CSVReader reader = null;

        try {
            reader = new CSVReader(new InputStreamReader(new FileInputStream(new File(saveFilePath)), "MS949"));
            MktParsnalEditReqDto reqDto = new MktParsnalEditReqDto();

            int rows = 0;
            String[] codes = null;

            String[] field;
            while ((field = reader.readNext()) != null) {

                //개인화 코드값 추출
                if (rows == 0) {
                    codes = new String[field.length];
                    System.arraycopy(field, 0, codes, 0, field.length);
//                    for ( int i = 0 ; i < field.length ; i++ ) {
//                        codes[i] = field[i];
//                    }
                }
                //개인화 값 추출
                else {
                    for (int i = 1; i < field.length; i++) {
                        reqDto = new MktParsnalEditReqDto();
                        reqDto.setSystemColumn(param.getSystemColumn());
                        reqDto.setContsId(param.getContsId());
                        reqDto.setTargetId(field[0]);
                        reqDto.setPrsnlCd(codes[i]);

                        if (ObjectUtil.isEmpty(codes[i])) {
                            break;
                        }
                        reqDto.setPrsnlVal(field[i]);

                        //개인화 등록
                        mktContentMapper.insertPrsnl(reqDto);
                    }
                }
                rows++;
            }

            dataInsert.setSuccess(true);
            rtnDto.setDataInsert(dataInsert);
        } catch (IOException e) {
            LogUtil.error(e);
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    LogUtil.error(e);
                }
            }
        }
        return rtnDto;
    }

    /**
     * 개인화 데이터 삭제
     *
     * @programId :
     * @name : removePrsnl
     * @date : 2017. 12. 8.
     * @author : jh.kim
     * @description :
     */
    public StatusResDto removePrsnl(MktParsnalEditReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");

        //파일삭제
        FileReqDto fileReq = new FileReqDto();
        fileReq.setConid(param.getContsId());

        commonService.deleteFile(fileReq);

        //개인화 데이터 삭제
        mktContentMapper.deletePrsnl(param);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

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
    public List<MktContentListResDto> getDetailContentByCamId(MktContentListReqDto param) {
        LogUtil.param(this.getClass(), param);

        return mktContentMapper.selectContentListByCamId(param);
    }

    /**
     * @return : MKTMmsDtlResponseDTO
     * @programId :
     * @name : getChnlGuide
     * @date : 2018 .09 .18
     * @author : 금동우
     * @table :
     * @description : 채널 가이드 조회
     */
    public MktMmsDtlResDto getChnlGuide(MktMmsDtlReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectChnlGuide(mcr);
    }

    /**
     * @return : MKTMmsDtlResponseDTO
     * @programId :
     * @name : selectPushTokenInfo
     * @date : 2018 .09 .18
     * @author : 금동우
     * @table :
     * @description : push 토큰 조회
     */
    public List<MktCondResDto> getPushTokenInfo(MktCondReqDto mpr) {
        return mktContentMapper.selectPushTokenInfo(mpr);
    }

    /**
     * @return : MktContentResDto
     * @programId :
     * @name : getImgSize
     * @date : 2020. 03. 30.
     * @author :yj.choi
     * @table : com.image
     * @description : 이미지 파일 사이즈
     */
    public MktContentResDto getImgSize(MktContentReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectImgSize(mcr);
    }


    /**
     * @return : MktContentResDto
     * @programId :
     * @name : getCpnList
     * @date : 2020. 11. 12.
     * @author :yj.choi
     * @table : loy_ofr
     * @description : 쿠폰 조회
     */
    public GridPagingResDto<OfferResDto> getCpnList(OfferReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);

        return new GridPagingResHelper<OfferResDto>().
                newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType())
                        , mktContentMapper.selectCpnList(reqDto), AnnotationType.CommCode);
    }

    /**
     * @return : MktContentResDto
     * @programId :
     * @name : getCampaignKeyList
     * @date : 2020. 11. 12.
     * @author :yj.choi
     * @table : loy_ofr
     * @description : 쿠폰 조회
     */
    public GridPagingResDto<OfferResDto> getCampaignKeyList(OfferReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);

        return new GridPagingResHelper<OfferResDto>().
                newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType())
                        , mktContentMapper.getCampaignKeyList(reqDto), AnnotationType.CommCode);
    }

    public StatusResDto getBrazeCampaignLoad(OfferReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();

        MktExternalListResDto externalList = mktContentMapper.selectExternal();
        if (ObjectUtil.isNotEmpty(externalList.getAccessToken())) {
            String accessToken = externalList.getAccessToken();
            String instance_url = externalList.getHost();

            String authorization = "Bearer " + accessToken;
            String endpointUrl = "https://" + instance_url;

            TimeZone tz = TimeZone.getTimeZone("UTC");
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'"); // Quoted "Z" to indicate UTC, no timezone offset
            df.setTimeZone(tz);
            String nowAsISO = df.format(new Date());

            String endpointUrlOption = externalList.getSiteName() + nowAsISO;
            try {
                ClientHttpRequestFactory requestFactory = getClientHttpRequestFactory();
                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
                headers.set("Authorization", authorization);
                HttpEntity<?> httpEntity = new HttpEntity<String>(headers);
                RestTemplate restTemplate = new RestTemplate(requestFactory);
                ResponseEntity<String> response = restTemplate.exchange(endpointUrl + endpointUrlOption, HttpMethod.GET, httpEntity, String.class);
                JSONParser jsonParser = new JSONParser();
                JSONObject responseObject = (JSONObject) jsonParser.parse(response.getBody());

                String responsecheckFlag = responseObject.get("message").toString();
                JSONArray jsonArrayBo = new JSONArray();

                if (responsecheckFlag.equals("success")) {
                    jsonArrayBo = (JSONArray) responseObject.get("campaigns");
                } else {
                    throw new Exception();
                }

                ArrayList<LinkedHashMap<Object, Object>> matchingResponseDataList = new ArrayList<>();

                for (int i = 0; i < jsonArrayBo.size(); i++) {
                    JSONObject temObj = (JSONObject) jsonArrayBo.get(i);
                    JSONArray arrays = (JSONArray) temObj.get("tags");

                    for (int j = 0; j < arrays.size(); j++) {
                        String temObj2 = (String) arrays.get(j);

                        if (temObj.get("is_api_campaign").toString().equals("true")) {
                            if (temObj2.equals(externalList.getMallId())) {
                                LinkedHashMap<Object, Object> transPerMap = new LinkedHashMap<>();
                                transPerMap.put("campaignApiKey", temObj.get("id").toString());
                                transPerMap.put("campaignName", temObj.get("name").toString());
                                transPerMap.put("campaignCreateDate", temObj.get("last_edited").toString());
                                matchingResponseDataList.add(transPerMap);
                            }
                        }
                    }
                }

                for (LinkedHashMap<Object, Object> data : matchingResponseDataList) {
                    String campaignApiKey = data.get("campaignApiKey").toString();
                    String campaignName = data.get("campaignName").toString();
                    String campaignCreateDate = data.get("campaignCreateDate").toString();

                    ZonedDateTime date = null;
                    String returnDate = null;
                    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ISO_DATE_TIME;

                    date = ZonedDateTime.parse(campaignCreateDate, dateTimeFormatter).withZoneSameInstant(ZoneOffset.of("+9"));
                    returnDate = date.format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"));

                    BrazeCamApiReqDto param = new BrazeCamApiReqDto();

                    param.setCamApiKey(campaignApiKey);
                    param.setCamNm(campaignName);
                    param.setCamCreateDate(returnDate);

                    String keyCheckFlag = mktContentMapper.selectBrazeCamApiDataForMatching(param);

                    if (keyCheckFlag.equals("N")) {

                        MktExternalListResDto externalListDetail = mktContentMapper.selectExternalCamDetail();

                        String accessTokenDetail = externalListDetail.getAccessToken();
                        String instance_urlDetail = externalListDetail.getHost();

                        String authorizationDetail = "Bearer " + accessTokenDetail;
                        String endpointUrlDetail = "https://" + instance_urlDetail;

                        String endpointUrlOptionDetail = externalListDetail.getSiteName();

                        ClientHttpRequestFactory requestFactoryDetail = getClientHttpRequestFactory();
                        HttpHeaders headersDetail = new HttpHeaders();
                        headersDetail.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
                        headersDetail.set("Authorization", authorizationDetail);
                        HttpEntity<?> httpEntityDetail = new HttpEntity<String>(headersDetail);
                        RestTemplate restTemplateDetail = new RestTemplate(requestFactoryDetail);
                        ResponseEntity<String> responseDetail = restTemplateDetail.exchange(endpointUrlDetail + endpointUrlOptionDetail + param.getCamApiKey(), HttpMethod.GET, httpEntityDetail, String.class);

                        JSONParser jsonParserDetail = new JSONParser();
                        JSONObject responseObjectDetail = (JSONObject) jsonParserDetail.parse(responseDetail.getBody());

                        String responsecheckFlagDetail = responseObjectDetail.get("messages").toString();

                        JSONParser jsonKeyParser = new JSONParser();

                        boolean chnlTgtCheckSaveFlag = false;

                        List<String> ketNameList = new ArrayList<String>();
                        //파싱할 문자열 지정 후 json object로 형변환
                        JSONObject obj = (JSONObject)jsonKeyParser.parse(responsecheckFlagDetail);
                        // key set 받아오기
                        Set key = obj.keySet();
                        // Iterator 설정
                        Iterator<String> iter = key.iterator();
                        // 각각 키 값 출력
                        while(iter.hasNext())
                        {
                            String keyname = iter.next();
                            if(keyname.indexOf("androidPush") > -1 || keyname.indexOf("iosPush") > -1) {
                                ketNameList.add(keyname);
                                chnlTgtCheckSaveFlag = true;
                            }
                        }
                        if(chnlTgtCheckSaveFlag) {
                            String tgtChnlListValue = String.join(",", ketNameList);
                            param.setTgtChnlList(tgtChnlListValue);

                            if(mktContentMapper.insertBrazeCamApiData(param) > 0){
                                rtnValue.setSuccess(true);
                                rtnValue.setMessage("캠페인 조회에 성공하였습니다.");
                            } else {
                                rtnValue.setSuccess(false);
                                rtnValue.setMessage("캠페인 조회에 실패하였습니다. 관리자에게 문의해주세요.");
                            }
                        } else {
                            rtnValue.setSuccess(true);
                            rtnValue.setMessage("불러올 캠페인이 없습니다. 잠시후 다시 시도해주세요.");
                        }
                    } else {
                        rtnValue.setSuccess(true);
                        rtnValue.setMessage("불러올 캠페인이 없습니다. 잠시후 다시 시도해주세요.");
                    }
                }

            } catch (Exception e){
                LogUtil.error(e.toString());
                rtnValue.setSuccess(false);
                rtnValue.setMessage("캠페인 조회에 실패하였습니다. 관리자에게 문의해주세요.");
            }


        }
        return rtnValue;
    }

    //http연결부
    private ClientHttpRequestFactory getClientHttpRequestFactory() {
        int timeout = 99999;
        HttpComponentsClientHttpRequestFactory clientHttpRequestFactory
                = new HttpComponentsClientHttpRequestFactory();
        clientHttpRequestFactory.setConnectTimeout(timeout);
        return clientHttpRequestFactory;
    }

    /**
     * @return : MktContentResDto
     * @programId :
     * @name : getPointOfrList
     * @description : 포인트 오퍼 조회
     */
    public GridPagingResDto<OfferResDto> getPointOfrList(OfferReqDto reqDto) {

        LogUtil.param(this.getClass(), reqDto);

        return new GridPagingResHelper<OfferResDto>().
                newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType())
                        , mktContentMapper.selectPointOfrList(reqDto), AnnotationType.CommCode);
    }

    /**
     * @return : StatusResDto
     * @programId :
     * @name : saveContsOfr
     * @date : 2020. 11. 13.
     * @author : yj.choi
     * @table : loy_cpn_mbr
     * @description : 컨텐츠 오퍼 rid 저장
     */
    public StatusResDto saveContsOfr(OfferReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        return mktContentMapper.insertContsOfr(reqDto);
    }

    ;

    /**
     * @return : StatusResDto
     * @programId :
     * @name : saveContsKakao
     * @date : 2021. 01. 07.
     * @author : lee gyeong young
     * @table :
     * @description : 카카오 알림톡/친구톡 신규
     */
    public StatusResDto saveContsKakao(MktContentReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        reqDto.setId(commonService.getRowID());
        rtnValue.setSuccess(false);

        for (MktContentKaKaoReqDto listData : reqDto.getKakaoConts()) {
            listData.setRidContsMst(reqDto.getId());
            listData.setSystemColumn(reqDto.getSystemColumn());
            mktContentMapper.insertContsKakaoBtn(listData);
        }
        mktContentMapper.insertContsKakao(reqDto);
        rtnValue.setSuccess(true);
        rtnValue.setMessage(reqDto.getId());
        return rtnValue;
    }

    ;

    /**
     * @return : StatusResDto
     * @programId :
     * @name : changeSaveContsKakao
     * @date : 2021. 01. 07.
     * @author : lee gyeong young
     * @table :
     * @description : 카카오 알림톡/친구톡 수정
     */
    public StatusResDto changeSaveContsKakao(MktContentReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);


        mktContentMapper.allDeleteContsKakaoBtn(reqDto);
        for (MktContentKaKaoReqDto listData : reqDto.getKakaoConts()) {
            listData.setRidContsMst(reqDto.getId());
            listData.setModifyBy(reqDto.getModifyBy());
            listData.setCreateBy(reqDto.getCreateBy());
            mktContentMapper.insertContsKakaoBtn(listData);
        }

        mktContentMapper.updateContsKakao(reqDto);
        rtnValue.setSuccess(true);
        rtnValue.setMessage(reqDto.getId());
        return rtnValue;
    }

    ;

    /**
     * @return : StatusResDto
     * @programId :
     * @name : getDescContsKakao
     * @date : 2021. 01. 07.
     * @author : lee gyeong young
     * @table :
     * @description : 카카오 알림톡/친구톡 조회 상세
     */
    public MktContentResDto getDescContsKakao(MktContentReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        return mktContentMapper.getDescContsKakao(reqDto);
    }

    ;

    /**
     * @return : GridPagingResDto<MktContentKaKaoReqDto>
     * @programId :
     * @name : getGridContsKakao
     * @date : 2021. 01. 07.
     * @author : lee gyeong young
     * @table :
     * @description : 카카오 알림톡/친구톡 조회 그리드
     */
    public GridPagingResDto<MktContentKaKaoResDto> getGridContsKakao(MktContentReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        return new GridPagingResHelper<MktContentKaKaoResDto>().
                newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType())
                        , mktContentMapper.alreadyContsKakaoBtn(reqDto), AnnotationType.CommCode);
    }

    ;

    /**
     * @programId :
     * @name : sendChannelTestSend
     * @date : 2021. 01. 13.
     * @author : lee gyeong young
     * @table :
     * @description : 카카오 알림톡/친구톡 테스트 발송
     */
    public StatusResDto sendChannelTestSend(notiAltTestReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        String forEmpId = reqDto.getCreateBy();
        String sendEmpDesName = mktContentMapper.selectAuthInfoDescente(forEmpId);

        MktContentResDto contentData = mktContentMapper.getTestSendDescContsKakao(reqDto);
        List<ContentKaKaoResDto> contentBtnData = mktContentMapper.selectTestSendContentBtnKaKao(reqDto);

        contentData.setAuthInfoDes(sendEmpDesName);

        String tranSubject = contentData.getTitle();
        String tranMsg = contentData.getContents();
        String tranReplaceMsg = contentData.getAttrib01();
        String tranSenderkey = contentData.getAttrib02();
        String tranTemplateCode = contentData.getAttrib03();
        String tranTypeCd = contentData.getAttrib04();

        contentData.setAttrib05(reqDto.getHhpValue().toString());
        StringBuilder tranButtonData = new StringBuilder();

        String firstBtnData = "{ \"attachment\":{ " + "\"button\":[";
        String lastBtnData = "] } }";

        int btnTotal = contentBtnData.size();
        int countBtn = 0;

        for (ContentKaKaoResDto btnData : contentBtnData) {
            String lierBtnData = null;

            if (StringUtil.isNotEmpty(btnData.getPcUrl())) {
                lierBtnData = " {\"name\":\"" + btnData.getBtnName() + "\",\"type\":\"" + btnData.getType() + "\",\"url_pc\":\"" + btnData.getPcUrl() + "\",\"url_mobile\":\"" + btnData.getMobileUrl() + "\"}";
            } else {
                lierBtnData = " {\"name\":\"" + btnData.getBtnName() + "\",\"type\":\"" + btnData.getType() + "\",\"url_mobile\":\"" + btnData.getMobileUrl() + "\"}";
            }

            if (countBtn == 0) {
                if (tranButtonData != null) {
                    tranButtonData
                            .append(firstBtnData)
                            .append(lierBtnData);
                }
            } else {
                if (tranButtonData != null) {
                    tranButtonData
                            .append(",")
                            .append(lierBtnData);
                }
            }
            countBtn++;
            if (btnTotal == countBtn) {
                tranButtonData
                        .append(lastBtnData);
            }
        }

        if (btnTotal == 0) {
            tranButtonData
                    .append(firstBtnData)
                    .append(lastBtnData);
        }

        String TRAN_SUBJECT_DATA = tranSubject;
        String TRAN_MSG_DATA = tranMsg;
        String TRAN_REPLACE_MSG_DATA = tranReplaceMsg;
        String TRAN_BUTTON_DATA = tranButtonData.toString();


        //컨텐츠 제목
        String kakaoContsTitle = StringUtil.convertNull(TRAN_SUBJECT_DATA);
        //컨텐츠 내용
        String kakaoContsSbst = StringUtil.convertNull(TRAN_MSG_DATA);
        //컨텐츠 대체 메세지
        String kakaoContsSbstReplace = StringUtil.convertNull(TRAN_REPLACE_MSG_DATA);

        String kakaoAttrValue = "";

        ArrayList<String> indexOfStrData = new ArrayList<String>();
        if (reqDto.getPersnal1() != null && reqDto.getPersnal1Value() != null
                && !reqDto.getPersnal1().equals("") && !reqDto.getPersnal1Value().equals("")) {
            indexOfStrData.add(reqDto.getPersnal1());
        }
        if (reqDto.getPersnal2() != null && reqDto.getPersnal2Value() != null
                && !reqDto.getPersnal2().equals("") && !reqDto.getPersnal2Value().equals("")) {
            indexOfStrData.add(reqDto.getPersnal2());
        }
        if (reqDto.getPersnal3() != null && reqDto.getPersnal3Value() != null
                && !reqDto.getPersnal3().equals("") && !reqDto.getPersnal3Value().equals("")) {
            indexOfStrData.add(reqDto.getPersnal3());
        }
        if (reqDto.getPersnal4() != null && reqDto.getPersnal4Value() != null
                && !reqDto.getPersnal4().equals("") && !reqDto.getPersnal4Value().equals("")) {
            indexOfStrData.add(reqDto.getPersnal4());
        }
        if (reqDto.getPersnal5() != null && reqDto.getPersnal5Value() != null
                && !reqDto.getPersnal5().equals("") && !reqDto.getPersnal5Value().equals("")) {
            indexOfStrData.add(reqDto.getPersnal5());
        }
        if (reqDto.getPersnal6() != null && reqDto.getPersnal6Value() != null
                && !reqDto.getPersnal6().equals("") && !reqDto.getPersnal6Value().equals("")) {
            indexOfStrData.add(reqDto.getPersnal6());
        }
        if (reqDto.getPersnal7() != null && reqDto.getPersnal7Value() != null
                && !reqDto.getPersnal7().equals("") && !reqDto.getPersnal7Value().equals("")) {
            indexOfStrData.add(reqDto.getPersnal7());
        }
        Integer j = 1;
        for (String dataList : indexOfStrData) {
            String colKorNm = dataList;
            String indexOfStr = "{{" + colKorNm + "}}";
            String replaceStr = "[{][{]" + colKorNm + "[}][}]";

            //개인화 속성값 '(' or ')' 포함인 경우 '[]'로 감싸준다.
            replaceStr = replaceStr.replaceAll("[(]", Matcher.quoteReplacement("[(]"));
            replaceStr = replaceStr.replaceAll("[)]", Matcher.quoteReplacement("[)]"));
            kakaoAttrValue = "etc" + j;

            if (kakaoContsTitle.indexOf(indexOfStr) > -1 || kakaoContsSbst.indexOf(indexOfStr) > -1 || kakaoContsSbstReplace.indexOf(indexOfStr) > -1) {
                kakaoContsTitle = kakaoContsTitle.replaceAll(replaceStr, Matcher.quoteReplacement(kakaoAttrValue));
                kakaoContsSbst = kakaoContsSbst.replaceAll(replaceStr, Matcher.quoteReplacement(kakaoAttrValue));
                kakaoContsSbstReplace = kakaoContsSbstReplace.replaceAll(replaceStr, Matcher.quoteReplacement(kakaoAttrValue));
            }
            j++;
        }

        int idx = 1;

        if (kakaoContsTitle.indexOf("etc1") > -1 || kakaoContsSbst.indexOf("etc1") > -1 || kakaoContsSbstReplace.indexOf("etc1") > -1) {
            if (StringUtil.isNotEmpty(reqDto.getPersnal1Value())) {
                kakaoContsTitle = kakaoContsTitle.replaceAll("etc1", reqDto.getPersnal1Value());
                kakaoContsSbst = kakaoContsSbst.replaceAll("etc1", reqDto.getPersnal1Value());
                kakaoContsSbstReplace = kakaoContsSbstReplace.replaceAll("etc1", reqDto.getPersnal1Value());
            }
        }
        if (kakaoContsTitle.indexOf("etc2") > -1 || kakaoContsSbst.indexOf("etc2") > -1 || kakaoContsSbstReplace.indexOf("etc2") > -1) {
            if (StringUtil.isNotEmpty(reqDto.getPersnal2Value())) {
                kakaoContsTitle = kakaoContsTitle.replaceAll("etc2", reqDto.getPersnal2Value());
                kakaoContsSbst = kakaoContsSbst.replaceAll("etc2", reqDto.getPersnal2Value());
                kakaoContsSbstReplace = kakaoContsSbstReplace.replaceAll("etc2", reqDto.getPersnal2Value());
            }
        }
        if (kakaoContsTitle.indexOf("etc3") > -1 || kakaoContsSbst.indexOf("etc3") > -1 || kakaoContsSbstReplace.indexOf("etc3") > -1) {
            if (StringUtil.isNotEmpty(reqDto.getPersnal3Value())) {
                kakaoContsTitle = kakaoContsTitle.replaceAll("etc3", reqDto.getPersnal3Value());
                kakaoContsSbst = kakaoContsSbst.replaceAll("etc3", reqDto.getPersnal3Value());
                kakaoContsSbstReplace = kakaoContsSbstReplace.replaceAll("etc3", reqDto.getPersnal3Value());
            }
        }
        if (kakaoContsTitle.indexOf("etc4") > -1 || kakaoContsSbst.indexOf("etc4") > -1 || kakaoContsSbstReplace.indexOf("etc4") > -1) {
            if (StringUtil.isNotEmpty(reqDto.getPersnal4Value())) {
                kakaoContsTitle = kakaoContsTitle.replaceAll("etc4", reqDto.getPersnal4Value());
                kakaoContsSbst = kakaoContsSbst.replaceAll("etc4", reqDto.getPersnal4Value());
                kakaoContsSbstReplace = kakaoContsSbstReplace.replaceAll("etc4", reqDto.getPersnal4Value());
            }
        }
        if (kakaoContsTitle.indexOf("etc5") > -1 || kakaoContsSbst.indexOf("etc5") > -1 || kakaoContsSbstReplace.indexOf("etc5") > -1) {
            if (StringUtil.isNotEmpty(reqDto.getPersnal5Value())) {
                kakaoContsTitle = kakaoContsTitle.replaceAll("etc5", reqDto.getPersnal5Value());
                kakaoContsSbst = kakaoContsSbst.replaceAll("etc5", reqDto.getPersnal5Value());
                kakaoContsSbstReplace = kakaoContsSbstReplace.replaceAll("etc5", reqDto.getPersnal5Value());
            }
        }
        if (kakaoContsTitle.indexOf("etc6") > -1 || kakaoContsSbst.indexOf("etc6") > -1 || kakaoContsSbstReplace.indexOf("etc6") > -1) {
            if (StringUtil.isNotEmpty(reqDto.getPersnal6Value())) {
                kakaoContsTitle = kakaoContsTitle.replaceAll("etc6", reqDto.getPersnal6Value());
                kakaoContsSbst = kakaoContsSbst.replaceAll("etc6", reqDto.getPersnal6Value());
                kakaoContsSbstReplace = kakaoContsSbstReplace.replaceAll("etc6", reqDto.getPersnal6Value());
            }
        }
        if (kakaoContsTitle.indexOf("etc7") > -1 || kakaoContsSbst.indexOf("etc7") > -1 || kakaoContsSbstReplace.indexOf("etc7") > -1) {
            if (StringUtil.isNotEmpty(reqDto.getPersnal7Value())) {
                kakaoContsTitle = kakaoContsTitle.replaceAll("etc7", reqDto.getPersnal7Value());
                kakaoContsSbst = kakaoContsSbst.replaceAll("etc7", reqDto.getPersnal7Value());
                kakaoContsSbstReplace = kakaoContsSbstReplace.replaceAll("etc7", reqDto.getPersnal7Value());
            }
        }
        contentData.setTitle(kakaoContsTitle);
        contentData.setContents(kakaoContsSbst);
        contentData.setAttrib06(kakaoContsSbstReplace);
        contentData.setAttrib07(TRAN_BUTTON_DATA);

        //알림톡
        if(reqDto.getSendKakaoChnlType().equals("noti")) {
            if (tranChnlEshopMapper.insertSendKakaoNoti(contentData) > -1) {
                rtnValue.setSuccess(true);
            } else {
                rtnValue.setSuccess(false);
            }
        //친구톡
        } else {
            if (tranChnlEshopMapper.insertSendKakaoFr(contentData) > -1) {
                rtnValue.setSuccess(true);
            }  else {
                rtnValue.setSuccess(false);
            }
        }

        return rtnValue;
    }

    ;

    /**
     * @programId :
     * @name : sendEmailTestSend
     * @date : 2021. 01. 13.
     * @author : lee gyeong young
     * @table :
     * @description : 이메일 테스트 발송
     */
    public StatusResDto sendEmailTestSend(notiAltTestReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        try {
            MktContentResDto contentData = mktContentMapper.selectTestSendContentEmail(reqDto);

            String tranSubject = contentData.getTitle();
            String tranMsg = contentData.getHtml();


            String TRAN_SUBJECT_DATA = tranSubject;
            String TRAN_MSG_DATA = tranMsg;


            //컨텐츠 제목
            String emailContsTitle = StringUtil.convertNull(TRAN_SUBJECT_DATA);
            //컨텐츠 내용
            String emailContsSbst = StringUtil.convertNull(TRAN_MSG_DATA);

            String emailAttrValue = "";

            ArrayList<String> indexOfStrData = new ArrayList<String>();

            if (reqDto.getPersnal1() != null && reqDto.getPersnal1Value() != null
                    && !reqDto.getPersnal1().equals("") && !reqDto.getPersnal1Value().equals("")) {
                indexOfStrData.add(reqDto.getPersnal1());
            }
            if (reqDto.getPersnal2() != null && reqDto.getPersnal2Value() != null
                    && !reqDto.getPersnal2().equals("") && !reqDto.getPersnal2Value().equals("")) {
                indexOfStrData.add(reqDto.getPersnal2());
            }
            if (reqDto.getPersnal3() != null && reqDto.getPersnal3Value() != null
                    && !reqDto.getPersnal3().equals("") && !reqDto.getPersnal3Value().equals("")) {
                indexOfStrData.add(reqDto.getPersnal3());
            }
            if (reqDto.getPersnal4() != null && reqDto.getPersnal4Value() != null
                    && !reqDto.getPersnal4().equals("") && !reqDto.getPersnal4Value().equals("")) {
                indexOfStrData.add(reqDto.getPersnal4());
            }
            if (reqDto.getPersnal5() != null && reqDto.getPersnal5Value() != null
                    && !reqDto.getPersnal5().equals("") && !reqDto.getPersnal5Value().equals("")) {
                indexOfStrData.add(reqDto.getPersnal5());
            }
            if (reqDto.getPersnal6() != null && reqDto.getPersnal6Value() != null
                    && !reqDto.getPersnal6().equals("") && !reqDto.getPersnal6Value().equals("")) {
                indexOfStrData.add(reqDto.getPersnal6());
            }
            if (reqDto.getPersnal7() != null && reqDto.getPersnal7Value() != null
                    && !reqDto.getPersnal7().equals("") && !reqDto.getPersnal7Value().equals("")) {
                indexOfStrData.add(reqDto.getPersnal7());
            }
            Integer j = 1;
            for (String dataList : indexOfStrData) {
                String colKorNm = dataList;
                String indexOfStr = "{{" + colKorNm + "}}";
                String replaceStr = "[{][{]" + colKorNm + "[}][}]";

                //개인화 속성값 '(' or ')' 포함인 경우 '[]'로 감싸준다.
                replaceStr = replaceStr.replaceAll("[(]", Matcher.quoteReplacement("[(]"));
                replaceStr = replaceStr.replaceAll("[)]", Matcher.quoteReplacement("[)]"));
                emailAttrValue = "{{etc" + j + "}}";

                if (emailContsTitle.indexOf(indexOfStr) > -1 || emailContsSbst.indexOf(indexOfStr) > -1) {
                    emailContsTitle = emailContsTitle.replaceAll(replaceStr, Matcher.quoteReplacement(emailAttrValue));
                    emailContsSbst = emailContsSbst.replaceAll(replaceStr, Matcher.quoteReplacement(emailAttrValue));
                }
                j++;
            }

            SesManager sesManager = new SesManager();
            AwsSesManagerReqDto awsReqDto = new AwsSesManagerReqDto();


            // 템플릿 생성
            awsReqDto.setTempNm(CommonUtil.newRid());
            awsReqDto.setText("");
            awsReqDto.setTextHtml(emailContsSbst);
            awsReqDto.setSubject(emailContsTitle);

            rtnValue = sesManager.createEmailTemplate(awsReqDto);
            List<AwsSesManagerReqDto> personalData = new ArrayList<>();


            String lnlDname = "락앤락몰";
            awsReqDto.setSenderAddrName(lnlDname);
            awsReqDto.setSenderAddr("mailer@locknlock.com");
            String lnlAddress = sesManager.encodeNameWithAddress(awsReqDto);

            awsReqDto.setSender(lnlAddress);
            awsReqDto.setTempNm(awsReqDto.getTempNm()); // 템플릿 설정

            AwsSesManagerReqDto personal = new AwsSesManagerReqDto();
            Map<String, String> etcMap = new HashMap<>();


            if (emailContsTitle.indexOf("etc1") > -1 || emailContsSbst.indexOf("etc1") > -1) {
                if (StringUtil.isNotEmpty(reqDto.getPersnal1Value())) {
                    etcMap.put("etc1", reqDto.getPersnal1Value());
                }
            }
            if (emailContsTitle.indexOf("etc2") > -1 || emailContsSbst.indexOf("etc2") > -1) {
                if (StringUtil.isNotEmpty(reqDto.getPersnal2Value())) {
                    etcMap.put("etc2", reqDto.getPersnal2Value());
                }
            }
            if (emailContsTitle.indexOf("etc3") > -1 || emailContsSbst.indexOf("etc3") > -1) {
                if (StringUtil.isNotEmpty(reqDto.getPersnal3Value())) {
                    etcMap.put("etc3", reqDto.getPersnal3Value());
                }
            }
            if (emailContsTitle.indexOf("etc4") > -1 || emailContsSbst.indexOf("etc4") > -1) {
                if (StringUtil.isNotEmpty(reqDto.getPersnal4Value())) {
                    etcMap.put("etc4", reqDto.getPersnal4Value());
                }
            }
            if (emailContsTitle.indexOf("etc5") > -1 || emailContsSbst.indexOf("etc5") > -1) {
                if (StringUtil.isNotEmpty(reqDto.getPersnal5Value())) {
                    etcMap.put("etc5", reqDto.getPersnal5Value());
                }
            }
            if (emailContsTitle.indexOf("etc6") > -1 || emailContsSbst.indexOf("etc6") > -1) {
                if (StringUtil.isNotEmpty(reqDto.getPersnal6Value())) {
                    etcMap.put("etc6", reqDto.getPersnal6Value());
                }
            }
            if (emailContsTitle.indexOf("etc7") > -1 || emailContsSbst.indexOf("etc7") > -1) {
                if (StringUtil.isNotEmpty(reqDto.getPersnal7Value())) {
                    etcMap.put("etc7", reqDto.getPersnal7Value());
                }
            }
            // json parsing
            try {
                ObjectMapper mapper = new ObjectMapper();
                String jsonString;
                jsonString = mapper.writeValueAsString(etcMap);
                personal.setReplaceData(jsonString);

            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
            personal.setReceiver(reqDto.getEmailValue());
            personalData.add(personal);

            awsReqDto.setDefaultData("{\"etc1\":\"none\",\"etc2\":\"none\",\"etc3\":\"none\",\"etc4\":\"none\",\"etc5\":\"none\",\"etc6\":\"none\",\"etc7\":\"none\"}");
            awsReqDto.setPersonalData(personalData);

            //발송
            rtnValue = sesManager.personalSendEmail(awsReqDto);
        } catch (Exception e) {
            rtnValue.setSuccess(false);
        }
        return rtnValue;
    }

    public MKTDBInfoDTO getDbInfo(MKTDBInfoDTO dbInfo) {
        if (ObjectUtil.isNotEmpty(dbInfo.getSecretNm())) {
            try {
                Map<String, Object> dbInfoJSON = new SecretsManager(BeansUtil.getAWSCredentials(),
                        BeansUtil.getAwsRegion()
                ).getSecretMap(dbInfo.getSecretNm());

                dbInfo.setUrl(dbInfoJSON.get("url").toString());
                dbInfo.setUserName(dbInfoJSON.get("username").toString());
                dbInfo.setPassword(dbInfoJSON.get("password").toString());
                dbInfo.setConIp(dbInfoJSON.get("ip").toString());
                dbInfo.setConPort(dbInfoJSON.get("port").toString());

            } catch (IllegalArgumentException e) {
                LogUtil.error(e.getMessage());
            }
        } else {
            dbInfo.setPassword(this.encryptor.decrypt(dbInfo.getPassword()));
        }

        return dbInfo;
    }

    /**
     * @return : StatusResDto
     * @programId : MKT_CTE_P02
     * @name : getPersonalType
     * @date : 2022. 04. 06.
     * @author : 정수지
     * @table : mst_conts_mst (콘텐츠 마스터 테이블)
     * @description : 개인화 속성 가져오기
     */
    public List<MktCondResDto> getPersonalType(MktCondReqDto param) {
        LogUtil.param(this.getClass(), param);

        return mktContentMapper.selectPersonalType(param);
    }


    /**
     * @return : List<MKTTemplateListResponseDTO>
     * @programId : MKT_CTE_P05
     * @name : selectPhoneNo
     * @date : 2022. 04. 18.
     * @author : 정수지
     * @table :
     * @description : 전화번호 조회
     */
    public MktContentResDto selectPhoneNo(MktContentReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktContentMapper.selectPhoneNo(mcr);
    }

}
