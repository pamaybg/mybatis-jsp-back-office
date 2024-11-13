package com.icignal.core.component;



import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;

public class ExcelViewHelper {
    private String currentDate;
    private String path;
    private String fileName;
    private String encodeFileName;
    private String pathFileName;

    public ExcelViewHelper(String fileName) {
        this.currentDate =  DateUtil.getFormattedDate(new Date(), "yyyyMMddHHmmss" );
        this.fileName = fileName;
        this.encodeFileName = encodeUTF8(fileName);
        this.path = BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path");
        this.pathFileName = this.path  + File.separator + this.fileName + "_" + this.currentDate;
    }


    private String encodeUTF8(String fileName) {
        String encodedFileName = "TEMP";
        try {
            encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        } catch (UnsupportedEncodingException e) {
        	LogUtil.error(e);
        }
        return encodedFileName;
    }

    public String getCurrentDate() {
        return currentDate;
    }

    public String getEncodeFileName() {
        return encodeFileName;
    }

    public String getPathFileName(){
        return pathFileName;
    }

    public String getFileName() {
        return fileName;
    }


	public String getPath() {
		return path;
	}


	public void setPath(String path) {
		this.path = path;
	}


	public void setCurrentDate(String currentDate) {
		this.currentDate = currentDate;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public void setEncodeFileName(String encodeFileName) {
		this.encodeFileName = encodeFileName;
	}


	public void setPathFileName(String pathFileName) {
		this.pathFileName = pathFileName;
	}
    
}
