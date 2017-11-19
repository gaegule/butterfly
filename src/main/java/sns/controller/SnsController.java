package sns.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.service.ComService;
import com.util.FileUtil;

import bbs.service.BbsService;
import net.sf.json.spring.web.servlet.view.JsonView;
import sns.service.SnsService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class SnsController  extends JsonView{
	
	private static final Logger logger = LoggerFactory.getLogger(SnsController.class);
	
	@Resource(name="fileUtil")
	private FileUtil fileUtil;
	
	@Resource(name="snsService")
	private SnsService snsService;
	
	@Resource(name="comService")
	private ComService comService;
	
	@ResponseBody
	@RequestMapping(value = "/sns/save", method = RequestMethod.POST)
	public ModelAndView bbsSave(@RequestParam Map<String, Object> params) throws Exception {
		
		params.put("queryId", "bbsControlMapper.insertMisung");
		
		ModelAndView mov= new ModelAndView();
		Model model = null;
		//System.out.println("replyYn = = = "+params.get("replyYn"));
		//System.out.println("title = = = "+params.get("title"));
		
		int maxSeq = 0;
		List<HashMap<String, String>> list = null;

		String snsId = (String)params.get("snsId");
		
		
		System.out.println("params=="+params.toString());
		System.out.println("profile_msg=="+(String)params.get("profile_msg"));
		System.out.println("attach_file_no=="+(String)params.get("attach_file_no"));
		System.out.println("pageStart=="+params.get("pageStart"));
		
		if(params.get("attach_file_no") == null || "".equals((String)params.get("attach_file_no")))
			params.put("attach_file_no", null);
		
		if(params.get("pageStart") == null || "".equals((String)params.get("pageStart")))
			params.put("pageStart", 0);
		else		
			params.put("pageStart", Integer.parseInt((String)params.get("pageStart")));
		
		if((snsId == null || "".equals(snsId))){
			list = snsService.snsNewSave(params);
		}else{
			//maxSeq = bbsService.bbsUpdate(params);
		}

		System.out.println("list.size() ================== "+list.size());
		mov.addObject("list", list );
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@RequestMapping(value = "/sns/imageTemp", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView snsImageUpload(MultipartHttpServletRequest request, 
	    HttpServletResponse res,@RequestParam Map<String, Object> params ,Model model) throws Exception {
		
		ModelAndView mov= new ModelAndView();
	 
	    Iterator<String> itr =  request.getFileNames();
	    
	    int maxSeq=0;
	    
	    //Map<String,MultipartFile>
	    
	    List<MultipartFile> list =request.getFiles("snsFile");
	    
	    System.out.println("list === "+list.size());
	    
	    List<Map<String,Object>> fileList = snsService.snsNewImageSave(params,list);
	    
	    //List<Map<String,Object>> fileList = new ArrayList<Map<String,Object>>();
	    //Map<String,Object> map =new HashMap<String,Object>();
	    //map.put("testimage1", "D:\\upload\\sns\\2016\\10\\05\\04c7e48b-cf5e-4c78-a674-7b2a2f753819\\전원주택 창문.jpg");
	    //map.put("testimage1", "dsfdsfsdf");
	    //fileList.add(map);
	    
	    System.out.println("fileList.size() ====================== "+fileList.toString());
	    
	    mov.addObject("fileList", fileList);
	    mov.setViewName("sns/frame");
	    //model.addAttribute("test", "hahahah");
	     
	    return mov;
	}
	
	@ResponseBody
	@RequestMapping(value = "/sns/imageUpd", method = RequestMethod.POST)
	public ModelAndView snsImageUpload_U(MultipartHttpServletRequest request, 
	    HttpServletResponse res,@RequestParam Map<String, Object> params ,Model model) throws Exception {
		
		ModelAndView mov= new ModelAndView();
	 
	    Iterator<String> itr =  request.getFileNames();
	    
	    int maxSeq=0;
	    
	    //Map<String,MultipartFile>
	    
	    List<MultipartFile> list =request.getFiles("snsFile_u");
	    
	    
	    params.put("attach_file_no", params.get("attach_file_no_u"));
	    System.out.println("attach_file_no === "+params.get("attach_file_no_u"));
	    System.out.println("list === "+list.size());
	    
	    List<Map<String,Object>> fileList = snsService.snsNewImageSave(params,list);

	    
	    //System.out.println("fileList.size() ====================== "+fileList.toString());
	    
	    mov.addObject("fileList", fileList);
	    mov.setViewName("sns/frame");
	    model.addAttribute("type", "update");
	     
	    return mov;
	}
	
	
	@RequestMapping(value = "/sns/iframe", method = RequestMethod.GET)
	public String pageMove(Locale locale, Model model,@RequestParam("pageName") String pageName,@RequestParam Map<String, Object> params) throws Exception {
		
		model.addAttribute("reParam", params );
		
		return "sns/frame";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/sns/snsList", method = RequestMethod.POST)
	public ModelAndView snsList(Model model,@RequestParam HashMap<String, Object> params,@RequestParam("pageStart") int pageStart) throws Exception {
		//logger.info("Welcome home! The client locale is {}.", locale);
		ModelAndView mov= new ModelAndView();

		params.put("pageStart", pageStart);

		System.out.println("user_nouser_nouser_no================"+params.get("user_no"));

		HashMap<String, List> outputs = snsService.snsList(params);

		System.out.println("outputs.size()"+outputs.toString());

		//mov.addObject("serverTime", formattedDate);
		mov.addObject("list", outputs.get("snsList"));
		
		System.out.println("friendListfriendListfriendList================"+outputs.get("friendList"));
		
		if(outputs.get("friendList") != null)
			mov.addObject("fList", outputs.get("friendList"));
		//mov.addObject("cnt", cnt);
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@ResponseBody
	@RequestMapping(value = "/sns/snsDetail", method = RequestMethod.POST)
	public ModelAndView snsDetail(Model model,@RequestParam HashMap<String, Object> params) throws Exception {

		ModelAndView mov= new ModelAndView();

		params.put("queryId", "snsControlMapper.selectSnsDetail");
		
		Map<String, Object> outputs = comService.comDetail(params);

		System.out.println("outputs.size()"+outputs.toString());

		String attach_file_no = (String)outputs.get("attach_file_no");
		
		if(!"".equals(attach_file_no)){
			
			params.put("queryId", "snsControlMapper.selectSnsAttach");
			
			params.put("attach_file_no", attach_file_no);
			List<HashMap<String, String>> snsAttach = comService.comList(params);
			mov.addObject("attachList", snsAttach);
		}
		
		mov.addObject("detail", outputs);
		
		//mov.addObject("cnt", cnt);
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/sns/snsUpdate", method = RequestMethod.POST)
	public ModelAndView snsUpdate(Model model,@RequestParam HashMap<String, Object> params) throws Exception {

		ModelAndView mov= new ModelAndView();

		params.put("queryId", "snsControlMapper.updateSns");
		
		System.out.println("profile_msg========================"+params.get("profile_msg"));
		
		int reSeq = snsService.snsUpdate(params);
		
		mov.addObject("reVal", reSeq);
		mov.addObject("attach_file_no", params.get("attach_file_no"));
		
		//mov.addObject("cnt", cnt);
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@RequestMapping(value = "/sns/searchFriend", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView snsSearchFriend(@RequestParam Map<String, Object> params ,Model model) throws Exception {
		
		ModelAndView mov= new ModelAndView();

		HashMap<String, List> friendMap = snsService.snsSearchFriend(params);

	    System.out.println("fileList.size() ====================== "+friendMap.toString());

	    mov.addObject("aFriend", (List<HashMap<String, String>>)friendMap.get("aFriend"));
	    mov.addObject("rFriend", (List<HashMap<String, String>>)friendMap.get("rFriend"));
	    mov.setViewName("sns/search_f");
	    //model.addAttribute("test", "hahahah");
	     
	    return mov;
	}
	
	@RequestMapping(value = "/sns/searchPeople", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView snsSearchPeople(@RequestParam Map<String, Object> params ,Model model) throws Exception {
		
		ModelAndView mov= new ModelAndView();
		
		params.put("queryId", "snsControlMapper.selectFriendSearch");
		
		List<HashMap<String, String>> outputs = comService.comList(params);

	    System.out.println("fileList.size() ====================== "+outputs.toString());

	    mov.addObject("people_s", outputs);

	    mov.setViewName("sns/search_p");
	    //model.addAttribute("test", "hahahah");
	     
	    return mov;
	}
	
	@RequestMapping(value = "/sns/friendAdd", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView snsfriendAdd(@RequestParam Map<String, Object> params ,Model model) throws Exception {
		
		ModelAndView mov= new ModelAndView();
		
		params.put("queryId", "snsControlMapper.insertFriendRequest");
		
		System.out.println("user_no ====================== "+params.get("user_no"));
		
		params.put("t_user_no",params.get("user_no"));
		//params.put("f_user_no",params.get("user_no"));
		
		int fAdd = comService.comSave(params);

	    System.out.println("fAddfAddfAddfAddfAddfAdd ====================== "+fAdd);

	    //mov.addObject("people_s", outputs);

	    mov.setViewName("jsonView");
	    //model.addAttribute("test", "hahahah");
	     
	    return mov;
	}
	
	@RequestMapping(value = "/sns/friendConfirm", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView snsfriendConfirm(@RequestParam Map<String, Object> params ,Model model) throws Exception {
		
		ModelAndView mov= new ModelAndView();
		
		params.put("queryId", "snsControlMapper.confirmFriendRequest");
		
		System.out.println("user_no ====================== "+params.get("user_no"));
		
		params.put("f_user_no",params.get("user_no"));
		//params.put("f_user_no",params.get("user_no"));
		
		int fAdd = comService.comSave(params);

	    System.out.println("fAddfAddfAddfAddfAddfAdd ====================== "+fAdd);

	    //mov.addObject("people_s", outputs);

	    mov.setViewName("jsonView");
	    //model.addAttribute("test", "hahahah");
	     
	    return mov;
	}
	

	@ResponseBody
	@RequestMapping(value = "/sns/snsFriendList", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView snsFriendList(HttpServletRequest request,Model model,@RequestParam HashMap<String, Object> params) throws Exception {
		//logger.info("Welcome home! The client locale is {}.", locale);
		ModelAndView mov= new ModelAndView();
		
		System.out.println("snsFriendListsnsFriendListsnsFriendListsnsFriendList================");

		params.put("status", "S");
		
		HttpSession session = request.getSession(true);
		
		Map<String, Object> sessionMap =(Map<String, Object>)session.getAttribute("loginInfo");
				
		//request.getSession().getAttribute("loginInfo");
		
		params.put("queryId", "snsControlMapper.selectFriendRequest");
		
		System.out.println("user_nouser_nouser_no================"+sessionMap.get("user_no"));
		
		params.put("user_no", sessionMap.get("user_no"));

		List<HashMap<String, String>> outputs = comService.comList(params);

		System.out.println("outputs.size()"+outputs.toString());

		//mov.addObject("serverTime", formattedDate);
		mov.addObject("list", outputs);
		//mov.addObject("cnt", cnt);
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@RequestMapping(value = "/sns/deleteSns", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView deleteSns(@RequestParam Map<String, Object> params ,Model model) throws Exception {
		
		ModelAndView mov= new ModelAndView();
		
		int fDel = 0;
		
		// 삭제지만 상태값 N 모드
		params.put("queryId", "snsControlMapper.deleteSnsUseYn");
		fDel = comService.comUpdate(params);
		
		
		
		System.out.println("sns_profile_no ================="+params.get("sns_profile_no"));
		System.out.println("#attach_file_no ================="+params.get("attach_file_no"));
		// 완전 삭제 모드
		//params.put("queryId", "snsControlMapper.deleteSns");
		//int reFile = fileUtil.imageDeleteAll(params);
		//fDel = comService.comDelete(params);

	    //System.out.println("fAddfAddfAddfAddfAddfAdd ====================== "+fDel);

	    mov.setViewName("jsonView");

	    return mov;
	}
}
