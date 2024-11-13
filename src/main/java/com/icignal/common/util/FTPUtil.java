package com.icignal.common.util;

import com.icignal.qpid.ftp.FTPManager;
import com.jcraft.jsch.SftpException;
import org.apache.commons.net.ftp.FTP;

import java.io.*;
import java.util.*;
import java.util.stream.Stream;

/**
 * SFTP Utility
 *
 * @author bg.yoon
 *
 */

public class FTPUtil {

    /**
     * SFTP 파일 업로드
     *
     * @param customPath SURVEY, CONTENT 중 하나
     * @param middlePath 업로드할 중간 폴더 경로
     * @param targetPath 업로드할 이미지 파일이 임시저장되어있는 경로
     * @return boolean
     */
    public static boolean saveFile(String customPath, String middlePath, String targetPath){
        try{
            FTPManager ftp = new FTPManager();
            ftp.initializeConnection(getUserName(), getPassword(), PATH.find(customPath).customPath, getBaseUri(), getBasePort(), true);
            if(middlePath != null) ftp.mkdirMiddlePath(middlePath);
            ftp.sendNotifications(targetPath);
            ftp.disconnection();

            return true;
        } catch(Exception e){
            LogUtil.error(e.getMessage(), e);
            return false;
        }


    }

    /**
     * SFTP 파일 불러오기
     *
     * @param imagePath 파일이 저장되어있는 파일서버의 상대경로 ( ex: survey_images/2022/02/08 )
     * @param fileName 불러올 파일의 이름
     * @return tempFile 불러온 이미지 파일
     */
    public static File getFile(String imagePath, String fileName) {
        InputStream in = null;
        String customPath = null;
        String[] imagePathArray = null;
        // Window
        if(File.separator.equals("\\")) imagePathArray = imagePath.split("\\\\");
        // Linux
        else if(File.separator.equals("/")) imagePathArray = imagePath.split("\\/");

        // Content, Survey 분류
        customPath = imagePathArray[0].substring(0, imagePathArray[0].indexOf("_"));

        // imagePath 중 날짜 부분만 추출
        String datePath = "";
        if(customPath.equals("survey")){
            String[] datePathArray = Arrays.copyOfRange(imagePathArray, 1, imagePathArray.length);
            datePath = String.join("/", datePathArray);
        }

        FTPManager ftp = new FTPManager();
        try {
            ftp.initializeConnection(getUserName(), getPassword(), PATH.find(customPath.toUpperCase()).customPath, getBaseUri(), getBasePort(), true);
            in = ftp.getFile(datePath, fileName);

            if(in != null) {
                File tempFile = File.createTempFile(String.valueOf(in.hashCode()), ".tmp");
                tempFile.deleteOnExit();

                copyInputStreamToFile(in, tempFile);
                return tempFile;
            }
            return null;
        } catch (IOException e) {
            LogUtil.error(e.getMessage(), e);
            return null;
        } finally {
            ftp.disconnection();
        }
    }

    /**
     * SFTP 파일 삭제
     *
     * @param imagePath 파일이 저장되어있는 파일서버의 상대경로 ( ex: survey_images/2022/02/08/example.PNG )
     * @return void
     */
    public static void deleteFile(String imagePath){
        if(imagePath == null) return;
        String[] imagePathArray = null;
        // Window
        if(File.separator.equals("\\")) {
            String[] splitTemp = imagePath.split("\\\\");
            String[] lastIndexSplitTemp = splitTemp[splitTemp.length-1].split("\\/");
            splitTemp = Arrays.copyOfRange(splitTemp, 0, splitTemp.length-1);
            imagePathArray = Stream.of(splitTemp, lastIndexSplitTemp).flatMap(Stream::of).toArray(String[]::new);
        }
        // Linux
        else if(File.separator.equals("/")) imagePathArray = imagePath.split("\\/");

        // Content, Survey 분류
        String customPath = imagePathArray[0].substring(0, imagePathArray[0].indexOf("_"));

        // File 이름 추출
        String fileName = imagePathArray[imagePathArray.length-1];

        // 중간 경로 추출
        String middlePath = "";
        
        String[] middlePathArray = Arrays.copyOfRange(imagePathArray, 1, imagePathArray.length-1);
        middlePath = String.join("/", middlePathArray);


        FTPManager ftp = new FTPManager();
        try {
            ftp.initializeConnection(getUserName(), getPassword(), PATH.find(customPath.toUpperCase()).customPath, getBaseUri(), getBasePort(), true);
            ftp.removeFile(middlePath, fileName);
        } catch (Exception e) {
            LogUtil.error(e.getMessage(), e);
        } finally {
            ftp.disconnection();
        }
    }

    /**
     * InputStream 내용을 임시 파일로 복사
     *
     * @param inputStream 파일서버로부터 불러온 파일의 정보
     * @param file 스트림의 내용을 받을 빈 파일
     * @return void
     */
    private static void copyInputStreamToFile(InputStream inputStream, File file){
        try (FileOutputStream outputStream = new FileOutputStream(file)){
            int read;
            byte[] bytes = new byte[1024];

            while((read = inputStream.read(bytes)) != -1){
                outputStream.write(bytes,0,read);
            }
        } catch (IOException e){
            LogUtil.error(e.getMessage(), e);
        }
    }

    /**
     * SFTP username
     */
    private static String getUserName(){
        return BeansUtil.getApplicationProperty("icignal.sftp.username");
    }

    /**
     * SFTP password
     */
    private static String getPassword(){
        return BeansUtil.getApplicationProperty("icignal.sftp.password");
    }

    /**
     * SFTP password
     */
    private static String getBaseUri(){
        return BeansUtil.getApplicationProperty("icignal.sftp.base-uri");
    }

    private static int getBasePort(){
        return Integer.parseInt(BeansUtil.getApplicationProperty("icignal.sftp.base-port"));
    }

    /**
     * 경로 구분
     *
     */
    private enum PATH {
        SURVEY("/app/web/image.descentekorea.co.kr/crm/UploadFile/survey_images"),
        CONTENT("/app/web/image.descentekorea.co.kr/crm/UploadFile/content_images");


        private final String customPath;

        PATH(String path) {
            this.customPath = path;
        }

        public String getPath() {
            return customPath;
        }

        public String getName() {
            return this.toString();
        }

        public static PATH find(String arg) {
            return Arrays.stream(values())
                    .filter(path -> path.getName().equals(arg))
                    .findAny()
                    .orElse(null);
        }
    }

}
