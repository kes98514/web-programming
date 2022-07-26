package du.user.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import du.dept.domain.DeptVO;
import du.dept.service.DeptService;
import du.user.domain.UserVO;
import du.user.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private DeptService deptService;
	
	@RequestMapping("/userInfo.do")
	public ModelAndView userInfoPage(HttpServletRequest request, UserVO user) {
		if(userService.loginProcess(request, user)) {
			ModelAndView mav = new ModelAndView("user/userInfo.jsp");
			List<DeptVO> dept = deptService.selectDeptList();
			mav.addObject("dept", dept);
			
			return mav;
		}
		else {
			ModelAndView mav = new ModelAndView("main.jsp");
			return mav;
		}
	}
	
	@RequestMapping("/userInfoConfirm.do")
	public String userInfoConfirmPage() {
		return "user/userInfoConfirm.jsp";
	}
	
	
	@RequestMapping("/userModify.do")
	public String userModify(@ModelAttribute UserVO user) {
		userService.updateUser(user);
		
		return "redirect:/logout.do";
	}

	@RequestMapping("/signUpPage.do")
	public ModelAndView signUpPage() {
		ModelAndView mav = new ModelAndView("user/signUp.jsp");
		List<DeptVO> dept = deptService.selectDeptList();
		mav.addObject("dept", dept);
		
		return mav;
	}
	
	@RequestMapping("/signUp.do")
	public String signUp(@ModelAttribute UserVO user) {
		userService.insertUser(user);
		
		return "redirect:/loginPage.do";
	}

	@RequestMapping("/userDelete.do")
	public String userDelete(HttpSession session) {
		userService.deleteUser(session);
		
		return "redirect:/loginPage.do";
	}
	
}
