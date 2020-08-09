package com.gdit.crud.test;

import com.gdit.crud.dao.DepartmentMapper;
import com.gdit.crud.dao.EmployeeMapper;
import com.gdit.crud.entity.Department;
import com.gdit.crud.entity.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
 DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
//        ClassPathXmlApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);

        //1、插入部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"研发部"));

//        2插入员工
//        employeeMapper.insertSelective(new Employee(null,"梁栋民","男","83759203@qq.com",1));

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        long start = System.currentTimeMillis();
        for(int i = 1; i<200;i++){
            String name = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(i,name,"男",name+"@qq.com",1));
        }
        long end = System.currentTimeMillis();
        System.out.println(end - start);
    }
}
