package com.gdit.crud.service;

import com.gdit.crud.dao.EmployeeMapper;
import com.gdit.crud.entity.Employee;
import com.gdit.crud.entity.EmployeeExample;
import com.gdit.crud.service.Iservice.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements IEmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAllEmps() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    @Override
    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    @Override
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long res = employeeMapper.countByExample(example);

        return res == 0;
    }

    @Override
    public Employee getEmpById(int id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    @Override
    public int UpdateEmp(Employee employee) {
        int res = employeeMapper.updateByPrimaryKeySelective(employee);
        return res;
    }

    @Override
    public int DelEmpById(Integer id) {
        int res = employeeMapper.deleteByPrimaryKey(id);
        return res;
    }

    @Override
    public int DelEmps(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        int res = employeeMapper.deleteByExample(example);
        return res;
    }
}
