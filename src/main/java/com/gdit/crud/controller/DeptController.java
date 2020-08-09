package com.gdit.crud.controller;

import com.gdit.crud.entity.Department;
import com.gdit.crud.entity.MSG;
import com.gdit.crud.service.Iservice.IDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    IDeptService service;

    @ResponseBody
    @RequestMapping("/dept")
    public MSG getAllDept(){
        List<Department> Depts = service.getAllDept();
        return MSG.success().add("depts",Depts);
    }
}
