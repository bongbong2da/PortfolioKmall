package com.kmall.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.kmall.util.FileUtils;
import com.kmall.util.MediaUtils;

@Controller
@RequestMapping(value = "/upload/*")
public class UploadController {
	
	private static final Logger log = LoggerFactory.getLogger(UploadController.class);
	
	@Resource
	//Context에 저장된 파일저장경로를 불러온다.
	String uploadPath;
	
	@ResponseBody
	@RequestMapping(value = "upload",produces="html/text;charset=UTF-8", method = RequestMethod.POST)
	public String upload(HttpServletRequest request, MultipartFile upload) throws UnsupportedEncodingException {

		log.info("Uploaded : " + upload.getOriginalFilename());

		//랜덤 ID 생성
		UUID uuid = UUID.randomUUID();

		//저장이름 초기화 및 랜덤ID_원본이름으로 저장
		String saveName = "";
		saveName = uuid.toString() + "_" + upload.getOriginalFilename();

		//원본파일의 확장자명 저장
		String format = FileUtils.getFormat(upload.getOriginalFilename());
		
		//파일이 저장될 경로를 지정
		String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/");
		
		//File객체 생성 및 경로,이름 지정
		File target = new File(savePath + saveName);
		
		try {
			//아웃풋 스트림에 타겟 File 객체를 파라미터로 지정
			FileOutputStream out = new FileOutputStream(target);
			//원본파일의 Byte[]를 타겟 File (target)에 씀.
			out.write(upload.getBytes());
			
			//저장되는 파일이 미디어타입인지 구별
			//미디어 타입이 아닐 시, 더미 이미지이름인 "file.png"를 리턴
			if(MediaUtils.getType(format) == null) {
				log.info("THE FILE IS NOT AN IMAGE TYPE");
				return "file.png";
			} else {
				//미디어 타입일 시, makeThumbnail 메소드를 호출
				log.info("THE FILE IS AN IMAGE TYPE");
				FileUtils.makeThumbnail(savePath, target);
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		log.info("Upload Method Returns : " + saveName);
		return saveName;
	}
	
	@ResponseBody
	@RequestMapping(value = "uploadCKE", method = RequestMethod.POST)
	public void uploadCKE(@RequestParam MultipartFile upload, HttpServletRequest request, HttpServletResponse response) {

		log.info("CKAJAX CALLED...");

		PrintWriter printWriter = null;

		JsonObject json = new JsonObject();

		UUID uuid = UUID.randomUUID();
		
		String saveName = uuid.toString() + "_" + upload.getOriginalFilename();
		
		String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/");
		
		File target = new File(savePath + saveName);
		
		
		try {
			FileOutputStream outStream = new FileOutputStream(target);
			
			outStream.write(upload.getBytes());
			FileUtils.makeThumbnail(savePath, target);
			
			json.addProperty("uploaded", 1);
			json.addProperty("fileName", saveName);
			json.addProperty("url", "/resources/upload/" + saveName);
			
			printWriter = response.getWriter();
			response.setContentType("text/html");
			
			printWriter.println(json);
			
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "getThumbnail", method=RequestMethod.GET)
	public ResponseEntity<byte[]> getThumbnail(HttpServletRequest request, String src) throws Exception {
		ResponseEntity<byte[]> out = null;
		HttpHeaders header = new HttpHeaders();
		MediaType mediaType = MediaUtils.getType(FileUtils.getFormat(src));
		FileInputStream in = null;
		
		String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/");
		
		if(mediaType == null) {
			String fileName = src.substring(src.indexOf("_")+1);
	    	
			File file = new File(savePath, "file.png");
			
			in = new FileInputStream(file);
			
			header.setContentType(MediaType.IMAGE_PNG);

		} else {
			header.setContentType(mediaType);

			File file = new File(savePath + "\\s_" + src);
			
			
			try {
				in = new FileInputStream(file);
				
				
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} 
		}
		out = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.OK);
		
		
		return out;
	}
	
	@RequestMapping(value = "getImage", method=RequestMethod.GET)
	public ResponseEntity<byte[]> getImage(HttpServletRequest request, String src) throws Exception {
		ResponseEntity<byte[]> out = null;
		HttpHeaders header = new HttpHeaders();
		MediaType mediaType = MediaUtils.getType(FileUtils.getFormat(src));
		FileInputStream in = null;
		
		String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/");
		
		if(mediaType == null) {
	    	
			File file = new File(uploadPath, "file.png");
			
			in = new FileInputStream(file);
			
			header.setContentType(MediaType.IMAGE_PNG);

		} else {
			header.setContentType(mediaType);

			File file = new File(savePath + "\\" + src);
			
			try {
				in = new FileInputStream(file);
				
				
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} 
		}
		out = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.OK);
		
		
		return out;
	}
	
}
