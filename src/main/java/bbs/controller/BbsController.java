package bbs.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.service.ComService;

import bbs.service.BbsService;
import net.sf.json.spring.web.servlet.view.JsonView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BbsController  extends JsonView{
	
	private static final Logger logger = LoggerFactory.getLogger(BbsController.class);

	@Resource(name="bbsService")
	private BbsService bbsService;
	
	@Resource(name="comService")
	private ComService comService;
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */

	@RequestMapping(value = "/bbs/move", method = RequestMethod.GET)
	public String pageMove(Locale locale, Model model,@RequestParam("pageName") String pageName,HashMap<String, Object> param) throws Exception {
		
		System.out.println("pageName==="+pageName);
		System.out.println("params==="+param.get("pageName"));
		
		return pageName;
	}

	@ResponseBody
	@RequestMapping(value = "/bbs/list", method = RequestMethod.POST)
	public ModelAndView misungList(Model model,@RequestParam HashMap<String, Object> params,@RequestParam("pageStart") int pageStart) throws Exception {
		//logger.info("Welcome home! The client locale is {}.", locale);
		ModelAndView mov= new ModelAndView();
		
		//Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		//String formattedDate = dateFormat.format(date);

		//Map<String,Object> map = new HashMap<String,Object>();
		
		params.put("pageStart", pageStart);
		
		System.out.println("pageStart=="+params.get("pageStart"));
		
		params.put("queryId", "bbsControlMapper.selectBbsListCount");
		
		int cnt = comService.comListCount(params);

		params.put("queryId", "bbsControlMapper.selectBbsList");
		
		System.out.println("cnt================"+cnt);

		List<HashMap<String, String>> outputs = comService.comList(params);

		System.out.println("outputs.size()"+outputs.size());

		//mov.addObject("serverTime", formattedDate);
		mov.addObject("list", outputs);
		mov.addObject("cnt", cnt);
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@RequestMapping(value = "/bbs/save" ,method = RequestMethod.POST)
	public ModelAndView bbsSave(@RequestParam Map<String, Object> params) throws Exception {
		
		params.put("queryId", "bbsControlMapper.insertMisung");
		
		ModelAndView mov= new ModelAndView();
		Model model = null;
		System.out.println("replyYn = = = "+params.get("replyYn"));
		System.out.println("title = = = "+params.get("title"));
		System.out.println("nm = = = "+params.get("nm"));
		System.out.println("passw = = = "+params.get("passw"));
		System.out.println("content = = = "+params.get("contentVal"));
		
		int maxSeq = 0;
		
		
		String replyYn = (String)params.get("replyYn");
		
		String bbsId = (String)params.get("bbsId");
		if((bbsId == null || "".equals(bbsId)) && "N".equals(replyYn))
			maxSeq = bbsService.bbsNewSave(params);
		else{
			if( "Y".equals(replyYn))
				maxSeq = bbsService.bbsReplySave(params);
			else
				maxSeq = bbsService.bbsUpdate(params);
		}

		model.addAttribute("maxSeq", maxSeq );
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@ResponseBody
	@RequestMapping(value = "/bbs/save3", produces = "text/plain;charset=UTF-8" ,method = RequestMethod.POST)
	public String bbsSave3(@RequestParam Map<String,Object> param, @RequestParam MultipartFile uploadFile) throws Exception {
		
		//params.put("queryId", "bbsControlMapper.insertMisung");
		
		ModelAndView mov= new ModelAndView();
		Model model = null;
		/*System.out.println("replyYn = = = "+params.get("replyYn"));
		System.out.println("title = = = "+params.get("title"));
		System.out.println("nm = = = "+params.get("nm"));
		System.out.println("passw = = = "+params.get("passw"));
		System.out.println("content = = = "+params.get("contentVal"));*/
		
		int maxSeq = 0;
		
		
/*		String replyYn = (String)params.get("replyYn");
		
		String bbsId = (String)params.get("bbsId");
		if((bbsId == null || "".equals(bbsId)) && "N".equals(replyYn))
			maxSeq = bbsService.bbsNewSave(params);
		else{
			if( "Y".equals(replyYn))
				maxSeq = bbsService.bbsReplySave(params);
			else
				maxSeq = bbsService.bbsUpdate(params);
		}*/

		
	
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		//multipartRequest.getFile("attachFile");
		//if(multipartRequest.getFile("attachFile") != null)
		//	System.out.println("file = = = "+multipartRequest.getFile("attachFile"));
		System.out.println("file = = = "+uploadFile);
		model.addAttribute("maxSeq", maxSeq );
		mov.setViewName("jsonView");
		
		return "jsonView";
	}
	
	@RequestMapping(value = "/bbs/save2", method = RequestMethod.POST)
	@ResponseBody
	public int bbsSave2(MultipartHttpServletRequest request, 
	    HttpServletResponse res,@RequestParam Map<String, Object> params) throws Exception {
	 
	    Iterator<String> itr =  request.getFileNames();
	    
	    int maxSeq=0;
	    
	    //Map<String,MultipartFile>
	    
	    List<MultipartFile> list =request.getFiles("attachFile");
	    
	    System.out.println("list === "+list.size());
	    
	    for(int i=0; i<list.size(); i++){
	    
		    MultipartFile mpf = list.get(i);
		    String originFileName = mpf.getOriginalFilename();
		 
		    System.out.println("originFileName=="+originFileName);
		    System.out.println("mpf = = = "+mpf.isEmpty());
	    }

	    System.out.println("replyYn = = = "+params.get("replyYn"));
		System.out.println("title = = = "+params.get("title"));
		System.out.println("nm = = = "+params.get("nm"));
		System.out.println("passw = = = "+params.get("passw"));
		System.out.println("content = = = "+params.get("contentVal"));
	    // ... »ý·«
	 
		String replyYn = (String)params.get("replyYn");
		
		String bbsId = (String)params.get("bbsId");
		if((bbsId == null || "".equals(bbsId)) && "N".equals(replyYn))
			maxSeq = bbsService.bbsNewSave(params,list);
		else{
			if( "Y".equals(replyYn))
				maxSeq = bbsService.bbsReplySave(params,list);
			else
				maxSeq = bbsService.bbsUpdate(params,list);
		}
	     
	    return maxSeq;
	}

	
	@RequestMapping(value = "/bbs/detail", method = RequestMethod.POST)
	public ModelAndView bbsDetail(Locale locale, Model model,@RequestParam Map<String, Object> params) throws Exception {
		
		params.put("queryId", "bbsControlMapper.selectBbsDetail");
		
		ModelAndView mov= new ModelAndView();

		System.out.println("replyYn = = = "+params.get("replyYn"));
		System.out.println("bbsNo = = = "+params.get("bbsNo"));

		Map<String, Object> bbsDetail = comService.comDetail(params);
		
		String attachId = (String)bbsDetail.get("attach_file_no");
		
		if(!"N".equals(attachId)){
			params.put("queryId", "bbsControlMapper.selectBbsDetailAttach");
			List<HashMap<String, String>> outputs = comService.comList(params);
			model.addAttribute("attachList", outputs );
		}else
			model.addAttribute("attachList", null );
		
		model.addAttribute("detail", bbsDetail );
		
		mov.setViewName("jsonView");
		
		return mov;
	}
	
	@RequestMapping(value = "/bbs/delete", method = RequestMethod.POST)
	public ModelAndView bbsDelete(Locale locale, Model model,@RequestParam Map<String, Object> params) throws Exception {
		
		params.put("queryId", "bbsControlMapper.deleteMisung");
		
		ModelAndView mov= new ModelAndView();
		
		System.out.println("BBS delete 1111111111111111 = = = ");

		int reVal = bbsService.bbsDelete(params);
	
		model.addAttribute("reVal", reVal );
		mov.setViewName("jsonView");
		
		return mov;
	}
	
}
