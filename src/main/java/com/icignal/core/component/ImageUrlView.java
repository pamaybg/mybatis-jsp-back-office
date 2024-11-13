package com.icignal.core.component;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.FTPUtil;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.util.LogUtil;

@Component
public class ImageUrlView extends AbstractView {

    protected final Logger log = LoggerFactory.getLogger(this.getClass());

    /*@Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String imagePath = (String) model.get("imagePath");
        String imageName = (String) model.get("imageName");


        response.setContentType("images/*");
        if (imageName != null && !imageName.isEmpty()) {
            String fileUploadPath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadFullPath");
            File targetFile = Paths.get(fileUploadPath, imagePath, imageName).toFile();

            if (targetFile.exists()) {
                response.getOutputStream().write(FileUtils.readFileToByteArray(targetFile));
            } else {
                String realPath = Objects.requireNonNull(getServletContext()).getRealPath("/");
                File file = Paths.get(realPath, "/resources/images/marketing/content/photo_def.jpg").toFile();

                response.getOutputStream().write(FileUtils.readFileToByteArray(file));
            }
        } else {
            //File file = readFile(imagePath);
            //확장자 뒤의 ?에서부터 문자 제거
            int pos = imagePath.lastIndexOf('.');
            int pos2 = imagePath.lastIndexOf('?');
            if (pos < pos2) {
                imagePath = imagePath.substring(0, pos2);
            }

            File targetFile = Paths.get(imagePath).toFile();

            if (targetFile.exists()) {
                response.getOutputStream().write(FileUtils.readFileToByteArray(targetFile));
            } else {
                String realPath = Objects.requireNonNull(getServletContext()).getRealPath("/");
                try {
                    File targetFile2 = Paths.get(realPath, imagePath).toFile();
                    if (targetFile2.exists()) {
                        response.getOutputStream().write(FileUtils.readFileToByteArray(targetFile2));
                    } else {
                        File file = Paths.get(realPath, "/resources/images/marketing/content/photo_def.jpg").toFile();
                        response.getOutputStream().write(FileUtils.readFileToByteArray(file));
                    }
                } catch (Exception e) {
                    File file = Paths.get(realPath, "/resources/images/marketing/content/photo_def.jpg").toFile();
                    response.getOutputStream().write(FileUtils.readFileToByteArray(file));
                }
            }
        }
    } */

    // file server에서 이미지 블러오기 (컨텐츠, 설문)
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String imagePath = (String) model.get("imagePath");
        String imageName = (String) model.get("imageName");

        // Content
        if(imagePath == null){
            String temp = imageName.substring(1);
            temp = temp.indexOf("?") > 0 ? temp.substring(0, temp.indexOf("?")) : temp;
            imagePath = "content_images";
            imageName = temp;
        }

        response.setContentType("images/*");
        if (imageName != null && !imageName.isEmpty()) {

            File targetFile = FTPUtil.getFile(imagePath, imageName);

            if (targetFile != null) {
                if (targetFile.exists()) response.getOutputStream().write(FileUtils.readFileToByteArray(targetFile));
            }
            else {
                String realPath = Objects.requireNonNull(getServletContext()).getRealPath("/");
                File file = Paths.get(realPath, "/resources/images/marketing/content/photo_def.jpg").toFile();

                response.getOutputStream().write(FileUtils.readFileToByteArray(file));
            }

        } else {
            //File file = readFile(imagePath);
            //확장자 뒤의 ?에서부터 문자 제거
            int pos = imagePath.lastIndexOf('.');
            int pos2 = imagePath.lastIndexOf('?');
            if (pos < pos2) {
                imagePath = imagePath.substring(0, pos2);
            }

            File targetFile = Paths.get(imagePath).toFile();

            if (targetFile.exists()) {
                response.getOutputStream().write(FileUtils.readFileToByteArray(targetFile));
            } else {
                String realPath = Objects.requireNonNull(getServletContext()).getRealPath("/");
                try {
                    File targetFile2 = Paths.get(realPath, imagePath).toFile();
                    if (targetFile2.exists()) {
                        response.getOutputStream().write(FileUtils.readFileToByteArray(targetFile2));
                    } else {
                        File file = Paths.get(realPath, "/resources/images/marketing/content/photo_def.jpg").toFile();
                        response.getOutputStream().write(FileUtils.readFileToByteArray(file));
                    }
                } catch (Exception e) {
                    File file = Paths.get(realPath, "/resources/images/marketing/content/photo_def.jpg").toFile();
                    response.getOutputStream().write(FileUtils.readFileToByteArray(file));
                }
            }
        }
    }
    /**
     * 파일로부터 byte 배열 읽어오기
     */
    private File readFile(String path) throws IOException {
        byte[] bytes = new byte[0];
        if (path != null) {
            String filePath = "";

            filePath = HTMLTagFilterRequestWrapper.decodeXSS(path);

            //확장자 뒤의 ?에서부터 문자 제거
            int pos = filePath.lastIndexOf('.');
            int pos2 = filePath.lastIndexOf('?');
            if (pos < pos2) {
                filePath = filePath.substring(0, pos2);
            }

            //캐릭터 셋 확인
            String[] charSet = {"utf-8", "euc-kr", "ksc5601", "iso-8859-1", "x-windows-949"};
            boolean setFlag = false;
            for (int i = 0; i < charSet.length; i++) {
                for (int j = 0; j < charSet.length; j++) {
                    try {
                        String str = new String(path.getBytes(charSet[i]), charSet[j]);
                        //LogUtil.debug("check Char Set : [" + charSet[i] + "][" + charSet[j] + "]" + str);

                        if (Paths.get(filePath).toFile().exists()) {
                            setFlag = true;
                            break;
                        } else if (new File(getServletContext().getRealPath(str)).exists()) {
                            setFlag = true;
                            filePath = getServletContext().getRealPath(str);
                            break;
                        }
                    } catch (UnsupportedEncodingException e) {
                        LogUtil.error(e);
                    }
                }

                if (setFlag) break;
            }

            //해당 파일이 없다면 기본 이미지 출력
            if (!(new File(filePath).exists())) {
                filePath = getServletContext().getRealPath("/resources/images/marketing/content/photo_def.jpg");
            }

            if (new File(filePath).exists()) {
                return new File(filePath);
            }
        }

        return null;
    }

    /**
     * 응답 OutputStream에 파일 내용 쓰기
     *
     * @throws IOException
     */
    private void write(HttpServletResponse res, byte[] bytes) throws IOException {
        OutputStream output = res.getOutputStream();
        try {
            output.write(bytes);
            output.flush();
        } catch (IOException e) {
            LogUtil.error(e);
        } finally {
            output.close();
        }
    }


}
