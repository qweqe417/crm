package cn.offcn.service.customer.impl;

import cn.offcn.entity.Customer;
import cn.offcn.entity.CustomerExample;
import cn.offcn.mapper.CustomerMapper;
import cn.offcn.service.customer.CustomerService;
import cn.offcn.utils.OAResult;
import cn.offcn.utils.PageView;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    public OAResult addCustomer(Customer customer) {
        customer.setAddtime(new Date());
        int rows=customerMapper.insert(customer);
        if(rows==1){
            return OAResult.ok(200,"客户信息添加成功");
        }
        return OAResult.ok(400,"客户信息添加失败");

    }

    public PageView<Customer> getCustomerCutPage(int currentPage, int pageSize){

        //1.设置PageHelper
        PageHelper.startPage(currentPage,pageSize);
        CustomerExample customerExample=new CustomerExample();
        List<Customer> customerList = customerMapper.selectByExample(customerExample);
        //2.创建一个PageInfo
        PageInfo pageInfo=new PageInfo(customerList);
        PageView<Customer> pageView=new PageView<Customer>(currentPage,pageSize);
        pageView.setTotalrecords(pageInfo.getTotal());
        pageView.setRecords(pageInfo.getList());

        return pageView;
    }

    public OAResult deleteCustomerBySelected(String ids){

        int count=0;
        String[] idds=null;
        if(ids!=null && ids.length()>0){
            idds=ids.split(",");
            for(String id : idds){
                customerMapper.deleteByPrimaryKey(Integer.parseInt(id));
                count++;
            }
        }
        if(count==idds.length){
            return OAResult.ok(200,"记录删除成功");
        }
        return OAResult.ok(400,"记录删除失败");


    }

    public Customer getCustomerById(int id){
       return  customerMapper.selectByPrimaryKey(id);
    }

    public OAResult updateCustomerById(Customer customer){
        Customer oldCustomer=customerMapper.selectByPrimaryKey(customer.getId());
        customer.setAddtime(oldCustomer.getAddtime());
        int rows=customerMapper.updateByPrimaryKey(customer);
        if(rows==1){
            return OAResult.ok(200,"客户信息修改成功");
        }
        return OAResult.ok(400,"客户信息修改失败");

    }

    public List<Customer> searchCustomer(int seacherType, String keyword, int orderby){
            CustomerExample customerExample=new CustomerExample();
            CustomerExample.Criteria criteria = customerExample.createCriteria();
            if(seacherType==1){
                if(StringUtils.isNotBlank(keyword)){
                    criteria.andComnameLike("%"+keyword+"%");
                }

            }else if(seacherType==2){
                if(StringUtils.isNotBlank(keyword)){
                    criteria.andCompanypersonLike("%"+keyword+"%");
                }
            }

            if(orderby==1){
                customerExample.setOrderByClause("addtime ASC");
            }
           return  customerMapper.selectByExample(customerExample);
    }
}
