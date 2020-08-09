package com.gdit.crud.service;

import com.gdit.crud.dao.DepartmentMapper;
import com.gdit.crud.entity.Department;
import com.gdit.crud.service.Iservice.IDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptServiceImpl implements IDeptService {
    @Autowired
    DepartmentMapper mapper;
    @Override
    public List<Department> getAllDept() {
        return mapper.selectByExample(null);
    }
}
