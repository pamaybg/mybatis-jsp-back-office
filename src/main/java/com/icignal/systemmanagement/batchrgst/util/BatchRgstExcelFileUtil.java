package com.icignal.systemmanagement.batchrgst.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import com.icignal.loyalty.channel.dto.request.LoyChnlReqDto;
import org.apache.commons.logging.Log;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ooxml.util.SAXHelper;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.eventusermodel.ReadOnlySharedStringsTable;
import org.apache.poi.xssf.eventusermodel.XSSFReader;
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler;
import org.apache.poi.xssf.model.SharedStringsTable;
import org.apache.poi.xssf.model.StylesTable;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.context.support.WebApplicationObjectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.xml.sax.ContentHandler;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.core.exception.DataFailException;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemReqDto;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpListReqDto;
import com.icignal.loyalty.event.dto.request.LOYProdRequestDTO;
import com.icignal.loyalty.event.dto.request.LoyEvtApplctReqDto;
import com.icignal.loyalty.faq.dto.request.LoyFaqUploadReqDto;
import com.icignal.loyalty.membershipcard.cardmaster.dto.request.LoyCardNoPoolReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyCategoryGrpListReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyProdGrpListReqDto;
import com.icignal.loyalty.product.dto.request.LoySetProdListReqDto;
import com.icignal.loyalty.targetgrp.dto.request.LoyTgtGrpXmListReqDto;
import com.icignal.offer.dto.request.OfferJoinChnlItemReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemBatchRgstUploadReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemPntBatchRgstUploadReqDto;
import com.icignal.systemmanagement.batchrgst.dto.request.SystemUploadReqDto;
import com.icignal.systemmanagement.roadaddress.dto.request.RoadAddressReqDto;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
* @name : infavor.loyalty.batchRgst.util.BatchRgstExcelFileUtil
* @date : 2017. 11. 28.
* @author : kimjunki
* @description :
*/
public class BatchRgstExcelFileUtil extends WebApplicationObjectSupport {


	public static final String UTF8_BOM = "\uFEFF";

//	@Autowired
//	private WebApplicationObjectSupport webApplicationObjectSupport;


//	@Autowired
//	private ILOYBatchRgstDAO iLoyBatchRegistDAO;
	


	/**
	* @programId   :
	* @name        : excelFileUpload
	* @date        : 2017. 11. 28.
	* @author      : kimjunki
	* @table       :
	* @return      : List<SystemBatchRgstUploadReqDto>
	* @description :
	**/
	public List<SystemBatchRgstUploadReqDto> excelFileUpload(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
	    String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");
		String offerType = (String) obj.get("offerType");
		//rid= iMKTBase.getRowID();
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

	    MultipartFile  excelFile=null;
	    while(iterator.hasNext()){
		    MultipartFile multipartFile = null;
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
	    }

	//    File destFile = new File( request.getSession().getServletContext().getRealPath("/") +CommonUtil.getInstance().getExcelFileUploadPath()+excelFile.getOriginalFilename());

	    //확장자 구하기
	    String orgName = excelFile.getOriginalFilename();
	    String filePath = request.getSession().getServletContext().getRealPath("/") +CommonUtil.getInstance().getExcelFileUploadPath();
	    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length());
	    String imsiFile = rid+'.'+exc;
	    File saveFile  = new File(filePath+imsiFile);
	    List<SystemBatchRgstUploadReqDto> upldList = new ArrayList<SystemBatchRgstUploadReqDto>();
	    SystemBatchRgstUploadReqDto param = new SystemBatchRgstUploadReqDto();
	    
	    try{
            excelFile.transferTo(saveFile);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }

	    if(!exc.equals("xlsx") && !exc.equals("xls")){
	    	param.setUploadValidCheck("EXT");
	    	upldList.add(param);
	    	return upldList;
	    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
	    	param.setUploadValidCheck("SIZE");
	    	upldList.add(param);
	    	return upldList;
	    }

	    //엑셀 읽기
	    ExcelReadOption ro = new ExcelReadOption();

	    ro.setFilePath(saveFile.getPath());
	    upldList.clear();
	    
	    param.setFileName(excelFile.getOriginalFilename());
		upldList.add(param);
		param.setOfferType(offerType);
		param.setFilePath(saveFile.getPath());
		
		FileInputStream fi = null;
		HSSFWorkbook workbook = null;
		
		try {
			fi = new FileInputStream(saveFile);
			workbook = new HSSFWorkbook(fi);
		    int excelRowValid=0;
		    if(offerType.equals("PNT")){
		    	excelRowValid = 5;
		    	ro.setOutputColumns("A", "B","C","D","E");
			    ro.setStartRow(2);
		        HSSFSheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		        int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		        numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
			    //coulumsize 비교
			    if(excelRowValid != numOfCells){
			    	upldList.clear();
			    	return upldList;
			    }
			    upldList.addAll(1, ExcelRead.pntRead(ro)) ;
			    
		    }else if(offerType.equals("STMP")){
		    	excelRowValid = 3;
		    	ro.setOutputColumns("A", "B", "C");
			    ro.setStartRow(2);
			    ro.getOutputColumns().size()  ;
		        HSSFSheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		        int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		        numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
			    //coulumsize 비교
			    if(excelRowValid != numOfCells){
			    	upldList.clear();
			    	return upldList;
			    }
			    upldList.addAll(1, ExcelRead.stampRead(ro)) ;
			    
		    }else if(offerType.equals("PROD")) {
		    	excelRowValid = 3;
		    	ro.setOutputColumns("A", "B", "C");
			    ro.setStartRow(2);
			    ro.getOutputColumns().size()  ;
		        HSSFSheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		        int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		        numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
			    //coulumsize 비교
			    if(excelRowValid != numOfCells){
			    	upldList.clear();
			    	return upldList;
			    }
			    upldList.addAll(1, ExcelRead.stampRead(ro)) ;
		    }
		    if(upldList.size()<2){
		    	upldList.clear();
		    	param.setUploadValidCheck("NOTUPLD");
		    	upldList.add(param);
		    }
		}catch(IOException e) {
			LogUtil.error(e);
		}finally {
		    fi.close();
		    workbook.close();
		}
	    //리스트 반환
	    return upldList;
	}



	public StatusResDto excelFileDown(HttpServletRequest request,SystemBatchRgstUploadReqDto param)  throws Exception {
		String fileName="";
		StatusResDto rtnValue = new StatusResDto();
		if(param.getOfferType().equals("STMP")){
			fileName="stamp_sample_data.xls";
		}else if(param.getOfferType().equals("PNT")){
			fileName="point_sample_data.xls";
		}else if(param.getOfferType().equals("CARD")){
			fileName="card_sample_data.xls";
		}else if(param.getOfferType().equals("TARGET_MEMBER")){
			fileName="mbr_sample_data.xls";
		}else if(param.getOfferType().equals("100") || param.getOfferType().equals("200")){
			
			fileName="event_sample_data.xls";
		}
		String strPhyfullpath = "/"+CommonUtil.getInstance().getExcelFileSampleDownPath()  + fileName;
		if(!fileName.equals("")){
			String filePath = new String ( strPhyfullpath.getBytes("utf-8"));
		//	String filePath = new String ( strPhyfullpath.getBytes("euc-kr"),"utf-8");
		    rtnValue.setSuccess(true);
		    rtnValue.setMessage(filePath);
		}
		return rtnValue;
	}

	public StatusResDto excelRead(File f) throws Exception{
	    ExcelReadOption ro = new ExcelReadOption();

	    List<SystemBatchRgstUploadReqDto> stmpList = new ArrayList<SystemBatchRgstUploadReqDto>();
	    ro.setFilePath(f.getPath());
	    //coulumsize 비교

	    ro.setOutputColumns("A", "B","C","D");
	    ro.setStartRow(2);
	    ro.getOutputColumns().size()  ;
	    stmpList = ExcelRead.stampRead(ro);
	    //리스트 insert처리
	    return null;
	}
	//UTF-8일때 처리 부분
//    private static String removeUTF8BOM(String s) {
//
//        if (s.startsWith(UTF8_BOM)) {
//            s = s.substring(1);
//        }
//        return s;
//    }
//

    //엑셀 파일이름 중복 체크
    public File rename(File file) {             //File file는 원본 파일
    	
    	File f = file;
    	
        if (createNewFile(f)) return f;        //생성된 f가 중복되지 않으면 리턴

        String name = f.getName();
        String body = null;
        String ext = null;

        int dot = name.lastIndexOf('.');
        if (dot != -1) {                              //확장자가 없을때
          body = name.substring(0, dot);
          ext = name.substring(dot);
        } else {                                     //확장자가 있을때
          body = name;
          ext = "";
        }

        int count = 0;
        //중복된 파일이 있을때
        while (!createNewFile(f) && count < 9999) {
          count++;
          String newName = body + " ("+count+")" + ext;
          f = new File(f.getParent(), newName);
        }
        return f;
      }

      private boolean createNewFile(File f) {
        try {
          return f.createNewFile();                        //존재하는 파일이 아니면
        }catch (IOException ignored) {
          return false;
        }
      }

      public StatusResDto gridExcelDown(HttpServletRequest request,SystemBatchRgstUploadReqDto param)  throws Exception {
    	  return null;
  	}

  	/**
  	* @programId :
  	* @name : excelFileUploadPnt
  	* @date : 2018. 11. 5.
  	* @author : hy.jun
  	* @table :
  	* @return : List<SystemBatchRgstUploadReqDto>
  	* @description :
  	*/
  	public SystemPntBatchRgstUploadReqDto excelFileUploadPnt(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
	    String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
		ns = HTMLTagFilterRequestWrapper.decodeXSS(ns);
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");
		String offerType = (String) obj.get("offerType");
		String fileUploadDt = (String) obj.get("fileUploadDt");
		String uploadTypeCd = (String) obj.get("uploadTypeCd");
		String procTypeCd = (String) obj.get("procTypeCd");
		String procDtlTypeCd = (String) obj.get("procDtlTypeCd");
		String pntApplyDt = (String) obj.get("pntApplyDt");
		String pgmRid = (String)obj.get("pgmRid");

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

	    MultipartFile  excelFile=null;
	    while(iterator.hasNext()){
		    MultipartFile multipartFile = null;
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
	    }
	    
	    //확장자 구하기
	    String orgName = excelFile.getOriginalFilename();
	    
	    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));

	    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;
	    
	    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length());
	    String imsiFile = rid+'.'+exc;
	    File saveFileOrg  = new File(filePath+orgName);
	    SystemPntBatchRgstUploadReqDto upldList = new SystemPntBatchRgstUploadReqDto();
	    
	    upldList.setRid(rid);
	    upldList.setFileUploadDt(fileUploadDt);
	    upldList.setUploadTypeCd(uploadTypeCd);
	    upldList.setProcTypeCd(procTypeCd);
	    upldList.setProcDtlTypeCd(procDtlTypeCd);
	    upldList.setPntApplyDt(pntApplyDt);
	    upldList.setPgmRid(pgmRid);

	    if(!new File(filePath).isDirectory()) {
	    	saveFileOrg.mkdirs();
	    }

	    if(!exc.equals("xlsx") && !exc.equals("xls")){
	    	upldList.setUploadValidCheck("EXT");
	    	saveFileOrg.delete();
	    	return upldList;
	    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
	    	upldList.setUploadValidCheck("SIZE");
	    	saveFileOrg.delete();
	    	return upldList;
	    }else if(saveFileOrg.exists()) { //다이소 포인트수동일괄등록 엑셀 파일명 중복 허용하지 않는다.
	    	upldList.setUploadValidCheck("DUP");
	    	return upldList;
	    }

	    try{
            excelFile.transferTo(saveFileOrg);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }

	    //엑셀 읽기
	    ExcelReadOption ro = new ExcelReadOption();

	    ro.setFilePath(saveFileOrg.getPath());
	    upldList.getArray().clear();
	    upldList.setFileName(excelFile.getOriginalFilename());
	    upldList.setOfferType(offerType);
	    upldList.setFilePath(saveFileOrg.getPath());
		FileInputStream fi = null;
		Workbook workbook = null;
		
		try {
			fi = new FileInputStream(saveFileOrg);
			if(upldList.getFileName().endsWith(".xls")) {
				workbook = new HSSFWorkbook(fi);
			} else if(upldList.getFileName().endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(fi);
			}
			
		    int excelRowValid=0;
		    
		    if(offerType.equals("100")||offerType.equals("200")) {
		    	excelRowValid = 4;
		    	ro.setOutputColumns("A","B","C","D");
			    ro.setStartRow(2);
		        Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		        int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		        numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
			    //coulumsize 비교
			    if(excelRowValid != numOfCells){
			    	upldList.getArray().clear();
			    	return upldList;
			    }
			    upldList.getArray().addAll(ExcelRead.surveyRead(ro)) ;
		    }else if(offerType.equals("TARGET_EVENT")){
		    	excelRowValid = 4;
		    	ro.setOutputColumns("A","B","C","D");
			    ro.setStartRow(2);
			    ro.getOutputColumns().size()  ;
			    Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		        int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		        numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
			    //coulumsize 비교
			    if(excelRowValid != numOfCells){
			    	upldList.getArray().clear();
			    	saveFileOrg.delete();
			    	return upldList;
			    }
			    upldList.getArray().addAll(ExcelRead.eventRead(ro)) ;
		    }else if(offerType.equals("TARGET_EMP")){
		    	excelRowValid = 4;
		    	ro.setOutputColumns("A","B","C","D");
		    	ro.setStartRow(2);
		    	ro.getOutputColumns().size()  ;
		    	Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		    	int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		    	numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
		    	//coulumsize 비교
		    	if(excelRowValid != numOfCells){
		    		upldList.getArray().clear();
		    		saveFileOrg.delete();
		    		return upldList;
		    	}
		    	upldList.getArray().addAll(ExcelRead.empRead(ro)) ;
		    }else if(offerType.equals("TARGET_MEMBER_CI")){
		     	excelRowValid = 3;
		    	ro.setOutputColumns("A","B","C");
			    ro.setStartRow(2);
		        Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		        int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		        numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
			    //coulumsize 비교
			    if(excelRowValid != numOfCells){
			    	upldList.getArray().clear();
			    	return upldList;
			    }
			    upldList.getArray().addAll(ExcelRead.ciRead(ro)) ;
		    }else if(offerType.equals("PROD")) {
		    	excelRowValid = 3;
		    	ro.setOutputColumns("A", "B", "C");
			    ro.setStartRow(2);
			    Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		        int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		        numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
			    //coulumsize 비교
			    if(excelRowValid != numOfCells){
			    	upldList.getArray().clear();
			    	return upldList;
			    }
			    upldList.getArray().addAll(ExcelRead.ciRead(ro)) ;
		    }else if(offerType.equals("TARGET_SURVEY")){
		    	excelRowValid = 4;
		    	ro.setOutputColumns("A","B","C","D");
			    ro.setStartRow(2);
		        Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		        int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		        numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
			    //coulumsize 비교
			    if(excelRowValid != numOfCells){
			    	upldList.getArray().clear();
			    	return upldList;
			    }
			    upldList.getArray().addAll(ExcelRead.surveyRead(ro)) ;
		    }
		    if(ObjectUtil.isEmpty(upldList.getArray())){
		    	upldList.setUploadValidCheck("NOTUPLD");
		    	upldList.getArray().clear();
		    	saveFileOrg.delete();
		    }
	
		    //upldList.setFileUploadDt(IFVMDateUtility.getToday("YYMMdd"));
		    upldList.setUploadCnt(String.valueOf(upldList.getArray().size()));
	
		    //원본파일 read 끝난 후 byte 암호화한다.
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
		    }
		}catch(IOException e) {
			LogUtil.error(e);
		}finally {
		    fi.close();
		    workbook.close();
		}
	    //리스트 반환
	    return upldList;
	}

  	/**
  	* @programId :
  	* @name : excelFileUploadPnt
  	* @date : 2018. 11. 5.
  	* @author : hy.jun
  	* @table :
  	* @return : List<SystemBatchRgstUploadReqDto>
  	* @description :
  	*/
  	public SystemPntBatchRgstUploadReqDto excelUploadSmsUnSub(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
	    String[] rs = mptRequest.getParameterValues("param");
		String ns = new String(rs[0].getBytes("iso-8859-1"),"utf-8");
		JSONObject json = (JSONObject) JSONSerializer.toJSON(ns);
		JSONObject obj = (JSONObject) json.get("data");
		String offerType = (String) obj.get("offerType");
		String fileUploadDt = (String) obj.get("fileUploadDt");
		String uploadTypeCd = (String) obj.get("uploadTypeCd");
		String procTypeCd = (String) obj.get("procTypeCd");
		String pntApplyDt = (String) obj.get("pntApplyDt");

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

	    MultipartFile  excelFile=null;
	    while(iterator.hasNext()){
		    MultipartFile multipartFile = null;
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
	    }


	    //확장자 구하기
	    String orgName = excelFile.getOriginalFilename();
	    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path").replaceAll("/", Matcher.quoteReplacement(File.separator));

	    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

	    if(orgName == null) return null;
	    
	    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length());
	   // String imsiFile = rid+'.'+exc;
	    File saveFileOrg  = new File(filePath+orgName);

	    SystemPntBatchRgstUploadReqDto upldList = new SystemPntBatchRgstUploadReqDto();
	    upldList.setRid(rid);
	    upldList.setFileUploadDt(fileUploadDt);
	    upldList.setUploadTypeCd(uploadTypeCd);
	    upldList.setProcTypeCd(procTypeCd);
	    upldList.setPntApplyDt(pntApplyDt);

	    if(!new File(filePath).isDirectory()) {
	    	saveFileOrg.mkdirs();
	    }

	    if(!exc.equals("xlsx") && !exc.equals("xls")){
	    	upldList.setUploadValidCheck("EXT");
	    	saveFileOrg.delete();
	    	return upldList;

	    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
	    	upldList.setUploadValidCheck("SIZE");
	    	saveFileOrg.delete();
	    	return upldList;

	    }else if(saveFileOrg.exists()) { //다이소 포인트수동일괄등록 엑셀 파일명 중복 허용하지 않는다.
	    	upldList.setUploadValidCheck("DUP");
	    	return upldList;
	    }

	    try{
            excelFile.transferTo(saveFileOrg);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }

	    //엑셀 읽기
	    ExcelReadOption ro = new ExcelReadOption();

	    ro.setFilePath(saveFileOrg.getPath());
	    upldList.getArray().clear();
	    upldList.setFileName(excelFile.getOriginalFilename());
	    upldList.setOfferType(offerType);
	    upldList.setFilePath(saveFileOrg.getPath());

		FileInputStream fi = null;
		Workbook workbook = null;

		try {
			fi = new FileInputStream(saveFileOrg);
			if(upldList.getFileName().endsWith(".xls")) {
				workbook = new HSSFWorkbook(fi);
			} else if(upldList.getFileName().endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(fi);
			}
			
		
	
		    int excelRowValid=0;
		    excelRowValid = 3;
	
		    //A,B,C 셀
		    ro.setOutputColumns("A","B","C");
		    //시작로우
			ro.setStartRow(2);
	
			if(workbook == null ) return upldList;
			
		    Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		    int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		    numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
	
			//coulumsize 비교
			if(excelRowValid != numOfCells){
				upldList.getArray().clear();
				return upldList;
			}
			upldList.getArray().addAll(ExcelRead.smsRead(ro)) ;
	
		    upldList.setUploadCnt(String.valueOf(upldList.getArray().size()));
	
		    //원본파일 read 끝난 후 byte 암호화한다.
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
		    }
		}catch(IOException e) {
			LogUtil.error(e);
		}finally {
		    fi.close();
		    workbook.close();
		}
		//리스트 반환
	    return upldList;
	}

  	
  	/**
  	* @programId :
  	* @name : excelUploadProd
  	* @date : 2019. 6. 13.
  	* @author : dw.keum
  	* @table :
  	* @return : SystemPntBatchRgstUploadReqDto
  	* @description :
  	*/
  	@SuppressWarnings("unchecked")
	public List<LoySetProdListReqDto> excelUploadProd(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

	    MultipartFile  excelFile=null;
	    while(iterator.hasNext()){
		    MultipartFile multipartFile = null;
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
	    }

	    //확장자 구하기
	    String orgName = excelFile.getOriginalFilename();
	    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path").replaceAll("/", Matcher.quoteReplacement(File.separator));

	    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

	    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
	    String imsiFile = rid+'.'+exc;
	    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

	    List<LoySetProdListReqDto> upldList = new ArrayList<LoySetProdListReqDto>();
	    LoySetProdListReqDto param = new LoySetProdListReqDto();
	    
	    if(!new File(filePath).isDirectory()) {
	    	saveFileOrg.mkdirs();
	    }

	    if(!exc.equals("xlsx") && !exc.equals("xls")){
	    	param.setUploadValidCheck("EXT");
	    	upldList.add(param);
	    	return upldList;

	    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
	    	param.setUploadValidCheck("SIZE");
	    	upldList.add(param);
	    	return upldList;

	    }

	    try{
            excelFile.transferTo(saveFileOrg);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }
	    
	    //엑셀 읽기
	    ExcelReadOption ro = new ExcelReadOption();
	    
	     
	    ro.setFilePath(saveFileOrg.getPath());
	    upldList.clear();
	    param.setFileName(excelFile.getOriginalFilename());
	    param.setFileName(excelFile.getOriginalFilename());
	    
	    
		FileInputStream fi = null;
		Workbook workbook = null;
		OPCPackage opc = null;
		try {
			fi = new FileInputStream(saveFileOrg);
			
			if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
				opc = OPCPackage.open(saveFileOrg);
				XSSFReader xssfReader = new XSSFReader(opc);
	
				XSSFReader.SheetIterator itr = (XSSFReader.SheetIterator)xssfReader.getSheetsData();
				StylesTable styles = xssfReader.getStylesTable();
				ReadOnlySharedStringsTable strings = new ReadOnlySharedStringsTable(opc);
				List<String[]> dataList = new ArrayList<String[]>();
				List<LoySetProdListReqDto> resDto = new ArrayList<LoySetProdListReqDto>();
				LoySetProdListReqDto obj = new LoySetProdListReqDto();
				while(itr.hasNext()) {
				    InputStream sheetStream = itr.next();
				    InputSource sheetSource = new InputSource(sheetStream);        
				 
				    //Sheet2ListHandler은 엑셀 data를 가져와서 SheetContentsHandler(Interface)를 재정의 해서 만든 Class
				    Sheet2ListHandler sheet2ListHandler = new Sheet2ListHandler(4, resDto,obj);   //Sheet2ListHandler은 엑셀 data를 가져와서 SheetContentsHandler(Interface)를 재정의 해서 만든 Class  
				    
				    //new XSSFSheetXMLHandler(StylesTable styles, ReadOnlySharedStringsTable strings, SheetContentsHandler sheet2ListHandler, boolean formulasNotResults)
				    //핸들러는  Sheet의 행(row) 및 Cell 이벤트를 생성
				    ContentHandler handler = new XSSFSheetXMLHandler(styles, strings, sheet2ListHandler, false);
				    
				    //sax parser를 생성하고...
				    try{SAXParserFactory saxFactory=SAXParserFactory.newInstance();
				    SAXParser saxParser=saxFactory.newSAXParser();       
				    
				    //sax parser 방식의 xmlReader를 생성
				    XMLReader sheetParser = saxParser.getXMLReader();
				    
				    //xml reader에 row와 cell 이벤트를 생성하는 핸들러를 설정한 후.
				    sheetParser.setContentHandler(handler);
				    
				    //위에서 Sheet 별로 생성한 inputSource를 parsing합니다.
				    //이 과정에서 handler는 row와 cell 이벤트를 생성하고 생성된 이벤트는 sheet2ListHandler 가 받아서 처리합니
				    sheetParser.parse(sheetSource);
				    
				    }catch(Exception e) {
				    	LogUtil.error(e);
				    }
				    upldList.addAll(sheet2ListHandler.getList());
				sheetStream.close();
				}
				
				//workbook = new XSSFWorkbook(fi);
			} else if(excelFile.getOriginalFilename().endsWith(".xls")) {
				workbook = new HSSFWorkbook(fi);
				
				int excelRowValid = 4;
			    //A,B,C 셀
			    ro.setOutputColumns("A","B","C","D");
			    //시작로우
				ro.setStartRow(2);
	
			    Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
			    int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
			    numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
	
				//coulumsize 비교
				if(excelRowValid != numOfCells){
					upldList.clear();
					return upldList;
				}
				//List<LoySetProdListReqDto> List
				upldList.addAll(ExcelRead.prodRead(ro)) ;
				
			    //원본파일 read 끝난 후 byte 암호화한다.
				
			}
			
		    /*int excelRowValid = 4;
		    //A,B,C 셀
		    ro.setOutputColumns("A","B","C","D");
		    //시작로우
			ro.setStartRow(2);
	
		    Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		    int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		    numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
	
			//coulumsize 비교
			if(excelRowValid != numOfCells){
				upldList.clear();
				return upldList;
			}
			//List<LoySetProdListReqDto> List
			upldList.addAll(ExcelRead.prodRead(ro)) ;*/
			
		    //원본파일 read 끝난 후 byte 암호화한다.
			
			LogUtil.error("saveFile :  " +saveFileOrg.exists()); 
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
		    }
		}catch(IOException e) {
			LogUtil.error(e);
		}finally {
			opc.close();
			workbook.close();
			fi.close();	
		}
	    
	  
	    
	    //리스트 반환
	    return upldList;
	}
  	
  	/**
  	* @programId :
  	* @name : excelUploadEventWinner
  	* @date : 2019. 7. 9.
  	* @author : dw.keum
  	* @table :
  	* @return : List<LOYEvtApplctRequestDTO>
  	* @description :
  	*/
  	public List<LoyEvtApplctReqDto> excelUploadEventWinner(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {

  		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

	    MultipartFile  excelFile=null;
	    while(iterator.hasNext()){
		    MultipartFile multipartFile = null;
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
	    }


	    String orgName = excelFile.getOriginalFilename();
	    String realPath = request.getSession().getServletContext().getRealPath("/").replaceAll("/", Matcher.quoteReplacement(File.separator));
	    String filePath = realPath + BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path").replaceAll("/", Matcher.quoteReplacement(File.separator));

	    filePath = filePath.replace("해당업무", "loyBatchRgst");

	    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
	    String imsiFile = rid+'.'+exc;
	    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

	    List<LoyEvtApplctReqDto> upldList = new ArrayList<LoyEvtApplctReqDto>();
	    LoyEvtApplctReqDto param = new LoyEvtApplctReqDto();
	    
	    if(!new File(filePath).isDirectory()) {
	    	saveFileOrg.mkdirs();
	    }

	    if(!exc.equals("xlsx") && !exc.equals("xls")){
	    	param.setUploadValidCheck("EXT");
	    	upldList.add(param);
	    	return upldList;

	    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
	    	param.setUploadValidCheck("SIZE");
	    	upldList.add(param);
	    	return upldList;

	    }

	    try{
            excelFile.transferTo(saveFileOrg);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }

	    //엑셀 읽기
	    ExcelReadOption ro = new ExcelReadOption();

	    ro.setFilePath(saveFileOrg.getPath());
	    upldList.clear();
	    param.setFileName(excelFile.getOriginalFilename());
	    
		FileInputStream fi = null;
		Workbook workbook = null;

		try {
			fi = new FileInputStream(saveFileOrg);
			if(excelFile.getOriginalFilename().endsWith(".xls")) {
				workbook = new HSSFWorkbook(fi);
			} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(fi);
			}
		    int excelRowValid = 2;
		    //A,B,C 셀
		    ro.setOutputColumns("A","B","C"); 
		    //시작로우
			ro.setStartRow(2);
	
		    Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
		    int numOfCells = sheet.getPhysicalNumberOfRows(); // 해당 시트
		    numOfCells = sheet.getRow(0).getPhysicalNumberOfCells();
	
			//coulumsize 비교
			/*if(excelRowValid != numOfCells){
				upldList.clear();
				return upldList;
			}*/
			
			upldList.addAll(ExcelRead.evnetWinnerRead(ro)) ;
			
		    //원본파일 read 끝난 후 byte 암호화한다.
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);	    
		    	}
		}catch(IOException e) {
			LogUtil.error(e);
			
		}finally {
			workbook.close();
			fi.close();
		}
	    //리스트 반환
	    return upldList;
	}
  	
  	
	public List<LoyFaqUploadReqDto> FaqUploadData(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {

  		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

	    MultipartFile  excelFile=null;
	    while(iterator.hasNext()){
		    MultipartFile multipartFile = null;
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
	    }

	    //확장자 구하기
	    String orgName = excelFile.getOriginalFilename();
	    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));

	    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

	    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
	    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

	    List<LoyFaqUploadReqDto> upldList = new ArrayList<LoyFaqUploadReqDto>();
	    LoyFaqUploadReqDto param = new LoyFaqUploadReqDto();
	    
	    if(!new File(filePath).isDirectory()) {
	    	saveFileOrg.mkdirs();
	    }

	    if(!exc.equals("xlsx") && !exc.equals("xls")){
	    	param.setUploadValidCheck("EXT");
	    	upldList.add(param);
	    	return upldList;

	    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
	    	param.setUploadValidCheck("SIZE");
	    	upldList.add(param);
	    	return upldList;

	    }

	    try{
            excelFile.transferTo(saveFileOrg);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }

	    //엑셀 읽기
	    ExcelReadOption ro = new ExcelReadOption();

	    ro.setFilePath(saveFileOrg.getPath());
	    upldList.clear();
	    param.setFileName(excelFile.getOriginalFilename());
	    
		FileInputStream fi = null;
		Workbook workbook = null;

		try {
			fi = new FileInputStream(saveFileOrg);
			if(excelFile.getOriginalFilename().endsWith(".xls")) {
				workbook = new HSSFWorkbook(fi);
			} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(fi);
			}
			int excelRowValid = 6;
		    //A,B,C 셀
		    ro.setOutputColumns("A","B","C","D","E","F");
		    //시작로우
			ro.setStartRow(3);
			
			upldList.addAll(ExcelRead.faqUploadRead(ro)) ;
			
		    //원본파일 read 끝난 후 byte 암호화한다.
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
		    }
	    }catch(IOException e) {
	    	LogUtil.error(e);
	    }finally {
		    fi.close();
		    workbook.close();
	    }
	    //리스트 반환
	    return upldList;
	}
	
	public List<LoyTgtGrpXmListReqDto> excelUploadTgtGrpXm(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {

  		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

	    MultipartFile  excelFile=null;
	    while(iterator.hasNext()){
		    MultipartFile multipartFile = null;
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
	    }

	    //확장자 구하기
	    String orgName = excelFile.getOriginalFilename();
	    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));

	    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

	    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
	    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

	    List<LoyTgtGrpXmListReqDto> upldList = new ArrayList<LoyTgtGrpXmListReqDto>();
	    LoyTgtGrpXmListReqDto param = new LoyTgtGrpXmListReqDto();
	    
	    if(!new File(filePath).isDirectory()) {
	    	saveFileOrg.mkdirs();
	    }

	    if(!exc.equals("xlsx") && !exc.equals("xls")){
	    	param.setUploadValidCheck("EXT");
	    	upldList.add(param);
	    	return upldList;

	    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
	    	param.setUploadValidCheck("SIZE");
	    	upldList.add(param);
	    	return upldList;

	    }

	    try{
            excelFile.transferTo(saveFileOrg);
        }catch(IllegalStateException | IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }

	    //엑셀 읽기
	    ExcelReadOption ro = new ExcelReadOption();

	    ro.setFilePath(saveFileOrg.getPath());
	    upldList.clear();
	    param.setFileName(excelFile.getOriginalFilename());
	    
		FileInputStream fi = null;
		Workbook workbook = null;

		try {
			fi = new FileInputStream(saveFileOrg);
			
			if(excelFile.getOriginalFilename().endsWith(".xls")) {
				workbook = new HSSFWorkbook(fi);
			} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(fi);
			}
			int excelRowValid = 6;
		    //A,B,C 셀
		    ro.setOutputColumns("A","B");
		    //시작로우
			ro.setStartRow(2);
			
			upldList.addAll(ExcelRead.tgtGrpUploadRead(ro)) ;
			
		    //원본파일 read 끝난 후 byte 암호화한다.
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
		    }
		}catch(Exception e) {
			LogUtil.error(e);
		}finally {
		    fi.close();
		    workbook.close();
		}
	    //리스트 반환
	    return upldList;
	}



	/**
	   * @programId :
	   * @name : msgUploadData
	   * @date : 2020. 01. 14.
	   * @author : sh.park
	   * @table :
	   * @return : ResponseEntity
	   * @description : 메시지 프로퍼티 파일 업로드
	*/

		public List<SystemUploadReqDto> msgUploadData(MultipartHttpServletRequest request, boolean b, String rid, String ridLang)  throws Exception {

		MultipartHttpServletRequest multipartHttpServletRequest = request;

		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

	    MultipartFile  excelFile=null;
	    while(iterator.hasNext()){
		    MultipartFile multipartFile = null;
	        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
	        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
	    }

	    //확장자 구하기
	    String orgName = excelFile.getOriginalFilename();
	    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path").replaceAll("/", Matcher.quoteReplacement(File.separator));

	    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

	    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
	    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

	    List<SystemUploadReqDto> upldList = new ArrayList<SystemUploadReqDto>();
	    SystemUploadReqDto param = new SystemUploadReqDto();
	    
	    if(!new File(filePath).isDirectory()) {
	    	saveFileOrg.mkdirs();
	    }

	    if(!exc.equals("xlsx") && !exc.equals("xls")){
	    	param.setUploadValidCheck("EXT");
	    	upldList.add(param);
	    	return upldList;

	    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
	    	param.setUploadValidCheck("SIZE");
	    	upldList.add(param);
	    	return upldList;

	    }

	    try{
          excelFile.transferTo(saveFileOrg);
      }catch(IllegalStateException | IOException e){
          throw new RuntimeException(e.getMessage(),e);
      }

	    //엑셀 읽기
	    ExcelReadOption ro = new ExcelReadOption();

	    ro.setFilePath(saveFileOrg.getPath());
	    upldList.clear();
	    param.setFileName(excelFile.getOriginalFilename());
	    
		FileInputStream fi = null;
		Workbook workbook = null;

		try {
			fi = new FileInputStream(saveFileOrg);
			if(excelFile.getOriginalFilename().endsWith(".xls")) {
				workbook = new HSSFWorkbook(fi);
			} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(fi);
			}
			int excelRowValid = 6;
		    //A,B,C 셀
		    ro.setOutputColumns("A","B","C","D","E","F");
		    //시작로우
			ro.setStartRow(3);
			
			upldList.addAll(ExcelRead.msgUploadRead(ro)) ;
			
		    //원본파일 read 끝난 후 byte 암호화한다.
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
		    }
		}catch(IOException e) {
			LogUtil.error(e);
		}finally {
		    fi.close();
		    workbook.close();
		}
	    //리스트 반환
	    return upldList;
	}
		
	  	/**
	  	* @programId :
	  	* @name : excelUploadTargetGroupItem
	  	* @date : 2019. 11. 11.
	  	* @author : dg.ryu
	  	* @table :
	  	* @return : List<LOYEvtApplctRequestDTO>
	  	* @description :
	  	*/
	  	public KprTargetGroupItemReqDto excelUploadTargetGroupItem(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {

	  		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

			multipartHttpServletRequest.setCharacterEncoding("UTF-8");
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		    MultipartFile  excelFile=null;
		    while(iterator.hasNext()){
			    MultipartFile multipartFile = null;
		        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
		    }

		    //확장자 구하기
		    String orgName = excelFile.getOriginalFilename();
		    String realPath = request.getSession().getServletContext().getRealPath("/").replaceAll("/", Matcher.quoteReplacement(File.separator));
		    String filePath = realPath + BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path").replaceAll("/", Matcher.quoteReplacement(File.separator));

		    filePath = filePath + File.separator + "tgtGroupItem" + File.separator;
		    
		    if (orgName  == null) return null;
		    
		    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		    String imsiFile = rid+'.'+exc;
		    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

		    KprTargetGroupItemReqDto param = new KprTargetGroupItemReqDto();

		    if(!new File(filePath).isDirectory()) {
		    	saveFileOrg.mkdirs();
		    }

		    if(!exc.equals("xlsx") && !exc.equals("xls")){
		    	param.setUploadValidCheck("EXT");
		    	
		    	return param;

		    }else if(excelFile.getSize()>12000000 && exc.equals("xls")){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
		    	param.setUploadValidCheck("SIZE");
		    	
		    	return param;

		    }

			try{
				excelFile.transferTo(saveFileOrg);
			}catch(IllegalStateException | IOException e){
				throw new RuntimeException(e.getMessage(),e);
			}

			//엑셀 읽기
			ExcelReadOption ro = new ExcelReadOption();


			ro.setFilePath(saveFileOrg.getPath());
			param.setFileName(excelFile.getOriginalFilename());
			param.setFileName(excelFile.getOriginalFilename());


			FileInputStream fi = null;
			Workbook workbook = null;
			OPCPackage opc = null;
			try {
				if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
					opc = OPCPackage.open(saveFileOrg);
					XSSFReader xssfReader = new XSSFReader(opc);
					ReadOnlySharedStringsTable strings = new ReadOnlySharedStringsTable(opc);
					StylesTable styles = xssfReader.getStylesTable();
					XSSFReader.SheetIterator itr = (XSSFReader.SheetIterator)xssfReader.getSheetsData();
					InputStream sheetStream = itr.next();
					InputSource sheetSource = new InputSource(sheetStream);

				    KprTargetGroupItemHandler kprTargetGroupItemHandler = new KprTargetGroupItemHandler();

					ContentHandler handler = new XSSFSheetXMLHandler(styles, strings, kprTargetGroupItemHandler, false);

					try{
						XMLReader sheetParser = SAXHelper.newXMLReader();
						sheetParser.setContentHandler(handler);
						sheetParser.parse(sheetSource);
					}catch(Exception e) {
						LogUtil.error(e);
					}
					param.setItemList(kprTargetGroupItemHandler.getKprList());
					sheetStream.close();
				} else if(excelFile.getOriginalFilename().endsWith(".xls")) {
					fi = new FileInputStream(saveFileOrg);
					workbook = new HSSFWorkbook(fi);
					if (workbook == null)  throw new DataFailException("workbook is null");

					//A,B,C 셀
					ro.setOutputColumns("A","B","C","D","E","F");
					//시작로우
					ro.setStartRow(2);
					param.setItemList(ExcelRead.tgtGroupItemRead(ro)) ;
				}

				if(saveFileOrg.exists()) {
//					SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
				}
			}catch(IOException e) {
				LogUtil.error(e);
			}finally {
				if(excelFile.getOriginalFilename().endsWith(".xlsx")){
					opc.close();
				}
				else if(excelFile.getOriginalFilename().endsWith(".xls")) {
					workbook.close();
					fi.close();
				}
			}

			//리스트 반환
			return param;
		}
	  	
	  	
	  	/**
	  	* @programId :
	  	* @name : excelUploadOfferJoinChnl
	  	* @date : 2020. 06. 13.
	  	* @author : jw.ryu
	  	* @table :
	  	* @return : List<OfferJoinChnlItemReqDto>
	  	* @description :
	  	*/
	  	public OfferJoinChnlItemReqDto excelUploadOfferJoinChnl(HttpServletRequest request,  boolean isRead, String rid)  throws Exception {

	  		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

			multipartHttpServletRequest.setCharacterEncoding("UTF-8");
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		    MultipartFile  excelFile=null;
		    while(iterator.hasNext()){
			    MultipartFile multipartFile = null;
		        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
		    }

		    //확장자 구하기
		    String orgName = excelFile.getOriginalFilename();
		    String realPath = request.getSession().getServletContext().getRealPath("/").replaceAll("/", Matcher.quoteReplacement(File.separator));
		    String filePath = realPath + BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path").replaceAll("/", Matcher.quoteReplacement(File.separator));

		    filePath = filePath + File.separator + "tgtGroupItem" + File.separator;
		    
		    if (orgName  == null) return null;
		    
		    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		    String imsiFile = rid+'.'+exc;
		    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

		    OfferJoinChnlItemReqDto param = new OfferJoinChnlItemReqDto();
		    
		    if(!new File(filePath).isDirectory()) {
		    	saveFileOrg.mkdirs();
		    }

		    if(!exc.equals("xlsx") && !exc.equals("xls")){
		    	param.setUploadValidCheck("EXT");
		    	
		    	return param;

		    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
		    	param.setUploadValidCheck("SIZE");
		    	
		    	return param;

		    }

		    try{
	            excelFile.transferTo(saveFileOrg);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }

		    //엑셀 읽기
		    ExcelReadOption ro = new ExcelReadOption();

		    ro.setFilePath(saveFileOrg.getPath());
		    param.setFileName(excelFile.getOriginalFilename());
		    
			FileInputStream fi = null;
			Workbook workbook = null;

			try {
				fi = new FileInputStream(saveFileOrg);
				String orgFileName = excelFile.getOriginalFilename();
				
				if(orgFileName == null ) throw new DataFailException("orgFileName is null");
				
				if( orgFileName.endsWith(".xls")) {
					workbook = new HSSFWorkbook(fi);
				} else if(orgFileName.endsWith(".xlsx")) {
					workbook = new XSSFWorkbook(fi);
				}
				
			    //A,B,C 셀
			    ro.setOutputColumns("A","B","C","D","E","F");
			    //시작로우
				ro.setStartRow(2);
				if (workbook == null)  throw new DataFailException("workbook is null");
				
			    param.setItemList(ExcelRead.offerJoinChnlItemRead(ro)) ;
				
			    //원본파일 read 끝난 후 byte 암호화한다.
			    if(saveFileOrg.exists()) {
			    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
			    }
			}catch(IOException e) {
				LogUtil.error(e);
			}finally {
				workbook.close();
				fi.close();
			}
		   
		    //리스트 반환
		    return param;
		}
	  	
	  	/**
	  	* @programId :
	  	* @name : excelUploadTargetGroupItem
	  	* @date : 2019. 11. 11.
	  	* @author : dg.ryu
	  	* @table :
	  	* @return : List<LOYEvtApplctRequestDTO>
	  	* @description :
	  	*/
	  	public LoyCardNoPoolReqDto excelUploadCardNoPool(HttpServletRequest request, boolean isRead, String rid)  throws Exception {

	  		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

			multipartHttpServletRequest.setCharacterEncoding("UTF-8");
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		    MultipartFile  excelFile=null;
		    while(iterator.hasNext()){
			    MultipartFile multipartFile = null;
		        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
		    }

		    //확장자 구하기
		    String orgName = excelFile.getOriginalFilename();
		    String realPath = request.getSession().getServletContext().getRealPath("/").replaceAll("/", Matcher.quoteReplacement(File.separator));
		    String filePath = realPath + BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path").replaceAll("/", Matcher.quoteReplacement(File.separator));

		    filePath = filePath + File.separator + "cardNoPool" + File.separator;
		    
		    if (orgName  == null) return null;
		    
		    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		    String imsiFile = rid+'.'+exc;
		    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

		    LoyCardNoPoolReqDto param = new LoyCardNoPoolReqDto();
		    
		    if(!new File(filePath).isDirectory()) {
		    	saveFileOrg.mkdirs();
		    }

		    if(!exc.equals("xlsx") && !exc.equals("xls")){
		    	param.setUploadValidCheck("EXT");
		    	
		    	return param;

		    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
		    	param.setUploadValidCheck("SIZE");
		    	
		    	return param;

		    }

		    try{
	            excelFile.transferTo(saveFileOrg);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }

		    //엑셀 읽기
		    ExcelReadOption ro = new ExcelReadOption();

		    ro.setFilePath(saveFileOrg.getPath());
		    //param.setFileName(excelFile.getOriginalFilename());
		    
			FileInputStream fi = null; 
			Workbook workbook = null;

			try {
				fi = new FileInputStream(saveFileOrg);
				String orgFileName = excelFile.getOriginalFilename();

				if(orgFileName == null ) throw new DataFailException("orgFileName is null");

				if( orgFileName.endsWith(".xls")) {
					workbook = new HSSFWorkbook(fi);
				} else if(orgFileName.endsWith(".xlsx")) {
					workbook = new XSSFWorkbook(fi);
				}

				//A,B,C 셀
				ro.setOutputColumns("A","B","C");
				//시작로우
				ro.setStartRow(3);
				if (workbook == null)  throw new DataFailException("workbook is null");

				param.setPoolList(ExcelRead.cardNoPoolRead(ro)) ;
			}catch(IOException e) {
				LogUtil.error(e);
			}finally {
				fi.close();
				workbook.close();
			}
		    //원본파일 read 끝난 후 byte 암호화한다.
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
		    }
		   
		    //리스트 반환
		    return param;
		}



		 /*
		  * 1. 메소드명: excelUploadProdGrpXm
		  * 2. 클래스명: BatchRgstExcelFileUtil
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 14.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param request
		 *   @param b
		 *   @param rid
		 *   @return	
		 * @throws Exception 
		 */
		
		public List<LoyProdGrpListReqDto> excelUploadProdGrpXm(MultipartHttpServletRequest request, boolean b,
				String rid) throws Exception {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

			multipartHttpServletRequest.setCharacterEncoding("UTF-8");
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		    MultipartFile  excelFile=null;
		    while(iterator.hasNext()){
			    MultipartFile multipartFile = null;
		        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
		    }

		    //확장자 구하기
		    String orgName = excelFile.getOriginalFilename();
		    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));

		    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

		    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

		    List<LoyProdGrpListReqDto> upldList = new ArrayList<LoyProdGrpListReqDto>();
		    LoyProdGrpListReqDto param = new LoyProdGrpListReqDto();
		    
		    if(!new File(filePath).isDirectory()) {
		    	saveFileOrg.mkdirs();
		    }

		    if(!exc.equals("xlsx") && !exc.equals("xls")){
		    	param.setUploadValidCheck("EXT");
		    	upldList.add(param);
		    	return upldList;

		    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
		    	param.setUploadValidCheck("SIZE");
		    	upldList.add(param);
		    	return upldList;

		    }

		    try{
	            excelFile.transferTo(saveFileOrg);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }

		    //엑셀 읽기
		    ExcelReadOption ro = new ExcelReadOption();

		    ro.setFilePath(saveFileOrg.getPath());
		    upldList.clear();
		    param.setFileName(excelFile.getOriginalFilename());
		    Workbook workbook = null;
		    FileInputStream fi = null;
		    try {
		    	fi = new FileInputStream(saveFileOrg);

		    	if(excelFile.getOriginalFilename().endsWith(".xls")) {
		    		workbook = new HSSFWorkbook(fi);
		    	} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
		    		workbook = new XSSFWorkbook(fi);
		    	}
		    } catch (IOException e) {
		    	LogUtil.error(e);
		    }finally {
		    	fi.close();
		    	if(workbook!=null) {
		    		workbook.close();
		    	}
		    	
		    }
			int excelRowValid = 6;
		    //A,B,C 셀
		    ro.setOutputColumns("A");
		    //시작로우
			ro.setStartRow(2);
			
			upldList.addAll(ExcelRead.prodGrpUploadRead(ro)) ;
			
		    //원본파일 read 끝난 후 byte 암호화한다.
		    if(saveFileOrg.exists()) {
		    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
		    }
		    //리스트 반환
		    return upldList;
		}
		public List<LoyChnlGrpListReqDto> excelUploadChnlGrpXm(MultipartHttpServletRequest request, boolean b,
				String rid) throws Exception {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
			
			multipartHttpServletRequest.setCharacterEncoding("UTF-8");
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
			
			MultipartFile  excelFile=null;
			while(iterator.hasNext()){
				MultipartFile multipartFile = null;
				multipartFile = multipartHttpServletRequest.getFile(iterator.next());
				excelFile =  multipartHttpServletRequest.getFile("fileUpload");
			}
			
			//확장자 구하기
			String orgName = excelFile.getOriginalFilename();
			String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));
			
			filePath = filePath + File.separator + "loyBatchRgst" + File.separator;
			
			String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
			File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.
			
			List<LoyChnlGrpListReqDto> upldList = new ArrayList<LoyChnlGrpListReqDto>();
			LoyChnlGrpListReqDto param = new LoyChnlGrpListReqDto();
			
			if(!new File(filePath).isDirectory()) {
				saveFileOrg.mkdirs();
			}
			
			if(!exc.equals("xlsx") && !exc.equals("xls")){
				param.setUploadValidCheck("EXT");
				upldList.add(param);
				return upldList;
				
			}else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
				param.setUploadValidCheck("SIZE");
				upldList.add(param);
				return upldList;
				
			}
			
			try{
				excelFile.transferTo(saveFileOrg);
			}catch(IllegalStateException | IOException e){
				throw new RuntimeException(e.getMessage(),e);
			}
			
			//엑셀 읽기
			ExcelReadOption ro = new ExcelReadOption();
			
			ro.setFilePath(saveFileOrg.getPath());
			upldList.clear();
			param.setFileName(excelFile.getOriginalFilename());
			
			FileInputStream fi = null;
			Workbook workbook = null;
			
			try {
				fi = new FileInputStream(saveFileOrg);
				if(excelFile.getOriginalFilename().endsWith(".xls")) {
					workbook = new HSSFWorkbook(fi);
				} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
					workbook = new XSSFWorkbook(fi);
				}
				int excelRowValid = 6;
				//A,B,C 셀
				ro.setOutputColumns("A");
				//시작로우
				ro.setStartRow(2);
				
				upldList.addAll(ExcelRead.chnlGrpUploadRead(ro)) ;
				
				//원본파일 read 끝난 후 byte 암호화한다.
				if(saveFileOrg.exists()) {
					SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
				}
			}catch(IOException e) {
				LogUtil.error(e);
			}finally {
				fi.close();
				workbook.close();
			}
			//리스트 반환
			return upldList;
		}
		



		 /*
		  * 1. 메소드명: excelUploadCategory
		  * 2. 클래스명: BatchRgstExcelFileUtil
		  * 3. 작성자명: 서정환 
		  * 4. 작성일자: 2020. 7. 15.
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *		
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param request
		 *   @param b
		 *   @param rid
		 *   @return	
		 */
		
		public List<LoyCategoryGrpListReqDto> excelUploadCategory(MultipartHttpServletRequest request, boolean b,
				String rid) throws Exception {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

			multipartHttpServletRequest.setCharacterEncoding("UTF-8");
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		    MultipartFile  excelFile=null;
		    while(iterator.hasNext()){
			    MultipartFile multipartFile = null;
		        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
		    }

		    //확장자 구하기
		    String orgName = excelFile.getOriginalFilename();
		    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));

		    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

		    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

		    List<LoyCategoryGrpListReqDto> upldList = new ArrayList<LoyCategoryGrpListReqDto>();
		    LoyCategoryGrpListReqDto param = new LoyCategoryGrpListReqDto();
		    
		    if(!new File(filePath).isDirectory()) {
		    	saveFileOrg.mkdirs();
		    }

		    if(!exc.equals("xlsx") && !exc.equals("xls")){
		    	param.setUploadValidCheck("EXT");
		    	upldList.add(param);
		    	return upldList;

		    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
		    	param.setUploadValidCheck("SIZE");
		    	upldList.add(param);
		    	return upldList;

		    }

		    try{
	            excelFile.transferTo(saveFileOrg);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }

		    //엑셀 읽기
		    ExcelReadOption ro = new ExcelReadOption();

		    ro.setFilePath(saveFileOrg.getPath());
		    upldList.clear();
		    param.setFileName(excelFile.getOriginalFilename());
		    
		    FileInputStream fi = null;
			Workbook workbook = null;
			try {
				fi = new FileInputStream(saveFileOrg);
				if(excelFile.getOriginalFilename().endsWith(".xls")) {
					workbook = new HSSFWorkbook(fi);
				} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
					workbook = new XSSFWorkbook(fi);
				}
				int excelRowValid = 6;
				// A,B,C 셀
			    ro.setOutputColumns("A");
			    //시작로우
				ro.setStartRow(2);
				
				upldList.addAll(ExcelRead.categoryUploadRead(ro)) ;
				
			    if(saveFileOrg.exists()) {
			    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
			    }
			}catch(IOException e) {
				LogUtil.error(e);
			}finally {  
				fi.close();
				workbook.close();}
		    //리스트 반환
		    return upldList;
		}
		
		
		
		/*
		  * 1. 메소드명: excelUploadRoadAddress
		  * 2. 클래스명: BatchRgstExcelFileUtil
		  * 3. 작성자명: jb.kim 
		  * 4. 작성일자: 2020. 12. 08
		  */
		/**
		 * <PRE>
		 * 1. 설명
		 *	  : 도로명 주소 관리 - '주소업로드' 시 업로드 된 엑셀파일을 처리하는 메소드
		 * 2. 사용법
		 *		
		 * </PRE>
		 *   @param request
		 *   @param b
		 *   @param rid
		 *   @return 
		 */
		
		public List<RoadAddressReqDto> excelUploadRoadAddress(MultipartHttpServletRequest request,
				boolean b, String rid) throws Exception {

			MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest)request;
			mRequest.setCharacterEncoding("UTF-8");
			
			Iterator<String> iterator = mRequest.getFileNames();
			// 엑셀파일을 집어꺼내서 담을 변수
		    MultipartFile excelFile = null;

		    while(iterator.hasNext()){
			    MultipartFile multipartFile = null;
		        multipartFile = mRequest.getFile(iterator.next());
		        excelFile =  mRequest.getFile("fileUpload");
		    }

		    //확장자 구하기
		    String orgName = excelFile.getOriginalFilename();
		    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));
		    // 파일경로 확정
		    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;
		    // 확장자명 구하기
		    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.
		    
		    // 사용할 Dto를 배열요소로 갖는 가변배열 리스트 upldList 생성
		    List<RoadAddressReqDto> upldList = new ArrayList<RoadAddressReqDto>();
		    RoadAddressReqDto param = new RoadAddressReqDto();
		    
		    // 저장할 경로에 디렉토리가 존재하는지
		    if(!new File(filePath).isDirectory()) {
		    	saveFileOrg.mkdirs();
		    }
		    // 확장자명 보고 양식 판단
		    if(!exc.equals("xlsx") && !exc.equals("xls")) {
		    	param.setUploadValidCheck("EXT");
		    	upldList.add(param);
		    	return upldList;
		    	
		    } else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
		    	param.setUploadValidCheck("SIZE");
		    	upldList.add(param);
		    	return upldList;
		    	
		    }

		    try {
	            excelFile.transferTo(saveFileOrg);
	        } catch(IllegalStateException | IOException e){
	        		System.out.println("에러발생 - IllegalStateException | IOException 중 하나");
	            throw new RuntimeException(e.getMessage(),e);
	        }

		    //엑셀 읽기
		    ExcelReadOption ro = new ExcelReadOption();

		    ro.setFilePath(saveFileOrg.getPath());
		    upldList.clear();

		    param.setFileName(excelFile.getOriginalFilename());
		    
		    // 인풋스트림
		    FileInputStream fi = null;
			Workbook workbook = null;

			try {
				fi = new FileInputStream(saveFileOrg);
				if(excelFile.getOriginalFilename().endsWith(".xls")) {
					workbook = new HSSFWorkbook(fi);
				} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
					workbook = new XSSFWorkbook(fi);
				}
				int excelRowValid = 6;
				// A,B,C 셀
			    ro.setOutputColumns("A","B","C"); //엑셀 파일에서 얻어낼 열(column)들 선택
			    //시작로우 : 엑셀 내용 상 2번째 row(행)부터 추출해낸다
				ro.setStartRow(2);
				
				upldList.addAll(ExcelRead.RoadAddressUploadRead(ro));
				
			    //원본파일 read 끝난 후 byte 암호화한다.
			    if(saveFileOrg.exists()) {
			    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
			    }
			}catch(IOException e) {
				LogUtil.error(e);
			}finally {
				fi.close();
				workbook.close();
			}
			//리스트 반환
		    return upldList;
		}// end excelUploadRoadAddress


		public List<LOYProdRequestDTO> excelUploadProdList(MultipartHttpServletRequest request, boolean b, String rid) throws Exception {
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
			multipartHttpServletRequest.setCharacterEncoding("UTF-8");
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		    MultipartFile  excelFile=null;
		    while(iterator.hasNext()){
			    MultipartFile multipartFile = null;
		        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
		    }

		    //확장자 구하기
		    String orgName = excelFile.getOriginalFilename();
		    String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));

		    filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

		    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

		    List<LOYProdRequestDTO> upldList = new ArrayList<LOYProdRequestDTO>();
		    LOYProdRequestDTO param = new LOYProdRequestDTO();
		    
		    if(!new File(filePath).isDirectory()) {
		    	saveFileOrg.mkdirs();
		    }

		    if(!exc.equals("xlsx") && !exc.equals("xls")){
		    	param.setUploadValidCheck("EXT");
		    	upldList.add(param);
		    	return upldList;

		    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
		    	param.setUploadValidCheck("SIZE");
		    	upldList.add(param);
		    	return upldList;

		    }

		    try{
	            excelFile.transferTo(saveFileOrg);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }

		    //엑셀 읽기
		    ExcelReadOption ro = new ExcelReadOption();

		    ro.setFilePath(saveFileOrg.getPath());
		    upldList.clear();
		    param.setFileName(excelFile.getOriginalFilename());
		    
		    FileInputStream fi = null;
			Workbook workbook = null;
			try {
				fi = new FileInputStream(saveFileOrg);
				if(excelFile.getOriginalFilename().endsWith(".xls")) {
					workbook = new HSSFWorkbook(fi);
				} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
					workbook = new XSSFWorkbook(fi);
				}
				// A,B,C 셀
				int excelRowValid = 5;
		    	ro.setOutputColumns("A", "B","C","D","E");
						    //시작로우
				ro.setStartRow(2);
				
				upldList.addAll(ExcelRead.prodListUploadRead(ro)) ;
				
			    if(saveFileOrg.exists()) {
			    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
			    }
			}catch(IOException e) {
				LogUtil.error(e);
			}finally {  
				fi.close();
				workbook.close();}
		    //리스트 반환
		    return upldList;
		}



		public OfferJoinChnlItemReqDto excelUploadOfferJoinProd(MultipartHttpServletRequest request, boolean b,
				String rid) throws IOException {

	  		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

			multipartHttpServletRequest.setCharacterEncoding("UTF-8");
			Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		    MultipartFile  excelFile=null;
		    while(iterator.hasNext()){
			    MultipartFile multipartFile = null;
		        multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		        excelFile =  multipartHttpServletRequest.getFile("fileUpload");
		    }

		    //확장자 구하기
		    String orgName = excelFile.getOriginalFilename();
		    String realPath = request.getSession().getServletContext().getRealPath("/").replaceAll("/", Matcher.quoteReplacement(File.separator));
		    String filePath = realPath + BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path").replaceAll("/", Matcher.quoteReplacement(File.separator));

		    filePath = filePath + File.separator + "tgtGroupItem" + File.separator;
		    
		    if (orgName  == null) return null;
		    
		    String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		    String imsiFile = rid+'.'+exc;
		    File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

		    OfferJoinChnlItemReqDto param = new OfferJoinChnlItemReqDto();
		    
		    if(!new File(filePath).isDirectory()) {
		    	saveFileOrg.mkdirs();
		    }

		    if(!exc.equals("xlsx") && !exc.equals("xls")){
		    	param.setUploadValidCheck("EXT");
		    	
		    	return param;

		    }else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
		    	param.setUploadValidCheck("SIZE");
		    	
		    	return param;

		    }

		    try{
	            excelFile.transferTo(saveFileOrg);
	        }catch(IllegalStateException | IOException e){
	            throw new RuntimeException(e.getMessage(),e);
	        }

		    //엑셀 읽기
		    ExcelReadOption ro = new ExcelReadOption();

		    ro.setFilePath(saveFileOrg.getPath());
		    param.setFileName(excelFile.getOriginalFilename());
		    
			FileInputStream fi = null;
			Workbook workbook = null;

			try {
				fi = new FileInputStream(saveFileOrg);
				String orgFileName = excelFile.getOriginalFilename();
				
				if(orgFileName == null ) throw new DataFailException("orgFileName is null");
				
				if( orgFileName.endsWith(".xls")) {
					workbook = new HSSFWorkbook(fi);
				} else if(orgFileName.endsWith(".xlsx")) {
					workbook = new XSSFWorkbook(fi);
				}
				
			    //A,B,C 셀
			    ro.setOutputColumns("A");
			    //시작로우
				ro.setStartRow(2);
				if (workbook == null)  throw new DataFailException("workbook is null");
				
			    param.setItemList(ExcelRead.offerJoinProdItemRead(ro)) ;
				
			    //원본파일 read 끝난 후 byte 암호화한다.
			    if(saveFileOrg.exists()) {
			    	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
			    }
			}catch(IOException e) {
				LogUtil.error(e);
			}finally {
				workbook.close();
				fi.close();
			}
		   
		    //리스트 반환
		    return param;
		}


	public List<LoyChnlReqDto> excelUploadChnlList(MultipartHttpServletRequest request, boolean b, String rid) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		multipartHttpServletRequest.setCharacterEncoding("UTF-8");
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

		MultipartFile  excelFile=null;
		while(iterator.hasNext()){
			MultipartFile multipartFile = null;
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			excelFile =  multipartHttpServletRequest.getFile("fileUpload");
		}

		//확장자 구하기
		String orgName = excelFile.getOriginalFilename();
		String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadExcelPath").replaceAll("/", Matcher.quoteReplacement(File.separator));

		filePath = filePath + File.separator + "loyBatchRgst" + File.separator;

		String exc  = orgName.substring(orgName.lastIndexOf('.')+1, orgName.length()).toLowerCase();
		File saveFileOrg  = new File(filePath+UUID.randomUUID().toString()+'.'+exc); // 파일 transfer시 파일명중복시 transfer 안됨.

		List<LoyChnlReqDto> upldList = new ArrayList<LoyChnlReqDto>();
		LoyChnlReqDto param = new LoyChnlReqDto();

		if(!new File(filePath).isDirectory()) {
			saveFileOrg.mkdirs();
		}

		if(!exc.equals("xlsx") && !exc.equals("xls")){
			param.setUploadValidCheck("EXT");
			upldList.add(param);
			return upldList;

		}else if(excelFile.getSize()>12000000){  // 파일의 용량이 12MB 이상이라면 오류 메시지 출력
			param.setUploadValidCheck("SIZE");
			upldList.add(param);
			return upldList;

		}

		try{
			excelFile.transferTo(saveFileOrg);
		}catch(IllegalStateException | IOException e){
			throw new RuntimeException(e.getMessage(),e);
		}

		//엑셀 읽기
		ExcelReadOption ro = new ExcelReadOption();

		ro.setFilePath(saveFileOrg.getPath());
		upldList.clear();
		param.setFileName(excelFile.getOriginalFilename());

		FileInputStream fi = null;
		Workbook workbook = null;
		try {
			fi = new FileInputStream(saveFileOrg);
			if(excelFile.getOriginalFilename().endsWith(".xls")) {
				workbook = new HSSFWorkbook(fi);
			} else if(excelFile.getOriginalFilename().endsWith(".xlsx")) {
				workbook = new XSSFWorkbook(fi);
			}
			// A,B,C,D 셀
			int excelRowValid = 4;
			ro.setOutputColumns("A","B","C","D");
			//시작로우
			ro.setStartRow(4);

			upldList.addAll(ExcelRead.chnlListUploadRead(ro)) ;

			//if(saveFileOrg.exists()) {
			//	SecurityUtil.createCryptoFile(Cipher.ENCRYPT_MODE, BeansUtil.getFileCryptorKey(), saveFileOrg, saveFileOrg);
			//}
		}catch(IOException e) {
			LogUtil.error(e);
		}finally {
			fi.close();
			workbook.close();
			if (saveFileOrg.isFile()) {
				saveFileOrg.delete();
			}
		}
		//리스트 반환
		return upldList;
	}
		
	
}
