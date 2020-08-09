package com.gdit.crud.controller;

import com.gdit.crud.entity.Employee;
import com.gdit.crud.entity.MSG;
import com.gdit.crud.service.Iservice.IEmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import sun.applet.resources.MsgAppletViewer;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    IEmployeeService empService;

    @RequestMapping("/emp")
    @ResponseBody
    public MSG getAllEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {

        PageHelper.startPage(pn, 5);
        List<Employee> emps = empService.getAllEmps();
        PageInfo pageInfo = new PageInfo(emps, 5);
        return MSG.success().add("pageInfo", pageInfo);
    }

    @RequestMapping(value = "/saveEmp", method = RequestMethod.POST)
    @ResponseBody
    public MSG saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            List<FieldError> errors = result.getFieldErrors();
            Map<String, Object> errorMap = new HashMap<>();
            for (FieldError error : errors) {
                errorMap.put(error.getField(), error.getDefaultMessage());
            }
            return MSG.fail().add("errors", errorMap);
        } else {
            empService.saveEmp(employee);
            return MSG.success();
        }

    }

    //检查用户名是否重复
    @RequestMapping("/checkUser")
    @ResponseBody
    public MSG checkUser(@RequestParam(value = "empName") String empNAme) {
        boolean res = empService.checkUser(empNAme);
        if (res == true) {
            return MSG.success();
        } else {
            return MSG.fail();
        }

    }

    @ResponseBody
    @RequestMapping(value = "/delEmp/{empId}", method = RequestMethod.DELETE)
    public MSG DelEmp(@PathVariable("empId") Integer empId) {
        int res = empService.DelEmpById(empId);
        if (res > 0) {
            return MSG.success();
        }
        return MSG.fail();

    }

    @ResponseBody
    @RequestMapping(value = "/delEmps/{ids}",method = RequestMethod.DELETE)
    public MSG DelEmps(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            List<Integer> idss = new ArrayList<>();
            String[] split = ids.split("-");
            for (String id : split) {
                idss.add(Integer.parseInt(id));
            }
            int res = empService.DelEmps(idss);
            if (res > 0) {
                return MSG.success();
            } else {
                return MSG.fail();
            }
        } else {
            int res = empService.DelEmpById(Integer.parseInt(ids));
            if (res > 0) {
                return MSG.success();
            } else {
                return MSG.fail();
            }

        }
    }

    //  通过单个id获取用户
    @RequestMapping("/getEmp/{id}")
    @ResponseBody
    public MSG getEmp(@PathVariable("id") Integer id) {
        Employee emp = empService.getEmpById(id);
        if (emp != null) {
            return MSG.success().add("emp", emp);
        }
        return null;
    }

    @RequestMapping(value = "/updateEmp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public MSG UpdateEmp(Employee employee) {
        int res = empService.UpdateEmp(employee);
        if (res > 0) {
            return MSG.success();
        }
        return MSG.fail();
    }

    public String getAllEmp(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        PageHelper.startPage(pn, 5);
        List<Employee> emps = empService.getAllEmps();
        PageInfo pageInfo = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }
}
