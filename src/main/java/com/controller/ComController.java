package com.controller;

import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.service.ComService;

import net.sf.json.spring.web.servlet.view.JsonView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ComController  extends JsonView{
	
	private static final Logger logger = LoggerFactory.getLogger(ComController.class);

	@Resource(name="comService")
	private ComService comService;
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("queryId", "userControlMapper.selectSample");

		List<HashMap<String, String>> outputs = comService.comList(map);

		HashMap<String,String> hash = outputs.get(0);
		
        model.addAttribute("showDB", outputs.toString());
		
		model.addAttribute("serverTime", formattedDate );
		
		model.addAttribute("list", outputs );
		return "index";
	}
	
	@ResponseBody
	@RequestMapping(value = "/misung/list", method = RequestMethod.POST)
	public ModelAndView misungList(Locale locale, Model model) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		ModelAndView mov= new ModelAndView();
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);

		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("queryId", "userControlMapper.selectMisung");

		List<HashMap<String, String>> outputs = comService.comList(map);

		System.out.println("outputs.size()"+outputs.size());

		mov.addObject("serverTime", formattedDate);
		mov.addObject("list", outputs);
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@RequestMapping(value = "/misung/save", method = RequestMethod.POST)
	public String misungSave(Locale locale, Model model,@RequestParam Map<String, Object> params) throws Exception {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		params.put("queryId", "userControlMapper.insertMisung");

		int reSave = comService.misungSave(params);

		model.addAttribute("serverTime", formattedDate );
		
		return "misung/listPage";
	}
	
	@RequestMapping(value = "/page/move", method = RequestMethod.POST)
	public String pageMove(Locale locale, Model model,@RequestParam("pageName") String pageName,@RequestParam Map<String, Object> params) throws Exception {
		
		System.out.println("pageName111==="+pageName);
		System.out.println("replyYn==="+params.get("replyYn"));
		System.out.println("bbsNo==="+params.get("bbsNo"));
		
		model.addAttribute("reParam", params );
		
		return pageName;
	}
	
	@RequestMapping(value = "/page/move2", method = RequestMethod.GET)
	public ModelAndView pageMove2(@RequestParam Map<String, Object> params) throws Exception {
		
		ModelAndView mov= new ModelAndView();
		
		String pageName = (String) params.get("pageName");

		//mov.addObject("reParam", params );
		mov.addAllObjects(params);
		//mov.addObject("replyYn", params.get("replyYn") );
		mov.setViewName(pageName);
		
		return mov;
	}
	
	@ResponseBody
	@RequestMapping(value = "/misung/save2", method = RequestMethod.POST,produces ={"application/xml", "application/json"})
	public ModelAndView misungTest(Locale locale, Model model, @RequestParam Map<String, String> params) throws Exception {
		
		ModelAndView mov= new ModelAndView();

		mov.setViewName("jsonView");
		return mov;
	}
	
	@RequestMapping(value = "/com/loginPage", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginPage(Model model,@RequestParam Map<String, Object> params) throws Exception {

		String pageType = (String)params.get("pageType");
		
		String pageName = "";
		
		System.out.println("1111111111111111111111111111111111111111111111111111");
		
		//if(pageType != null && "SNS".equals(pageType))
		
		return "login/login";
	}
	
	@RequestMapping(value = "/com/login/login", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, Model model,@RequestParam Map<String, Object> params) throws Exception {
		
		ModelAndView mov= new ModelAndView();
		
		params.put("queryId", "userControlMapper.login_select");

		Map<String, Object> outputs = comService.comDetail(params);
		
		System.out.println("outputs=========="+outputs);
		
		if(outputs == null)
			mov.addObject("loginYn", "N");
		else{
			mov.addObject("loginYn", "Y");
			HttpSession session = request.getSession(true);
			session.setAttribute("loginInfo", outputs);
		}
		//model.addAttribute("serverTime", formattedDate );
		mov.addObject("login_info", outputs);
		mov.setViewName("jsonView");
		return mov;
	}
	

	@RequestMapping(value = "/com/login/logout", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView loginOut(HttpServletRequest request, Model model,@RequestParam Map<String, Object> params) throws Exception {

		ModelAndView mov= new ModelAndView();
		HttpSession session = request.getSession(true);
		session.invalidate();
		mov.addObject("logout_yn", "Y");
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@ResponseBody
	@RequestMapping(value = "/com/login/userSave", method = RequestMethod.POST)
	public ModelAndView userSave(@RequestParam Map<String, Object> params) throws DataAccessException {
		
		ModelAndView mov= new ModelAndView();
		Model model = null;
		
		try{
			params.put("queryId", "userControlMapper.insertUser");

			params.put("user_name", (String)params.get("first_nm") + (String)params.get("last_nm"));

			params.put("birthday", (String)params.get("year") + (String)params.get("month")
			+ (String)params.get("day"));
			
			Map<String, Object> reSave = comService.userSave(params);

			System.out.println("22 reSave==============="+reSave);
			
			mov.addObject("detail", reSave );
			mov.setViewName("jsonView");
			
			
		}catch(DataAccessException dae){
			System.out.println("2222222================="+dae.toString());
		}catch(Exception e){
			System.out.println("3333333================="+e.toString());
		}
		return mov;
	}
	
	@RequestMapping(value = "/com/login/loginAft", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginAft(Model model,@RequestParam Map<String, Object> params) throws Exception {

		System.out.println("email==="+params.get("email"));
		
		//if(pageType != null && "SNS".equals(pageType))
		model.addAttribute("reParam", params );
		
		return "login/loginAft";
	}
	
	@RequestMapping(value = "/com/layout/top", method = {RequestMethod.GET, RequestMethod.POST})
	public String layoutTop(HttpSession session,@RequestParam Map<String, Object> params) throws Exception {

		String pageName = "layout/bbs/top";
		
		Map<String, Object> map =(Map<String, Object>)session.getAttribute("loginInfo");

		System.out.println("1111111111111111111111111111111111111111111111111111"+map);
		
		if(map != null)
			pageName = "layout/sns/login_top";
		//if(pageType != null && "SNS".equals(pageType))
		
		return pageName;
	}
	
	@RequestMapping("/com/fileDownload")
	public ModelAndView fileDownload(@RequestParam("fileName") String fileName) throws Exception {
	     
		System.out.println("fileName=============="+fileName);
	    /** 첨부파일 정보 조회 */
	    Map<String, Object> fileInfo = new HashMap<String, Object>();
	    fileInfo.put("fileNameKey", fileName);
	    fileInfo.put("fileName", fileName);
	    //fileInfo.put("filePath", filePath);
	 
	    return new ModelAndView("fileDownloadUtil", "downloadFile", fileInfo);
	}

}
