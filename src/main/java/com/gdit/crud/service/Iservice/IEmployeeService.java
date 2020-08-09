package com.gdit.crud.service.Iservice;

import com.gdit.crud.entity.Employee;

import java.util.List;

public interface IEmployeeService {
    List<Employee> getAllEmps();
    int saveEmp(Employee employee);
    boolean checkUser(String empName);
    Employee getEmpById(int id);
    int UpdateEmp(Employee employee);
    int DelEmpById(Integer id);
    int DelEmps(List<Integer> ids);
}
